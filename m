Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287943AbSABUOE>; Wed, 2 Jan 2002 15:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287941AbSABUNy>; Wed, 2 Jan 2002 15:13:54 -0500
Received: from boden.synopsys.com ([204.176.20.19]:19883 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S287936AbSABUNl>; Wed, 2 Jan 2002 15:13:41 -0500
From: Joe Buck <jbuck@synopsys.COM>
Message-Id: <200201022013.MAA20576@atrus.synopsys.com>
Subject: Re: [PATCH] C undefined behavior fix
To: trini@kernel.crashing.org (Tom Rini)
Date: Wed, 2 Jan 2002 12:13:34 -0800 (PST)
Cc: velco@fadata.bg (Momchil Velikov), linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
        Franz.Sirl-kernel@lauterbach.com (Franz Sirl),
        paulus@samba.org (Paul Mackerras),
        benh@kernel.crashing.org (Benjamin Herrenschmidt),
        minyard@acm.org (Corey Minyard)
In-Reply-To: <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> from "Tom Rini" at Jan 02, 2002 12:09:10 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Okay, here's a summary of all of the options we have:
> 1) Change this particular strcpy to a memcpy
> 2) Add -ffreestanding to the CFLAGS of arch/ppc/kernel/prom.o (If this
> optimization comes back on with this flag later on, it would be a
> compiler bug, yes?)
> 3) Modify the RELOC() marco in such a way that GCC won't attempt to
> optimize anything which touches it [1]. (Franz, again by Jakub)
> 4) Introduce a function to do the calculations [2]. (Corey Minyard)
> 5) 'Properly' set things up so that we don't need the RELOC() macros
> (-mrelocatable or so?), and forget this mess altogether.

2) will prevent any future gcc from ever assuming it can transform the
strcpy into anything but a call to strcpy, or assume anything about the
semantics of strcpy.  Be careful with 3), as trying to fool the optimizer
is likely to be only a temporary solution (meaning that the kernel people
will return to flame the gcc people when the optimizer gets changed
again).

