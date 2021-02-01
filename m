Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E10AC433E9
	for <io-uring@archiver.kernel.org>; Mon,  1 Feb 2021 15:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1596E64EA1
	for <io-uring@archiver.kernel.org>; Mon,  1 Feb 2021 15:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhBAPbZ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhBAPaw (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 1 Feb 2021 10:30:52 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F083C061786;
        Mon,  1 Feb 2021 07:29:53 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6b99-008atG-Br; Mon, 01 Feb 2021 15:29:47 +0000
Date:   Mon, 1 Feb 2021 15:29:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: make do_mkdirat() take struct filename
Message-ID: <20210201152947.GR740243@zeniv-ca>
References: <20201116044529.1028783-1-dkadashev@gmail.com>
 <20201116044529.1028783-2-dkadashev@gmail.com>
 <027e8488-2654-12cd-d525-37f249954b4d@kernel.dk>
 <20210126225504.GM740243@zeniv-ca>
 <CAOKbgA4fTyiU4Xi7zqELT+WeU79S07JF4krhNv3Nq_DS61xa-A@mail.gmail.com>
 <20210201150042.GQ740243@zeniv-ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201150042.GQ740243@zeniv-ca>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Mon, Feb 01, 2021 at 03:00:42PM +0000, Al Viro wrote:

> The last one is the easiest to answer - we want to keep the imported strings
> around for audit.  It's not so much a proper refcounting as it is "we might
> want freeing delayed" implemented as refcount.

BTW, regarding io_uring + audit interactions - just how is that supposed to
work if you offload any work that might lead to audit records (on permission
checks, etc.) to helper threads?
