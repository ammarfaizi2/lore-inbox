Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267205AbSKUXlH>; Thu, 21 Nov 2002 18:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267201AbSKUXlH>; Thu, 21 Nov 2002 18:41:07 -0500
Received: from mail.science.uva.nl ([146.50.4.51]:47798 "EHLO
	mail.science.uva.nl") by vger.kernel.org with ESMTP
	id <S267205AbSKUXlD>; Thu, 21 Nov 2002 18:41:03 -0500
Message-Id: <200211212347.gALNlVK13868@mail.science.uva.nl>
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
To: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Compiling x86 with and without frame pointer
Date: Fri, 22 Nov 2002 00:47:31 +0100
X-Mailer: KMail [version 1.3.2]
Cc: David Zaffiro <davzaffiro@netscape.net>
References: <19005.1037854033@kao2.melbourne.sgi.com> <224900000.1037900678@flay>
In-Reply-To: <224900000.1037900678@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Spam-Rating: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 November 2002 18:44, Martin J. Bligh wrote:
> > The conventional wisdom is that compiling x86 without frame pointer
> > results in smaller code.  It turns out to be the opposite, compiling
> > with frame pointers results in a smaller kernel.  gcc version 3.2
> > 20020822 (Red Hat Linux Rawhide 3.2-4).
> 
> I looked at 2.5.47 (with a splattering of performance patches) using 
> gcc 2.95.4 (Debian Woody), on a 16-way NUMA-Q, and did some kernel
> compile testing. The times to do the tests were almost identical
> (within error noise), but the kernel was indeed smaller
> 
>    text    data     bss     dec     hex filename
> 1873293  396231  459388 2728912  29a3d0 2.5.47-mjb1/vmlinux
> 1427355  396875  455356 2279586  22c8a2 2.5.47-mjb1-frameptr/vmlinux
> 
> Wow ... that's quite some difference ;-)

I also tried it, but it is not that big a difference:

   text    data     bss     dec     hex filename  flags
1991125  306324  270484 2567933  272efd vmlinux    -fomit-frame-pointer
1981477  306324  270484 2558285  27094d vmlinux    
1990965  306324  270484 2567773  272e5d vmlinux    -momit-leaf-frame-pointer

this was with gcc 2.95.3 and binutils 2.12 on my lfs system

        Rudmer
> 
> > I use -momit-leaf-frame-pointer for optimization in some own 
> > projects, instead of the "-fomit-frame-pointer". For me, this 
> > results in better codesize/speed compared to both "-fomit-frame-pointer" 
> > or no option at all. Actually gcc-2.95 seems to support this feature 
> > as well, but it never made it into the 2.95 docs...
> 
> I tried this, but it seemed to be the same as -fomit-frame-pointer
> (on 2.95 at least).
> 
> Given that omitting the -fomit-frame-pointer makes a smaller kernel,
> that's easier to debug, I'd say this is a good thing to do unless someone
> can get *negative* benchmark results. 
> 
> M.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
