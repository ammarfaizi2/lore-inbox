Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbVKWCvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVKWCvd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 21:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVKWCvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 21:51:33 -0500
Received: from bigip-smtp1.dyxnet.com ([202.66.146.141]:22486 "EHLO
	bigip-smtp1.dyxnet.com") by vger.kernel.org with ESMTP
	id S932471AbVKWCvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 21:51:32 -0500
Message-ID: <4383D92A.9070409@thizgroup.com>
Date: Wed, 23 Nov 2005 10:51:22 +0800
From: Zhang Le <robert@thizgroup.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051028)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: liyu <liyu@ccoss.com.cn>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Question] I doublt on spin_lock again.
References: <4383CE48.60007@ccoss.com.cn>
In-Reply-To: <4383CE48.60007@ccoss.com.cn>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

liyu wrote:

| 1. I found these use spin_lock(&rq->lock) in set_user_nice(), but
| not disable interrput ( e.g.  when sys_nice() call it ),  if the
| one timer interrput come before we unlock the spin_lock, Shall we
| dead lock here?  Since the scheduler_tick() may try to hold the
| same lock.

set_user_nice() -> task_rq_lock -> local_irq_save()

|
| 2. # define __acquires(x)    __attribute__((context(0,1))) # define
| __releases(x)    __attribute__((context(1,0))) # define
| __acquire(x)    __context__(1) # define __release(x)
| __context__(-1)

info gcc

BTW, have you ever read "HOWTO do Linux kernel development" be Greg?
Do it, if you haven't

- --
Zhang Le, Robert
Linux Engineer/Trainer

ThizLinux Laboratory Limited
Address: Unit 1004, 10/F, Tower B,
Hunghom Commercial Centre, 37 Ma Tau Wai Road,
To Kwa Wan, Kowloon, Hong Kong
Telephone: (852) 2735 2725
Mobile:(852) 9845 4336
Fax: (852) 2111 0702
URL: http://www.thizgroup.com
Public key: gpg --keyserver pgp.mit.edu --recv-keys 1E4E2973

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDg9kOvFHICB5OKXMRAg7BAJwIhyW9Qop4YGF9G56nzqImjy8UgQCfUE/g
b8pK2Fk6oW8ScK42krTZdOQ=
=mDfg
-----END PGP SIGNATURE-----

