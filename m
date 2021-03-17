Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDC8C433E0
	for <io-uring@archiver.kernel.org>; Wed, 17 Mar 2021 17:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F4464E90
	for <io-uring@archiver.kernel.org>; Wed, 17 Mar 2021 17:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhCQRC0 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:02:26 -0400
Received: from verein.lst.de ([213.95.11.211]:38069 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232698AbhCQRCP (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Wed, 17 Mar 2021 13:02:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4935068BEB; Wed, 17 Mar 2021 18:02:12 +0100 (CET)
Date:   Wed, 17 Mar 2021 18:02:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
        chaitanya.kulkarni@wdc.com, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, anuj20.g@samsung.com,
        javier.gonz@samsung.com, nj.shetty@samsung.com,
        selvakuma.s1@samsung.com
Subject: Re: [RFC PATCH v3 3/3] nvme: wire up support for async passthrough
Message-ID: <20210317170212.GB25097@lst.de>
References: <20210316140126.24900-1-joshi.k@samsung.com> <CGME20210316140240epcas5p3e71bfe2afecd728c5af60056f21cc9b7@epcas5p3.samsung.com> <20210316140126.24900-4-joshi.k@samsung.com> <20210317164550.GA4162742@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317164550.GA4162742@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Wed, Mar 17, 2021 at 09:45:50AM -0700, Keith Busch wrote:
> > +	if (ioucmd) { /* async handling */
> > +		u32 effects;
> > +
> > +		effects = nvme_command_effects(ns->ctrl, ns, cmd->common.opcode);
> > +		/* filter commands with non-zero effects, keep it simple for now*/
> 
> You shouldn't need to be concerned with this. You've wired up the ioucmd
> only to the NVME_IOCTL_IO_CMD, and nvme_command_effects() can only
> return 0 for that.
> 
> It would be worth adding support for NVME_IOCTL_IO_CMD64 too, though,
> and that doesn't change the effects handling either.

There is no good reason to support the non-64 structure in new code.
And we really should support the admin command submission (on the char
device node) as well.
