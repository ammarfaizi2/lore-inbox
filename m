Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270661AbRHJW0P>; Fri, 10 Aug 2001 18:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270664AbRHJW0G>; Fri, 10 Aug 2001 18:26:06 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:11253 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S270661AbRHJWZz>; Fri, 10 Aug 2001 18:25:55 -0400
Message-ID: <3B745F64.3E9E277F@mvista.com>
Date: Fri, 10 Aug 2001 15:25:40 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Raghava Raju <vraghava_raju@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: __asm__ usage ????
In-Reply-To: <20010810195004.18859.qmail@web20008.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raghava Raju wrote:
> 
> hi
> 
>    I want some basic insights into assembly level code
> emmbedded in C language. Following is the code of
> PowerPc ambedded in C languagge:
> 
> unsigned long old,mask, *p;
> 
>         __asm__ __volatile__(SMP_WMB "\
> 1:      lwarx   %0,0,%3
>         andc    %0,%0,%2
>         stwcx   %0,0,%3
>         bne     1b"
>         SMP_MB
>         : "=&r" (old), "=m" (*p)
>         : "r" (mask), "r" (p), "m" (*p)
>         : "cc");
> 
>         1) what does these things denote: __volatile__,
> SMP_WMB, SMP_MB, "r","=&r","=m",
> "cc" and 1: .
> 
>         2) Is it that %0,%2,%3 denote addresses of old,mask,p
> respectively.
> 
>         3) Say if it is PowerPc then how should I
> access registers r1,r2 etc, i.e. what is the exact
> syntax.
> 
>         4) I think in power PC we can't access
> directly the contents of memory, but we should
> give addresses of memory in registers then use
> registers in instructions to access memory. But in
> above example he is using %3 in lwarx command
> accessing that memory directly. Is my interpretation
> of above instructions wrong.
> 
>         5) Some people use "memory" in place of "cc" ,
> like I want to know what are these things.
> 
>         6) Finally I want to write a simple programme
> to write the contents of a local variable "xyz" into
> register r33, then store the contents of r33 into
> local variable "abc". Kindly would u give me a sample
> code of doing it.
> 
> Please reply to vraghava_raju@yahoo.com, since I am
> not subscriber to list.
> 
>          Thanks in advance.
>          Raghava.
> 
I think you need to spend a bit of time looking over the gcc info
pages.  From emacs use CTL-X h, else, try info (a program).

You might also want to go to the kernel "top dir" (where the master make
file is) and do:

make TAGS (for emacs)
or
make ctags (for vi)

Then find the symbols SMP_WMB, etc.

This should get you past most of the questions and impart a great deal
more info that you will need on the way.

Along the way I think you will come to understand that you are not just
dropping asm code into the program, you are giving gcc enough info to
optimize your asm along with its other productions.

George
