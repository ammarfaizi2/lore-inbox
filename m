Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVCZWxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVCZWxC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 17:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVCZWxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 17:53:02 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:21972 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261340AbVCZWwq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 17:52:46 -0500
Date: Sat, 26 Mar 2005 23:50:56 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: [PATCH] r8169 backport for 2.4.x
Message-ID: <20050326225056.GA27494@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It took a bit longer than expected but the backport of the r8169 driver
has been updated for kernel 2.4.29.

Noticeable changes since 12/2004:
- better handling of PHY as found on Acer Aspire 1524WLMi (Richard Dawe);
- fix a bug triggered when the device is brought down then up again;
- avoid a few lost/screaming interrupts;
- closed a race when a change of mtu is issued during network activity;
- fix VLAN on big-endian hosts;
- merge relevant changes from Realtek's 2.2 driver;
- ethtool stats (Stephen Hemminger);
- ethtool msglevel support (Stephen Hemminger);
- fix Rx descriptors f*ckup [*];
- fix incoming frame length check [*].

There are probably some bits of Jon Mason as well but I'm too lazy to
check and the whole detail is available in the patch-script directory.

If your r8169 device will never receive oversized frames nor can it 
experience a really high packet per second stream (count 50kpps as low),
the items marked [*] make no difference. If the adapter is on a public
lan and/or it does not use the default 1500 MTU, you almost surely want
these.

If it worked for you before, you should not notice anything.

Patch against 2.4.29/2.4.30-rc3:
- http://www.fr.zoreil.com/~romieu/misc/20050326-2.4.29-r8169-test.patch

Patch-script directory (65 patches):
- http://www.fr.zoreil.com/linux/kernel/2.4.x/2.4.29/r8169/

Patch-script tarball:
- http://www.fr.zoreil.com/linux/kernel/2.4.x/2.4.29/r8169-blob.tar.bz2

As usual, success/regression reports will be welcome.

Thank you for your attention.

--
Ueimor
