Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbULEM0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbULEM0r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 07:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbULEM0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 07:26:47 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:40935 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261296AbULEM0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 07:26:44 -0500
Date: Sun, 5 Dec 2004 13:24:14 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Nicholas Papadakos <panic@quake.gr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: realtek r8169 + kernel 2.4.24 (openmosix)
Message-ID: <20041205122414.GA22383@electric-eye.fr.zoreil.com>
References: <20041204173327.GA4026@electric-eye.fr.zoreil.com> <200412050124.iB51O6Ym014932@kane.otenet.gr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <200412050124.iB51O6Ym014932@kane.otenet.gr>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Nicholas Papadakos <panic@quake.gr> :
[...]
> I commented out the line recompiled but still same problem.

gcc should spit one message less.

> I tried to apply the patch both in the older version and in the new one but
> nothing.

The tabs have been turned into spaces. Either add 'ull' to 0x0badbadbadbadbad
or apply the attached version (don't edit/copy/paste it if you are not sure
that the tabs are preserved).

[...]
> And yeah values greater than 1500 would improve openmosix a lot a believe.

A backport of the test version of the 2.6.x driver (SG, RX/TX csum, up to ~7000
bytes frames, patch against vanilla 2.4.28) is available at:
http://www.fr.zoreil.com/people/francois/misc/20041205-2.4.28-r8169.c-test.patch

For the curious one, the patchscript version can be found at:
http://www.fr.zoreil.com/linux/kernel/2.4.x/2.4.28

It compiles but it is completely untested. You should probably wait a bit until
I verify it is not trivially broken. Otoh, if you have some spare time...

--
Ueimor

--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="r8169-mini-fix.patch"

--- drivers/net/r8169.c.orig	2004-12-04 18:22:18.000000000 +0100
+++ drivers/net/r8169.c	2004-12-04 18:22:37.000000000 +0100
@@ -1161,7 +1161,7 @@ rtl8169_hw_start(struct net_device *dev)
 
 static inline void rtl8169_make_unusable_by_asic(struct RxDesc *desc)
 {
-	desc->addr = 0x0badbadbadbadbad;
+	desc->addr = 0x0badbadbadbadbadull;
 	desc->status &= ~cpu_to_le32(OWNbit | RsvdMask);
 }
 

--hHWLQfXTYDoKhP50--
