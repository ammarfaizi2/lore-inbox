Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVFTSIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVFTSIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVFTSIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:08:32 -0400
Received: from kanga.kvack.org ([66.96.29.28]:12736 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261410AbVFTSIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:08:19 -0400
Date: Mon, 20 Jun 2005 14:10:08 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, wli@holomorphy.com,
       zab@zabbo.net, mason@suse.com, ysaito@hpl.hp.com
Subject: Re: Pending AIO work/patches
Message-ID: <20050620181007.GA4031@kvack.org>
References: <20050620120154.GA4810@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620120154.GA4810@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 05:31:54PM +0530, Suparna Bhattacharya wrote:
> (1) Updating AIO to use wait-bit based filtered wakeups (me/wli)
> 	Status: Updated to 2.6.12-rc6, needs review
> (2) Buffered filesystem AIO read/write (me/Ben)
> 	Status: aio write: Updated to 2.6.12-rc6, needs review
> 	Status: aio read : Needs rework against readahead changes in mainline

I've looked over the patches from today and they seem quite sane.  Comments 
pending...

> (3) POSIX AIO support (Bull: Laurent/Sebastian or Oracle: Joel)
> 	Status: Needs review and discussion ?

The latest version incorporates changes from the last round of feedback 
(great work Sebastien!) and updates the library license, so people should 
definately take a closer look.  This includes the necessary changes for 
in-kernel signal support, as well as minimal conversion done on iocbs (the 
layout matches the in-kernel iocb).

A quick reading shows that most of it looks quite good.  I have to stare 
at the cancellation code a bit more closely, though.

> (4) AIO for pipes (Chris Mason)
> 	Status: Needs update to latest kernels

This likely needs a rewrite with whatever the final semaphore operations 
turn out to look like, as it gets very easy to convert down() into 
aio_down() and that minimises the changes to the code.

> (5) Asynchronous semaphore implementation (Ben/Trond?)
> 	Status: Posted - under development & discussion

I got the aio_down() variant working with cancellation now, and should be 
able to post an updated series of patches against 2.6.12 shortly.

> (6) epoll - AIO integration (Zach Brown/Feng Zhou/wli)
> 	Status: Needs resurrection ?

What are folks thoughts in this area?  Zach's patches took the approach of 
making multishot iocbs possible, which helped avoid the overhead of plain 
aio_poll's command setup, which was quite visible in pipetest.  Zach -- did 
you do any benchmarking on your aio-epoll patches?

> (7) Vector AIO (aio readv/writev) (Yasushi Saito)
> 	Status: Needs resurrection ?

Zach also made some noises about this recently...

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
