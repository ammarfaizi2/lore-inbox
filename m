Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272656AbRIGNeg>; Fri, 7 Sep 2001 09:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272659AbRIGNe0>; Fri, 7 Sep 2001 09:34:26 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:11388 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272656AbRIGNeQ>; Fri, 7 Sep 2001 09:34:16 -0400
Date: Fri, 7 Sep 2001 15:34:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Mosberger <davidm@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] proposed fix for ptrace() SMP race
Message-ID: <20010907153425.P11329@athlon.random>
In-Reply-To: <20010907032801.N11329@athlon.random> <E15fAdr-0000r7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15fAdr-0000r7-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Sep 07, 2001 at 02:41:11AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2001 at 02:41:11AM +0100, Alan Cox wrote:
> > +#ifdef CONFIG_SMP
> > +	rmb(); /* read child->has_cpu after child->state */
> > +	while (child->has_cpu);
> 		rep_nop();
> 
> otherwise your PIV will overheat

indeed correct (OTOH it's a so small window [not like a contended
spinlock] that I wonder if it will make a difference in real life ;)

Andrea
