Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVAJK2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVAJK2p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 05:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVAJK2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 05:28:44 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:41686 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262191AbVAJK2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 05:28:41 -0500
Date: Mon, 10 Jan 2005 11:28:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: keventd gives exceptional priority to usermode helpers
Message-ID: <Pine.LNX.4.61.0501101121370.11128@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-689907754-1105352918=:11128"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-689907754-1105352918=:11128
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,


on SUSE 9.2, we experienced that plugging in an USB stick slows the system 
down considerably. In the end, I tracked (one half of the problem) down to 
kernelspace, where keventd starts the /sbin/hotplug usermode helper with 
priority -20. This is bad because hotplug, udev or the programs that ship with 
the whole hotplug subsystem (possibly including SUSE's own scripts) require 
some CPU -- and with nice -20 get it definitely.

keventd itself should stay at nice level -20, since it also spawns kreiserfsd, 
just to name one. So the (attached) patch reprioritizes *user*mode 
helpers/tasks back to nice 0.

Signed-off-by: Jan Engelhardt <jengelh@linux01.gwdg.de>



Jan Engelhardt
-- 
ENOSPC
--1283855629-689907754-1105352918=:11128
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="renice_keventd_usermode.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0501101128380.11128@yvahk01.tjqt.qr>
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
PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiMgRmlsZTogIHV0ZjhmaXgu
ZGlmZg0KIyBDbGFzczoNCiMNCiMgLSB1ZGV2IGFuZCBmcmllbmRzIG5lZWQg
YSBmYWlyIGFtb3VudCBvZiBDUFUsIGFuZCByZWFsbHkgYnJpbmcgZG93biB0
aGUNCiMgICBzeXN0ZW0gd2hlbiB0aGV5IHJ1biAtLSB1c3VhbGx5IGluIG5p
Y2UgLTIwDQojICAgRml4IGl0IGluIHRoYXQgdXNlcm1vZGUgaGVscGVycyBh
bHdheXMgZ2V0IG5pY2UgMCBieSBkZWZhdWx0DQojDQojLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpkaWZmIC1kcHUgdXNyX0Evc3JjL2tv
dGQvbGludXgtMi42LjgtMjAwNDEyMDQwMzAyMDAva2VybmVsL2ttb2QuYyB1
c3JfQi9zcmMva290ZC9saW51eC0yLjYuOC0yMDA0MTIwNDAzMDIwMC9rZXJu
ZWwva21vZC5jDQotLS0gdXNyX0Evc3JjL2tvdGQvbGludXgtMi42LjgtMjAw
NDEyMDQwMzAyMDAva2VybmVsL2ttb2QuYwkyMDA0LTEyLTA2IDE0OjI4OjQ0
LjAwMDAwMDAwMCArMDEwMA0KKysrIHVzcl9CL3NyYy9rb3RkL2xpbnV4LTIu
Ni44LTIwMDQxMjA0MDMwMjAwL2tlcm5lbC9rbW9kLmMJMjAwNS0wMS0wNiAx
MTo0NDowNC4xMzA2MDAwMDAgKzAxMDANCkBAIC0xNjUsNiArMTY1LDcgQEAg
c3RhdGljIGludCBfX19fY2FsbF91c2VybW9kZWhlbHBlcih2b2lkIA0KIA0K
IAkvKiBXZSBjYW4gcnVuIGFueXdoZXJlLCB1bmxpa2Ugb3VyIHBhcmVudCBr
ZXZlbnRkKCkuICovDQogCXNldF9jcHVzX2FsbG93ZWQoY3VycmVudCwgQ1BV
X01BU0tfQUxMKTsNCisgICAgICAgIHNldF91c2VyX25pY2UoY3VycmVudCwg
MCk7DQogDQogCXJldHZhbCA9IC1FUEVSTTsNCiAJaWYgKGN1cnJlbnQtPmZz
LT5yb290KQ0K

--1283855629-689907754-1105352918=:11128--
