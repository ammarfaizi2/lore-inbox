Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTEBIES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 04:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbTEBIES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 04:04:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25510 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261876AbTEBIER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 04:04:17 -0400
Date: Fri, 2 May 2003 10:16:34 +0200
From: Jens Axboe <axboe@suse.de>
To: Zhihui Zhang <bf20761@binghamton.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re-drive buffer head more than once
Message-ID: <20030502081633.GC1012@suse.de>
References: <Pine.SOL.L4.44.0305011246180.28401-100000@bingsun2.cc.binghamton.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.L4.44.0305011246180.28401-100000@bingsun2.cc.binghamton.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01 2003, Zhihui Zhang wrote:
> Hi,
> 
> Is it legal to call general_make_request() more than once on the same bh?
> What will happen if a previous request is still in the queue, or just
> initiated but not finished yet?  If I call general_make_request() on the
> same buffer 10 times, does it mean the same buffer will *always* be
> written 10 times on the disk?

It's not legal to call generic_make_request() on a buffer_head, if you
have not acquired the BH_Lock first. The buffer_head will be unlocked on
IO completion, so that basically tells you that you cannot issue more
than _one_ generic_make_request() on a buffer_head.

If you fail to comply with that, then you will basically corrupt the
existing request in the queue where the buffer is attached. You _must_
do a lock_buffer() before calling generic_make_request.

-- 
Jens Axboe

