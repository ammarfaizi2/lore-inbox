Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268317AbTAMUSl>; Mon, 13 Jan 2003 15:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268320AbTAMUSk>; Mon, 13 Jan 2003 15:18:40 -0500
Received: from chaos.analogic.com ([204.178.40.224]:38277 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268317AbTAMURl>; Mon, 13 Jan 2003 15:17:41 -0500
Date: Mon, 13 Jan 2003 15:28:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make `obsolete params' work correctly if MODULE_SYMBOL_PRE
In-Reply-To: <8do$n39mw-B@khms.westfalen.de>
Message-ID: <Pine.LNX.3.95.1030113152122.30378A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jan 2003, Kai Henningsen wrote:

> rusty@rustcorp.com.au (Rusty Russell)  wrote on 11.01.03 in <20030111224007$7807@gated-at.bofh.it>:
> 
> > In message <Pine.LNX.4.44.0301102134150.9532-100000@home.transmeta.com> you
> > wri te:
> > >
> > > On Sat, 11 Jan 2003, Rusty Russell wrote:
> > > >
> > > > Just in case someone names a variable over 2000 chars, and uses it as
> > > > an old-style module parameter?
> > >
> > > No. Just because variable-sized arrays aren't C, and generate crappy code.
> > >
> > > >  	for (i = 0; i < num; i++) {
> > > > +		char sym_name[strlen(obsparm[i].name)
> > > > +			     + sizeof(MODULE_SYMBOL_PREFIX)];
> > >
> > > It's still there.
> >
> > OK, *please* explain to me in little words so I can understand.
> 
> Do "char sym_name[CONSTANT];". What's so hard to understand about that?
> 
> > Variable-sized arrays are C, as of C99.  They've been a GNU extension
> > forever.
> 
> Actually, the gcc thing and the C99 thing are significantly different, and  
> neither is a sub- or superset of the other. In fact, gcc's C99-conformance  
> page (http://gcc.gnu.org/c99status.html) still lists VLAs as "broken".
> 
> See here for at least some explanation:
>         http://gcc.gnu.org/ml/gcc/2002-10/msg00470.html
> 
> > While gcc 2.95.4 generates fairly horrible code, gcc 3.0 does better
> > (the two compilers I have on my laptop).
> >
> > Both generate correct code.
> 
> For the GNU extension, maybe.
> 
> MfG Kai

In principle, the idea of variable-length arrays should cause
the compiler to generate very reasonable code because the
length is only a value to subtract from ESP.

void foo(int len)
{
   char use[0x100];
   char bar[len];
}

In the case of 'use', the compiler subtracts (0x100 * sizeof(char))
from the current stack value and uses that as the location for 'use'.
In the case of 'bar' the compiler subtracts (len * sizeof(char))
from the current stack value and uses that as the location for 'bar'.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


