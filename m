Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129697AbQKHSeY>; Wed, 8 Nov 2000 13:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129689AbQKHSeO>; Wed, 8 Nov 2000 13:34:14 -0500
Received: from adsl-63-194-89-126.dsl.snfc21.pacbell.net ([63.194.89.126]:27660
	"HELO skull.piratehaven.org") by vger.kernel.org with SMTP
	id <S129508AbQKHSeF>; Wed, 8 Nov 2000 13:34:05 -0500
Date: Wed, 8 Nov 2000 10:29:06 -0800
From: Brian Pomerantz <bapper@piratehaven.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Pentium 4 and 2.4/2.5
Message-ID: <20001108102906.A9302@skull.piratehaven.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001108101248.A8902@skull.piratehaven.org> <E13tZrA-0000HQ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <E13tZrA-0000HQ-00@the-village.bc.nu>
X-homepage: http://www.piratehaven.org/~bapper/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 06:21:54PM +0000, Alan Cox wrote:
> > > 		asm volatile("rep ; nop");
> > > 
> > > (there's not much a "rep nop" _can_ do, after all - the most likely CPU
> > > extension would be to raise an "Illegal Opcode" fault).
> > 
> > Just for the curious, this works on Athlons. :)
> 
> What state does it leave the condition codes ?  That matters. 
> 
> Take for example
> 
> if (!oldval)
>                 asm volatile(
>                         "2:"
>                         "cmpl $-1, %0;"
>                         "rep; nop;"
>                         "je 2b;"
>                         	: :"m" (current->need_resched));
> }
> 
> When running SMP with poll_idle enabled. I can't see it changing condition
> codes on an athlon but..

Yup, that works as well.  This example:

	int	foo = -1;
	asm volatile(
		"2:"
		"cmpl $-1, %0;"
		"rep; nop;"
		"je 2b;"
		: :"m" (foo));

loops forever.  If you set 'foo = 0' it drops out.


BAPper
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
