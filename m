Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263229AbUEJXYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbUEJXYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbUEJXT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:19:26 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:54932 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262007AbUEJXNB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:13:01 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 May 2004 16:12:58 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Daniel Jacobowitz <dan@debian.org>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Fabiano Ramos <ramos_fabiano@yahoo.com.br>, Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ptrace in 2.6.5
In-Reply-To: <20040510225818.GA24796@nevyn.them.org>
Message-ID: <Pine.LNX.4.58.0405101610480.1156@bigblue.dev.mdolabs.com>
References: <1UlcA-6lq-9@gated-at.bofh.it> <m365b4kth8.fsf@averell.firstfloor.org>
 <1084220684.1798.3.camel@slack.domain.invalid> <877jvkx88r.fsf@devron.myhome.or.jp>
 <873c67yk5v.fsf@devron.myhome.or.jp> <20040510225818.GA24796@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004, Daniel Jacobowitz wrote:

> On Tue, May 11, 2004 at 07:47:08AM +0900, OGAWA Hirofumi wrote:
> > OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
> > 
> > > So single-step exception happen *after* executed the "mov ...".
> > > Probably you need to use the breakpoint instead of single-step.
> > 
> > Ah, sorry. Just use PTRACE_SYSCALL instead of PTRACE_SINGLESTEP.
> > It's will stop before/after does syscall.
> 
> Doing it this way is pretty lousy - you have to inspect the code after
> every step to see if it's an int $0x80.  Is there some reason not to
> report a trap on the syscall return path if single-stepping?

Well, the "iret" restore TF, and Intel states that the TF flag must be set 
at the beginning of the instruction for the trap to be fired. The next 
insn has the TF set, and the tap is fired. But the EIP is the one 
following the trapped insn.



- Davide

