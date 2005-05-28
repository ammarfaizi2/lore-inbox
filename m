Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbVE1APj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbVE1APj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 20:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVE1APj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 20:15:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:434 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262608AbVE1APa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 20:15:30 -0400
Date: Fri, 27 May 2005 17:16:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Fieroch <Fieroch@web.de>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:
 nobody cared!"
Message-Id: <20050527171613.5f949683.akpm@osdl.org>
In-Reply-To: <d6gf8j$jnb$1@sea.gmane.org>
References: <d6gf8j$jnb$1@sea.gmane.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Fieroch <Fieroch@web.de> wrote:
>
> Problem 1:
> while booting the message "hdb: cdrom_pc_intr: The drive appears
> confused (ireason = 0x01)" repeats several times and the system hangs
> for some seconds. After booting sometimes I get the same message and
> linux hangs.
> 
> Problem 2:
> syslog message "irq 18: nobody cared!" followed by a call trace repeats
> while booting and while running linux.
> 
> On the bottom of this mail you'll find an extract of /var/log/syslog
> showing this error.
> 
> 
> My system is a P4 630 with em64t, ASUS P5GD2 Premium board (ICH6
> chipset) and nvidia 6600GT PCIe graphic card.
> I'm running a self compiled kernel 2.6.12rc4 but I've had these bugs in
>  self compiled kernel 2.6.11.8 and default debian kernel
> 2.6.11-9-em64t-p4-smp too.
> The default debian kernel 2.6.8-11-em64t-p4-smp seems to be the only one
> where problem 1 does not occur but problem 2 does.

Does the thing work correctly under any versions of Linux?  If so, which?

It appears that you entered cdrom_pc_intr() with IDE_IREASON_REG = 0x01.

 * ATAPI Interrupt Reason Register.
 *
 * cod          : Information transferred is command (1) or data (0)
 * io           : The device requests us to read (1) or write (0)

io = 0
cod = 1

I'm not sure what this means.  It generated an interrupt, expecting the
kernel to send a write command?  That sounds odd.

If the answer to my first queston is "no" then perhaps the hardware is
busted.  Try swapping out cables, check power supplies, try a different
drive, etc.

If none of that helps then perhaps there's something we can do in
cdrom_pc_intr() to work around this?

(Should cdrom_pc_intr() be using atapi_ireason_t?)

