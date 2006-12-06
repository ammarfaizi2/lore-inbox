Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760661AbWLFOf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760661AbWLFOf2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 09:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760660AbWLFOf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 09:35:28 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:31753 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760661AbWLFOf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 09:35:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HE+VC92AUI53BXGMD2Uca9gmMTqn6q0e8AW5+Oe+hk35xgPZbf2ZpU/w/1q5l8ZtyX5BvcCHxkx54ZaxOOHkEAR2AlhVs8Nugz6imNKl7LNMMaOGqi8SmWkXyXn6zRGf9+eE4UE0hAk1uMFoO43z4fDRxYmcuTwLjL97ebFceQs=
Message-ID: <aa5953d60612060635l43b79ed8g1196cfc0435c0cb1@mail.gmail.com>
Date: Wed, 6 Dec 2006 20:05:25 +0530
From: "Jaswinder Singh" <jaswinderrajput@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH] let WARN_ON() output the condition
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       "Andrew Morton" <akpm@osdl.org>, "Jiri Kosina" <jkosina@suse.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061206135445.GA17224@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061205172737.14ecfeb3.akpm@osdl.org>
	 <200612061252.kB6CqRYP008046@laptop13.inf.utfsm.cl>
	 <20061206135445.GA17224@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am playing with linux kernel but kernel dumps on WARN_ON , when I
commented WARN_ON in my code my kernel starts working but I get two
sideeffects :-

1. During Boot kernel Hangs sometimes in :-
Updating /etc/motd...done.
INIT: Entering runlevel: 3
<<hangs>>

2. Always Hangs in :-
cat /proc/interrupts
after showing interrupts
<<hangs>>

Are these side-effects of commenting WARN_ON.

Sometimes I also gets :-

<1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Unable to handle kernel NULL pointer dereference at virtual address 00000004
<1>pgd = c5810000
pgd = c5810000
<1>[00000004] *pgd=85844031[00000004] *pgd=85844031, *pte=00000000,
*pte=00000000, *ppte=00000000, *ppte=00000000

Internal error: Oops: 17 [#1]
Internal error: Oops: 17 [#1]
Modules linked in:Modules linked in:

CPU: 0
CPU: 0
PC is at dequeue_task+0xc/0x78
PC is at dequeue_task+0xc/0x78
LR is at deactivate_task+0x24/0x30
LR is at deactivate_task+0x24/0x30
pc : [<c0037264>]    lr : [<c003759c>]    Not tainted
sp : c545ddcc  ip : c545dddc  fp : c545ddd8
pc : [<c0037264>]    lr : [<c003759c>]    Not tainted
sp : c545ddcc  ip : c545dddc  fp : c545ddd8
r10: c68fd340  r9 : c02e04d4  r8 : c028ccf8
r10: c68fd340  r9 : c02e04d4  r8 : c028ccf8
r7 : c028ded8  r6 : c028ccf4  r5 : c545c000  r4 : c68fd340
r7 : c028ded8  r6 : c028ccf4  r5 : c545c000  r4 : c68fd340
r3 : 00000002  r2 : 00000000  r1 : 00000000  r0 : c68fd340
r3 : 00000002  r2 : 00000000  r1 : 00000000  r0 : c68fd340
Flags: NzcvFlags: Nzcv  IRQs on  FIQs on  Mode SVC_32  Segment user
  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 5317F  Table: 85810000  DAC: 00000015
Control: 5317F  Table: 85810000  DAC: 00000015
Process X (pid: 1107, stack limit = 0xc545c198)
Process X (pid: 1107, stack limit = 0xc545c198)
Stack: (0xc545ddcc to 0xc545e000)
Stack: (0xc545ddcc to 0xc545e000)

How to get rid of dequeue_task issue.

Thanks

Jaswinder Singh.

On 12/6/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:
>
> > Why not just:
> >
> >     WARN_ON(debug_locks_off())
> >
> > here? Would give a more readable message too, IMHO.
>
> debug_locks_off() has a side-effect, and in general we dont like to put
> stuff with side-effects witin WARN_ON().
>
>        Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
