Return-Path: <SRS0=s7bN=4U=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CF5C3F2C6
	for <io-uring@archiver.kernel.org>; Tue,  3 Mar 2020 23:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CE320842
	for <io-uring@archiver.kernel.org>; Tue,  3 Mar 2020 23:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bnXVFbMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgCCXvB (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 3 Mar 2020 18:51:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40942 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgCCXvB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 3 Mar 2020 18:51:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id l184so2324216pfl.7
        for <io-uring@vger.kernel.org>; Tue, 03 Mar 2020 15:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tr8OJ5yWq8T3QOKN75HSsi3oOVT2GndhHyPHMHEj8qg=;
        b=bnXVFbMGlWIV1BX/uJBZjXZSRDbokUk5NT6p9WUsWXWic5+WbZhK9taY4taMrRvKoQ
         YGVlRyOYOyLlGjNca8snJsfZelaIoEJo1JqRtRVPgCfQxtFSSQi4n6zw+wIruLPr7JSc
         pqXeH9dB7txxc0bPkS7gT+g4Zj/68VP0vJ57A+q9pArCKD201zX7u8pHX2A9te7ewZq1
         IK93QORBe1t8mBT3SaEEo8ZjbD5BIlBLnYMEY00u9oevJ9pbCODlk1iTKFsLRNWzeSbB
         ocxbWzu4eyFYFT2Dsb46XUsTnHGb0szT9l5gtz5oGSLWy7uqEtqjsbPE/tc1zjKkt4c1
         GumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tr8OJ5yWq8T3QOKN75HSsi3oOVT2GndhHyPHMHEj8qg=;
        b=oweVSbltMHW/jL41WQSR6B6hWorEyJAGyxtHNd7R3BtZgxpQ60U5fu6LKXTTViS964
         0IuSBnCrnfJQ572XUmtD1I/7UaRuIXhIb1xh6Kl+c4NkNzHId1Pti62PW+M6KRb64+2L
         2m5oBqDAJgrjmdqOjy858/ZI3PGmjJthE5kCx1gbxkn2xAtK0M1PalruibLrWY1DULF8
         PtxjtfEyxD7QQ67qskp7mscUeyujIDqFZ2NnUa1dnLjKI03OLQTqatToWPEkqpdvQbEg
         AVBN9LFzz505Bnf6TjBt4DLvsNYLcpybOUAOeXKFzfHTaAwISigAlOmBhyQQJWM1f2G/
         fOpA==
X-Gm-Message-State: ANhLgQ0QkHw/dophWldpRCkS2ZgGtSsRbnl4J6XLKGefMiCf28KBpOp0
        cdkn/9vk/JPQz4k5ing8a4LaHPIPTi8=
X-Google-Smtp-Source: ADFU+vujNECnfSCPMqdyHv8TV6UeCbenMx0XsAQsNJu4IcXbGVFJOaxivMXuNtXV3H0nhOHN4ci/eQ==
X-Received: by 2002:a05:6a00:4c:: with SMTP id i12mr204202pfk.81.1583279459303;
        Tue, 03 Mar 2020 15:50:59 -0800 (PST)
Received: from x1.localdomain ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id d24sm27041503pfq.75.2020.03.03.15.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 15:50:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     jlayton@kernel.org
Subject: [PATCHSET RFC 0/4] Support passing fds between chain links
Date:   Tue,  3 Mar 2020 16:50:49 -0700
Message-Id: <20200303235053.16309-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

One of the fabled features with chains has long been the desire to
support things like:

<open fileX><read from fileX><close fileX>

in a single chain. This currently doesn't work, since the read/close
depends on what file descriptor we get on open.

This is very much a RFC patchset, but it allows the read/close above
to set their fd to a magic value, IOSQE_FD_LAST_OPEN. If set to this
value, the file descriptor will be inherited from the last open in
that chain. If there are no opens in the chain, the IO is simply
errored. Only a single magic fd value is supported, so if the chain
needs to operate on two of them, care needs to be taken to ensure
things are correct. Consider for example the desire to open fileX
and read from it, and write that to another file. You could do that
ala:

<open fileX><read from fileX><close fileX><open fileY><write to fileY>
	<close fileY>

and have that work, but you cannot open both files first, then read/write
and then close. I don't think that necessarily poses a problem, and
I'd rather not get into fd nesting and things like that. Open to input
here, of course.

Another concern here is that we currently error linked IO if it doesn't
match what was asked for, a prime example being short reads. For a
basic chain of open/read/close, the close doesn't really care if the read
is short or not. It's only if we have further links in the chain that
depend on the read length that this is a problem.

Anyway, with this, prep handlers can't look at ->file as it may not be
valid yet. Only close and read/write do that, from a quick glance, and
there are two prep patches to split that a bit (2 and 3). Patch 1 is just
a basic prep patch as well, patch 4 is the functional part.

I added a small 'orc' (open-read-close) test program in the fd-pass
branch of liburing:

https://git.kernel.dk/cgit/liburing/plain/test/orc.c?h=fd-pass

as an example use case.

-- 
Jens Axboe


