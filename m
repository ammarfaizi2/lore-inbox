Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbSLIR1E>; Mon, 9 Dec 2002 12:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265880AbSLIR1E>; Mon, 9 Dec 2002 12:27:04 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:61072 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265863AbSLIR1B>;
	Mon, 9 Dec 2002 12:27:01 -0500
Date: Mon, 9 Dec 2002 17:31:44 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, ronis@onsager.chem.mcgill.ca,
       David Ronis <ronis@ronispc.chem.mcgill.ca>
Subject: Re: build failure in 2.4.20
Message-ID: <20021209173144.GA3751@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel@vger.kernel.org, ronis@onsager.chem.mcgill.ca,
	David Ronis <ronis@ronispc.chem.mcgill.ca>
References: <15860.46389.654483.692231@ronispc.chem.mcgill.ca> <200212091809.57622.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212091809.57622.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 06:09:57PM +0100, Marc-Christian Petersen wrote:
 > > drivers/net/net.o(.data+0xd4): undefined reference to `local symbols in
 > > discarded section .text.exit' make: *** [vmlinux] Error 1
 > > It sounds like this is a problem with ld or as, but I'm not sure.  Any
 > > suggestions?
 > $editor arch/i386/vmlinux.lds
 > 
 > you'll see starting at line 67 this:
 > 
 >   /* Sections to be discarded */
 >   /DISCARD/ : {
 >         *(.text.exit)
 >         *(.data.exit)
 >         *(.exitcall.exit)
 >         }
 > 
 > remove this:
 > 
 >         *(.text.exit)

This may get rid of the compile error, but this is *not* the correct way
to fix this problem. The correct fix is to run reference_discarded [1]
to find out which driver is causing the problem, and add __devexit
tags where relevant.

		Dave

[1] http://kernelnewbies.org/scripts/reference_discarded.pl

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
