Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLOTGM>; Fri, 15 Dec 2000 14:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLOTGC>; Fri, 15 Dec 2000 14:06:02 -0500
Received: from chaos.analogic.com ([204.178.40.224]:12672 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129340AbQLOTFw>; Fri, 15 Dec 2000 14:05:52 -0500
Date: Fri, 15 Dec 2000 13:34:41 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: Andrea Arcangeli <andrea@suse.de>, Mike Black <mblack@csihq.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h
In-Reply-To: <4.3.2.7.2.20001215185622.025f8740@mail.lauterbach.com>
Message-ID: <Pine.LNX.3.95.1001215131538.1528B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2000, Franz Sirl wrote:

> At 18:43 15.12.00, Andrea Arcangeli wrote:
> >On Fri, Dec 15, 2000 at 12:07:55PM -0500, Richard B. Johnson wrote:
> > > Current code makes perfect sense if you put a 'break;' after the last
> >
> >Current code makes perfect sense also without the break. I guess that's a
> >strict check to try to catch bugs, but calling it "deprecated" is wrong, it
> >should only say "warning: make sure that's not a bug" (when -Wall is enabled).
> 
> It's required by ISO C, and since that's the standard now, gcc spits out a 
> warning. Just adding a ; is enough and already done for most stuff in 
> 2.4.0-test12.
> 
> Franz.
> 

Right. I encountered something like this not too long ago in some
other gcc code that would not compile on a Sun.

	FYI, just because gcc lets you get away with some things (it
	knows what you want and tries to be helpful), that doesn't
	mean that the 'C' standard allows it.

	Here is a cute example:

	void foo()
        {
            extern int a;
            if(a) goto foo;
            return;
            foo:
	    printf("%d\n", a);
        }

	gcc allows you to use a label that has the same name as
	the function!
	It also allows you to use the name of a variable as a label!

	void foo()
	{
	   extern int a;
	   if(a) goto a;
	   return;
	   a:
	   printf("%d\n", a);
	}

	Both examples allow an extern declaration inside a function scope
	which is also contrary to any (even old) 'C' standards. 'extern'
	is always file scope, there's no way to make it otherwise.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
