Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266464AbRGTBiF>; Thu, 19 Jul 2001 21:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266469AbRGTBh4>; Thu, 19 Jul 2001 21:37:56 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:40468 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S266464AbRGTBhj>; Thu, 19 Jul 2001 21:37:39 -0400
Date: Fri, 20 Jul 2001 03:37:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7pre8aa1
Message-ID: <20010720033749.J31850@athlon.random>
In-Reply-To: <200107192245.f6JMjcR08865@karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107192245.f6JMjcR08865@karaya.com>; from jdike@karaya.com on Thu, Jul 19, 2001 at 06:45:38PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 19, 2001 at 06:45:38PM -0400, Jeff Dike wrote:
> > Only in 2.4.7pre6aa1: 51_uml-ac-to-aa-2.bz2
> > Only in 2.4.7pre8aa1/: 51_uml-ac-to-aa-3.bz2
> >         Moved part of it in the tux directory so it can compile
> >         without tux (in reality I got errno compilation error
> >         but it's low prio and I'll sort it out later, Jeff Dike any
> >         hint is welcome ;).
> 
> This is the patch I sent to Alan a while back which works around the problem.
> 
> rmk suggested a better way which I'll add at some point.
> 
> 				Jeff
> 
> 
> diff -Naur -X exclude-files ac_cur/arch/um/Makefile ac/arch/um/Makefile
> --- ac_cur/arch/um/Makefile	Mon Jul  9 13:05:03 2001
> +++ ac/arch/um/Makefile	Mon Jul  9 13:26:21 2001
> @@ -20,6 +20,8 @@
>  LINK_PROFILE = $(PROFILE) -Wl,--wrap,__monstartup
>  endif
>  
> +CFLAGS := $(subst -fno-common,,$(CFLAGS))
> +
>  SUBDIRS += $(ARCH_DIR)/fs $(ARCH_DIR)/drivers $(ARCH_DIR)/kernel \
>  	$(ARCH_DIR)/sys-$(SUBARCH)

works fine thanks! Of course I agree with rmk it would be better not to
disable -fno-common but this is ok for now ;) (after all we would catch
any potential important name collision during the compiles of the other
targets)

Andrea
