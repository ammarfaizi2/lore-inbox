Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285174AbRLMUtO>; Thu, 13 Dec 2001 15:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285169AbRLMUtF>; Thu, 13 Dec 2001 15:49:05 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:16656 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S285166AbRLMUs5>; Thu, 13 Dec 2001 15:48:57 -0500
Message-Id: <200112132048.fBDKmog10485@aslan.scsiguy.com>
To: Steve Lord <lord@sgi.com>
cc: Jens Axboe <axboe@suse.de>, LBJM <LB33JM16@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping 
In-Reply-To: Your message of "13 Dec 2001 14:29:29 CST."
             <1008275369.22208.5.camel@jen.americas.sgi.com> 
Date: Thu, 13 Dec 2001 13:48:50 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>So according to this, zero.

Thanks for the info - its the first useful report I've gotten todate. 8-)
I believe I've found and fixed the bug.  I've changed a few other things
in the driver for the 6.2.5 release, so once I've tested them I'll release
new patches.  In the mean time, you should be able to avoid the problem by
moving the initialization of scb->sg_count to 0 in the function:

	aic7xxx_linux.c:ahc_linux_run_device_queue()

to before the statement:

	if (cmd->use_sg != 0) {

I'd give you diffs, but these other changes in my tree need more testing
before I'll feel comfortable releasing them.  I also don't have a 2.5 tree
downloaded yet to verify that the driver functions there.

In order to reproduce the bug, you need to issue a command that uses
all of the segments of a given transaction and then have a command with
use_sg == 0 be the next command to use that same SCB.  This explains why
I was not able to reproduce the problem here.

--
Justin
