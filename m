Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbVKWC4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbVKWC4S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 21:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVKWC4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 21:56:18 -0500
Received: from [210.76.114.22] ([210.76.114.22]:47009 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S932474AbVKWC4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 21:56:17 -0500
Message-ID: <4383DA6B.400@ccoss.com.cn>
Date: Wed, 23 Nov 2005 10:56:43 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zhang Le <robert@thizgroup.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Question] I doublt on spin_lock again.
References: <4383CE48.60007@ccoss.com.cn> <4383D92A.9070409@thizgroup.com>
In-Reply-To: <4383D92A.9070409@thizgroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang Le wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> liyu wrote:
>
> | 1. I found these use spin_lock(&rq->lock) in set_user_nice(), but
> | not disable interrput ( e.g.  when sys_nice() call it ),  if the
> | one timer interrput come before we unlock the spin_lock, Shall we
> | dead lock here?  Since the scheduler_tick() may try to hold the
> | same lock.
>
> set_user_nice() -> task_rq_lock -> local_irq_save()
>
> |
> | 2. # define __acquires(x)    __attribute__((context(0,1))) # define
> | __releases(x)    __attribute__((context(1,0))) # define
> | __acquire(x)    __context__(1) # define __release(x)
> | __context__(-1)
>
> info gcc
>
> BTW, have you ever read "HOWTO do Linux kernel development" be Greg?
> Do it, if you haven't
>
> - --
> Zhang Le, Robert
> Linux Engineer/Trainer
>
> ThizLinux Laboratory Limited
> Address: Unit 1004, 10/F, Tower B,
> Hunghom Commercial Centre, 37 Ma Tau Wai Road,
> To Kwa Wan, Kowloon, Hong Kong
> Telephone: (852) 2735 2725
> Mobile:(852) 9845 4336
> Fax: (852) 2111 0702
> URL: http://www.thizgroup.com
> Public key: gpg --keyserver pgp.mit.edu --recv-keys 1E4E2973
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.2 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
>
> iD8DBQFDg9kOvFHICB5OKXMRAg7BAJwIhyW9Qop4YGF9G56nzqImjy8UgQCfUE/g
> b8pK2Fk6oW8ScK42krTZdOQ=
> =mDfg
> -----END PGP SIGNATURE-----
>
>
>
Thanks first.

1.  I know local_irq_save() in task_rq_lock(), but it only save FLAGS 
register to one unsigned long variable, but not disable maskable interrupt.
2. OK, I am going to get it.

-liyu


