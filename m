Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbTI1Q4f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 12:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbTI1Q4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 12:56:35 -0400
Received: from h24-76-142-122.wp.shawcable.net ([24.76.142.122]:7431 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S262624AbTI1Q4e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 12:56:34 -0400
Date: Sun, 28 Sep 2003 11:56:32 -0500 (CDT)
From: Derek Foreman <manmower@signalmarketing.com>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: CDROM_SEND_PACKET oddity
In-Reply-To: <20030928085119.GJ15415@suse.de>
Message-ID: <Pine.LNX.4.58.0309281149590.3337@uberdeity.signalmarketing.com>
References: <Pine.LNX.4.58.0309262131110.15317@uberdeity.signalmarketing.com>
 <20030927114712.GJ3416@suse.de> <20030927122703.GK3416@suse.de>
 <20030927175445.GI15415@suse.de> <Pine.LNX.4.58.0309272200200.1850@uberdeity.signalmarketing.com>
 <20030928085119.GJ15415@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Sep 2003, Jens Axboe wrote:

> On Sat, Sep 27 2003, Derek Foreman wrote:
> > On Sat, 27 Sep 2003, Jens Axboe wrote:
> > 
> > -			memcpy(hdr.cmdp, cgc.cmd, sizeof(cgc.cmd));
> > +			hdr.cmdp = (unsigned char *)arg
> > +			         + offsetof(struct cdrom_generic_command, cmd);
> 
> No that's buggy, arg is a user pointer. It needs to read:
> 
> 			hdr.cmdp = cgc.cmd;

Actually, hdr.cmdp is expected to be a user pointer.  in sg_io we do

        rq->cmd_len = hdr->cmd_len;
        if (copy_from_user(rq->cmd, hdr->cmdp, hdr->cmd_len))
                goto out_request;
        if (sizeof(rq->cmd) != hdr->cmd_len)
