Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287972AbSABXzY>; Wed, 2 Jan 2002 18:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287169AbSABXzI>; Wed, 2 Jan 2002 18:55:08 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:24452
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S288001AbSABXex>; Wed, 2 Jan 2002 18:34:53 -0500
Date: Wed, 2 Jan 2002 16:34:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Momchil Velikov <velco@fadata.bg>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020102233452.GQ1803@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <15411.37817.753683.914033@argo.ozlabs.ibm.com> <877kr0uyc5.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877kr0uyc5.fsf@fadata.bg>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 01:28:42AM +0200, Momchil Velikov wrote:
> >>>>> "Paul" == Paul Mackerras <paulus@samba.org> writes:
> 
> Paul> Tom Rini writes:
> 
> >> Okay, here's a summary of all of the options we have:
> >> 1) Change this particular strcpy to a memcpy
> >> 2) Add -ffreestanding to the CFLAGS of arch/ppc/kernel/prom.o (If this
> >> optimization comes back on with this flag later on, it would be a
> >> compiler bug, yes?)
> >> 3) Modify the RELOC() marco in such a way that GCC won't attempt to
> >> optimize anything which touches it [1]. (Franz, again by Jakub)
> >> 4) Introduce a function to do the calculations [2]. (Corey Minyard)
> >> 5) 'Properly' set things up so that we don't need the RELOC() macros
> >> (-mrelocatable or so?), and forget this mess altogether.
> 
> Paul> I would add:
> 
> Paul> 6) change strcpy to string_copy so gcc doesn't think it knows what the
> Paul>    function does
> 
> GCC thinks exactly what the function does.

And then optimizes it to something that fails to work in this particular
case.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
