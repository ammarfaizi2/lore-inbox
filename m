Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278617AbRJXQAD>; Wed, 24 Oct 2001 12:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278615AbRJXP7n>; Wed, 24 Oct 2001 11:59:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57610 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278603AbRJXP7c>; Wed, 24 Oct 2001 11:59:32 -0400
Date: Wed, 24 Oct 2001 08:56:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <E15wQRC-0001uV-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110240855430.8049-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Oct 2001, Alan Cox wrote:
>
> > call might block for some device information, that does not mean that it
> > can allocate memory with GFP_KERNEL, for example: when we shut off device
> > X, the disk may have been prepared for shutdown already, and the VM layer
> > cannot do any IO. So the suspend (and resume) function have to use
> > GFP_NOIO for their allocations - _regardless_ of any other device issues.
>
> So I have to write a whole extra set of code paths to duplicate normal
> functionality during power off

If that ends up being a problem, we can just make alloc_pages turn off the
IO bits on suspend. Easy enough..

Although I think you're making the problem bigger than it is. Most of the
suspend stuff should not need any "normal functionality" at all.

		Linus

