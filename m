Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSG3Hib>; Tue, 30 Jul 2002 03:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSG3Hib>; Tue, 30 Jul 2002 03:38:31 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:26598 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S315119AbSG3Hi3>; Tue, 30 Jul 2002 03:38:29 -0400
Message-Id: <5.1.0.14.2.20020730002724.00a407f0@mail.attbi.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 30 Jul 2002 00:41:42 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, rwhite@pobox.com
From: Robert White <rwhite@pobox.com>
Subject: Re: n_tty.c driver patch (semantic and performance correction)
  (a ll recent versions)
Cc: Andries Brouwer <aebr@win.tue.nl>, Russell King <rmk@arm.linux.org.uk>,
       Ed Vance <EdV@macrolink.com>, "'Theodore Tso'" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <1027886676.790.5.camel@irongate.swansea.linux.org.uk>
References: <200207271934.27102.rwhite@pobox.com>
 <11E89240C407D311958800A0C9ACF7D13A789A@EXCHANGE>
 <200207271507.56873.rwhite@pobox.com>
 <20020727232129.GA26742@win.tue.nl>
 <200207271934.27102.rwhite@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Um... "no duh"  (I have been programming Unix boxen for twenty years)

In point of fact I specifically AND repeatedly stated that there would 
probably be no change to human-interactive applications.

On the other hand there are a wide number of applications that do have need 
for variable packet lengths, VMIN/VTIME style timeouts and known, but 
variable sized or larger than 256 byte packet sizes.

The entire "smart card" arena is one such set of applications.  Also test 
gear, and simple X/Y/Z modem type transfers.

If it talks at serial speeds, if it has any kind of TIMEOUT feature and/or 
if it doesn't makes sense to strobe it out with no-delay reads (e.g. 
perhaps because there isn't any background-worthy in-application task 
n'cest pa?)  Then having the VMIN and VTIME behaviors, but not having them 
block for un-asked for characters or unconscionably short packets makes 
lots of sense.

As I said, repeatedly calling the kernel TO ASSEMBLE AN INPUT BUFFER if 
VMIN == 1 IS DUMB.

Reading out single (raw) keystrokes isn't "ASSEMBLING AN INPUT BUFFER", it 
is INTERACTING WITH A USER.  [For the audience that is reading along: (in 
cooked mode the buffer assembly happens in... gasp... one read call...) (in 
an editor, for example, or a similar application where VMIN==1 us used, the 
task of aggregating the input into storage is not so straight forward as 
assembling an input buffer as the nature of each keystroke may impact the 
larger state of the program)

When reading data from a non-human source the predictability goes up and 
the buffered data can be more efficiently blocked out by known predicates, 
etc.  This is the audience for the patch.

Rob.


At 21:04 7/28/2002 +0100, Alan Cox wrote:
>On Sun, 2002-07-28 at 03:34, Robert White wrote:
> > Having virtually every user on the planet realize this and just set 
> VMIN == 1
> > is an fairly telling indicator.
> >
> > Repeatedly calling the kernel to assemble an input buffer which is 
> necessary
> > if VMIN ==1, is dumb.
>
>VMIN was basically invented for communication protocols when you know
>the block length that should arrive within a given timeout. Its pretty
>much essential on old old boxes and was very important for
>interrupt/context switch reduction when doing block transfers. In that
>world the read blocks or in O_NDELAY returns -EAGAIN (0 in old SYS5)
>until the data block is big enough to warrant its copying. Similarly
>poll has no business saying data is ready until a large enough block is.
>
>When talking to a human setting VMIN > 1 makes no sense anyway. In fact
>nowdays it makes even less sense than it did before because of the use
>of UTF8 encodings for unicode characters.

----------------------------------------------------------------------
-- Rob White         --  Consider: for all vectors v, Cv - Cv = 0   --
-- rwhite@pobox.com  --    general relativity is thus disproved.    --
----------------------------------------------------------------------
-- There once was a man who claimed nothing was true,               --
--   he was later, of course, found to be lying.                    --
----------------------------------------------------------------------
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: PGPfreeware 7.0.3 for non-commercial use <http://www.pgp.com>

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
=Zx5A
-----END PGP PUBLIC KEY BLOCK-----

