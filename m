Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVAMAL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVAMAL1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVAMALX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 19:11:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8708 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261376AbVAMAJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 19:09:52 -0500
Date: Thu, 13 Jan 2005 00:09:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, ecashin@coraid.com
Subject: [BUG] ATA over Ethernet __init calling __exit
Message-ID: <20050113000949.A7449@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	ecashin@coraid.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

static void __exit
aoe_exit(void)
{
...
}

static int __init
aoe_init(void)
{
...
                        aoe_exit();
...
}

Enough said, please shoot the author of that in the foot.  You can't
call functions marked __exit (which may be discarded) from functions
which aren't.  If you want to do this, please loose the __exit on
aoe_exit().

In addition, please shoot the author in the other foot for:

config ATA_OVER_ETH
        tristate "ATA over Ethernet support"
        depends on NET
        default m               <==== this line.

That's not nice for embedded guys who do a "make xxx_defconfig" and
unsuspectingly end up with ATA over Ethernet built in for their
platform.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
