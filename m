Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267599AbRGUHLa>; Sat, 21 Jul 2001 03:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267600AbRGUHLK>; Sat, 21 Jul 2001 03:11:10 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:13740 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S267599AbRGUHLB>;
	Sat, 21 Jul 2001 03:11:01 -0400
Message-ID: <3B592427.96AFB00F@mandrakesoft.com>
Date: Sat, 21 Jul 2001 02:41:43 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bitops.h ifdef __KERNEL__ cleanup.
In-Reply-To: <917E9842025@vcnet.vc.cvut.cz> <11472.995579612@redhat.com> <9j8bf1$1at$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"H. Peter Anvin" wrote:
> Followup to:  <11472.995579612@redhat.com>
> By author:    David Woodhouse <dwmw2@infradead.org>
> In newsgroup: linux.dev.kernel
> >
> > It has been stated many times that kernel headers should not be used in
> > apps. Renaming or moving them should not be necessary - and people would
> > probably only start to use them again anyway. We'd see autoconf checks to
> > find whether it's linux/private.h or xunil/private.h :)
> >
> > In the absence of any expectation that userspace developers will ever obey
> > the simple and oft-repeated rule that you don't use kernel headers from
> > userspace, the #ifdef __KERNEL__ approach would seem to be the best on
> > offer.

> Note that the rule is at least in part theoretical; even glibc include
> kernel headers or -derivatives.

Derivatives are fine and IMHO irrelevant to the issue of __KERNEL__: 
you can always do something like gcc's fixincludes.

uClibc and dietlibc do not include any kernel headers at all.  And at
least one glibc developer spoke up in a previous thread and agreed that
it is not necessary to include kernel headers in glibc.

As important as glibc is, it's breaking a rule, which is a bug, that can
be fixed.


> I think the idea with <asm/bitops.h> is that they are protected by
> #ifdef __KERNEL__ if they are kernel-only; however, if they work in
> user space then there is no #ifdef and autoconf can detect their
> presence.

Any amount of sharing between userspace and kernel -adds- constraints to
kernel code, and leads to namespace pollution on both ends by careless
(or busy!) developers.

Let's remove restrictions and constraints from kernel code, not add to
them...

-- 
Jeff Garzik      | "I wouldn't be so judgemental
Building 1024    |  if you weren't such a sick freak."
MandrakeSoft     |             -- goats.com
