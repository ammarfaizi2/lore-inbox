Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129691AbRBJJKI>; Sat, 10 Feb 2001 04:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130579AbRBJJJ6>; Sat, 10 Feb 2001 04:09:58 -0500
Received: from colorfullife.com ([216.156.138.34]:32772 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129691AbRBJJJp>;
	Sat, 10 Feb 2001 04:09:45 -0500
Message-ID: <3A850555.488DE444@colorfullife.com>
Date: Sat, 10 Feb 2001 10:09:41 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [beta patch] SSE copy_page() / clear_page()
In-Reply-To: <3A846C84.109F1D7D@colorfullife.com> <961rkk$fgm$1@penguin.transmeta.com> <3A847729.2C868879@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:
> 
> > I have this strong suspicion that your kernel will lock up in a bad way
> > of you have somebody do something like divide by zero without actually
> > touching a single FP instruction after the divide (so that the error has
> > happened, but has not yet been raised as an exception).
> 
> Or much worse, let the kernel mix-and-match SSE and MMX optimized routines
> without doing full saves of the FPU on SSE routines, which leads to FPU saves
> in MMX routines with kernel data in the SSE registers, which then shows up
> when the app touches those SSE registers and you get use space corruption.  My
> code to handle this type of situation was *very* complex, and I don't think I
> ever got it quite perfectly right without simply imposing a rule that the
> kernel could never use both SSE and MMX instructions on the same CPU.
>

I don't see that problem:
* sse_{copy,clear}_page() restore the sse registers before returning.
* the fpu saves into current->thread.i387.f{,x}save never happen from
interrupts.

How can kernel sse values end up in user space? I'm sure I overlook
something, but what?

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
