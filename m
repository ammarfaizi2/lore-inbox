Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129274AbRAZO64>; Fri, 26 Jan 2001 09:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129184AbRAZO6p>; Fri, 26 Jan 2001 09:58:45 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:59144 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129274AbRAZO6c>;
	Fri, 26 Jan 2001 09:58:32 -0500
Message-ID: <3A719074.CBF3055B@mandrakesoft.com>
Date: Fri, 26 Jan 2001 09:57:56 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: bero@redhat.de, alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: MatroxFB support can't be compiled into kernel
In-Reply-To: <20010126153247.A24714@vana.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> 
> On 26 Jan 01 at 14:29, Bernhard Rosenkraenzer wrote:
> >
> > Subject says it all - works as a module, but can't be compiled into the
> > kernel because of duplicate definitions, caused by several files including
> > matroxfb_base.h which in turn defines global_disp.
> >
> > Patch attached.
> 
> Oops. I did not tried matroxfb without multihead for so long... But...
> Should not (1) compiler optimize them out, as global_disp is used only
> by matroxfb_base.c and (2) linker merge them together? I was under
> impression that kernel uses common storage for uninitialized variables...
> I'm sure that it worked sometime in the past...
> 
> Anyway, I preffer patch bellow, as global_disp is used only by
> matroxfb_base.c, and only if CONFIG_FB_MATROX_MULTIHEAD is not set...
> 
> Linus, original complaint was against 2.4.0-ac11 - I do not know, whether
> Alan uses some new linker scripts or what's going on. In any case, can you
> apply this too? There is no reason why matrox's 'global_disp' should polute
> global namespace.

If you compile your kernels with -fno-common, this problem would show
up.  Andrea and a couple of the gcc guys, in a thread ~30 days ago,
recommended the use of -fno-common to build the kernel.  I started using
it myself, and have picked up and fixed a few problems such as the one
that your patch fixes.

I sent a patch to Alan to add -fno-common to the command line of his
2.4.0-acXX patches, but it got dropped (presumeably too experimental or
whatever).

In case anyone is curious, here is what 'info gcc' says about
-fno-common:

> `-fno-common'
>      Allocate even uninitialized global variables in the bss section of
>      the object file, rather than generating them as common blocks.
>      This has the effect that if the same variable is declared (without
>      `extern') in two different compilations, you will get an error
>      when you link them.  The only reason this might be useful is if
>      you wish to verify that the program will work on other systems
>      which always work this way.

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
