Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9171EC432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 04:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535DA2072A
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 04:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="co5vaGbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKOE4J (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 14 Nov 2019 23:56:09 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:41396 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfKOE4I (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 14 Nov 2019 23:56:08 -0500
Received: by mail-pl1-f174.google.com with SMTP id d29so3792909plj.8
        for <io-uring@vger.kernel.org>; Thu, 14 Nov 2019 20:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Sc0Kh9RuoMKmfatAAEacUCOqvmUqmlWySEyEySUO9Q=;
        b=co5vaGbT7PTdeBv7Y/io3uDDvrhsCc2Sig24gTDWxn+9CLMX6YZclqN9hRGWrWZsXD
         CasxDlDZS8wegG1AjwiyOyqJzNZZOLz+L9Cs9Biptb9Rka8Mp70Yp3BdqkVyxMu5jxkF
         z2TOqLQwCpKX3NbQRuVxGHIZMt/iWvvHeJf/m99Km9NJVQp2XA/mKgjyamKe3TKzb4fE
         LcdP4YbRVPHIYKtUwQHkzBZpFpOHSq+dr8p1xELshYXnshME2fBGcA+EiedOP8tn7jYP
         N0bAh7jaythKGziosjoOfkZ4iow+EEtRALjT7JYohObnAbsvNSzu0f0G2It4+HvexJ7a
         6LdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Sc0Kh9RuoMKmfatAAEacUCOqvmUqmlWySEyEySUO9Q=;
        b=mQuTDaoJq6JG/nGz3jZairsO5mD/g9N7dTDhMvhHbhCINUcjBCyfLIa2VHM1ea628g
         Enq6Awo8W9VYZWz7DGMMbQHvCtSSqr5wRswxBKGxLPADRGQO3KFDDGxXZ7efVT3APTht
         KwznhNOEjd9TQDrsk+Prcys151z+npgojAh/lANlkGtaFzO6FcYyMrOWDDaoS5REGPdw
         zoQYnUtQARWAmzPIrAk7lwiUNiE9kEWb8C6kT/7DNF6SYhly1x+pF4GEB45MUKGJDVgB
         2m57dzYk2ZX75REwFkDb9dKG5W5Y2cgI0zgOg011166tD/Iks5iKNFhehfP7l10hwcR0
         XnNQ==
X-Gm-Message-State: APjAAAUtWdkQIbBBHvaBcmqEDzHJhazJIVPXOmp/qLR1gqFskB0M4Uf2
        MOhchEQ0Lbd9cd0RZOgpDfe5WJTuw/k=
X-Google-Smtp-Source: APXvYqy5pTvoCgejo41CtRhWlWPVdvpohIu0mQo+hzit7YGPIFk5c2sML0hFUqujsdhJZrNrEQ9KKQ==
X-Received: by 2002:a17:902:760d:: with SMTP id k13mr680285pll.28.1573793767562;
        Thu, 14 Nov 2019 20:56:07 -0800 (PST)
Received: from x1.localdomain ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id w7sm9192366pfb.101.2019.11.14.20.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 20:56:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com
Subject: [PATCHSET 0/2] Fix issue with (and clarify) linked timeouts
Date:   Thu, 14 Nov 2019 21:56:01 -0700
Message-Id: <20191115045603.15158-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

First patch is just a prep patch that cleans up the return values from
the various queueing functions, and the second one fixes sequencing
issues with linked timeouts, as well as makes it so that we only support
one linked timeout in a chain (and only as the 2nd request). We can relax
this restriction later, if it makes sense, for now I think we should just
play it safe. This doesn't mean that you can only submit a request and
timeout in a submission, just that requests that are linked with
IOSQE_LINK must have a parent request and then a timeout tied to that.
That's the intended use case anyway, a timeout is paired with one other
parent request.

 fs/io_uring.c | 79 +++++++++++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 34 deletions(-)

-- 
Jens Axboe


