Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUGFGyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUGFGyB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 02:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUGFGyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 02:54:00 -0400
Received: from jupiter.loonybin.net ([208.248.0.98]:55049 "EHLO
	jupiter.loonybin.net") by vger.kernel.org with ESMTP
	id S263540AbUGFGrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 02:47:46 -0400
Date: Tue, 6 Jul 2004 01:47:25 -0500
From: Zinx Verituse <zinx@epicsol.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 8139too in 2.6.x tx timeout
Message-ID: <20040706064725.GA11069@bliss>
References: <20040626222304.GA31195@bliss> <87hdsoghdv.fsf@devron.myhome.or.jp> <20040704194009.GA2029@bliss> <873c4713fl.fsf@ibmpc.myhome.or.jp> <20040706053328.GA860@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040706053328.GA860@bliss>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 12:33:28AM -0500, Zinx Verituse wrote:
> On Mon, Jul 05, 2004 at 01:30:22PM +0900, OGAWA Hirofumi wrote:
> > Zinx Verituse <zinx@epicsol.org> writes:
> > 
> > > Up with some other files:
> > > http://zinx.xmms.org/misc/tmp/8139too/
> > > linux-2.6.7-mobius-dotconfig (.config being used for the kernel)
> > 
> > Probably this isn't fix the problem, but can you try the following?
> > 
> > CONFIG_8139TOO_PIO=n
> > CONFIG_8139TOO_TUNE_TWISTER=n
> > 
> > (both config to "n")
> > 
> 
> Tried, but didn't work (not relevant due to new information after I tried,
> though -- see below)
> 
> > > On the ping -c1: several pings made it, then it didn't reply for one,
> > > but also reported no timeout in the messages.  Another ping caused it
> > > to not reply _and_ to timeout/reset.
> > 
> > This may not be the problem of 8139too driver, because 2.4.24's
> > driver didn't fix.
> > 
> > Umm.. possible of cable or hub problem, but 2.4.24 is work...
> > Do you know lastest worked version?
> > 
> 
> I just tried a 2.4.24 kernel I compiled myself -- It doesn't work.
> I tried booting the 2.4.24-xfs knoppix kernel on my actual system
> instead of the knoppix CD (required a bit of fiddling to get it
> booting) -- Also does not work.
> 
> So, it seems to be some configuration issue on my end, though I'm
> not sure what at this point (first thing i tried way back was copying
> knoppix's /etc/pcmcia).  Ah well, I'll figure it out eventually :)
> Thanks for your time :)
> 

I have now discovered what causes the card to work on knoppix --
The probe during the loading of the OSS "cs46xx.o" driver.  This driver
doesn't work with my sound card (non-AC97 codec), and does not finish
loading, but apparently it does some magic that causes the rtl8139C NIC
I have to work :x

So, it's not a configuration problem after all :(

I'll be loading this driver in 2.6.7 in the short term, but it does
appear to mash some random registers, possibly the 8139's, and it may
fool around with interrupts.  I'll look in to the probe process more
later and see if I can figure out something real for the 8139too driver.

I've put up the output from cs46xx and 8139too (2.4.24) at:
http://zinx.xmms.org/misc/tmp/8139too/cs46xx.log

> > > By the way, I downloaded the specs for the 8139C and noticed immediately
> > > it claims writing to the ISR has no effect and that reading it clears it.
> > > The drivers appear to indicate this documentation is entirely wrong --
> > > Is there any real documentation for this chipset?
> > 
> > Indeed. I think you are reading the same document with me. Docs says it,
> > however, the interrupt status wasn't cleared by read.
> > -- 
> > OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> >  
> > 
> 
> -- 
> Zinx Verituse                                    http://zinx.xmms.org/

-- 
Zinx Verituse                                    http://zinx.xmms.org/
