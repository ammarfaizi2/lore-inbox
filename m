Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272142AbTHRReG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 13:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272150AbTHRReG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 13:34:06 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:23463
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S272142AbTHRReD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 13:34:03 -0400
Date: Mon, 18 Aug 2003 16:23:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, green@namesys.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030818142332.GV7862@dualathlon.random>
References: <20030802142734.5df93471.skraw@ithnet.com> <Pine.LNX.4.44.0308051340010.2848-100000@logos.cnet> <20030806094150.4d7b0610.skraw@ithnet.com> <20030806090920.GA9492@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806090920.GA9492@alpha.home.local>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 11:09:20AM +0200, Willy Tarreau wrote:
> On Wed, Aug 06, 2003 at 09:41:50AM +0200, Stephan von Krawczynski wrote:
>  
> > Code;  c0144b14 <__remove_from_queues+14/30>
> > 00000000 <_EIP>:
> > Code;  c0144b14 <__remove_from_queues+14/30>   <=====
> >    0:   89 02                     mov    %eax,(%edx)   <=====
> > Code;  c0144b16 <__remove_from_queues+16/30>
> >    2:   c7 41 30 00 00 00 00      movl   $0x0,0x30(%ecx)
> > Code;  c0144b1d <__remove_from_queues+1d/30>
> >    9:   89 4c 24 04               mov    %ecx,0x4(%esp,1)
> > Code;  c0144b21 <__remove_from_queues+21/30>
> >    d:   e9 7a ff ff ff            jmp    ffffff8c <_EIP+0xffffff8c>
> > Code;  c0144b26 <__remove_from_queues+26/30>
> >   12:   8d 76 00                  lea    0x0(%esi),%esi
> 
> once again, it's *pprev=next which is is causing trouble, with pprev=6 this
> time (fs/buffer.c:523). There really seems to be something playing badly with
> this...
> 
> I find amazing that such widely used portions of code only trigger panics on
> your system ! either it's a rare combinations of several components/drivers, or
> a strange hardware problem, although I can't imagine which (cpu? bus locking?).

normally it's bad ram (or anyways a problem with the memory) when bugs
triggers in that place reproducibly. the list walking trashes the l2 and
that put more stress on the ram. If it was random memory corruption
(software) it would more likely crash in different places (though it's
not guaranteed ;).

Andrea
