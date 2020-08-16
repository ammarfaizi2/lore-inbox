Return-Path: <SRS0=xRDk=B2=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0363C433DF
	for <io-uring@archiver.kernel.org>; Sun, 16 Aug 2020 02:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8AB1206C0
	for <io-uring@archiver.kernel.org>; Sun, 16 Aug 2020 02:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iujc1J/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgHPCki (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 15 Aug 2020 22:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgHPCki (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 15 Aug 2020 22:40:38 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF549C061786
        for <io-uring@vger.kernel.org>; Sat, 15 Aug 2020 19:40:37 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s15so6370818pgc.8
        for <io-uring@vger.kernel.org>; Sat, 15 Aug 2020 19:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5/r+33S1SCzYarjjPzyxVKsNs/bcpj2dU3zu+JyhPMU=;
        b=iujc1J/byJpj8P4bP2stywl9BIF6E81QIbM9+HMpU/ZwmjyMa2sA8nIr6mUWQv/IHm
         H1Pwu5Hs2lM90JxbWCbhmwOQ41X8FILEWlMHuRHDyfTYTvizwgIgFvl3ZJBIHvjgVi8x
         dusjQxu+pdpd3BC4V2JGc0nfBrTosCqsvJV5//dB18na1nrOKBEkjp9j3VnC4ZBWq4NW
         H5w3PtHvStbJpm/ls+PEYJbl5aWBNY9I/X08QZs2djuOvZdAn6Tiic5Dzt6aAAl62gcH
         D0ryUO2+5s+lgYeAiA9rQlcup7TdP74MGvlRH9RieD1gmnaool6jADgk7MQS0SODV8IF
         ykLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5/r+33S1SCzYarjjPzyxVKsNs/bcpj2dU3zu+JyhPMU=;
        b=VHSQL9YhSuy2B27yhUnYDHFOoujmpxCXGKbdJF/D1jU820TJT2kO3rL2pSB/NKDsZC
         cpnhtxbSaaXbgqDDWJr6B0+SGXssSi8E+D5mtutSepuHb61KxJx81LGSjxAwivBUKw+C
         91KOZ6MEJUk73Qw/6uRHGE//u98rP4x+Jgjm+t9V3wSLJzCjSu434ODjRDLGgFrmX14u
         gj4z68ny7i5yXIvObHBthMPxreVvTKYTak+i+Or4Gj9LL8G5vpZQlIIewgjT3br1XhNl
         EYkeTT85zRs5RLt0iaQwinGDy4qIosgpTs9ReAxfKF1v8s88bqWQ+3mYJ4jIcaYUShHi
         TaOA==
X-Gm-Message-State: AOAM53177KWj0CYwyJPQfUY6mOvZGv1Lam57LXC62njyjEF/SW2p6ojO
        sqmrbMZD6I9FCV4Tad3yUYIc0JtRRXTB/g==
X-Google-Smtp-Source: ABdhPJzWPuPoVnVBySfEU9yhQVFbBE5vZOp4BvX1VWcxxMqpc/SfJBbGpXo2qGicNMeoFKuZ9w+5Zg==
X-Received: by 2002:a63:8943:: with SMTP id v64mr5924689pgd.261.1597545637032;
        Sat, 15 Aug 2020 19:40:37 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:6299:2df1:e468:6351? ([2605:e000:100e:8c61:6299:2df1:e468:6351])
        by smtp.gmail.com with ESMTPSA id z17sm13989532pfq.38.2020.08.15.19.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2020 19:40:36 -0700 (PDT)
Subject: Re: Consistently reproducible deadlock with simple io_uring program
To:     Drew DeVault <sir@cmpwn.com>, io-uring@vger.kernel.org
References: <C4Y2LXWFIUZX.47V7HCX3WU5D@homura>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <46608b91-f3f7-28b1-4e56-6c006c3f8744@kernel.dk>
Date:   Sat, 15 Aug 2020 19:40:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <C4Y2LXWFIUZX.47V7HCX3WU5D@homura>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 8/15/20 7:38 PM, Drew DeVault wrote:
> On Sat Aug 15, 2020 at 10:37 PM EDT, Jens Axboe wrote:
>> This should be fixed by this one:
>>
>> https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.9&id=d4e7cd36a90e38e0276d6ce0c20f5ccef17ec38c
>>
>> which will go into 5.7/5.8 stable shortly. Affected files are the ones
>> that use double waitqueues at the same time for polling, which are
>> mostly just tty...
> 
> Thanks, I'll give this patch a try. I can trivially verify that it works
> correctly if stdin is not a TTY, I should have tried that myself. Do you
> know of any userspace workarounds for the problem that I could try on
> older kernels?

Not really any work-arounds, and on earlier 5.7 (and 5.6 and older) the
poll operation would have just failed with -EINVAL.

-- 
Jens Axboe

