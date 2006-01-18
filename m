Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWARHkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWARHkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWARHkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:40:37 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:49376 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1030299AbWARHkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:40:36 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 17 Jan 2006 23:40:34 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, dwmw2@infradead.org
Subject: Re: [PATCH] pepoll_wait ...
In-Reply-To: <20060117210318.1f4212f0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0601172338530.4942@localhost.localdomain>
References: <Pine.LNX.4.63.0601171933400.15529@localhost.localdomain>
 <43CDC21C.7050608@redhat.com> <20060117210318.1f4212f0.akpm@osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2006, Andrew Morton wrote:

> Ulrich Drepper <drepper@redhat.com> wrote:
>>
>> Davide Libenzi wrote:
>>> The attached patch implements the pepoll_wait system call, that extend
>>> the event wait mechanism with the same logic ppoll and pselect do. The
>>> definition of pepoll_wait is: [...]
>>
>> I definitely ACK this patch, it's needed for the same reasons we need
>> pselect and ppoll.
>>
>
> It busts most architectures.
>
> fs/eventpoll.c: In function `sys_pepoll_wait':
> fs/eventpoll.c:727: error: `TIF_RESTORE_SIGMASK' undeclared (first use in this function)
>
> It seems that the preferred way to fix this is to sprinkle #ifdef
> TIF_RESTORE_SIGMASK all over the code.

Hey, I've written in the comments that it depends on the 
TIF_RESTORE_SIGMASK bits ;) The latest one that dwmw posted used such 
feature, so I though to align epoll bits to that too.



- Davide


