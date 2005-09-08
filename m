Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932696AbVIHP3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbVIHP3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbVIHP3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:29:31 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:12390
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932696AbVIHP3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:29:31 -0400
Message-Id: <4320753F02000078000244AA@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:30:39 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix i386 init initializers
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part5D7F330F.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part5D7F330F.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

An addition and a fix to the static i386 initializers.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/include/asm-i386/processor.h
2.6.13-i386-init/include/asm-i386/processor.h
--- 2.6.13/include/asm-i386/processor.h	2005-08-29
01:41:01.000000000 +0200
+++ 2.6.13-i386-init/include/asm-i386/processor.h	2005-09-01
13:14:48.000000000 +0200
@@ -460,6 +460,7 @@ struct thread_struct {
 
 #define INIT_THREAD 
{							\
 	.vm86_info =
NULL,						\
+	.esp0 = sizeof(init_stack) +
(long)&init_stack,			\
 	.sysenter_cs =
__KERNEL_CS,					\
 	.io_bitmap_ptr =
NULL,						\
 }
@@ -474,7 +475,7 @@ struct thread_struct {
 	.esp0		= sizeof(init_stack) +
(long)&init_stack,	\
 	.ss0		=
__KERNEL_DS,					\
 	.ss1		=
__KERNEL_CS,					\
-	.ldt		=
GDT_ENTRY_LDT,				\
+	.ldt		= GDT_ENTRY_LDT *
8,				\
 	.io_bitmap_base	=
INVALID_IO_BITMAP_OFFSET,			\
 	.io_bitmap	= { [ 0 ... IO_BITMAP_LONGS] = ~0
},		\
 }


--=__Part5D7F330F.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-i386-init.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-i386-init.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkFuIGFkZGl0aW9uIGFuZCBhIGZpeCB0byB0
aGUgc3RhdGljIGkzODYgaW5pdGlhbGl6ZXJzLgoKU2lnbmVkLW9mZi1ieTogSmFuIEJldWxpY2gg
PGpiZXVsaWNoQG5vdmVsbC5jb20+CgpkaWZmIC1OcHJ1IDIuNi4xMy9pbmNsdWRlL2FzbS1pMzg2
L3Byb2Nlc3Nvci5oIDIuNi4xMy1pMzg2LWluaXQvaW5jbHVkZS9hc20taTM4Ni9wcm9jZXNzb3Iu
aAotLS0gMi42LjEzL2luY2x1ZGUvYXNtLWkzODYvcHJvY2Vzc29yLmgJMjAwNS0wOC0yOSAwMTo0
MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xMy1pMzg2LWluaXQvaW5jbHVkZS9hc20taTM4
Ni9wcm9jZXNzb3IuaAkyMDA1LTA5LTAxIDEzOjE0OjQ4LjAwMDAwMDAwMCArMDIwMApAQCAtNDYw
LDYgKzQ2MCw3IEBAIHN0cnVjdCB0aHJlYWRfc3RydWN0IHsKIAogI2RlZmluZSBJTklUX1RIUkVB
RCAgewkJCQkJCQlcCiAJLnZtODZfaW5mbyA9IE5VTEwsCQkJCQkJXAorCS5lc3AwID0gc2l6ZW9m
KGluaXRfc3RhY2spICsgKGxvbmcpJmluaXRfc3RhY2ssCQkJXAogCS5zeXNlbnRlcl9jcyA9IF9f
S0VSTkVMX0NTLAkJCQkJXAogCS5pb19iaXRtYXBfcHRyID0gTlVMTCwJCQkJCQlcCiB9CkBAIC00
NzQsNyArNDc1LDcgQEAgc3RydWN0IHRocmVhZF9zdHJ1Y3QgewogCS5lc3AwCQk9IHNpemVvZihp
bml0X3N0YWNrKSArIChsb25nKSZpbml0X3N0YWNrLAlcCiAJLnNzMAkJPSBfX0tFUk5FTF9EUywJ
CQkJCVwKIAkuc3MxCQk9IF9fS0VSTkVMX0NTLAkJCQkJXAotCS5sZHQJCT0gR0RUX0VOVFJZX0xE
VCwJCQkJXAorCS5sZHQJCT0gR0RUX0VOVFJZX0xEVCAqIDgsCQkJCVwKIAkuaW9fYml0bWFwX2Jh
c2UJPSBJTlZBTElEX0lPX0JJVE1BUF9PRkZTRVQsCQkJXAogCS5pb19iaXRtYXAJPSB7IFsgMCAu
Li4gSU9fQklUTUFQX0xPTkdTXSA9IH4wIH0sCQlcCiB9Cg==

--=__Part5D7F330F.0__=--
