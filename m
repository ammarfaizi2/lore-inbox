Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265300AbRFUXh4>; Thu, 21 Jun 2001 19:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265299AbRFUXhp>; Thu, 21 Jun 2001 19:37:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:9632 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265298AbRFUXhc>;
	Thu, 21 Jun 2001 19:37:32 -0400
Date: Thu, 21 Jun 2001 19:37:31 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads) 
In-Reply-To: <m15CvoL-001UJEC@mozart>
Message-ID: <Pine.GSO.4.21.0106211931180.209-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Jun 2001, Rusty Russell wrote:

> Disagree.  A significant percentage of the netfilter bugs have been
> SMP only (the whole thing is non-reentrant on UP).

I really doubt it. <looking through the thing> <raised brows>
Well, if you use GFP_ATOMIC for everything... grep...
Erm... AFAICS, you call create_chain() with interrupts disabled
(under write_lock_irq_save()). Unless I'm _very_ mistaken,
kmalloc(..., GFP_KERNEL) is a Bad Thing(tm) in that situation.
And create_chain() leads to it.

