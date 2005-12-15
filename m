Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422655AbVLOJWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422655AbVLOJWe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422664AbVLOJWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:22:33 -0500
Received: from main.gmane.org ([80.91.229.2]:28093 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422655AbVLOJVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:21:53 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Aric Cyr <Aric.Cyr@gmail.com>
Subject: Re: amd64 cdrom access locks system
Date: Thu, 15 Dec 2005 09:15:44 +0000 (UTC)
Message-ID: <loom.20051215T100746-620@post.gmane.org>
References: <42A64556.4060405@cyte.com> <20050608052354.7b70052c.akpm@osdl.org>  <42A861F8.9000301@cyte.com> <20050609160045.69c579d2.akpm@osdl.org>  <42ADB5B4.1020704@cyte.com>  <58cb370e05061400555407d144@mail.gmail.com>  <42AEB30B.1070808@cyte.com> <58cb370e05061411162b190ae9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 203.179.21.193 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051018 Firefox/1.0.7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier <at> gmail.com> writes:

> 
> On 6/14/05, Jeff Wiegley <jeffw <at> cyte.com> wrote:
> > using "dev=/dev/hda" yeilds the exact same behavior...
> > 
> >    Jun 14 03:21:50 localhost kernel: ide-cd: cmd 0x3 timed out
> >    Jun 14 03:21:50 localhost kernel: hda: lost interrupt
> >    Jun 14 03:22:50 localhost kernel: ide-cd: cmd 0x3 timed out
> >    Jun 14 03:22:50 localhost kernel: hda: lost interrupt
> >    Jun 14 03:23:30 localhost kernel: hda: lost interrupt
> 
> Jens, any idea?
> 
> > And I'm a little confused by Robert's suggestion... Should it
> > ever be possible for a user-space application to cause lost
> > interrupts and other kernel state problems regardless of what
> > "interface" is used?? Sure, if the application uses the wrong
> > interface it should get spanked somehow but should it be able to
> > mess up the kernel for other applications as well? (Like now
> > I can't read or eject.)
> 
> It shouldn't be possible unless it is "raw" interface
> (requires CAP_SYS_RAWIO) w/o checking all possible
> parameters (it is not always possible) or device is buggy.
> 
> Also it is quite unlikely that somebody will fix obsolete
> interface (hey, it got obsoleted for some reason .
> 
> Bartlomiej
> 

Has this problem been fixed at all or any workarounds known?  I am having the
exact same issue with similar hardware and the alim15x3 driver.  In my case it
does not matter which method I use for cdrecord (ATA:, ATAPI: or dev=/dev/hda),
I will always get the lost interrupts from the command "cdrecord -atip".  I have
tried other drives without success so I don't believe that is the problem. 
Interestingly cdrdao does not have any problems at all and burns perfectly, so I
suspect that cdrecord might be throwing some command that ide-cd or the IDE
drive doesn't like and fails to recover from.  However, disabling DMA on the
drive via hdparm makes cdrecord work perfectly, so I suspect the alim15x3 driver
more than anything else.  I can play DVDs for hours with DMA enabled just fine
though... go figure.  My current kernel is 2.6.14-gentoo-r6, but I have had this
problem since I first had got the system (around 2.6.12).

I'm really anxious to track this down so if anyone has any information, or need
something from me (logs or debugging) please don't hesitate to ask.

Regards,
  Aric

