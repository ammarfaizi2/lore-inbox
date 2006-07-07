Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWGGWt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWGGWt5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWGGWt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:49:57 -0400
Received: from smtp.ono.com ([62.42.230.12]:23273 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S932365AbWGGWt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:49:56 -0400
Date: Sat, 8 Jul 2006 00:49:43 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Chase Venters <chase.venters@clientec.com>
Cc: "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
Message-ID: <20060708004943.05dbb10c@werewolf.auna.net>
In-Reply-To: <Pine.LNX.4.64.0607071718080.23767@turbotaz.ourhouse>
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
	<m34pxt8emn.fsf@defiant.localdomain>
	<Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com>
	<Pine.LNX.4.64.0607071318570.3869@g5.osdl.org>
	<Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com>
	<20060708000531.410cd672@werewolf.auna.net>
	<Pine.LNX.4.64.0607071718080.23767@turbotaz.ourhouse>
X-Mailer: Sylpheed-Claws 2.3.1cvs68 (GTK+ 2.10.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 17:22:22 -0500 (CDT), Chase Venters <chase.venters@clientec.com> wrote:

> > .L7:
> >    movl    $1, mtx    <=========
> >    movl    spinvar, %eax
> >    movl    $0, mtx    <=========
> >    testl   %eax, %eax
> >    jne .L7
> >    popl    %ebp
> >    ret
> 
> NO! It's not better. You're still not syncing or locking the bus! If you 
> refer to the fact that the "movl $1" has magically appeared, that's 
> because you've just PAPERED OVER THE PROBLEM WITH "volatile", which is 
> _exactly_ what Linus is telling you NOT TO DO.
> 

BTW, I really don't mind if a given architecnture has to lock the bus or
say a prayer to Budha to reload a variable. I want it to be reloaded at
every (or a certain, in case of a (volatile)mtx cast) usage. The compiler
is the responsible of knowing what to do. What if nextgen P4 Xeon do not
need a bus lock ? Will you rewrite the kernel ?

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam01 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Wed
