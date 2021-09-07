Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9633C433F5
	for <io-uring@archiver.kernel.org>; Tue,  7 Sep 2021 07:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08176108D
	for <io-uring@archiver.kernel.org>; Tue,  7 Sep 2021 07:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbhIGHtb (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 7 Sep 2021 03:49:31 -0400
Received: from verein.lst.de ([213.95.11.211]:34965 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233953AbhIGHtH (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Tue, 7 Sep 2021 03:49:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 14DD667373; Tue,  7 Sep 2021 09:48:00 +0200 (CEST)
Date:   Tue, 7 Sep 2021 09:47:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        anuj20.g@samsung.com, javier.gonz@samsung.com, hare@suse.de
Subject: Re: [RFC PATCH 4/6] io_uring: add helper for fixed-buffer uring-cmd
Message-ID: <20210907074759.GC29874@lst.de>
References: <20210805125539.66958-1-joshi.k@samsung.com> <CGME20210805125931epcas5p259fec172085ea34fdbf5a1c1f8da5e90@epcas5p2.samsung.com> <20210805125539.66958-5-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805125539.66958-5-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Thu, Aug 05, 2021 at 06:25:37PM +0530, Kanchan Joshi wrote:
> +int io_uring_cmd_import_fixed(void *ubuf, unsigned long len,
> +		int rw, struct iov_iter *iter, void *ioucmd)
> +{
> +	u64 buf_addr = (u64)ubuf;

This will cause a warning on 32-bit platforms.
