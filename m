Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTJGHuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 03:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTJGHuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 03:50:44 -0400
Received: from smtpout.mac.com ([17.250.248.86]:9429 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261868AbTJGHuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 03:50:39 -0400
Message-ID: <1448383.1065513016965.JavaMail.pwaechtler@mac.com>
Date: Tue, 07 Oct 2003 09:50:16 +0200
From: Peter Waechtler <pwaechtler@mac.com>
To: Jakub Jelinek <jakub@redhat.com>
Subject: Re: POSIX message queues
Cc: Jamie Lokier <jamie@shareable.org>, Ulrich Drepper <drepper@redhat.com>,
       Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
       linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
       Michal Wronski <wrona@mat.uni.torun.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
On Sunday, October 05, 2003, at 08:32PM, Jakub Jelinek <jakub@redhat.com> wrote:

>> Speaking of librt - I should not have to link in pthreads and the
>> run-time overhead associated with it (locking stdio etc.) just so I
>> can use shm_open().  Any chance of fixing this?
>
>That overhead is mostly gone in current glibcs (when using NPTL):
>a) e.g. locking is done unconditionally even when libpthread is not present
>   (it is just lock cmpxchgl, inlined)


a "lock cmpxchg" is > 100 cycles (according to a recent Linux Journal article
from Paul McKenney: 107ns on 700MHz PentiumIII)

But I think you will have benchmarked the alternatives?
BTW, what are they?

you suggested naming the syscall number symbols NR_mq_open instead of
NR_sys_mq_open. In the stub I want to overload some syscalls (e.g. mq_open)
but others not (e.g. mq_timedsend).

How to deal with that?

