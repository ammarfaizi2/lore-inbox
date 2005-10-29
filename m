Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbVJ2WH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVJ2WH3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 18:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVJ2WH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 18:07:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3340 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932461AbVJ2WH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 18:07:28 -0400
Date: Sat, 29 Oct 2005 23:07:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: ralf@linux-mips.org, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [FIXME] Comments on serial and MMC changes in MIPS merge
Message-ID: <20051029220722.GI14039@flint.arm.linux.org.uk>
Mail-Followup-To: ralf@linux-mips.org,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some comments on the recent MIPS merge:

1. au1xxx mmc driver

   mmc_remove_host() does a safe shutdown of the MMC host, removing
   cards and then powering down.  This must be called prior to the
   driver thinking of tearing anything down.

   As for those disable_irq()...enable_irq(), are you aware that MMC
   can start talking to the host as soon as you've called mmc_add_host() ?

2. IP3106 serial driver

   -#define PORT_MAX_8250  15      /* max port ID */
   +#define PORT_IP3106    16
   +#define PORT_MAX_8250  16      /* max port ID */

   Do not add new port numbers after the 8250 port number range.
   Add them on the end of the list.

   Since this will get in the way of additional 8250 ports, it's a
   serious problem.  Please fix ASAP.

   (btw, I notice that this change was _not_ included with the
    IP3106 driver you sent for review.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
