Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWDYS3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWDYS3v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWDYS3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:29:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15708 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932281AbWDYS3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:29:50 -0400
Date: Tue, 25 Apr 2006 20:30:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Hua Zhong <hzhong@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: revert unlikely in ll_back_merge_fn
Message-ID: <20060425183026.GR4102@suse.de>
References: <Pine.LNX.4.64.0604251112490.5810@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604251112490.5810@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25 2006, Hua Zhong wrote:
> With likely/unlikely profiling (see the recent patch dwalker@mvista.com 
> sent), on my not-so-busy-typical-development system it shows more than 
> 80K misses and no hits. So I guess it makes sense to revert.
> 
> I don't know BIO code very well, but I hope this data is useful for the 
> experts.

Well you'd want to optimize for the busy case, right, no point in
optimizing for a more idle system.

I'm not at all uninterested in this, I'd just like to see a more
intelligent/controlled work load that actually stresses the io subsystem
being profiled. If you have a not-so-busy system, you like don't do
enough IO to trigger a lot of merges. Or maybe you do, and we just have
a bug somewhere so that we unfortunately repeatedly recount segments.

Care to run a simple io benchmark and profile that?

-- 
Jens Axboe

