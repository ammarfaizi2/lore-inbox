Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbVIWSBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbVIWSBW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVIWSBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:01:22 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:7040 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1750931AbVIWSBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:01:21 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 23 Sep 2005 11:04:05 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Nish Aravamudan <nish.aravamudan@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Make epoll_wait() handle negative timeouts as
 MAX_SCHEDULE_TIMEOUT ...
In-Reply-To: <29495f1d0509231042139e9b94@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0509231055260.10222@localhost.localdomain>
References: <Pine.LNX.4.63.0509231031570.10222@localhost.localdomain>
 <29495f1d0509231042139e9b94@mail.gmail.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2005, Nish Aravamudan wrote:

> On 9/23/05, Davide Libenzi <davidel@xmailserver.org> wrote:
>>
>> As reported by Vadim Lobanov, epoll_wait() did not handle correctly
>> timeouts <0 (only the -1 case was MAX_SCHEDULE_TIMEOUT'd).
>>
>>
>> Signed-off-by: Davide Libenzi <davidel@xmailserver.org>
>
> Arrgggh, this is as wrong as sys_poll() was before! :)
>
> --- a/fs/eventpoll.c	2005-09-23 10:06:45.000000000 -0700
> +++ b/fs/eventpoll.c	2005-09-23 10:09:35.000000000 -0700
> @@ -1507,7 +1507,7 @@
> 	 * and the overflow condition. The passed timeout is in milliseconds,
> 	 * that why (t * HZ) / 1000.
> 	 */
> -	jtimeout = timeout == -1 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?
> +	jtimeout = timeout < 0 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?
>
> @timeout is in miliseconds, per the comment, yes? If so, then
>
> timeout [msecs] > MAX_SCHEDULE_TIMEOUT [jiffies] - 1000 [jiffies] / HZ
> [jiffies / sec]

Sh*t, you're right! Reposting soon.


- Davide


