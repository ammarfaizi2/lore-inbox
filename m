Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130529AbRCIP2G>; Fri, 9 Mar 2001 10:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130532AbRCIP15>; Fri, 9 Mar 2001 10:27:57 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:36342 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130529AbRCIP1p>; Fri, 9 Mar 2001 10:27:45 -0500
Date: Fri, 9 Mar 2001 19:39:59 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Philipp Rumpf <prumpf@mandrakesoft.com>
cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] documentation mm.h + swap.h
In-Reply-To: <20010309021523.A13408@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0103091938430.2283-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2001, Philipp Rumpf wrote:
> On Thu, Mar 08, 2001 at 06:10:16PM -0300, Rik van Riel wrote:
> > --- linux-2.4.2-doc/include/linux/mm.h.orig	Wed Mar  7 15:36:32 2001
> > +++ linux-2.4.2-doc/include/linux/mm.h	Thu Mar  8 09:54:22 2001
> > @@ -39,32 +39,37 @@
> >   * library, the executable area etc).
> >   */
> >  struct vm_area_struct {
> > -	struct mm_struct * vm_mm;	/* VM area parameters */
> > -	unsigned long vm_start;
> > -	unsigned long vm_end;
> > +	struct mm_struct * vm_mm;	/* The address space we belong to. */
> > +	unsigned long vm_start;		/* Our start address within vm_mm. */
> > +	unsigned long vm_end;		/* Our end address within vm_mm. */
>
> it might be a good idea to point out that this is the address of
> the byte after the last one covered by the vma, not the address
> of the last byte.

        unsigned long vm_end;           /* The first byte after our end address
                                           within vm_mm. */

Does this look good to you ?


> (are there any architectures where we allow a vma at the end of
> memory ?  Is the mm/ code handling ->vm_end = 0 correctly ?)

Good question ...

> >  /*
> > + * Each physical page in the system has a struct page associated with
             ^^^^^^^^
> Each page of "real" RAM.

> > + *
> > + * TODO: make this structure smaller, it could be as small as 32 bytes.
>
> Or make it cover large pages, which might be even more of a win ..

*nod*

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

