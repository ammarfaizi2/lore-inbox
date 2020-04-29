Return-Path: <SRS0=pVP4=6N=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C0CC83004
	for <io-uring@archiver.kernel.org>; Wed, 29 Apr 2020 15:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2680A20731
	for <io-uring@archiver.kernel.org>; Wed, 29 Apr 2020 15:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NCst16kY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgD2P0w (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD2P0w (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 29 Apr 2020 11:26:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36CBC03C1AD
        for <io-uring@vger.kernel.org>; Wed, 29 Apr 2020 08:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FUUB5IBKoVMuHMbwf2DSLUoG5x9Iaua6beWGI0rA6V0=; b=NCst16kYfnDhXkxgTu1+fga1fi
        /NzMcurBT5Yc8qKnXi3XHdmcVYFqXVk8scoUBk+mzzmmLJTWZLyjDx798hQstfxnth9cVZ218jDNY
        HWAUVyz9L0p69Nj4ckT8kW9wB0n7PqRAPSSn/tonP1KaGHiZxX7/MZo63UBloAaDrOSqKlUOJ5ERw
        M/TNgGignC3iwh8L5Hm4wai5ZszHVb5bnIWWczG37WYWhPFe5aM7neZnJwujj1s42xXfg4k5SiZ/P
        N++0ps/cmX7WYcCmTdexNXbDaWZ0K0uVLvxzQ0C4KuqB+H+bYMNpUL5oZ+krzMInjq1hCPCc+OV1I
        sFX+SkaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTobn-0006yA-0B; Wed, 29 Apr 2020 15:26:47 +0000
Date:   Wed, 29 Apr 2020 08:26:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>,
        io-uring@vger.kernel.org
Subject: Re: Build 0.6 version fail on musl libc
Message-ID: <20200429152646.GA17156@infradead.org>
References: <20200428192956.GA32615@arya.arvanta.net>
 <04edfda7-0443-62e1-81af-30aa820cf256@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04edfda7-0443-62e1-81af-30aa820cf256@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Wed, Apr 29, 2020 at 09:24:40AM -0600, Jens Axboe wrote:
> 
> Not sure what the best fix is there, for 32-bit, your change will truncate
> the offset to 32-bit as off_t is only 4 bytes there. At least that's the
> case for me, maybe musl is different if it just has a nasty define for
> them.
> 
> Maybe best to just make them uint64_t or something like that.

The proper LFS type would be off64_t.
