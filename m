Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbUDZSXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUDZSXX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 14:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbUDZSXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 14:23:23 -0400
Received: from port-212-202-41-96.reverse.qsc.de ([212.202.41.96]:22715 "EHLO
	rocklinux-consulting.de") by vger.kernel.org with ESMTP
	id S263107AbUDZSXQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 14:23:16 -0400
Date: Mon, 26 Apr 2004 20:22:57 +0200 (CEST)
Message-Id: <20040426.202257.884025800.rene@rocklinux-consulting.de>
To: trini@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, valentin@rocklinux-consulting.de
Subject: Re: [PATCH] fix compilation of ppc embedded configs
From: Rene Rebe <rene@rocklinux-consulting.de>
In-Reply-To: <20040426164641.GB19246@smtp.west.cox.net>
References: <20040422.103620.607961025.rene@rocklinux-consulting.de>
	<20040426164641.GB19246@smtp.west.cox.net>
X-Mailer: Mew version 3.1 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "heap.localnet", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, (un CC'ed Linus) On: Mon, 26 Apr 2004 09:46:41
	-0700, Tom Rini <trini@kernel.crashing.org> wrote: > I'd like to see
	the hunks that aren't tested dropped as I strongly [...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, (un CC'ed Linus)

On: Mon, 26 Apr 2004 09:46:41 -0700,
    Tom Rini <trini@kernel.crashing.org> wrote:

> I'd like to see the hunks that aren't tested dropped as I strongly

If you think so - I found it logical to fix the found on the way and
not to let too much bit-rot ...

If I have to work with one of those boards in the future I want to
track the real problems I might encounter - and not to fix 20 obvious
compile issues first ...

> suspect there's more subtle errors in these platforms, if the call to
> openpic_init hasn't been changed.  Also, why is:

> > --- linux-2.6.6-rc2/arch/ppc/platforms/pplus.c	2004-04-22 10:27:16.000000000 +0200
> > +++ linux-2.6.5-wip/arch/ppc/platforms/pplus.c	2004-04-18 22:36:08.000000000 +0200
> > @@ -19,6 +19,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/init.h>
> > +#include <linux/initrd.h>
> >  #include <linux/ioport.h>
> >  #include <linux/console.h>
> >  #include <linux/pci.h>
> 
> Needed?  Thanks.

To get the file compile - otherwise you get:

arch/ppc/platforms/pplus.c: In function `pplus_setup_arch':
arch/ppc/platforms/pplus.c:569: `initrd_start' undeclared (first use in this function)
arch/ppc/platforms/pplus.c:569: (Each undeclared identifier is reported only once
arch/ppc/platforms/pplus.c:569: for each function it appears in.)

and since I do not have all the kernel kernel in my memory and the
other files include initrd.h I thought it is the most logical thing to try ...

# grep initrd * | grep include
adir_setup.c:#include <linux/initrd.h>
apus_setup.c:#include <linux/initrd.h>
chrp_setup.c:#include <linux/initrd.h>
ev64260_setup.c:#include <linux/initrd.h>
gemini_setup.c:#include <linux/initrd.h>
k2_setup.c:#include <linux/initrd.h>
lopec_setup.c:#include <linux/initrd.h>
mcpn765_setup.c:#include <linux/initrd.h>
mvme5100_setup.c:#include <linux/initrd.h>
pal4_setup.c:#include <linux/initrd.h>
pcore_setup.c:#include <linux/initrd.h>
pmac_setup.c:#include <linux/initrd.h>
powerpmc250.c:#include <linux/initrd.h>
prep_setup.c:#include <linux/initrd.h>
prpmc750_setup.c:#include <linux/initrd.h>
prpmc800_setup.c:#include <linux/initrd.h>
sandpoint.c:#include <linux/initrd.h>
spruce.c:#include <linux/initrd.h>

Sincerely yours,
  René Rebe
    - ROCK Linux stable release maintainer

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene@rocklinux-consulting.de
http://www.rocklinux.org http://www.rocklinux-consulting.de

