Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277152AbRKSKHo>; Mon, 19 Nov 2001 05:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277228AbRKSKHe>; Mon, 19 Nov 2001 05:07:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57099 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277152AbRKSKHT>; Mon, 19 Nov 2001 05:07:19 -0500
Subject: Re: VM-related Oops: 2.4.15pre1
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 19 Nov 2001 10:15:14 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111181756260.7482-100000@penguin.transmeta.com> from "Linus Torvalds" at Nov 18, 2001 06:02:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E165lSM-000666-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There's no point being a language lawyer and saying that gcc "could write
> anything to value before it writes the final 2". Tha's not true. A compile
> rthat does that is
> 
>  (a) buggy as hell from a POSIX standpoint

It would mean someone misdefined sig_atomic_t if it broke for assignment

> And yes, the argument for "page->flags" is _exactly_ the same. Writing
> intermediate values to "page->flags" that were never referenced by the
> programmer is clearly such a violation of QoI that it is a bug even if
> "sig_atomic_t" happens to be "int", and "page->flags" happens to be
> "unsigned int".

If the code execution path is faster why shouldnt the compiler generate
those patterns. You haven't told the variable that its volatile. Therefore
the compiler is supposed to be optimising it.

You can in theory get even stranger effects. Consider

	if(!(flag&4))
	{
		blahblah++;
		flag|=4;
	}

The compiler is completely at liberty to turn that into

	test bit 2
	jz 1f
	inc blahblah
	add #4, flag
1f:

because it knows the bit was clear and it knows the variable is not
volatile.

Having your own personal custom language dialect might be tempting but it is 
normally something only the lisp community do.

Alan
