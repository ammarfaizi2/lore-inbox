Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVIXUF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVIXUF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 16:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVIXUF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 16:05:58 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:34438 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1750726AbVIXUF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 16:05:57 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 24 Sep 2005 13:08:22 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Willy Tarreau <willy@w.ods.org>
cc: Andrew Morton <akpm@osdl.org>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] fixes for overflow in poll(), epoll(), and
 msec_to_jiffies()
In-Reply-To: <20050924193839.GB26197@alpha.home.local>
Message-ID: <Pine.LNX.4.63.0509241301440.31327@localhost.localdomain>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain>
 <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com>
 <20050924061500.GA24628@alpha.home.local> <20050924171928.GF3950@us.ibm.com>
 <Pine.LNX.4.63.0509241120380.31327@localhost.localdomain>
 <20050924193839.GB26197@alpha.home.local>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2005, Willy Tarreau wrote:

> Hello,
>
> After the discussion around epoll() timeout, I noticed that the functions used
> to detect the timeout could themselves overflow for some values of HZ.
>
> So I decided to fix them by defining a macro which represents the maximal
> acceptable argument which is guaranteed not to overflow. As an added bonus,
> those functions can now be used in poll() and ep_poll() and remove the divide
> if HZ == 1000, or replace it with a shift if (1000 % HZ) or (HZ % 1000) is a
> power of two.

Why all that code, when you can have it with:

#define MAX_LONG_MSTIMEO (long) min(1000ULL * MAX_SCHEDULE_TIMEOUT / HZ, LONG_MAX / HZ - 1000ULL)

that gcc-O2 collapses into a single constant?


- Davide


