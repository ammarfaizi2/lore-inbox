Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbULIOLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbULIOLx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbULIOLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:11:53 -0500
Received: from alog0402.analogic.com ([208.224.222.178]:14464 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261347AbULIOKJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:10:09 -0500
Date: Thu, 9 Dec 2004 09:09:30 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Phani Kandula <phani.lkml@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: doubt about "switch" - default case in af_inet.c
In-Reply-To: <7d34f21904120905573ddb6d25@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0412090901260.21235@chaos.analogic.com>
References: <7d34f21904120905573ddb6d25@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2004, Phani Kandula wrote:

> Hi all,
>
> I'm a newbie to the Linux. I'm using 2.6.8 kernel.
> In /usr/src/linux/net/ipv4/af_inet.c I came across this...
> <code>
>     switch (sock->state) {
>     default:
>     //do something..
>         goto out;
>     case SS_CONNECTED:
>     //do something..
>         goto out;
>     case SS_CONNECTING:
>     //do something..
>         break;
>     case SS_UNCONNECTED:
>     //do something..
>         break;
>     }
> </code>
>
> Is there any advantage in having 'default' as the first case?
> My understanding is that it will be useful only when 'default' is the
> most likely case (in general).
>
> Even then, my doubt: How will compiler (say gcc) implement 'default'
> as the first value? Program is supposed to see all the cases and then
> decide 'default'. Is this correct?
>
> So, is this the best way to do it? please clarify..
>
> Thanks,
> Phani

Generally speaking when you see "strange" code mixed with gotos,
somebody has adjusted the code, often by looking at the assembly
output, to maximize the performance.

Of course, when the compiler changes, the code may no longer be
optimum.

In principle, if the labels in a switch represent incrementing
numbers, the compiler can generate fast code by using that fact.
However, often little care is taken in the placement of these
labels or the numerical differences between them so the code output
degenerates to a bunch of "compares". In this case, the most common
value should be the one checked first.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
