Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287996AbSABX2g>; Wed, 2 Jan 2002 18:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287981AbSABX1T>; Wed, 2 Jan 2002 18:27:19 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:17284
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S287972AbSABX0V>; Wed, 2 Jan 2002 18:26:21 -0500
Date: Wed, 2 Jan 2002 16:26:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020102232618.GP1803@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <15411.37817.753683.914033@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15411.37817.753683.914033@argo.ozlabs.ibm.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 10:11:53AM +1100, Paul Mackerras wrote:
> Tom Rini writes:
> 
> > Okay, here's a summary of all of the options we have:
> > 1) Change this particular strcpy to a memcpy
> > 2) Add -ffreestanding to the CFLAGS of arch/ppc/kernel/prom.o (If this
> > optimization comes back on with this flag later on, it would be a
> > compiler bug, yes?)
> > 3) Modify the RELOC() marco in such a way that GCC won't attempt to
> > optimize anything which touches it [1]. (Franz, again by Jakub)
> > 4) Introduce a function to do the calculations [2]. (Corey Minyard)
> > 5) 'Properly' set things up so that we don't need the RELOC() macros
> > (-mrelocatable or so?), and forget this mess altogether.
> 
> I would add:
> 
> 6) change strcpy to string_copy so gcc doesn't think it knows what the
>    function does
> 7) code RELOC etc. in assembly, which would let us get rid of the
> 	offset = reloc_offset();
>    at the beginning of each function which uses RELOC.

I think 7 sounds good for 2.4 at least, and maybe we can convince Franz
to look into 5 for 2.5 (since that would make things look a bit more
clean)..

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
