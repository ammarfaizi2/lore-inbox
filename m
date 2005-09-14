Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbVINRSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbVINRSl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965254AbVINRSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:18:41 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:8679 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965253AbVINRSk (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:18:40 -0400
Date: Wed, 14 Sep 2005 19:18:31 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
In-Reply-To: <43285374.3020806@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0509141906040.3728@scrub.home>
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au>
 <Pine.LNX.4.61.0509141814220.3743@scrub.home> <43285374.3020806@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Sep 2005, Nick Piggin wrote:

> Or here is possible pseudo code for an architecture with ll/sc
> instructions:
> 
>   do {
>     tmp = load_locked(v);
>     if (!tmp)
>       break;
>     tmp++;
>   } while (!store_cond(v, tmp));
> 
>   return tmp;
> 
> As opposed to using the cmpxchg version, which would have more
> loads and conditional branches, AFAIKS.

I'd prefer to generalize this construct, than polluting atomic.h with all 
kinds of esoteric atomic operations.
So you would get:

	do {
		old = atomic_load_locked(v);
		if (!old)
			break;
		new = old + 1;
	} while (!atomic_store_lock(v, old, new));

bye, Roman
