Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbTI1VC5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 17:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbTI1VC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 17:02:57 -0400
Received: from h24-76-142-122.wp.shawcable.net ([24.76.142.122]:23815 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S262724AbTI1VC4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 17:02:56 -0400
Date: Sun, 28 Sep 2003 16:02:55 -0500 (CDT)
From: Derek Foreman <manmower@signalmarketing.com>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: CDROM_SEND_PACKET oddity
In-Reply-To: <20030928181421.GK15415@suse.de>
Message-ID: <Pine.LNX.4.58.0309281602020.1896@uberdeity.signalmarketing.com>
References: <Pine.LNX.4.58.0309262131110.15317@uberdeity.signalmarketing.com>
 <20030927114712.GJ3416@suse.de> <20030927122703.GK3416@suse.de>
 <20030927175445.GI15415@suse.de> <Pine.LNX.4.58.0309272200200.1850@uberdeity.signalmarketing.com>
 <20030928085119.GJ15415@suse.de> <Pine.LNX.4.58.0309281149590.3337@uberdeity.signalmarketing.com>
 <20030928181421.GK15415@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Sep 2003, Jens Axboe wrote:

> On Sun, Sep 28 2003, Derek Foreman wrote:
> > On Sun, 28 Sep 2003, Jens Axboe wrote:
> > 
> > > On Sat, Sep 27 2003, Derek Foreman wrote:
> > > > On Sat, 27 Sep 2003, Jens Axboe wrote:
> > > > 
> > > > -			memcpy(hdr.cmdp, cgc.cmd, sizeof(cgc.cmd));
> > > > +			hdr.cmdp = (unsigned char *)arg
> > > > +			         + offsetof(struct cdrom_generic_command, cmd);
> > > 
> > > No that's buggy, arg is a user pointer. It needs to read:
> > > 
> > > 			hdr.cmdp = cgc.cmd;
> > 
> > Actually, hdr.cmdp is expected to be a user pointer.  in sg_io we do
> > 
> >         rq->cmd_len = hdr->cmd_len;
> >         if (copy_from_user(rq->cmd, hdr->cmdp, hdr->cmd_len))
> >                 goto out_request;
> >         if (sizeof(rq->cmd) != hdr->cmd_len)
> 
> Ah you are right, I'd rather kill that too then like I removed user
> sg_io_hdr pointer as well. It makes for less error handling in sg_io().
> 

That one works great, thanks
