Return-Path: <SRS0=qbp9=ZY=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EBAC43215
	for <io-uring@archiver.kernel.org>; Mon,  2 Dec 2019 15:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CE620748
	for <io-uring@archiver.kernel.org>; Mon,  2 Dec 2019 15:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HJkUaW0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfLBPtJ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:49:09 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36493 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfLBPtI (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 2 Dec 2019 10:49:08 -0500
Received: by mail-io1-f65.google.com with SMTP id l17so14843895ioj.3
        for <io-uring@vger.kernel.org>; Mon, 02 Dec 2019 07:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lUV1YCzvy/Bk6GN33KJO5EoQ21oVlzfQOCa/jgUbcKY=;
        b=HJkUaW0iR9HaWBDgP8ZPABt63QabWVV4dTdB0xaaL9Q2LRIU/9WmY37uezyL7CoEPd
         Mvx7Gc6G9XPtagzkOTej4N5I5QPIKOQt1oFf2KoFrx+CbL+TwcD9MqVljWrtQ8D1hPxz
         1cBrfPxro1f/GsGSestA42WJTtKEqRL8pQdjPijXtTWbpaQmyV+Vfolgdqlf2qllZWgx
         pmuQgCD5CVMRVNqc7vouerqLz56c0l6q1XclAYLmK1y2nhAMOpcybk4u3FFCcZhGni6b
         fpkztX+83ifcMaBmyEpTZPaQ1cqWyyKxAj6fRa1aYF6CXc3JkyHIGuy08ns60oWmx2U0
         UKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lUV1YCzvy/Bk6GN33KJO5EoQ21oVlzfQOCa/jgUbcKY=;
        b=bYsaEK0KmDiPsH4ySFVgpSLohr4bG3lCEWzwqQejmgDYYYwS9CZYUhthguWVdBzhwO
         fNTgEF78ENyJMaJ3UP1ydp+42rCA77o4JGU6x5MFFSfEfGjyORwdvXilEJWAZs4B7bIQ
         4iAkD+TsT5HkjTKnPjRPXFYKnsiOnKjSvwbqMqw8h/uZtHrqGtQeVlduwtBpG+/SGoss
         haHocuEtGvE1fm7JFban8qhAPW884iCQzHtjXYxf9x6BpwtUti3Fq4IVdZC8qYvBGaZI
         cBdcPmsH4JL5Mt/eZHdEYaVK3evibcse2d1bYlJw7nJm8IQeXKn0FAb/53PhXtuRZRYX
         xOug==
X-Gm-Message-State: APjAAAWYbmNZLTZTvgG8fi4ULSLUqQQYtav5fmQcyKHknFvwzcyflzXH
        KvUJX4orDydDYwMEBZbp3yAMRw==
X-Google-Smtp-Source: APXvYqzZBDPylb+uAXhA22FT+e+8mIXSGoWX+RQK9aCeE0TCVTRfcOL1V7MzvTw5GbyOa29G6IJNmg==
X-Received: by 2002:a6b:ef13:: with SMTP id k19mr21106341ioh.23.1575301746677;
        Mon, 02 Dec 2019 07:49:06 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i2sm3539171iol.29.2019.12.02.07.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 07:49:05 -0800 (PST)
Subject: Re: general protection fault in override_creds
From:   Jens Axboe <axboe@kernel.dk>
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Anna.Schumaker@netapp.com,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, NeilBrown <neilb@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <000000000000da160a0598b2c704@google.com>
 <CACT4Y+ZGx16qc8qtekP0Bx=syVQest8K_RVtEN084jnszx4qhA@mail.gmail.com>
 <39ea5e00-3278-a84f-25ae-c7a93a4b8ab5@kernel.dk>
Message-ID: <7be77044-5390-7df1-33d4-e92166fb927a@kernel.dk>
Date:   Mon, 2 Dec 2019 08:49:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <39ea5e00-3278-a84f-25ae-c7a93a4b8ab5@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 12/2/19 7:40 AM, Jens Axboe wrote:
> On 12/1/19 10:40 PM, Dmitry Vyukov wrote:
>> On Mon, Dec 2, 2019 at 7:35 AM syzbot
>> <syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com> wrote:
>>>
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=10f9ffcee00000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=5320383e16029ba057ff
>>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dd682ae00000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16290abce00000
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com
>>
>> I think this relates to fs/io_uring.c rather than kernel/cred.c.
>> +io_uring maintainers
> 
> Yeah that's my fault, guessing the below will fix it. I'll test and
> queue it up.

This is cleaner, tested fine.


diff --git a/fs/io-wq.c b/fs/io-wq.c
index 91b85df0861e..74b40506c5d9 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -111,7 +111,7 @@ struct io_wq {
  
  	struct task_struct *manager;
  	struct user_struct *user;
-	struct cred *creds;
+	const struct cred *creds;
  	struct mm_struct *mm;
  	refcount_t refs;
  	struct completion done;
diff --git a/fs/io-wq.h b/fs/io-wq.h
index 600e0158cba7..dd0af0d7376c 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -87,7 +87,7 @@ typedef void (put_work_fn)(struct io_wq_work *);
  struct io_wq_data {
  	struct mm_struct *mm;
  	struct user_struct *user;
-	struct cred *creds;
+	const struct cred *creds;
  
  	get_work_fn *get_work;
  	put_work_fn *put_work;
diff --git a/fs/io_uring.c b/fs/io_uring.c
index ec53aa7cdc94..5cab7a047317 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -238,7 +238,7 @@ struct io_ring_ctx {
  
  	struct user_struct	*user;
  
-	struct cred		*creds;
+	const struct cred	*creds;
  
  	/* 0 is for ctx quiesce/reinit/free, 1 is for sqo_thread started */
  	struct completion	*completions;
@@ -4759,7 +4759,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
  	ctx->compat = in_compat_syscall();
  	ctx->account_mem = account_mem;
  	ctx->user = user;
-	ctx->creds = prepare_creds();
+	ctx->creds = get_current_cred();
  
  	ret = io_allocate_scq_urings(ctx, p);
  	if (ret)

-- 
Jens Axboe

