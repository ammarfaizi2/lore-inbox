Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271824AbRHUTEa>; Tue, 21 Aug 2001 15:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271828AbRHUTEU>; Tue, 21 Aug 2001 15:04:20 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:519 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271824AbRHUTEG>; Tue, 21 Aug 2001 15:04:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: Memory Problem in 2.4.9 ?
Date: Tue, 21 Aug 2001 21:10:44 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010821154617.4671f85d.skraw@ithnet.com> <20010821174918Z16114-32383+718@humbolt.nl.linux.org> <20010821201733.40fae5cf.skraw@ithnet.com>
In-Reply-To: <20010821201733.40fae5cf.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010821190414Z16086-32384+294@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 21, 2001 08:17 pm, Stephan von Krawczynski wrote:
> On Tue, 21 Aug 2001 19:55:49 +0200
> Daniel Phillips <phillips@bonn-fries.net> wrote:
> 
> > Do you have highmem configged?  Try it with highmem off.
> 
> I did. Problem stays:
> 
> Aug 21 20:14:51 admin kernel: __alloc_pages: 3-order allocation failed 
(gfp=0x20/0).
> Aug 21 20:14:51 admin last message repeated 146 times
> 
> Next idea?

It's an atomic allocation, the driver is supposed to be able to handle this, 
and it does since you report that the burn just runs slowly, it does not 
stop.  There is way too much in cache:

>         total:    used:    free:  shared: buffers:  cached:
> Mem:  1053675520 1047502848  6172672        0 20930560 939307008
> Swap: 271392768 15880192 255512576

This is causing the high order allocation failures - with only a small 
fraction of memory free the chances of none of it being in contiguous, 
aligned 8 page units rises dramatically.  It's likely the kprint that is 
slowing you down, you could check this by commenting it out (page_alloc.c, 
near the end of __alloc_pages).

Do you have the same problem on 2.4.8, but not in 2.4.7?

--
Daniel
