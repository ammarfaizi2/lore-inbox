Return-Path: <SRS0=3AE1=76=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24407C433E0
	for <io-uring@archiver.kernel.org>; Wed, 17 Jun 2020 17:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1134212CC
	for <io-uring@archiver.kernel.org>; Wed, 17 Jun 2020 17:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KH9dEePl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFQRm7 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQRm7 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 17 Jun 2020 13:42:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAFDC06174E;
        Wed, 17 Jun 2020 10:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CkyHJY+MLCHaDHdWKXst4+zbNAtcnZ7dwIww1fY+0cU=; b=KH9dEePlMHpTfpCpY97B0WgqzR
        apq9Cwcf0HNGJgYj8xSCmuLWcRoCSO1GjCmpI7XH8KV1PJs+h9dHna54hr4ieZxHtcdOiO/BxiRnk
        iYYte5LX7UYv4axoVDkT6leuq/+JjUrfGAdw5iI9WiLpGIlgblUJYoJoocdEpmABdv8viFl9rlnzh
        RpdqTU2HxXWp6B4OILcwr1xt8hHLibbc68W7OYO8eRxoUPYXgvJmaDWL93CNinvE+nAOwj09QuL6s
        f5p9UXq7aWLvGkgCTpRvuxwiHVrQiWHF/4WscBAK4USfRg4IRXu8oIpGFEEC3GadavRrw5TDs6OVo
        LwH8EIyQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlc5J-0008QP-68; Wed, 17 Jun 2020 17:42:49 +0000
Date:   Wed, 17 Jun 2020 10:42:49 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, selvakuma.s1@samsung.com,
        nj.shetty@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH 0/3] zone-append support in aio and io-uring
Message-ID: <20200617174249.GL8681@bombadil.infradead.org>
References: <CGME20200617172653epcas5p488de50090415eb802e62acc0e23d8812@epcas5p4.samsung.com>
 <1592414619-5646-1-git-send-email-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592414619-5646-1-git-send-email-joshi.k@samsung.com>
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Wed, Jun 17, 2020 at 10:53:36PM +0530, Kanchan Joshi wrote:
> This patchset enables issuing zone-append using aio and io-uring direct-io interface.
> 
> For aio, this introduces opcode IOCB_CMD_ZONE_APPEND. Application uses start LBA
> of the zone to issue append. On completion 'res2' field is used to return
> zone-relative offset.

Maybe it's obvious to everyone working with zoned drives on a daily
basis, but please explain in the commit message why you need to return
the zone-relative offset to the application.
