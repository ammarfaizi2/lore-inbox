Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317748AbSGZOjS>; Fri, 26 Jul 2002 10:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317753AbSGZOjS>; Fri, 26 Jul 2002 10:39:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317748AbSGZOjR>; Fri, 26 Jul 2002 10:39:17 -0400
Date: Fri, 26 Jul 2002 10:39:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Daniel Phillips <phillips@arcor.de>, Andrew Rodland <arodland@noln.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -ac] Panicking in morse code
In-Reply-To: <Pine.LNX.3.96.1020726091213.16487A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.3.95.1020726100704.2003A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2002, Bill Davidsen wrote:

> On Fri, 26 Jul 2002, Daniel Phillips wrote:
> 
> > On Thursday 25 July 2002 14:51, Bill Davidsen wrote:
> > > On Fri, 19 Jul 2002, Alan Cox wrote:
> > > 
> > > > > +static const char * morse[] = {
> > > > > +	".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", /* A-H */
> [...snip...]
> > > > 
> > > > How about using bitmasks here. Say top five bits being the length, lower
> > > > 5 bits being 1 for dash 0 for dit ?
> > > 
> > > ??? If the length is 1..5 I suspect you could use the top two bits and fit
> > > the whole thing in a byte. But since bytes work well, use the top three
> > > bits for length without the one bit offset. Still a big win over strings,
> > > although a LOT harder to get right by eye.
> > 
> > Please read back through the thread and see how 255 different 7 bit codes
> > complete with lengths can be packed into 8 bits.
> 
> ???
>  1 - there are not 255 different 7 bit values, there are 128
>  2 - morse code has a longest value of 5 elements not 7


The '.' (also called full-stop) is 6 elements long. The ',' is also
6 elements long. For a correct implimentation, i.e., one that sounds
correct, you need to encode a 'pause' element into each symbol. This
is because the pause between Morse characters is sometimes ahead
of a character and sometimes behind a character (the pause is ahead
of characters starting with a dot and after characters ending with a
dot, including characters of all dots -- except for numbers, which
have pauses after them). In a previously life, I had to develop
the correct "fist" to pass the Socond Class Radio Telegraph License.

This means that it is probably best to use one 8-byte character
for each Morse-code character.

If anybody's interested I have some DOS assembly circa 1987 that
did this stuff. It ignored the correct "fist", and has spaces after
each character. It doesn't sound too bad.

>  3 - Alan was talking about len+val representation, not stop-bit patterns,
>      which is what I guess you mean

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

