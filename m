Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbSLISjg>; Mon, 9 Dec 2002 13:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266094AbSLISjg>; Mon, 9 Dec 2002 13:39:36 -0500
Received: from ronispc.Chem.McGill.CA ([132.206.205.91]:62872 "EHLO
	ronispc.chem.mcgill.ca") by vger.kernel.org with ESMTP
	id <S266010AbSLISjd>; Mon, 9 Dec 2002 13:39:33 -0500
From: David Ronis <ronis@ronispc.chem.mcgill.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15860.58665.606855.853566@ronispc.chem.mcgill.ca>
Date: Mon, 9 Dec 2002 13:47:05 -0500
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org, ronis@onsager.chem.mcgill.ca,
       David Ronis <ronis@ronispc.chem.mcgill.ca>
Subject: Re: build failure in 2.4.20
In-Reply-To: <20021209173144.GA3751@suse.de>
References: <15860.46389.654483.692231@ronispc.chem.mcgill.ca>
	<200212091809.57622.m.c.p@wolk-project.de>
	<20021209173144.GA3751@suse.de>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: ronis@onsager.chem.mcgill.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, with Marc-Christian's change and my guess about --oformat I am
able to build and install the kernel and its modules.  It actually
even boots.

One last thing, the kernel version seems to have regressed a bit.  It
thinks it's 2.4.0.

Dave, I haven't had a chance to look at the URL you suggested yet (and
probably do not have the expertise to fix things the way you're
suggesting either); is Marc-Christian's fix safe in the mean time?

David

Dave Jones writes:
 > On Mon, Dec 09, 2002 at 06:09:57PM +0100, Marc-Christian Petersen wrote:
 >  > > drivers/net/net.o(.data+0xd4): undefined reference to `local symbols in
 >  > > discarded section .text.exit' make: *** [vmlinux] Error 1
 >  > > It sounds like this is a problem with ld or as, but I'm not sure.  Any
 >  > > suggestions?
 >  > $editor arch/i386/vmlinux.lds
 >  > 
 >  > you'll see starting at line 67 this:
 >  > 
 >  >   /* Sections to be discarded */
 >  >   /DISCARD/ : {
 >  >         *(.text.exit)
 >  >         *(.data.exit)
 >  >         *(.exitcall.exit)
 >  >         }
 >  > 
 >  > remove this:
 >  > 
 >  >         *(.text.exit)
 > 
 > This may get rid of the compile error, but this is *not* the correct way
 > to fix this problem. The correct fix is to run reference_discarded [1]
 > to find out which driver is causing the problem, and add __devexit
 > tags where relevant.
 > 
 > 		Dave
 > 
 > [1] http://kernelnewbies.org/scripts/reference_discarded.pl
 > 
 > -- 
 > | Dave Jones.        http://www.codemonkey.org.uk
 > | SuSE Labs
