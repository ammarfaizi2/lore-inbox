Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130451AbRCIIQQ>; Fri, 9 Mar 2001 03:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130450AbRCIIQG>; Fri, 9 Mar 2001 03:16:06 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:37144 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S130452AbRCIIP4>; Fri, 9 Mar 2001 03:15:56 -0500
Date: Fri, 9 Mar 2001 02:15:23 -0600
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] documentation mm.h + swap.h
Message-ID: <20010309021523.A13408@mandrakesoft.mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.33.0103081807260.1314-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.4.33.0103081807260.1314-100000@duckman.distro.conectiva>; from Rik van Riel on Thu, Mar 08, 2001 at 06:10:16PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2001 at 06:10:16PM -0300, Rik van Riel wrote:
> --- linux-2.4.2-doc/include/linux/mm.h.orig	Wed Mar  7 15:36:32 2001
> +++ linux-2.4.2-doc/include/linux/mm.h	Thu Mar  8 09:54:22 2001
> @@ -39,32 +39,37 @@
>   * library, the executable area etc).
>   */
>  struct vm_area_struct {
> -	struct mm_struct * vm_mm;	/* VM area parameters */
> -	unsigned long vm_start;
> -	unsigned long vm_end;
> +	struct mm_struct * vm_mm;	/* The address space we belong to. */
> +	unsigned long vm_start;		/* Our start address within vm_mm. */
> +	unsigned long vm_end;		/* Our end address within vm_mm. */

it might be a good idea to point out that this is the address of the byte
after the last one covered by the vma, not the address of the last byte.

(are there any architectures where we allow a vma at the end of memory ?  Is
the mm/ code handling ->vm_end = 0 correctly ?)

>  /*
> + * Each physical page in the system has a struct page associated with
> + * it to keep track of whatever it is we are using the page for at the
> + * moment. Note that we have no way to track which tasks are using
> + * a page.
> + *

Each page of "real" RAM.  In particular I think MMIO pages still don't have
a struct page.

>   * Try to keep the most commonly accessed fields in single cache lines
>   * here (16 bytes or greater).  This ordering should be particularly
>   * beneficial on 32-bit processors.
>   *
>   * The first line is data used in page cache lookup, the second line
>   * is used for linear searches (eg. clock algorithm scans).
> + *
> + * TODO: make this structure smaller, it could be as small as 32 bytes.

Or make it cover large pages, which might be even more of a win ..
