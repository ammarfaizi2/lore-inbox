Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbVDGRSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVDGRSk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbVDGRSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:18:40 -0400
Received: from alog0304.analogic.com ([208.224.222.80]:47244 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262492AbVDGRSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:18:36 -0400
Date: Thu, 7 Apr 2005 13:17:28 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Dave Jones <davej@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, stsp@aknet.ru,
       linux-kernel@vger.kernel.org, VANDROVE@vc.cvut.cz
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
In-Reply-To: <20050407164734.GB19016@redhat.com>
Message-ID: <Pine.LNX.4.61.0504071310050.5977@chaos.analogic.com>
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru>
 <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org> <4252EA01.7000805@aknet.ru>
 <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org> <425403F6.409@aknet.ru>
 <20050407080004.GA27252@elte.hu> <20050407041006.4c9db8b2.akpm@osdl.org>
 <Pine.LNX.4.58.0504070737190.28951@ppc970.osdl.org> <20050407164734.GB19016@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2005, Dave Jones wrote:

> On Thu, Apr 07, 2005 at 07:47:41AM -0700, Linus Torvalds wrote:
>
> > So the sysenter sequence might as well look like
> >
> > 	pushl $(__USER_DS)
> > 	pushl %ebp
> > 	sti
> > 	pushfl
> > 	..
> >
> > which actually does three protected pushes thanks to the one-instruction
> > "interrupt shadow" after an sti.
>
> Is this guaranteed on every x86 variant (or rather, every one
> that has SEP). ?
>
> 		Dave

The i486 book says that if the next instruction lets the IF
flag remain enabled, then any interrupts pending occur after
the next instruction. If the next instruction is CLI, no
interrupts will occur. There is a note:

"In case of an NM1, trap, or fault following ST1, the interrupt
will be taken before executing the next sequential instruction
in the code." The use of "NM1" and "ST1" is (sic). I don't
know what NM1 is, it can't be NMI because, by definition NMI
is not maskable so CLI and STI could not affect this pin.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
