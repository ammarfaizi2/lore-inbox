Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288005AbSABXR4>; Wed, 2 Jan 2002 18:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287968AbSABXQf>; Wed, 2 Jan 2002 18:16:35 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:26382 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S287983AbSABXQN>;
	Wed, 2 Jan 2002 18:16:13 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15411.37817.753683.914033@argo.ozlabs.ibm.com>
Date: Thu, 3 Jan 2002 10:11:53 +1100 (EST)
To: Tom Rini <trini@kernel.crashing.org>
Cc: Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
	<20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini writes:

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

I would add:

6) change strcpy to string_copy so gcc doesn't think it knows what the
   function does
7) code RELOC etc. in assembly, which would let us get rid of the
	offset = reloc_offset();
   at the beginning of each function which uses RELOC.

Maybe 7 is the way to go, at least it will shut the bush-lawyers up.

Paul.
