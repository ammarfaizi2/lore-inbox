Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265364AbRF0Ssz>; Wed, 27 Jun 2001 14:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbRF0Ssr>; Wed, 27 Jun 2001 14:48:47 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:52922 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265364AbRF0Ssj>;
	Wed, 27 Jun 2001 14:48:39 -0400
Message-ID: <3B3A2AAC.A4852671@mandrakesoft.com>
Date: Wed, 27 Jun 2001 14:49:16 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        eger@cc.gatech.edu
Subject: Re: PCI Power Management / Interrupt Context
In-Reply-To: <Pine.SOL.4.21.0106262208240.3824-100000@oscar.cc.gatech.edu> <200106271841.f5RIfR432746@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <Pine.SOL.4.21.0106262208240.3824-100000@oscar.cc.gatech.edu>,
> David T Eger  <eger@cc.gatech.edu> wrote:
> >
> >So I'm writing some code for a PCI card that is a framebuffer device, and
> >happily filling in the functions for the probe() and remove() functions
> >when I read documentation (Documentation/pci.txt) which mentions that
> >remove() can be called from interrupt context.
> 
> This used to be true for a short while for hot-plug CardBus. I don't
> think it is true any more - and if it is, that would be a bug.
> 
> So I think it's the documentation that is in error, and we should just
> fix that.
> 
> Jeff?

Correct, pci_driver::remove does not get called from interrupt context.

I don't know where the heck this thread is coming from ;-)  The docs
appear to be correct:

>         remove          Pointer to a function which gets called whenever a device
>                         being handled by this driver is removed (either during
>                         deregistration of the driver or when it's manually pulled
>                         out of a hot-pluggable slot). This function always gets
>                         called from process context, so it can sleep.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
