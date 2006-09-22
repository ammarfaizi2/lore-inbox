Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWIVJsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWIVJsH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWIVJsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:48:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:34153 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751132AbWIVJsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:48:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HT8P4f0efYZZ5UDwhZ6a1LAPIWQbHsa/AGUcrfUmWO1W32jItEyrxAOSEXz16aWxObbAf1TvcW++iT2XE6+sk3IUXeqB5y5RWHMCDAHX7PzqWiL46vVzo3JYDMPfjJkTZgjtme+9wX0iMwyYxKfibT8HKNtJ/5TuUwUMY7/yM+0=
Message-ID: <489ecd0c0609220248m41749725t75ccf9ca8753b8dc@mail.gmail.com>
Date: Fri, 22 Sep 2006 17:48:03 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Randy. Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 1/3] [BFIN] Blackfin architecture patch for 2.6.18
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Greg KH" <greg@kroah.com>
In-Reply-To: <20060921232921.88d2aa5d.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0609212204k6cbbf63ej7d59d3855a4993e7@mail.gmail.com>
	 <20060921232921.88d2aa5d.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Thanks a lot. I fixed most of the issues. And I'll resend the patch
after you and other people finishes the first time review.

On 9/22/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> On Fri, 22 Sep 2006 13:04:43 +0800 Luke Yang wrote:
>
> >  And we also fixed a lot of other issues and ported it to 2.6.18 now.
> > As usual, this architecture patch is too big so I just give a link
> > here. Please review it and give you comments, we really appreciate.
>
> It's 2 MB.  I doubt that many people will review it.  :(
  Yes it is big. But as an architecture patch, it is this big :(
Thank you very much for reviewing it.
>
> > This is a big patch so I only put a link here:
> > http://blackfin.uclinux.org/frs/download.php/1010/blackfin_arch_2.6.18.patch
>
> I have some comments on it.  The summary of most of them is
> that the patch doesn't quite look like a Linux patch.
> You may have heard that comment previously... I don't know.
>
> Here are some detailed comments.
>
> 1.  For Kconfig help text, help text should be indented 2 spaces.
> Several of these need to be cleaned up.
  Done.
>
> 2.  Kconfig help text:  don't make text lines go past column 80
> for 2 reasons:  (1) we want editors in a xterm to be able to read
> source files easily (without lots of wrapping) and (2) users should
> be able to read an item's help text [in menuconfig] without needing
> to scroll left/right (with arrow keys).
  Done.
>
> 3.  Kconfig help text:  end sentences with a period (".").
  Done
>
> 4.  Kconfig and header files:  excessive and gratuitous use of
> spaces around parentheses.
>
> example 1:
> +       depends on ( BFIN533_STAMP || BFIN533_BLUETECHNIX_CM )
>
> should be:
> +       depends on (BFIN533_STAMP || BFIN533_BLUETECHNIX_CM)
>
> (these parens actually aren't needed at all, but if used,
> some spaces there should be lost)
>
> example 2:
> +#if defined( CONFIG_BLKFIN_DCACHE )
>
> should be:
> +#if defined(CONFIG_BLKFIN_DCACHE)
 Done.
>
> 5.  Several of the head.S files have really sloppy indentation or
> formatting in them.
 Fixed.
>
> 6.  Don't introduce new typedefs.  If the kernel header files
> already have a typedef and you need to use that (e.g., in
> include/asm-blackfin/*.h), that's OK, but it's not OK to add
> new typedefs [with a few rare, extreme exceptions].
> And structs are almost NEVER typedeffed.  Just use struct xyzzy
> {
> ...
> };
 I removed some "new typedef" we added. But for the common ones in
some of the header files, they have to be there for now...
>
> 7.  In function prototypes and externs (as in header files),
> include parameter names, not just data types.
  Fixed.
>
> 8.  No space between "*" and parameter name.  Example:
> +void spi_enable(spi_device_t * spi_dev);
 Fixed.
>
> should be:
> +void spi_enable(spi_device_t *spi_dev);
>
> 9.  In struct sport_register, what are all of those volatiles
> for?  Use of volatile usually
> indicates bad locking or bad memory barriers, etc., somewhere.
 This is not a bug. In embedded, a memory mapped register should be
defined as volatile, becasue the hardware may change it without
notifying the software.
>
> 10. In struct sport_dev, use a mutex instead of a semaphore
> for the mutex.
  Fixed.
>
> 11. Don't use C99 //-style comments in Linux kernel.
> Just use /* ... */ on one line for short comments.
> Long comment style is:
> /*
>  * This is the Linux kernel long format style.
>  * Use it for multi-line comments.
>  */
 Fixed.
>
> 12. Are the ioctl interfaces in include/asm-blackfin/dpmc.h
> documented somewhere?
> See Documentation/ABI/README and Documentation/SubmitChecklist.
  Removed for now. And we will submit it again later with the dpmc
driver and a document.
>
> 13. printk() calls usually should begin with a KERN_* level.
  I looked through and fixed some necessary ones. Especially in the
header folder.
>
> 14. Don't comment obvious things, like this one:
>
> +#define OFFSET_( x ) ((x) & 0x0000FFFF)        /* define macro for offset */
  Removed. At least some of them.. And we will review code later to
improve the comment quality.
>
> 15. Is this really needed?
>
> +#define ZERO           0x0
 Maybe not. I removed it.
>
> 16. Most of the source files have history and changelog comments in
> them.  Those should go into the SCM changelogs, not in the source
> files.
>
> 17.  #defines that are of the form
> #define VALUE   expression
>
> should almost always have parentheses around (expression)
> to prevent accidental misuse later on.
  Added parentheses for some of the places in the code.
>
> 18. Looks like this diff:
> diff -urN linux-2.6.18/init/Kconfig.orig linux-2.6.18.patch1/init/Kconfig.orig
>
> should not have been included in the patch file at all.
  Right. Removed.
>
>
> That's it for my Kconfig/Makefile/header files comments.
> I'll have C source code comments by this weekend.
>
> ---
> There are also a bunch of corrected spelling typos and more detailed
> comments in this file:
> http://www.xenotime.net/linux/doc/blackfin-arch-meta.patch
> (it's only 84 KB :)
>
> ---
> ~Randy
>


-- 
Best regards,
Luke Yang
luke.adi@gmail.com
