Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbVAKMML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVAKMML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 07:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbVAKMML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 07:12:11 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:16090 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262729AbVAKMME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 07:12:04 -0500
Date: Tue, 11 Jan 2005 13:11:41 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chris Wright <chrisw@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: keventd gives exceptional priority to usermode helpers
In-Reply-To: <Pine.LNX.4.61.0501101249380.4459@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0501111310340.12548@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0501101121370.11128@yvahk01.tjqt.qr>
 <20050110034202.P469@build.pdx.osdl.net> <Pine.LNX.4.61.0501101249380.4459@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-716779382-1105445501=:12548"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-716779382-1105445501=:12548
Content-Type: TEXT/PLAIN; charset=US-ASCII

Signed-off-by: Jan Engelhardt <jengelh@linux01.gwdg.de>


--- linux-2.6.8-20041204030200/kernel/kmod.c	2004-12-06 14:28:44.000000000 +0100
+++ linux-2.6.8-20041204030200/kernel/kmod.c	2005-01-06 11:44:04.130600000 +0100
@@ -165,6 +165,7 @@ static int ____call_usermodehelper(void 
 
 	/* We can run anywhere, unlike our parent keventd(). */
 	set_cpus_allowed(current, CPU_MASK_ALL);
+	set_user_nice(current, 0);
 
 	retval = -EPERM;
 	if (current->fs->root)




Jan Engelhardt
-- 
ENOSPC
--1283855629-716779382-1105445501=:12548
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="renice_keventd_usermode.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0501111311410.12548@yvahk01.tjqt.qr>
Content-Description: 
Content-Disposition: attachment; filename="renice_keventd_usermode.diff"

Iz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KIyBMaW51eCAy
LjYtSFggTU9ESUZJQ0FUSU9ODQojICAgQ29weXJpZ2h0IChDKSBKYW4gRW5n
ZWxoYXJkdCA8amVuZ2VsaCBbYXRdIGxpbnV4MDEgZ3dkZyBkZT4sIDIwMDQN
CiMgICAtLSBMaWNlbnNlIHJlc3RyaWN0aW9ucyBhcHBseSAoR1BMMikNCiMg
ICAtLSBGb3IgZGV0YWlscyBzZWUgZG9jL0dQTDIudHh0Lg0KIyAgIGh0dHA6
Ly9saW51eDAxLm9yZzoyMjIyL3Byb2ctaHh0b29scy5waHANCiM9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiMNCiMgLSB1ZGV2IGFuZCBm
cmllbmRzIG5lZWQgYSBmYWlyIGFtb3VudCBvZiBDUFUsIGFuZCByZWFsbHkg
YnJpbmcgZG93biB0aGUNCiMgICBzeXN0ZW0gd2hlbiB0aGV5IHJ1biAtLSB1
c3VhbGx5IGluIG5pY2UgLTUNCiMgICBGaXggaXQgaW4gdGhhdCB1c2VybW9k
ZSBoZWxwZXJzIGFsd2F5cyBnZXQgbmljZSAwIGJ5IGRlZmF1bHQNCiMNCiMt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCmRpZmYgLWRwdSB1
c3JfQS9zcmMva290ZC9saW51eC0yLjYuOC0yMDA0MTIwNDAzMDIwMC9rZXJu
ZWwva21vZC5jIHVzcl9CL3NyYy9rb3RkL2xpbnV4LTIuNi44LTIwMDQxMjA0
MDMwMjAwL2tlcm5lbC9rbW9kLmMNCi0tLSBsaW51eC0yLjYuOC0yMDA0MTIw
NDAzMDIwMC9rZXJuZWwva21vZC5jCTIwMDQtMTItMDYgMTQ6Mjg6NDQuMDAw
MDAwMDAwICswMTAwDQorKysgbGludXgtMi42LjgtMjAwNDEyMDQwMzAyMDAv
a2VybmVsL2ttb2QuYwkyMDA1LTAxLTA2IDExOjQ0OjA0LjEzMDYwMDAwMCAr
MDEwMA0KQEAgLTE2NSw2ICsxNjUsNyBAQCBzdGF0aWMgaW50IF9fX19jYWxs
X3VzZXJtb2RlaGVscGVyKHZvaWQgDQogDQogCS8qIFdlIGNhbiBydW4gYW55
d2hlcmUsIHVubGlrZSBvdXIgcGFyZW50IGtldmVudGQoKS4gKi8NCiAJc2V0
X2NwdXNfYWxsb3dlZChjdXJyZW50LCBDUFVfTUFTS19BTEwpOw0KKwlzZXRf
dXNlcl9uaWNlKGN1cnJlbnQsIDApOw0KIA0KIAlyZXR2YWwgPSAtRVBFUk07
DQogCWlmIChjdXJyZW50LT5mcy0+cm9vdCkNCg==

--1283855629-716779382-1105445501=:12548--
