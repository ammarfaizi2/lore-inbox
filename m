Return-Path: <SRS0=kSh0=6A=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6B6C38A29
	for <io-uring@archiver.kernel.org>; Thu, 16 Apr 2020 06:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60EE206D6
	for <io-uring@archiver.kernel.org>; Thu, 16 Apr 2020 06:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587019436;
	bh=BKmhwxbmr2z9YCdItTQJHwRjKGeTBBS+eQgot1INXhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e8fTpjOK7RCj/mM32rQx3o1mhZ+qE10uzmyJcPrhluG3l3hl70oiT5k9s7GlkuQjz
	 5wVPhK8OlBouzaLGgjr2HUbm/LkaQMl8Xj7ZcXXIh5lrEjVIukjtVJ9bL0gV3XIFym
	 VHdJVjixqJy9raWIxjWITew5stpwzxkgqScDuC/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408422AbgDPGns (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:43:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408168AbgDPGnp (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Thu, 16 Apr 2020 02:43:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4DA8206D6;
        Thu, 16 Apr 2020 06:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587019423;
        bh=BKmhwxbmr2z9YCdItTQJHwRjKGeTBBS+eQgot1INXhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWchGAC+vAFFSp6qh9NsLKsGlU90wq24zkjqWRuJQDRzI7cr9AxDmicO2eD+IzJ3c
         sGCzNz3JCiuBvIVBeRdXO2UQKyfJ3SXnfZbVTf7z3X6+UWo1V7dQ9GHa/KBptAxeB3
         icdyyi0gEO6PLAhNJ9+K2CaqqrQu1Y95AIUwfP44=
Date:   Thu, 16 Apr 2020 08:43:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/3] kernel: better document the use_mm/unuse_mm API
 contract
Message-ID: <20200416064341.GB300290@kroah.com>
References: <20200416053158.586887-1-hch@lst.de>
 <20200416053158.586887-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416053158.586887-3-hch@lst.de>
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Thu, Apr 16, 2020 at 07:31:57AM +0200, Christoph Hellwig wrote:
> Switch the function documentation to kerneldoc comments, and add
> WARN_ON_ONCE asserts that the calling thread is a kernel thread and
> does not have ->mm set (or has ->mm set in the case of unuse_mm).
> 
> Also give the functions a kthread_ prefix to better document the
> use case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> [usb]
