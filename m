Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275238AbTHGIpE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 04:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275239AbTHGIpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 04:45:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6071 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S275238AbTHGIpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 04:45:00 -0400
Date: Thu, 7 Aug 2003 10:44:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm5
Message-ID: <20030807084451.GA858@suse.de>
References: <20030806223716.26af3255.akpm@osdl.org> <28050000.1060237907@[10.10.2.4]> <20030807000542.5cbf0a56.akpm@osdl.org> <3F320DFC.6070400@cyberone.com.au> <3F32108A.2010000@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F32108A.2010000@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07 2003, Nick Piggin wrote:
> --- linux-2.6/drivers/block/as-iosched.c.orig	2003-08-07 18:33:06.000000000 +1000
> +++ linux-2.6/drivers/block/as-iosched.c	2003-08-07 18:36:03.000000000 +1000
> @@ -1198,8 +1198,10 @@ static int as_dispatch_request(struct as
>  			 */
>  			goto dispatch_writes;
>  
> - 		if (ad->batch_data_dir == REQ_ASYNC)
> + 		if (ad->batch_data_dir == REQ_ASYNC) {
> +			WARN_ON(ad->new_batch || ad->changed_batch);

combining debug checks like this is generally a bad idea imho, since you
don't know which of them triggered...

-- 
Jens Axboe

