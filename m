Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWGGW7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWGGW7g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWGGW7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:59:36 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:9873 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932273AbWGGW7f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:59:35 -0400
Date: Fri, 7 Jul 2006 15:59:34 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
cc: Chase Venters <chase.venters@clientec.com>,
       "linux-os \\\\(Dick Johnson\\\\)" <linux-os@analogic.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <20060708004943.05dbb10c@werewolf.auna.net>
Message-ID: <Pine.LNX.4.58.0607071556400.619@shell3.speakeasy.net>
References: <20060705114630.GA3134@elte.hu> <20060705193551.GA13070@elte.hu>
 <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
 <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
 <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org>
 <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org> <20060706081639.GA24179@elte.hu>
 <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
 <Pine.LNX.4.64.0607060856080.12404@g5.osdl.org> <Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
 <Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com> <m34pxt8emn.fsf@defiant.localdomain>
 <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com>
 <Pine.LNX.4.64.0607071318570.3869@g5.osdl.org> <Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com>
 <20060708000531.410cd672@werewolf.auna.net> <Pine.LNX.4.64.0607071718080.23767@turbotaz.ourhouse>
 <20060708004943.05dbb10c@werewolf.auna.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2006, J.A. [UTF-8] Magallón wrote:

> On Fri, 7 Jul 2006 17:22:22 -0500 (CDT), Chase Venters <chase.venters@clientec.com> wrote:
>
> > > .L7:
> > >    movl    $1, mtx    <=========
> > >    movl    spinvar, %eax
> > >    movl    $0, mtx    <=========
> > >    testl   %eax, %eax
> > >    jne .L7
> > >    popl    %ebp
> > >    ret
> >
> > NO! It's not better. You're still not syncing or locking the bus! If you
> > refer to the fact that the "movl $1" has magically appeared, that's
> > because you've just PAPERED OVER THE PROBLEM WITH "volatile", which is
> > _exactly_ what Linus is telling you NOT TO DO.
> >
>
> BTW, I really don't mind if a given architecnture has to lock the bus or
> say a prayer to Budha to reload a variable. I want it to be reloaded at
> every (or a certain, in case of a (volatile)mtx cast) usage. The compiler
> is the responsible of knowing what to do. What if nextgen P4 Xeon do not
> need a bus lock ? Will you rewrite the kernel ?

Looks like you need to read Documentation/memory-barriers.txt. That file
explains why the above assembly code is not correct.

Bonus question: what stops the processor from coalescing or rearranging
the three movl instructions in that assembly?

> --
> J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
>                                          \         It's better when it's free
> Mandriva Linux release 2007.0 (Cooker) for i586
> Linux 2.6.17-jam01 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Wed

-- Vadim Lobanov
