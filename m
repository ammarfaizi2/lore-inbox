Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWHRQdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWHRQdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWHRQdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:33:21 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:58516 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751411AbWHRQdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:33:20 -0400
Subject: Re: Serial issue
From: Lee Revell <rlrevell@joe-job.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <1155915851.3426.4.camel@amdx2.microgate.com>
References: <1155862076.24907.5.camel@mindpipe>
	 <1155915851.3426.4.camel@amdx2.microgate.com>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 12:34:04 -0400
Message-Id: <1155918845.24907.42.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 10:44 -0500, Paul Fulghum wrote:
> On Thu, 2006-08-17 at 20:47 -0400, Lee Revell wrote:
> > I've found a weird serial bug.  My host is a Via EPIA M-6000 running
> > 2.6.17 connected to a PPC Yosemite board running 2.6.13. 
> > 
> > In all cases the serial console works great.  But, with the default
> > setting of IRQ 4, Kermit file transfers via the serial interface simply
> > time out.  However if I use polling mode (setserial /dev/ttyS0 irq 0 on
> > the host), file transfers work.
> > 
> > When set to IRQ 4, the interrupt count does increase.
> > 
> > # cat /proc/tty/driver/serial 
> > serinfo:1.0 driver revision:
> > 0: uart:16550A port:000003F8 irq:4 tx:267 rx:667 DSR|CD
> > [...]
> > 
> > Any ideas?  I'm guessing it might be a quirk of the VIA chipset?
> 
> You mention serial console. Hasn't there been some changes
> related to reenabling the THRE interrupt after sending
> console data? IIRC the changes fixed transmit stalls on
> some machines but broke things on other machine.
> 
> Can you try disabling the serial console and see
> if the file transfer starts working?
> 

I tried it with the serial console inactive (not disabled) and file
transfers don't work whether I set IRQ 0 or 4.  Maybe I'm doing it wrong
- I connected to the target via SSH and ran "gkermit -r" then ran
ckermit locally and issued a "send file.txt" command.

Normally I connect to the target with "kermit -c" which gives me a
serial console, then issue a "gkermit -r", then escape to my local
Kermit and issue the send file command.

Lee

