Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270445AbRHHLVP>; Wed, 8 Aug 2001 07:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270454AbRHHLVF>; Wed, 8 Aug 2001 07:21:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59230 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S270445AbRHHLUz>; Wed, 8 Aug 2001 07:20:55 -0400
To: Andrew McNamara <andrewm@connect.com.au>
Cc: Jes Sorensen <jes@sunsite.dk>, Chris Wedgwood <cw@f00f.org>,
        linux-kernel@vger.kernel.org
Subject: Re: how to tell Linux *not* to share IRQs ?
In-Reply-To: <20010808000528.DB146BF02@wawura.off.connect.com.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Aug 2001 05:14:07 -0600
In-Reply-To: <20010808000528.DB146BF02@wawura.off.connect.com.au>
Message-ID: <m1wv4eu7ls.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew McNamara <andrewm@connect.com.au> writes:

> >Chris> Yes, drivers need to check their hardware devices and
> >Chris> acknowledge whether or not it's was their interrupt or not.  It
> >Chris> sounds terrible but even with many thousands of interrupts per
> >Chris> second the cost doesn't seem to be that high.
> >
> >Not only is this the case, it's also the only sane thing to do <tm>,
> >any device driver should check the status of the hardware it is
> >serving before doing anything else.
> 
> That's not necessarily the case - the problem arises due the
> limitations of PC interrupt routing. In an ideal world, the
> interrupting device would be able to be uniquely identified, rather
> than having to poll every device sharing that interrupt.

Interrupts are inherently race, so you still want to check your device
status, even if you get an interrupt.  Having a smaller set of devices
to poll to see if there is any work to do is of course good.
 
> The problem is largely historical - each interrupt traditionally had a
> physically line associated with it, and lines on your backplane were a
> limited resource. 
> 
> If you were to do it again these days, you might have some sort of
> shared serial bus, so devices could give detailed data to the cpu
> (not only to uniquely identify the interrupting device, but also
> identify sub-devices - say a USB peripheral).

I don't know.  The ISA bus was structured somewhat like you describe
and that is what is truly legacy at the moment.  I suspect
the one line per interrupt came of wanting to reduce latencies.

Though when you start think of things like the current ioapics where
you do get a serial bus for your interrupts anyway.  A shared serial
bus probably makes sense.

On the other side I think having drivers that can share interupts is a
very healthy thing so I'm not certain I would want to discourage that.

Eric
