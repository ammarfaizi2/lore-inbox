Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274970AbTHFJJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 05:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274985AbTHFJJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 05:09:35 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:14343 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S274970AbTHFJJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 05:09:34 -0400
Date: Wed, 6 Aug 2003 11:09:20 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, andrea@suse.de,
       linux-kernel@vger.kernel.org, green@namesys.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030806090920.GA9492@alpha.home.local>
References: <20030802142734.5df93471.skraw@ithnet.com> <Pine.LNX.4.44.0308051340010.2848-100000@logos.cnet> <20030806094150.4d7b0610.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806094150.4d7b0610.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 09:41:50AM +0200, Stephan von Krawczynski wrote:
 
> Code;  c0144b14 <__remove_from_queues+14/30>
> 00000000 <_EIP>:
> Code;  c0144b14 <__remove_from_queues+14/30>   <=====
>    0:   89 02                     mov    %eax,(%edx)   <=====
> Code;  c0144b16 <__remove_from_queues+16/30>
>    2:   c7 41 30 00 00 00 00      movl   $0x0,0x30(%ecx)
> Code;  c0144b1d <__remove_from_queues+1d/30>
>    9:   89 4c 24 04               mov    %ecx,0x4(%esp,1)
> Code;  c0144b21 <__remove_from_queues+21/30>
>    d:   e9 7a ff ff ff            jmp    ffffff8c <_EIP+0xffffff8c>
> Code;  c0144b26 <__remove_from_queues+26/30>
>   12:   8d 76 00                  lea    0x0(%esi),%esi

once again, it's *pprev=next which is is causing trouble, with pprev=6 this
time (fs/buffer.c:523). There really seems to be something playing badly with
this...

I find amazing that such widely used portions of code only trigger panics on
your system ! either it's a rare combinations of several components/drivers, or
a strange hardware problem, although I can't imagine which (cpu? bus locking?).

Cheers,
Willy

