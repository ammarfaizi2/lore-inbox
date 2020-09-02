Return-Path: <SRS0=O4+P=CL=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDC6C433E7
	for <io-uring@archiver.kernel.org>; Wed,  2 Sep 2020 14:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A959C2078E
	for <io-uring@archiver.kernel.org>; Wed,  2 Sep 2020 14:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="frhXgOwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgIBOsb (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgIBOMq (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 2 Sep 2020 10:12:46 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BEEC061244
        for <io-uring@vger.kernel.org>; Wed,  2 Sep 2020 07:12:45 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id w3so5088831ilh.5
        for <io-uring@vger.kernel.org>; Wed, 02 Sep 2020 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ahvdegrHt/xdF59AntZ+oSmf5bREwGGYgmgDz2a9oOk=;
        b=frhXgOwDTvFs9IwHZ6CG3Uinp9jb3zGxDjJk78fBQKNA390Btl+bRiwAEYPaxT662F
         5V8+KAx/tl8WjHWAHhZJjEGJ3nkctP4FkiMXAVEj4TNNh4nAW5PYRqETycm6fOzc+MR9
         aKJenWN4HeO9/nWa8AmRLWulflIg0gsBATGdMHMALIE+XUXB4Xx19gjHDvbjpeQyvs3m
         pdJUZH32KQYeVDlDCLNbZXqOEb1QNNEqyBdBZ+p04QvW0nrQu/YG0vL7wcsjcwbj8qCT
         kIBPW5AK42/jU3YBh+mI7DI/jvSs9iKZNho7Gkidy4SOmFCjKLhi7M5XsNZRotYv+S4t
         K7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ahvdegrHt/xdF59AntZ+oSmf5bREwGGYgmgDz2a9oOk=;
        b=SgobN7GLPBugf+C9XCFyUqQcvLgbrr8VVTluBaa/6ZAxOwP3z97+uTcFkoBYjrfdXa
         vr62xeFRNWvc8fTtPP84DGCIh3dhrhY2PzrAhgKnf89a3VHIVnYwAC5yCyjDjwMoNVcS
         hTrwI31I7hj27C0bYAQSAYkIbF5HbKp+TdQ7+EGWNnfLLaEVzbT785EPlrHVkj7kjcfo
         BralU2Oj3rqRScIiSQSJRCJHOMcLWa94cUNquOsHp2kYjh8azQZlAjTS32rUO5I6HXVm
         G4giKAYr0dnHAoV9pXNjNtvyoESSkMQb8H9BsLUEBBgaOxIqpd9Ucqme4eLPFZOAr3dz
         XisQ==
X-Gm-Message-State: AOAM532ZU2CjHNt3Q+kEE9wdu3bbhfaj670TWdFyNKvq3l2CAIrJ9lJd
        twG3aXODQvfA+HSRn+1Zu1QTGP7qkU1RB08/
X-Google-Smtp-Source: ABdhPJzj+Dhp4g+yNSJh8bClfNskcX4Y12389+xdjZ6g1+Iz0CzrZ6XnQWJQj73JxiaIMDxs7qWcCw==
X-Received: by 2002:a92:7307:: with SMTP id o7mr859082ilc.226.1599055964253;
        Wed, 02 Sep 2020 07:12:44 -0700 (PDT)
Received: from [192.168.1.57] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 3sm2251978ilz.26.2020.09.02.07.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 07:12:43 -0700 (PDT)
Subject: Re: [PATCH] io_uring: set table->files[i] to NULL when
 io_sqe_file_register failed
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>, io-uring@vger.kernel.org
References: <1599040779-41219-1-git-send-email-jiufei.xue@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c278224e-314d-e810-67f3-f5353daf9045@kernel.dk>
Date:   Wed, 2 Sep 2020 08:12:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1599040779-41219-1-git-send-email-jiufei.xue@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 9/2/20 3:59 AM, Jiufei Xue wrote:
> While io_sqe_file_register() failed in __io_sqe_files_update(),
> table->files[i] still point to the original file which may freed
> soon, and that will trigger use-after-free problems.

Applied, thanks.

-- 
Jens Axboe

