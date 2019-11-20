Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD6CC432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 14:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B542070B
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 14:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tHeu9Vkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfKTOYO (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:24:14 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:46038 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbfKTOYO (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 09:24:14 -0500
Received: by mail-io1-f52.google.com with SMTP id v17so16673437iol.12
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 06:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RZd/0W5FYjp0VAN5ic99QOpfU0C7eMY2uaQSCKqryYk=;
        b=tHeu9Vkh1/2BWL0MpydVOUK8RAB6DUuu8FMprV9kaKfSb5kjE96f7UzSYB7Oh3CquS
         3AyTgfrE8gI/Pzo3orQVKUveqxfFGQN2JMDx65tS4nYyDQIXhA70Hqe3aMms/IRiE/Ob
         JM8jmOKrZiabPWLMKaLEqUSS2RM89PWQ/B9QA8IJ1hWBWIjMajxk4PCTlIMk8H1NWQZ3
         gvmUTp6DfihzIzOVsg2rktyeyjqCuNsZcHvbw9/QJFwEwQDrcHK7yREr9xEtU2Z9R6Tn
         lcOl4K31nrW9hpWwkP+Y9N/QVuFoEXsa5NR7P2nglALaF0yas3TlwZo8ybemKUBgPZMN
         RFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RZd/0W5FYjp0VAN5ic99QOpfU0C7eMY2uaQSCKqryYk=;
        b=Ke+rTPn5F+1S2a/XysFWR2is62mB90eTCwuDtKPYb3S8o7N4DIM4524/Tc09tDgDrc
         imWib09hGgmG/peeqUDoJOdBUUwBdt86gO6R7MvftChfN69bwu0m1yE56+Zyt+SqWNzZ
         t61t1OHEfs2np2ROoBpsl3JpztMSNI2soua612ryCprbjmnf8RCAJfSvXZvMl+6vSAkE
         YFOPPfyFRzuK4Jr1h+VFP16wn7N2RO0PyDvtfAaLXhKDZMlsexyVbj7viRVyb6/YNWKV
         rD+FqOxg7p53KsccDSwdKY8AT64wkKzRlanmRR66yLg1pFuNWJ3iboxVuNhC+djx90G9
         ba9A==
X-Gm-Message-State: APjAAAV4+v1KqbX3V+w/eWmdQmVpe0grEWvK4ba9lLSg1cnW7eKKHr3f
        NuV98BKFE8UPAdT3WqRmVVye1vYVG94LTw==
X-Google-Smtp-Source: APXvYqy7d40JcbFjUO5cRjknjqIlVqx+6INkqFpOXcP3C4ZNR4+9qdTxBWORmyuGNphxqH0yN24/9w==
X-Received: by 2002:a5e:aa10:: with SMTP id s16mr2477325ioe.113.1574259853090;
        Wed, 20 Nov 2019 06:24:13 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u6sm6570063ilm.22.2019.11.20.06.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 06:24:12 -0800 (PST)
Subject: Re: [PATCH liburing] linked-timeout: check invalid linked timeouts
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <3f42aab361c25ee4122c47a0dbe5a346816c4f5c.1574195785.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <52f24782-6c8d-f0a9-35ea-e53e0f0103b3@kernel.dk>
Date:   Wed, 20 Nov 2019 07:24:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3f42aab361c25ee4122c47a0dbe5a346816c4f5c.1574195785.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/19/19 1:37 PM, Pavel Begunkov wrote:
> Check miscounting references for the following case:
> REQ(fail) -> LINKED_TIMEOUT -> LINKED_TIMEOUT

Looks like I forgot to reply to this one, I did apply it yesterday.
Thanks!

-- 
Jens Axboe

