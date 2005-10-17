Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVJQIoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVJQIoa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 04:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVJQIoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 04:44:30 -0400
Received: from [213.91.10.50] ([213.91.10.50]:41944 "EHLO zone4.gcu-squad.org")
	by vger.kernel.org with ESMTP id S932215AbVJQIo3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 04:44:29 -0400
X-DomainKeys: Sendmail DomainKeys Filter v0.3.0 zone4.gcu-squad.org j9H8Wnp6024750
X-DKIM: Sendmail DKIM Filter v0.1.1 zone4.gcu-squad.org j9H8Wnp6024750
Date: Mon, 17 Oct 2005 10:32:47 +0200 (CEST)
To: torvalds@osdl.org, dipankar@in.ibm.com
Subject: Re: VFS: file-max limit 50044 reached
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <JTFDVq8K.1129537967.5390760.khali@localhost>
In-Reply-To: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Serge Belyshev" <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Manfred Spraul" <manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.1 (zone4.gcu-squad.org [127.0.0.1]); Mon, 17 Oct 2005 10:32:50 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, Dipankar, all,

On 2005-10-17, Linus Torvalds wrote:
> I would _really_ prefer to not do this in the system call hot-path by
> default. That is unquestionably the hottest path in the kernel by far.
>
> It would be _much_ better to set one of the TIF_WORK flags when there's a
> lot of RCU stuff, and do this all in the not-quit-so-hot path of
> do_notify_resume() (on x86, I think others call it other things) instead.
>
> If you use the same kind of "set the TIF flag every 1000 rcu events"
> approach that my failed patch had, you'd be much better off.
>
> In fact, in that path you could even do a full "rcu_process_callbacks()".
> After all, this is not that different from signal handling.
>
> Gaah. I had really hoped to release 2.6.14 tomorrow. It's been a week
> since -rc4.

Isn't reverting the original change an option? 2.6.13 was working OK if
I'm not mistaken.

Thanks,
--
Jean Delvare
