Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbVIFJpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbVIFJpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 05:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVIFJpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 05:45:23 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:18261
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S964783AbVIFJpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 05:45:22 -0400
Message-Id: <431D81810200007800023FB9@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 06 Sep 2005 11:46:09 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] resubmit: i386 NMI handler stack check adjustments
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part22007171.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part22007171.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Stack pointer comparisons for the NMI on debug stack check/fixup were
incorrect.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
/home/jbeulich/tmp/linux-2.6.13/arch/i386/kernel/entry.S	2005-08-29
01:41:01.000000000 +0200
+++ 2.6.13/arch/i386/kernel/entry.S	2005-08-29 09:50:38.000000000
+0200
@@ -557,11 +557,10 @@ nmi_stack_fixup:
 nmi_debug_stack_check:
 	cmpw $__KERNEL_CS,16(%esp)
 	jne nmi_stack_correct
-	cmpl $debug - 1,(%esp)
-	jle nmi_stack_correct
+	cmpl $debug,(%esp)
+	jb nmi_stack_correct
 	cmpl $debug_esp_fix_insn,(%esp)
-	jle nmi_debug_stack_fixup
-nmi_debug_stack_fixup:
+	ja nmi_stack_correct
 	FIX_STACK(24,nmi_stack_correct, 1)
 	jmp nmi_stack_correct
 


--=__Part22007171.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-i386-nmi.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-i386-nmi.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKClN0YWNrIHBvaW50ZXIgY29tcGFyaXNvbnMg
Zm9yIHRoZSBOTUkgb24gZGVidWcgc3RhY2sgY2hlY2svZml4dXAgd2VyZQppbmNvcnJlY3QuCgpT
aWduZWQtb2ZmLWJ5OiBKYW4gQmV1bGljaCA8amJldWxpY2hAbm92ZWxsLmNvbT4KCi0tLSAvaG9t
ZS9qYmV1bGljaC90bXAvbGludXgtMi42LjEzL2FyY2gvaTM4Ni9rZXJuZWwvZW50cnkuUwkyMDA1
LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzL2FyY2gvaTM4Ni9rZXJu
ZWwvZW50cnkuUwkyMDA1LTA4LTI5IDA5OjUwOjM4LjAwMDAwMDAwMCArMDIwMApAQCAtNTU3LDEx
ICs1NTcsMTAgQEAgbm1pX3N0YWNrX2ZpeHVwOgogbm1pX2RlYnVnX3N0YWNrX2NoZWNrOgogCWNt
cHcgJF9fS0VSTkVMX0NTLDE2KCVlc3ApCiAJam5lIG5taV9zdGFja19jb3JyZWN0Ci0JY21wbCAk
ZGVidWcgLSAxLCglZXNwKQotCWpsZSBubWlfc3RhY2tfY29ycmVjdAorCWNtcGwgJGRlYnVnLCgl
ZXNwKQorCWpiIG5taV9zdGFja19jb3JyZWN0CiAJY21wbCAkZGVidWdfZXNwX2ZpeF9pbnNuLCgl
ZXNwKQotCWpsZSBubWlfZGVidWdfc3RhY2tfZml4dXAKLW5taV9kZWJ1Z19zdGFja19maXh1cDoK
KwlqYSBubWlfc3RhY2tfY29ycmVjdAogCUZJWF9TVEFDSygyNCxubWlfc3RhY2tfY29ycmVjdCwg
MSkKIAlqbXAgbm1pX3N0YWNrX2NvcnJlY3QKIAo=

--=__Part22007171.0__=--
