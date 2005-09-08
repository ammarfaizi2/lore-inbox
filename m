Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbVIHPgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbVIHPgv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbVIHPgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:36:51 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:35687
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932595AbVIHPgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:36:50 -0400
Message-Id: <432076F302000078000244B8@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:37:55 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix i386 condition to call nmi_watchdog_tick
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part92B0FCC3.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part92B0FCC3.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Don't call nmi_watchdog_tick() when this isn't enabled.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/arch/i386/kernel/traps.c
2.6.13-i386-watchdog-active/arch/i386/kernel/traps.c
--- 2.6.13/arch/i386/kernel/traps.c	2005-08-29 01:41:01.000000000
+0200
+++
2.6.13-i386-watchdog-active/arch/i386/kernel/traps.c	2005-09-01
14:04:35.000000000 +0200
@@ -611,7 +611,7 @@ static void default_do_nmi(struct pt_reg
 		 * Ok, so this is none of the documented NMI sources,
 		 * so it must be the NMI watchdog.
 		 */
-		if (nmi_watchdog) {
+		if (nmi_watchdog && nmi_active > 0) {
 			nmi_watchdog_tick(regs);
 			return;
 		}
diff -Npru 2.6.13/include/asm-i386/apic.h
2.6.13-i386-watchdog-active/include/asm-i386/apic.h
--- 2.6.13/include/asm-i386/apic.h	2005-08-29 01:41:01.000000000
+0200
+++
2.6.13-i386-watchdog-active/include/asm-i386/apic.h	2005-09-01
11:32:11.000000000 +0200
@@ -125,6 +125,7 @@ extern void enable_APIC_timer(void);
 extern void enable_NMI_through_LVT0 (void * dummy);
 
 extern unsigned int nmi_watchdog;
+extern int nmi_active;
 #define NMI_NONE	0
 #define NMI_IO_APIC	1
 #define NMI_LOCAL_APIC	2


--=__Part92B0FCC3.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-i386-watchdog-active.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-i386-watchdog-active.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkRvbid0IGNhbGwgbm1pX3dhdGNoZG9nX3Rp
Y2soKSB3aGVuIHRoaXMgaXNuJ3QgZW5hYmxlZC4KClNpZ25lZC1vZmYtYnk6IEphbiBCZXVsaWNo
IDxqYmV1bGljaEBub3ZlbGwuY29tPgoKZGlmZiAtTnBydSAyLjYuMTMvYXJjaC9pMzg2L2tlcm5l
bC90cmFwcy5jIDIuNi4xMy1pMzg2LXdhdGNoZG9nLWFjdGl2ZS9hcmNoL2kzODYva2VybmVsL3Ry
YXBzLmMKLS0tIDIuNi4xMy9hcmNoL2kzODYva2VybmVsL3RyYXBzLmMJMjAwNS0wOC0yOSAwMTo0
MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xMy1pMzg2LXdhdGNoZG9nLWFjdGl2ZS9hcmNo
L2kzODYva2VybmVsL3RyYXBzLmMJMjAwNS0wOS0wMSAxNDowNDozNS4wMDAwMDAwMDAgKzAyMDAK
QEAgLTYxMSw3ICs2MTEsNyBAQCBzdGF0aWMgdm9pZCBkZWZhdWx0X2RvX25taShzdHJ1Y3QgcHRf
cmVnCiAJCSAqIE9rLCBzbyB0aGlzIGlzIG5vbmUgb2YgdGhlIGRvY3VtZW50ZWQgTk1JIHNvdXJj
ZXMsCiAJCSAqIHNvIGl0IG11c3QgYmUgdGhlIE5NSSB3YXRjaGRvZy4KIAkJICovCi0JCWlmIChu
bWlfd2F0Y2hkb2cpIHsKKwkJaWYgKG5taV93YXRjaGRvZyAmJiBubWlfYWN0aXZlID4gMCkgewog
CQkJbm1pX3dhdGNoZG9nX3RpY2socmVncyk7CiAJCQlyZXR1cm47CiAJCX0KZGlmZiAtTnBydSAy
LjYuMTMvaW5jbHVkZS9hc20taTM4Ni9hcGljLmggMi42LjEzLWkzODYtd2F0Y2hkb2ctYWN0aXZl
L2luY2x1ZGUvYXNtLWkzODYvYXBpYy5oCi0tLSAyLjYuMTMvaW5jbHVkZS9hc20taTM4Ni9hcGlj
LmgJMjAwNS0wOC0yOSAwMTo0MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xMy1pMzg2LXdh
dGNoZG9nLWFjdGl2ZS9pbmNsdWRlL2FzbS1pMzg2L2FwaWMuaAkyMDA1LTA5LTAxIDExOjMyOjEx
LjAwMDAwMDAwMCArMDIwMApAQCAtMTI1LDYgKzEyNSw3IEBAIGV4dGVybiB2b2lkIGVuYWJsZV9B
UElDX3RpbWVyKHZvaWQpOwogZXh0ZXJuIHZvaWQgZW5hYmxlX05NSV90aHJvdWdoX0xWVDAgKHZv
aWQgKiBkdW1teSk7CiAKIGV4dGVybiB1bnNpZ25lZCBpbnQgbm1pX3dhdGNoZG9nOworZXh0ZXJu
IGludCBubWlfYWN0aXZlOwogI2RlZmluZSBOTUlfTk9ORQkwCiAjZGVmaW5lIE5NSV9JT19BUElD
CTEKICNkZWZpbmUgTk1JX0xPQ0FMX0FQSUMJMgo=

--=__Part92B0FCC3.0__=--
