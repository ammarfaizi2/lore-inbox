Return-Path: <SRS0=XIRX=BN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C31C433DF
	for <io-uring@archiver.kernel.org>; Mon,  3 Aug 2020 21:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D0922C9F
	for <io-uring@archiver.kernel.org>; Mon,  3 Aug 2020 21:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596489056;
	bh=Zntgb1IKBKruUSqK5NDfCgopJUFSeU3A1wK1R69Of68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P09ZLZPeZwGhJNmmq1M5+kbV4yDlupk4saiCx6kSqYXOzDs/v3+JTUjUf+eIkgMu3
	 pqWy6fMNBRUcrJMG645JxJqrE6ScCv8SrRs0HW1X49KcuFDe8fvfhD0fXjtB2tICTq
	 /0DwFNVbUdEjyFi4ABYkrfwTwkpCKSw8HjOqFpLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgHCVKz (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgHCVKz (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 3 Aug 2020 17:10:55 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E4EC061756
        for <io-uring@vger.kernel.org>; Mon,  3 Aug 2020 14:10:55 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id d27so29367401qtg.4
        for <io-uring@vger.kernel.org>; Mon, 03 Aug 2020 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=crxxw8rThRklFBNXR7vpbUEyywjHEaTiMUtvnHuY1yc=;
        b=TsnxLlOKfC5W3tP760pOKGzK2aJTE0DxwhHZchzQAVeTO33l63LCzeuir04zRUZ3M5
         wDNBEPRrwgPTeplKvBpxlRJjEkBu8eJswiXJ9+GSCtDPmYZYl95UzbYMyDCNRWstQVuR
         xLXeRRw8YMvy2f+ID/iQ95v7IZAqvw9mApRVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=crxxw8rThRklFBNXR7vpbUEyywjHEaTiMUtvnHuY1yc=;
        b=bE5U7Mu6gF1iZtCkP7zq3H+AZ0nawdg/pjv/Lm1NPdXPnIw/9XoSIVgvGAc7yuWIW/
         pf8hvx5ATCUuKhyoMK5hL10CaW0PGRIqXA6pKADE8e5wyZAJyTorO5wYdLKGbyconIBN
         /9/58GyMgQ4G+7LfTOgFKE0ce9DNhaBzpWcqCSByjCaqpQflD8WggXQrOLVDA4qHPKTi
         XhLV1f6pcRUV6X0KiJ/X+6WIKhHWDzKfxTsYawS9ZSrIhEO5dkjrai55ZrvrSICu5LX7
         WFLkaHtGT1nVtt2hbyoRP7/+KzEiMfnm4mNuovt0a1Ov3D3CZAX9ZgLWwst6avpDHAEO
         wZ6g==
X-Gm-Message-State: AOAM533WKmyxn7HPUnYhgmv0GoxZWRMdngfNEmZdiLNxbjqOjl14uC5t
        Lc5Fc7P3MhhEoI6yuvF/sVyLvA==
X-Google-Smtp-Source: ABdhPJx0FSvnnuJJ0t3/OEm3KNmXk091dowACULZGY4A0SuNrYsVDLzoiHzLzNWnGAoxe2OMjjaZdg==
X-Received: by 2002:ac8:4e28:: with SMTP id d8mr18623709qtw.134.1596489054039;
        Mon, 03 Aug 2020 14:10:54 -0700 (PDT)
Received: from chatter.i7.local ([87.101.92.156])
        by smtp.gmail.com with ESMTPSA id o25sm1806541qkm.42.2020.08.03.14.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:10:53 -0700 (PDT)
Date:   Mon, 3 Aug 2020 17:10:50 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] io_uring changes for 5.9-rc1
Message-ID: <20200803211050.ib2km76lch5abnjb@chatter.i7.local>
References: <50466810-9148-e245-7c1e-e7435b753582@kernel.dk>
 <CAHk-=wgaxWMA7DVTQq+KxqaWHPDrXDuScX9orzRgxdi7SBfmoA@mail.gmail.com>
 <CAHk-=wjztm0K9e_62KZj9vJXhmid-=euv-pOHg97LUbHyPKwzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjztm0K9e_62KZj9vJXhmid-=euv-pOHg97LUbHyPKwzA@mail.gmail.com>
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Mon, Aug 03, 2020 at 01:53:12PM -0700, Linus Torvalds wrote:
> On Mon, Aug 3, 2020 at 1:48 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I've pushed out my merge of this thing [..]
> 
> It seems I'm not the only one unhappy with the pull request.
> 
> For some reason I also don't see pr-tracker-bot being all happy and
> excited about it. I wonder why.

My guess it's because the body consists of two text/plain MIME-parts and 
Python returned the merge.txt part first, where we didn't find what we 
were looking for.

I'll see if I can teach it to walk all text/plain parts looking for 
magic git pull strings instead of giving up after the first one.

-K
