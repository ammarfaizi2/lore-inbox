Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVFPG7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVFPG7i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 02:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVFPG73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 02:59:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:44739 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261739AbVFPG52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 02:57:28 -0400
Date: Thu, 16 Jun 2005 08:58:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.12-rc6-mm1] blk: cfq_find_next_crq fix
Message-ID: <20050616065840.GC1483@suse.de>
References: <20050616035622.GA29153@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050616035622.GA29153@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16 2005, Tejun Heo wrote:
>  Hello, Jens.
>  Hello, Andrew.
> 
>  In cfq_find_next_crq(), cfq tries to find the next request by
> choosing one of two requests before and after the current one.
> Currently, when choosing the next request, if there's no next request,
> the next candidate is NULL, resulting in selection of the previous
> request.  This results in weird scheduling.  Once we reach the end, we
> always seek backward.
> 
>  The correct behavior is using the first request as the next
> candidate.  cfq_choose_req() already has logics for handling wrapped
> requests.

Good spotting, applied. I'll set up an iosched git tree as well, with a
cfq-ts branch.

-- 
Jens Axboe

