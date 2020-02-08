Return-Path: <SRS0=6U8q=34=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C30C35250
	for <io-uring@archiver.kernel.org>; Sat,  8 Feb 2020 13:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705D22082E
	for <io-uring@archiver.kernel.org>; Sat,  8 Feb 2020 13:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBLglfOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBHN3E (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 8 Feb 2020 08:29:04 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:34444 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgBHN3E (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 8 Feb 2020 08:29:04 -0500
Received: by mail-lj1-f171.google.com with SMTP id x7so2257537ljc.1
        for <io-uring@vger.kernel.org>; Sat, 08 Feb 2020 05:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=V4tzyl1wzNqnfv9HjJ8KJkw9TCUrxGu7vImy/N3FLCM=;
        b=UBLglfOXl80D1bZwOjKm9VB8OeweHfg/PA70lO1FhGtzBSEydx3CXjuUpVebYv9Hdj
         1cCfZrbHJHlMDabmAmH+bPQeI9gnpLULycxvOg7Q/IUKKzB2c7nNsOyU5fA3GoY7KC4h
         hKrK7JGvwwIxMwVdWhJc8sXdPLXTd/tI5ODqWzg2awD311PT97Y0U36HqEe1AYw9hM1H
         RyHU+mmn7cMgZENFKjpOshpU8xoXOsSkSZoyVKK2NtSfO8ngtfQuD0FEw5Dxm46UAazc
         Sbj3YOH9Hjgkyh3Kth1suAC/zGohn1XQDVlgCD/6UEjwlBwCYxEl0p06UXcW1Qjs3dsK
         tVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=V4tzyl1wzNqnfv9HjJ8KJkw9TCUrxGu7vImy/N3FLCM=;
        b=DD0JrPX5FEopxzuep2LFK4vIHuYboqLXAakfuTbc+QQH24gvsQ/FLL2SRoVk2LVWCI
         VnHXz8EifgZbCYlVbg86cMRHhSHN/ppS5bvyWTpLUcUmrTb3RmY0/T3TUAypeN7HTSZY
         xaG7Ix+5So3YKMuNdHIUyCre5nlbSh9aXenqHMgGysSC3l95FmTWig0ZPhlrF+FRp8tk
         gsDbV6+jygRS+l70LRQPLus6g5yzA34wvh9JNYA7oGNKnEhYubln/ODQgwkxQpQkblGQ
         yVQNgP4riCer0YlyVZGdGPUGEMlxHEU1CpGUTIG/Fb7z1/ZBxz5t7IRAlowGytsWXc/7
         fbFA==
X-Gm-Message-State: APjAAAW7xb38HDmOOujkXXui7DAEbh7mXAFslaSO94wIxQxFrZArDU+z
        hCnE4iv2dreU3Csf5ZLK5GGyfk+tlb8=
X-Google-Smtp-Source: APXvYqyeULdJ5fLY8ULToC+eLGtCn8dwfQU/GDs310ftX8gSgKVZfHEEuEUq6j4FqJCTi1MRPQQOuw==
X-Received: by 2002:a05:651c:10f:: with SMTP id a15mr2767387ljb.237.1581168541481;
        Sat, 08 Feb 2020 05:29:01 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id a8sm3092190ljn.74.2020.02.08.05.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2020 05:29:01 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC] fixed files
Message-ID: <ace72a3f-0c25-5d53-9756-32bbdc77c844@gmail.com>
Date:   Sat, 8 Feb 2020 16:28:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi,

As you remember, splice(2) needs two fds, and it's a bit of a pain
finding a place for the second REQ_F_FIXED_FILE flag. So, I was
thinking, can we use the last (i.e. sign) bit to mark an fd as fixed? A
lot of userspace programs consider any negative result of open() as an
error, so it's more or less safe to reuse it.

e.g.
fill_sqe(fd) // is not fixed
fill_sqe(buf_idx | LAST_BIT) // fixed file


-- 
Pavel Begunkov
