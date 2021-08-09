Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073B2C4338F
	for <io-uring@archiver.kernel.org>; Mon,  9 Aug 2021 15:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E306D61040
	for <io-uring@archiver.kernel.org>; Mon,  9 Aug 2021 15:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbhHIPzM (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 9 Aug 2021 11:55:12 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:53776 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbhHIPzM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 9 Aug 2021 11:55:12 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mD7Zv-009HZG-Pe; Mon, 09 Aug 2021 15:52:40 +0000
Date:   Mon, 9 Aug 2021 15:52:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iter revert problems
Message-ID: <YRFPR25scNRYaRzW@zeniv-ca.linux.org.uk>
References: <cover.1628509745.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1628509745.git.asml.silence@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Mon, Aug 09, 2021 at 12:52:35PM +0100, Pavel Begunkov wrote:
> For the bug description see 2/2. As mentioned there the current problems
> is because of generic_write_checks(), but there was also a similar case
> fixed in 5.12, which should have been triggerable by normal
> write(2)/read(2) and others.
> 
> It may be better to enforce reexpands as a long term solution, but for
> now this patchset is quickier and easier to backport.

	Umm...  Won't that screw the cases where we *are* doing proper
reexpands?  AFAICS, with your patches that flag doesn't go away once
it had been set...
