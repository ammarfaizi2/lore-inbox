Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbWH2RHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbWH2RHM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 13:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWH2RHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 13:07:11 -0400
Received: from guru.webcon.ca ([216.194.67.26]:1956 "EHLO guru.webcon.ca")
	by vger.kernel.org with ESMTP id S965157AbWH2RHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 13:07:09 -0400
Date: Tue, 29 Aug 2006 13:06:46 -0400 (EDT)
From: "Ian E. Morgan" <imorgan@webcon.ca>
X-X-Sender: imorgan@light.int.webcon.net
To: Wim Van Sebroeck <wim@iguana.be>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH][SBC8360] Re: Neverending module_param() bugs
In-Reply-To: <20060812214709.GC6252@martell.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.64.0608291301140.23609@light.int.webcon.net>
References: <20060812214709.GC6252@martell.zuzino.mipt.ru>
Organization: Webcon, Inc
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463806462-1472440461-1156871206=:23609"
X-Assp-Spam-Prob: 0.00000
X-Assp-Whitelisted: Yes
X-Assp-Envelope-From: imorgan@webcon.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806462-1472440461-1156871206=:23609
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sun, 13 Aug 2006, Alexey Dobriyan wrote:

> Can someone think of a way to explicitly tell driver author that last
> argument of module_param is PERMISSIONS, not default value? It's late
> here I can't. Preferably resulting in compilation failure.
> 
> drivers/char/watchdog/sbc8360.c:203:module_param(timeout, int, 27);

Here's my fix for sbc8360, inlined and attached. Please merge.

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan at webcon dot ca       PGP: #2DA40D07       www.webcon.ca
    *  Customized Linux Network Solutions for your Business  *
-------------------------------------------------------------------

--- linux-2.6.17.11/drivers/char/watchdog/sbc8360.c.orig	2006-08-29 12:55:26.000000000 -0400
+++ linux-2.6.17.11/drivers/char/watchdog/sbc8360.c	2006-08-29 12:58:20.000000000 -0400
@@ -201,7 +201,7 @@ static int wd_margin = 0xB;
 static int wd_multiplier = 2;
 static int nowayout = WATCHDOG_NOWAYOUT;
 
-module_param(timeout, int, 27);
+module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Index into timeout table (0-63) (default=27 (60s))");
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout,
@@ -408,7 +408,7 @@ module_exit(sbc8360_exit);
 MODULE_AUTHOR("Ian E. Morgan <imorgan@webcon.ca>");
 MODULE_DESCRIPTION("SBC8360 watchdog driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("1.0");
+MODULE_VERSION("1.01");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
 
 /* end of sbc8360.c */
---1463806462-1472440461-1156871206=:23609
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=sbc8360-1.01.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0608291306460.23609@light.int.webcon.net>
Content-Description: 
Content-Disposition: attachment; filename=sbc8360-1.01.patch

LS0tIGxpbnV4LTIuNi4xNy4xMS9kcml2ZXJzL2NoYXIvd2F0Y2hkb2cvc2Jj
ODM2MC5jLm9yaWcJMjAwNi0wOC0yOSAxMjo1NToyNi4wMDAwMDAwMDAgLTA0
MDANCisrKyBsaW51eC0yLjYuMTcuMTEvZHJpdmVycy9jaGFyL3dhdGNoZG9n
L3NiYzgzNjAuYwkyMDA2LTA4LTI5IDEyOjU4OjIwLjAwMDAwMDAwMCAtMDQw
MA0KQEAgLTIwMSw3ICsyMDEsNyBAQCBzdGF0aWMgaW50IHdkX21hcmdpbiA9
IDB4QjsNCiBzdGF0aWMgaW50IHdkX211bHRpcGxpZXIgPSAyOw0KIHN0YXRp
YyBpbnQgbm93YXlvdXQgPSBXQVRDSERPR19OT1dBWU9VVDsNCiANCi1tb2R1
bGVfcGFyYW0odGltZW91dCwgaW50LCAyNyk7DQorbW9kdWxlX3BhcmFtKHRp
bWVvdXQsIGludCwgMCk7DQogTU9EVUxFX1BBUk1fREVTQyh0aW1lb3V0LCAi
SW5kZXggaW50byB0aW1lb3V0IHRhYmxlICgwLTYzKSAoZGVmYXVsdD0yNyAo
NjBzKSkiKTsNCiBtb2R1bGVfcGFyYW0obm93YXlvdXQsIGludCwgMCk7DQog
TU9EVUxFX1BBUk1fREVTQyhub3dheW91dCwNCkBAIC00MDgsNyArNDA4LDcg
QEAgbW9kdWxlX2V4aXQoc2JjODM2MF9leGl0KTsNCiBNT0RVTEVfQVVUSE9S
KCJJYW4gRS4gTW9yZ2FuIDxpbW9yZ2FuQHdlYmNvbi5jYT4iKTsNCiBNT0RV
TEVfREVTQ1JJUFRJT04oIlNCQzgzNjAgd2F0Y2hkb2cgZHJpdmVyIik7DQog
TU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KLU1PRFVMRV9WRVJTSU9OKCIxLjAi
KTsNCitNT0RVTEVfVkVSU0lPTigiMS4wMSIpOw0KIE1PRFVMRV9BTElBU19N
SVNDREVWKFdBVENIRE9HX01JTk9SKTsNCiANCiAvKiBlbmQgb2Ygc2JjODM2
MC5jICovDQo=

---1463806462-1472440461-1156871206=:23609--
