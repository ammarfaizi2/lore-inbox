Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264769AbRGNSWD>; Sat, 14 Jul 2001 14:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264754AbRGNSVx>; Sat, 14 Jul 2001 14:21:53 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:13220 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264724AbRGNSVp>;
	Sat, 14 Jul 2001 14:21:45 -0400
Message-ID: <3B508DB2.86078E16@mandrakesoft.com>
Date: Sat, 14 Jul 2001 14:21:38 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Cc: Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@caldera.de>,
        Gunther Mayer <Gunther.Mayer@t-online.de>, paul@paulbristow.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy)
In-Reply-To: <20010715045842.B6963@weta.f00f.org>  <20010715031815.D6722@weta.f00f.org> <200107141414.f6EEEjQ05792@ns.caldera.de> <17573.995129225@redhat.com> <19235.995134153@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> cw@f00f.org said:
> >  If it changes vmlinux by a single byte, I might agree.... all it does
> > is close off and older depricated API.
> 
> Why is the sane API deprecated in favour of the implementation-specific one?
> 
> If we must standardise on a single header file to include, surely we should
> do it the other way round?
> 
> Index: include/linux/slab.h
> ===================================================================
> RCS file: /inst/cvs/linux/include/linux/slab.h,v
> retrieving revision 1.1.1.1.2.12
> diff -u -r1.1.1.1.2.12 slab.h
> --- include/linux/slab.h        2001/06/08 22:41:51     1.1.1.1.2.12
> +++ include/linux/slab.h        2001/07/14 18:08:37
> @@ -4,6 +4,10 @@
>   * (markhe@nextd.demon.co.uk)
>   */
> 
> +#ifndef _LINUX_MALLOC_H
> +#warning Please do not include linux/slab.h directly, use linux/malloc.h instead.
> +#endif

malloc.h is extra indirection we don't need.  IMHO

	/* malloc.h */
	#include <linux/slab.h>

is a windows interface.  Linux wrappers should be kept to a minimum...

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
