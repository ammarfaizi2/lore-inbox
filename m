Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWDDDh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWDDDh3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 23:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWDDDh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 23:37:28 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:4781 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S964995AbWDDDh0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 23:37:26 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 3 Apr 2006 20:37:19 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Michael Kerrisk <mtk-manpages@gmx.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, michael.kerrisk@gmx.net
Subject: Re: [patch] uniform POLLRDHUP handling between epoll and poll/select
 ...
In-Reply-To: <12469.1144121501@www102.gmx.net>
Message-ID: <Pine.LNX.4.64.0604032034060.30048@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0604032011040.30048@alien.or.mcafeemobile.com>
 <12469.1144121501@www102.gmx.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2006, Michael Kerrisk wrote:

> Davide,
>
>> Like reported by Michael Kerrisk, POLLRDHUP handling was not consistent
>> between epoll and poll/select, since in epoll it was unmaskeable. This
>> patch brings uniformity in POLLRDHUP handling.
> [...]
>> diff -Nru linux-2.6.16/fs/eventpoll.c linux-2.6.16.mod/fs/eventpoll.c
>> --- linux-2.6.16/fs/eventpoll.c	2006-04-03 20:08:23.000000000 -0700
>> +++ linux-2.6.16.mod/fs/eventpoll.c	2006-04-03 20:09:51.000000000 -0700
>> @@ -599,7 +599,7 @@
>>   	switch (op) {
>>   	case EPOLL_CTL_ADD:
>>   		if (!epi) {
>> -			epds.events |= POLLERR | POLLHUP | POLLRDHUP;
>> +			epds.events |= POLLERR | POLLHUP;
>>
>>   			error = ep_insert(ep, &epds, tfile, fd);
>>   		} else
>> @@ -613,7 +613,7 @@
>>   		break;
>>   	case EPOLL_CTL_MOD:
>>   		if (epi) {
>> -			epds.events |= POLLERR | POLLHUP | POLLRDHUP;
>> +			epds.events |= POLLERR | POLLHUP;
>>   			error = ep_modify(ep, epi, &epds);
>>   		} else
>>   			error = -ENOENT;
>
> This makes things consistent -- but in the opposite way
> from what I thought they might be.  (The alternative would of
> course have been to make POLLRDHUP un-maskable in both epoll
> and poll().)
>
> So I'm curious: what is the rationale for making POLLRDHUP
> maskable when POLLHUP is not?   Is it an issue of ABI
> compatibility; or something else?

Yes, ABI compatibility.



- Davide


