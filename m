Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131035AbQLHRUo>; Fri, 8 Dec 2000 12:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129639AbQLHRUe>; Fri, 8 Dec 2000 12:20:34 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4992 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131537AbQLHRUW>; Fri, 8 Dec 2000 12:20:22 -0500
Date: Fri, 8 Dec 2000 11:49:13 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Matthew Vanecek <linux4us@home.com>
cc: Peter Samuelson <peter@cadcamlab.org>, Rainer Mager <rmager@vgkk.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Signal 11
In-Reply-To: <3A310E18.DD23D416@home.com>
Message-ID: <Pine.LNX.3.95.1001208113945.1500A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000, Matthew Vanecek wrote:

> Peter Samuelson wrote:
> > 
> > [Dick Johnson]
> > > Do:
> > >
> > > char main[]={0xff,0xff,0xff,0xff};
> > 
> > Oh come on, at least pick an *interesting* invalid opcode:
> > 
> >   char main[]={0xf0,0x0f,0xc0,0xc8};    /* try also on NT (: */
> > 
> 
> me2v@reliant DRFDecoder $ ./op
> Illegal instruction (core dumped)
> 
> Is that the expected behavior?

Yep. And on early Pentinums, the ones with the "f00f" bug, it
would lock the machine tighter than a witches crotch. Ooops,
not politically correct.... It would allow user-mode code
to halt the machine.

Here is code that just quietly returns to the runtime code
that called it:

char main[]={0x90, 0x90, 0xc3};

FYI, if the .data section was not executable, you couldn't do
this. You would have to use some __asm__ stuff to put it in
the .text section. But, this is an interesting example of
how you can create code that the compiler refuses to generate.

It's easier to use assembly, though.....

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
