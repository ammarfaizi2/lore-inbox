Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271861AbRIQQnx>; Mon, 17 Sep 2001 12:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271856AbRIQQnp>; Mon, 17 Sep 2001 12:43:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:44417 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S271832AbRIQQna>; Mon, 17 Sep 2001 12:43:30 -0400
Date: Mon, 17 Sep 2001 12:42:27 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Re: [Q] Implementation of spin_lock on i386: why "rep;nop" ?
In-Reply-To: <Pine.LNX.4.31.0109171725140.26090-100000@sisley.ri.silicomp.fr>
Message-ID: <Pine.LNX.3.95.1010917123904.14830A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001, Jean-Marc Saffroy wrote:

> Hi all,
> 
> One of my coworkers directed my attention to the implementation of
> spinlocks on IA-32. In spin_lock_string, we can read:
> 
> 	"cmpb $0,%0\n\t" \
> 	"rep;nop\n\t" \
> 	"jle 2b\n\t" \
> 
> The "rep;nop" line looks dubious, since the IA-32 programmer's manual from
> Intel (year 2001) mentions that the behaviour of REP is undefined when it
> is not used with string opcodes. BTW, according to the same manual, REP is
> supposed to modify ecx, but it looks like is is not the case here... which
> is fortunate, since ecx is never saved. :-)
> 
> What is the intent behind this "rep;nop" ? Does it really rely on an
> undocumented behaviour ?
> 
> 
> Regards,

Well it's now documented although you have to search a web-site to
find it. Basically, it runs the CPU at low clock-speed when it's
busy-waiting. Since most all spin-locks lock for mere microseconds
it's unlikely that it does anything useful, but it can't hurt.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


