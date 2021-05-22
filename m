Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAE8C04FF3
	for <io-uring@archiver.kernel.org>; Sat, 22 May 2021 00:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 936B861168
	for <io-uring@archiver.kernel.org>; Sat, 22 May 2021 00:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhEVAzH (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 21 May 2021 20:55:07 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58901 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhEVAzG (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 21 May 2021 20:55:06 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 14M0rCum089289;
        Sat, 22 May 2021 09:53:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp);
 Sat, 22 May 2021 09:53:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 14M0rB9s089286
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 22 May 2021 09:53:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH 0/9] Add LSM access controls and auditing to io_uring
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        io-uring@vger.kernel.org
References: <162163367115.8379.8459012634106035341.stgit@sifl>
Cc:     selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f67213bf-8f41-ce06-b3b2-adf1ab2a3c5c@i-love.sakura.ne.jp>
Date:   Sat, 22 May 2021 09:53:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <162163367115.8379.8459012634106035341.stgit@sifl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 2021/05/22 6:49, Paul Moore wrote:
> I've provided the SELinux
> implementation, Casey has been nice enough to provide a Smack patch,
> and John is working on an AppArmor patch as I write this.  I've
> mentioned this work to the other LSM maintainers that I believe might
> be affected but I have not heard back from anyone else at this point.

I don't think any change is required for TOMOYO, for TOMOYO does not
use "struct cred"->security where [RFC PATCH 8/9] and [RFC PATCH 9/9]
are addressing, and TOMOYO does not call kernel/audit*.c functions.
