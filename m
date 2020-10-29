Return-Path: <SRS0=zNVv=EE=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51522C55179
	for <io-uring@archiver.kernel.org>; Thu, 29 Oct 2020 01:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CAB20791
	for <io-uring@archiver.kernel.org>; Thu, 29 Oct 2020 01:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bl4ckb0ne.ca header.i=@bl4ckb0ne.ca header.b="mdneiJZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404017AbgJ2BAU (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 28 Oct 2020 21:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404016AbgJ2BAT (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 28 Oct 2020 21:00:19 -0400
X-Greylist: delayed 11769 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Oct 2020 18:00:19 PDT
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43425C0613CF
        for <io-uring@vger.kernel.org>; Wed, 28 Oct 2020 18:00:19 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bl4ckb0ne.ca;
        s=default; t=1603933217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=pOUTd6uwywzxRfrH1f09Ml1TFUxQGVvuphIKK6QBoWc=;
        b=mdneiJZ7YnM/0bHqQRp+J4xRVIXVmfrEh5GbAl/mTJ06a5uka/RabVRNylY9e1nPuuL3FC
        J+EqYHZFCgMoqGkfLIGjUDg+QnfsEBjYDMZQZfVdFAATmKD9gRv1ONDZjagEBHXxIRS8xw
        D1cBbYCyEp2aGWrQ4p6Y3OSIyakV6sk=
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH] examples: disable ucontext-cp if ucontext.h is not
 available
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Simon Zeni" <simon@bl4ckb0ne.ca>
To:     "Jens Axboe" <axboe@kernel.dk>, <io-uring@vger.kernel.org>
Date:   Wed, 28 Oct 2020 20:53:26 -0400
Message-Id: <C6OYQ7AU7G3Z.2XB9LZ8CPC23V@gengar>
In-Reply-To: <18887bed-0e96-5904-5bbd-147393e1eae5@kernel.dk>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Wed Oct 28, 2020 at 12:33 PM EDT, Jens Axboe wrote:
> It's been a while since I double checked 5.4-stable, I bet a lot of
> these
> are due to the tests not being very diligent in checking what is and
> what
> isn't supported. I'll take a look and rectify some of that.

I tried with 5.9.1 and fewer tests failed.

```
Tests failed:  <defer> <double-poll-crash> <file-register>
<io_uring_enter> <io_uring_register> <iopoll> <poll-cancel-ton>
<read-write> <rename> <sq-poll-dup> <sq-poll-share> <unlink>
```

It might be due to musl, I'll as I use the library and send the
necessary patches if needed.

Simon
