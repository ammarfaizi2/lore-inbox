Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285180AbRLMVAo>; Thu, 13 Dec 2001 16:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285169AbRLMVAe>; Thu, 13 Dec 2001 16:00:34 -0500
Received: from zok.sgi.com ([204.94.215.101]:25248 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S285178AbRLMVAT>;
	Thu, 13 Dec 2001 16:00:19 -0500
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
From: Steve Lord <lord@sgi.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Jens Axboe <axboe@suse.de>, LBJM <LB33JM16@yahoo.com>,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
In-Reply-To: <200112132048.fBDKmog10485@aslan.scsiguy.com>
In-Reply-To: <200112132048.fBDKmog10485@aslan.scsiguy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.13.08.57 (Preview Release)
Date: 13 Dec 2001 14:58:31 -0600
Message-Id: <1008277112.22093.7.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-12-13 at 14:48, Justin T. Gibbs wrote:
> >So according to this, zero.
> 
> Thanks for the info - its the first useful report I've gotten todate. 8-)
> I believe I've found and fixed the bug.  I've changed a few other things
> in the driver for the 6.2.5 release, so once I've tested them I'll release
> new patches.  In the mean time, you should be able to avoid the problem by
> moving the initialization of scb->sg_count to 0 in the function:
> 
> 	aic7xxx_linux.c:ahc_linux_run_device_queue()
> 
> to before the statement:
> 
> 	if (cmd->use_sg != 0) {
> 
> I'd give you diffs, but these other changes in my tree need more testing
> before I'll feel comfortable releasing them.  I also don't have a 2.5 tree
> downloaded yet to verify that the driver functions there.
> 
> In order to reproduce the bug, you need to issue a command that uses
> all of the segments of a given transaction and then have a command with
> use_sg == 0 be the next command to use that same SCB.  This explains why
> I was not able to reproduce the problem here.

Thanks, I will test it out here and let you know, looks like David
Miller is proposing the same assignment in a different place.

Steve

> 
> --
> Justin
-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
