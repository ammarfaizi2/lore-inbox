Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129212AbRBINgk>; Fri, 9 Feb 2001 08:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129201AbRBINga>; Fri, 9 Feb 2001 08:36:30 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:16894 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129212AbRBINgX>; Fri, 9 Feb 2001 08:36:23 -0500
Date: Fri, 9 Feb 2001 11:35:24 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Daniel Stodden <stodden@in.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: paging question
In-Reply-To: <87elx81omm.fsf@bitch.localnet>
Message-ID: <Pine.LNX.4.21.0102091133260.2378-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2001, Daniel Stodden wrote:

> i desperately hope this is not too stupid.

Only if the hardware is so stupid that you need this ;)

> i'm trying to write a driver which depends on giving pci devices
> access to somewhat larger amounts of pysical memory. let's say, a
> megabyte of contiguous ram.
> 
> is it possible to resize such an area later on? i mean: is there some
> mechanism available in the kernel to enlarge such a region even if the
> area beyond it is already in use?
> 
> i understand that this is pretty impossible if some entity depends on
> correct physical locations of the pages in question. but couldn't for
> example userland memory be copied elsewhere and its new location
> simply remapped?

Currently Linux doesn't have any way to figure out which
programs are using a certain physical memory location, so
we cannot efficiently unmap the memory.

And even if we could ... what if the memory is in use by
the kernel itself and there are pointers to those kernel
addresses somewhere else in the kernel ?    These pages
would be unfreeable anyway...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
