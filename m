Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbTI0SL2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 14:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbTI0SL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 14:11:28 -0400
Received: from [24.76.142.122] ([24.76.142.122]:20230 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S261360AbTI0SL1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 14:11:27 -0400
Date: Sat, 27 Sep 2003 13:11:25 -0500 (CDT)
From: Derek Foreman <manmower@signalmarketing.com>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: CDROM_SEND_PACKET oddity
In-Reply-To: <20030927175445.GI15415@suse.de>
Message-ID: <Pine.LNX.4.58.0309271310170.1820@uberdeity.signalmarketing.com>
References: <Pine.LNX.4.58.0309262131110.15317@uberdeity.signalmarketing.com>
 <20030927114712.GJ3416@suse.de> <20030927122703.GK3416@suse.de>
 <20030927175445.GI15415@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Sep 2003, Jens Axboe wrote:

> On Sat, Sep 27 2003, Jens Axboe wrote:
> > On Sat, Sep 27 2003, Jens Axboe wrote:
> > > On Fri, Sep 26 2003, Derek Foreman wrote:
> > > > The example code from
> > > > http://www.ussg.iu.edu/hypermail/linux/kernel/0202.0/att-0603/01-cd_poll.c
> > > > 
> > > > Does not behave as expected on my 2.6.0-test5 system.  While the command 
> > > > seems to be successfully sent - 2 of my drives report it as an invalid 
> > > > opcode - for the other 2 drives, the buffer comes back all zeros.
> > > > (actually, the buffer's contents will remain in whatever state they're in 
> > > > before the ioctl is called)
> > > > 
> > > > Sending the same command to those 2 drives with SG_IO results in the 
> > > > expected behaviour.
> > > 
> > > Can you try current -bk? It has some fixes for CDROM_SEND_PACKET.
> > > 
> > > However, cd_poll should be rewritten to use SG_IO. Pretty trivial
> > > exercise.
> > 
> > Actually, try this patch against current bk, it kills the
> > CDROM_SEND_PACKET setup and use SG_IO internally instead. Should be much
> > much better than what we have now. It's not tested here at all though,
> > I'd appreciate it if you could give it a go.
> 
> This has a better chance of working. Changes:
> 
> - Don't export sg_io() anyways (leftover)
> - Actually set ->cmdp and ->cmd_len
> 
> still untested.

The old one worked after I fixed it up to set cmdp and the sense buffer.  
I'll test this one out a little later today.
