Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129722AbQJaX1z>; Tue, 31 Oct 2000 18:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129803AbQJaX1p>; Tue, 31 Oct 2000 18:27:45 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:46347 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129722AbQJaX1j>; Tue, 31 Oct 2000 18:27:39 -0500
Message-ID: <39FF5483.1E27D357@timpanogas.org>
Date: Tue, 31 Oct 2000 16:23:47 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: root@chaos.analogic.com, Andi Kleen <ak@suse.de>,
        Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.4.21.0011010129010.18143-100000@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:
> 
> On Tue, 31 Oct 2000, Jeff V. Merkey wrote:
> 
> > > One could create a 'kernel' that does:
> > >         for(;;)
> > >         {
> > >           proc0();
> > >           proc1();
> > >           proc2();
> > >           proc3();
> > >           etc();
> > >         }
> >
> > would be coded like this (no C compiler):
> >
> > proc0:
> >
> > proc1:
> >
> > proc2:
> >
> > proc3:
> >
> > etc:
> >
> > label:
> >      jmp  proc0
> 
> oh, and what happens if it turns out that some other place wants to call
> proc3 as well? Recode the assembly - cool! Not.

They would load the registers to the proper values and jump to it.  The
return address would be stored in the ESI register, and when the routie
completed, it would do

jmp   esi  

to return, with 0 stack usage.

> 
> > I just avoided 5 x 20 bytes of pushes and pops on the stack ad optimized
> > for a simple fall through case.
> 
> FYI, GCC does not generate 5 x 20 bytes of pushes and pops. In fact in the
> above specific case it will not generate a single push (automatically -
> you dont have to worry about it).

If the compiler were set to optimize.  

Jeff

> 
>         Ingo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
