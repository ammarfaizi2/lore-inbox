Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWGFVCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWGFVCd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 17:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWGFVCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 17:02:32 -0400
Received: from smtp.ono.com ([62.42.230.12]:56653 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S1750856AbWGFVCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 17:02:32 -0400
Date: Thu, 6 Jul 2006 23:02:15 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
Message-ID: <20060706230215.203c790c@werewolf.auna.net>
In-Reply-To: <Pine.LNX.4.64.0607061057240.12404@g5.osdl.org>
References: <20060705114630.GA3134@elte.hu>
	<20060705101059.66a762bf.akpm@osdl.org>
	<20060705193551.GA13070@elte.hu>
	<20060705131824.52fa20ec.akpm@osdl.org>
	<Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
	<20060705204727.GA16615@elte.hu>
	<Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
	<20060705214502.GA27597@elte.hu>
	<Pine.LNX.4.64.0607051458200.12404@g5.osdl.org>
	<Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
	<20060706081639.GA24179@elte.hu>
	<Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
	<Pine.LNX.4.64.0607060856080.12404@g5.osdl.org>
	<Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
	<Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com>
	<Pine.LNX.4.64.0607061057240.12404@g5.osdl.org>
X-Mailer: Sylpheed-Claws 2.3.1cvs59 (GTK+ 2.10.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006 11:00:43 -0700 (PDT), Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Thu, 6 Jul 2006, linux-os (Dick Johnson) wrote:
> > 
> > Linus, you may have been reading too many novels.
> > 
> > If I have some code that does:
> > 
> > extern int spinner;
> > 
> > funct(){
> >      while(spinner)
> >          ;
> > 
> > The 'C' compiler has no choice but to actually make that memory access
> > and read the variable because the variable is in another module (a.k.a.
> > file).
> 
> You don't know how C works, do you?
> 
> You also have no idea of what out-of-order memory accesses do to OS code, 
> right?
> 

I think you are mixing apples and oranges. Using volatile to control o-o-o
memory accesses is sure wrong.
It just means "don't assume this variable has not changed because you don't
see any access to it" to the compiler. It is designed to prevent high level
optimizations like code movement or dead code elimination, but a _high_ level.
It has nothing to do with memory barriers and so on. That is surely a
misuse of volatile.

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam01 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Wed
