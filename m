Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRBWABj>; Thu, 22 Feb 2001 19:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129550AbRBWAB3>; Thu, 22 Feb 2001 19:01:29 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:44818 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129511AbRBWABT>; Thu, 22 Feb 2001 19:01:19 -0500
Date: Thu, 22 Feb 2001 18:01:03 -0600
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rusty Russell <rusty@linuxcare.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac15
Message-ID: <20010222180103.B30762@mandrakesoft.mandrakesoft.com>
In-Reply-To: <E14Vl7y-0001FG-00@halfway> <E14Vstm-0003q3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <E14Vstm-0003q3-00@the-village.bc.nu>; from Alan Cox on Thu, Feb 22, 2001 at 10:22:56AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2001 at 10:22:56AM +0000, Alan Cox wrote:
> > > We can take page faults in interrupt handlers in 2.4 so I had to use a 
> > > spinlock, but that sounds the same
> > 
> > We can?  Woah, please explain.
> 
> vmalloc does a lazy load of the tlb. That can lead to the exception table 
> being walked on an IRQ

But will that ever get to the search_exception_table code ?  (I don't
think that would be valid, but other exceptions in interrupts might be -
cf some of the self-modifying mmx copy versions).

Oh, like rdmsr_eio on SMP systems.  Definitely valid, and it can deadlock
with both the semaphore and the spinlock AFAICS.  Alan, is this an issue ?
