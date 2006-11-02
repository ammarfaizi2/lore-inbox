Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752254AbWKBTFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbWKBTFL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 14:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752256AbWKBTFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 14:05:11 -0500
Received: from brick.kernel.dk ([62.242.22.158]:28182 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1752254AbWKBTFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 14:05:09 -0500
Date: Thu, 2 Nov 2006 20:07:01 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>, tytso@mit.edu
Subject: Re: [PATCH] splice : Must fully check for fifos
Message-ID: <20061102190700.GQ13555@kernel.dk>
References: <1162199005.24143.169.camel@taijtu> <200610311151.33104.dada1@cosmosbay.com> <200611021802.28519.dada1@cosmosbay.com> <200611021805.07962.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611021805.07962.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02 2006, Eric Dumazet wrote:
> With the patch this time :( Sorry guys
> 
> Hi Andrew
> 
> I think this patch is necessary. It's quite easy to crash a 2.6.19-rc4 box :(
> 
> AFAIK the problem come from inode-diet (by Theodore Ts'o, (2006/Sep/27))
> 
> Thank you
> 
> [PATCH] splice : Must fully check for FIFO
> 
> It appears that i_pipe, i_cdev and i_bdev share the same memory location 
> (anonymous union in struct inode) since commits 
> 577c4eb09d1034d0739e3135fd2cff50588024be
> eaf796e7ef6014f208c409b2b14fddcfaafe7e3a
> 
> Because of that, testing i_pipe being NULL is not anymore sufficient
> to tell if an inode is a FIFO or not.
> 
> Therefore, we must use the S_ISFIFO(inode->i_mode) test before
> assuming i_pipe pointer is pointing to a struct pipe_inode_info.

Indeed, the inode slimming introduced this bug. I'll queue up a test run
of things and send it upstream, thanks for catching this.

-- 
Jens Axboe

