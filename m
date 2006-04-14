Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbWDNACo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWDNACo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 20:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWDNACo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 20:02:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:63137 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965022AbWDNACo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 20:02:44 -0400
Subject: Current linus git bcm4xxx broken for me
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: bcm43xx-dev@lists.berlios.de
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 10:02:36 +1000
Message-Id: <1144972957.5006.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get that with current upstream git :

[   34.127738] bcm43xx: Chip ID 0x4318, rev 0x2
[   34.136739] bcm43xx: Number of cores: 4
[   34.145660] bcm43xx: Core 0: ID 0x800, rev 0xd, vendor 0x4243, enabled
[   34.154658] bcm43xx: Core 1: ID 0x812, rev 0x9, vendor 0x4243, disabled
[   34.163560] bcm43xx: Core 2: ID 0x804, rev 0xc, vendor 0x4243, enabled
[   34.172422] bcm43xx: Core 3: ID 0x80d, rev 0x7, vendor 0x4243, enabled
[   34.184508] bcm43xx: PHY connected
[   34.193390] bcm43xx: Detected PHY: Version: 3, Type 2, Revision 7
[   34.202256] bcm43xx: Detected Radio: ID: 8205017f (Manuf: 17f Ver: 2050 Rev: 8)
[   34.211067] bcm43xx: Radio turned off
[   34.219814] bcm43xx: Radio turned off
[   35.158260] bcm43xx: PHY connected
[   35.315532] bcm43xx: Radio turned on
[   35.340646] bcm43xx: ASSERTION FAILED (radio_attenuation < 10) at: drivers/net/wireless/bcm43xx/bcm43xx_phy.c:1485:bcm43xx_find_lopair()
[   35.350611] bcm43xx: WARNING: Writing invalid LOpair (low: 58, high: 32, index: 130)
[   35.360642] Call Trace:
[   35.370672] [8F8AFBE0] [800080AC] show_stack+0x5c/0x1a0 (unreliable)
[   35.380875] [8F8AFC10] [C24D394C] bcm43xx_phy_lo_adjust+0xcc/0x390 [bcm43xx]
[   35.391054] [8F8AFC30] [C24CA19C] bcm43xx_radio_set_txpower_bg+0x18c/0x310 [bcm43xx]
[   35.401223] [8F8AFC50] [C24D2314] bcm43xx_phy_initb6+0x264/0x920 [bcm43xx]
[   35.411399] [8F8AFC70] [C24D4BD8] bcm43xx_phy_initg+0x428/0xff0 [bcm43xx]
[   35.421520] [8F8AFCE0] [C24D5864] bcm43xx_phy_init+0xc4/0x7b0 [bcm43xx]
[   35.431634] [8F8AFD00] [C24C4554] bcm43xx_wireless_core_init+0xaa4/0x12c0 [bcm43xx]
[   35.441842] [8F8AFDA0] [C24C5FA0] bcm43xx_init_board+0x300/0x690 [bcm43xx]
[   35.452092] [8F8AFDF0] [8027C3D8] dev_open+0x88/0xe0
[   35.462274] [8F8AFE10] [8027B124] dev_change_flags+0x144/0x180
[   35.472505] [8F8AFE30] [802C4D98] devinet_ioctl+0x628/0x760
[   35.482661] [8F8AFEA0] [802C5174] inet_ioctl+0xb4/0xe0
[   35.492743] [8F8AFEB0] [8026E28C] sock_ioctl+0xfc/0x270
[   35.502832] [8F8AFED0] [80094B7C] do_ioctl+0x3c/0x90
[   35.512837] [8F8AFEE0] [80094C5C] vfs_ioctl+0x8c/0x460
[   35.522718] [8F8AFF10] [80095070] sys_ioctl+0x40/0x80
[   35.532524] [8F8AFF40] [8000FBB4] ret_from_syscall+0x0/0x38

The error (with backtrace) is repeated every second or so. The card doesn't appear to associate.
It used to work with real old versions of the driver (though I never had it working above 11Mbits),
and I haven't tried again in the past few monthes mostly because I was too busy and couldn't be
bothered to try the new git based stuff.

Ben.


