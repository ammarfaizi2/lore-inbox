Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265798AbSLIRm1>; Mon, 9 Dec 2002 12:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265843AbSLIRm0>; Mon, 9 Dec 2002 12:42:26 -0500
Received: from mail.ccur.com ([208.248.32.212]:22022 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id <S265798AbSLIRmV>;
	Mon, 9 Dec 2002 12:42:21 -0500
Message-ID: <3DF4D7B1.7A037B25@ccur.com>
Date: Mon, 09 Dec 2002 12:49:37 -0500
From: Jim Houston <jim.houston@ccur.com>
Reply-To: jim.houston@ccur.com
Organization: Concurrent Computer Corp.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Daniel Jacobowitz <dan@debian.org>, george anzinger <george@mvista.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
References: <Pine.LNX.4.44.0212090828460.3397-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> NOTE NOTE NOTE! This patch is totally untested. It may or may not compile
> and work. It _looks_ correct, but that's all I'm going to guarantee about
> it.
> 
>                 if (regs->eax == -ERESTART_RESTARTBLOCK){
> +                       struct restart_block *restart = &current_thread_info()->restart_block;
>                         regs->eax = __NR_restart_syscall;
> +                       regs->ebx = restart->arg0;
> +                       regs->ecx = restart->arg1;

Hi Linus,

Either I'm missing something or this is broken if there is ever 
more than one restart function involved.  You save the arguments
to the register state that gdb saves but not the restart function
address.  In the nested case this would call one restart function
with the arguments of another.

Jim Houston - Concurrent Computer Corp.
