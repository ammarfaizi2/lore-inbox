Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbSLVKUu>; Sun, 22 Dec 2002 05:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbSLVKUu>; Sun, 22 Dec 2002 05:20:50 -0500
Received: from luyer.net ([203.62.148.69]:4480 "EHLO luyer.net")
	by vger.kernel.org with ESMTP id <S264939AbSLVKUt>;
	Sun, 22 Dec 2002 05:20:49 -0500
Date: Sun, 22 Dec 2002 21:28:49 +1100
From: David Luyer <david@luyer.net>
To: Bob <gillb4@telusplanet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre2 hdparm Kernel Oops
Message-ID: <20021222102849.GA2523@athena.luyer.net>
References: <1040374707.1476.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040374707.1476.12.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 01:58:27AM -0700, Bob wrote:
> Hi. I haven't seen any discussions about the 2.4.21-pre1 and pre2
> kernels kernel panicing when you execute  
> /sbin/hdparm -d1 -c3 -m16 -k1 /dev/hdb
> /sbin/hdparm -d1 -c3 -m16 -k1 /dev/hda
> 
> (where /dev/hda contains both my boot and root partitions).
> 
> I ran this command in a startup script to improve disk performance.  It
> would cause the kernel to panic on startup.  I commented it out of the
> script, and the newly built kernels would startup and run OK, but when I
> went back and re-ran the script (with the now running system), it would
> crash the box.  I installed a new version of hdparm (5.3) to make sure
> it wasn't an old version problem.
> 
> Thanks in advance, apologies if it's already been looked at, or if it's
> just me.

Is this an oops that looks somewhat like (giving one line of context here):

Freeing unused kernel memory: 88 kbytes.
kernel BUG in header file at line 155
kernel BUG at panic.c:141
invalid operand 0000
CPU: 0

and then traces back with:

>>EIP; c01148df <__out_of_line_bug+f/20>   <=====

Trace; c01a6ce7 <ide_build_sglist+127/160>
Trace; c01a738b <__ide_dma_read+2b/120>

...that's basically what I get with 2.4.21pre2, all drives on the legacy
IDE controller of an A7V333 and a PDC MBFastTrack133Lite RAID controller
configured in but no drives on it.

I'm doing some hdparms during bootup but I don't think it's getting to
them, I should add something to the top of the script to check, but I'd
rather not reboot the machine too often.

Apologies for the partial details of the oops, but my pen ran out. :-/

David.
-- 
David Luyer                                        Phone:   +61 3 9674 7525
Network Development Manager    P A C I F I C       Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T      Mobile:  +61 4 1111 BYTE
http://www.pacific.net.au/                         NASDAQ:  PCNTF
