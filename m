Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317462AbSFCTOC>; Mon, 3 Jun 2002 15:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317461AbSFCTOB>; Mon, 3 Jun 2002 15:14:01 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:58560 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S317460AbSFCTN6>; Mon, 3 Jun 2002 15:13:58 -0400
Date: Mon, 3 Jun 2002 21:13:57 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Pavel Machek <pavel@suse.cz>
cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: do_mmap
In-Reply-To: <20020603121943.A37@toy.ucw.cz>
Message-ID: <Pine.GSO.4.05.10206032110520.7433-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pavel,

> > what about the do_mmap/do_mmap_pgoff implementation?
> > reurn-type: _unsigned_ long	(which should be ok cause we've to return
> > 				 an adress if len == 0)
> > on error: -ERR_*
> > 
> > and the checks in various places are really strange. - well some
> > places check for:
> > 	o != NULL
> > 	o > -1024UL
> > 	o ...
> > 
> > guess this nedds some cleanup.
> 
> While you are at it... fs/binfmt_elf does mmaps but does not check for errors.
> And errors actually do happen there :-(

sure, was tripping over that anyways ... since the compiler spits out tons
of "conversion without a cast" warnings (seems to be a different way to 
use grep :)

i just came across one problem: when converting the unsigned longs to
        void * pointers, everything works fine, beside the "advanced"
        pointer arithmetic. (like aligning the address to a certain 
        boundary - using address & MASK) ... for that case i need to
        cast to an unsigned long in any case :( 
                is there another way to do it without explicit casting?
		should we introduce ptr_addr_t?
		can we be sure that an unsigned long is capable to hold
			and address (also in the future)
		can we be sure about gcc void * pointer arithmetic (like
			++ incremets the address by one)

	tm

-- 
in some way i do, and in some way i don't.

