Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268269AbTAMUtg>; Mon, 13 Jan 2003 15:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268307AbTAMUtf>; Mon, 13 Jan 2003 15:49:35 -0500
Received: from chaos.analogic.com ([204.178.40.224]:40325 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268269AbTAMUte>; Mon, 13 Jan 2003 15:49:34 -0500
Date: Mon, 13 Jan 2003 16:01:32 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Valdis.Kletnieks@vt.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make `obsolete params' work correctly if MODULE_SYMBOL_PRE 
In-Reply-To: <200301132043.h0DKhSRX007387@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.3.95.1030113155524.30616A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003 Valdis.Kletnieks@vt.edu wrote:

> On Mon, 13 Jan 2003 15:28:45 EST, "Richard B. Johnson" said:
> 
> > void foo(int len)
> > {
> >    char use[0x100];
> >    char bar[len];
> > }
> > 
> > In the case of 'use', the compiler subtracts (0x100 * sizeof(char))
> > from the current stack value and uses that as the location for 'use'.
> > In the case of 'bar' the compiler subtracts (len * sizeof(char))
> > from the current stack value and uses that as the location for 'bar'.
> 
> One or the other of these is missing a -0x100 for the location...
> 
> void foo (int len1, unsigned int len2)
> {
>   char bar[0x100];
>   char baz[len1];
>   char quux[len2];
>   char moby[8];
> }
> 
> And moby[6] is *where*? ;)  Bonus points for getting this right if
> compiled with -fvomit-stack-pointer. <evil grin> ;)
> -- 

Trivial. The constant stuff gets allocated first, then the dynamic.
You can write the code in any order you want, but the code generation
is as though you did:
	char bar [0x100];
        char moby[8];
Also, vomit-stack-pointer is "f(v)omit-frame-pointer". It works
the same. No problem except when trying to find local variables
in the debugger (known -g implimentation "feature"). The frame
pointer is BP. The stack is never omitted. You can save a few
instructions if you don't use it.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


