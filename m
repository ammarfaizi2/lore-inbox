Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288158AbSACEdC>; Wed, 2 Jan 2002 23:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288201AbSACEcx>; Wed, 2 Jan 2002 23:32:53 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:1664 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S288158AbSACEco>; Wed, 2 Jan 2002 23:32:44 -0500
Date: Wed, 2 Jan 2002 21:32:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Cameron Simpson <cs@zip.com.au>
Cc: Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: C undefined behavior fix
Message-ID: <20020103043239.GA749@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <20020103150843.B644@zapff.research.canon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020103150843.B644@zapff.research.canon.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 03:08:43PM +1100, Cameron Simpson wrote:
> On Wed, Jan 02, 2002 at 12:09:10PM -0700, Tom Rini <trini@kernel.crashing.org> wrote:
> | On Wed, Jan 02, 2002 at 01:03:25AM +0200, Momchil Velikov wrote:
> | > The GCC tries to replace the strcpy from a constant string source with
> | > a memcpy, since the length is know at compile time.
> | 
> | Okay, here's a summary of all of the options we have:
> | 1) Change this particular strcpy to a memcpy
> | 2) Add -ffreestanding to the CFLAGS of arch/ppc/kernel/prom.o (If this
> | optimization comes back on with this flag later on, it would be a
> | compiler bug, yes?)
> | 3) Modify the RELOC() marco in such a way that GCC won't attempt to
> | optimize anything which touches it [1]. (Franz, again by Jakub)
> | 4) Introduce a function to do the calculations [2]. (Corey Minyard)
> | 5) 'Properly' set things up so that we don't need the RELOC() macros
> | (-mrelocatable or so?), and forget this mess altogether.
> 
> Dudes, maybe I'm missing something here, but why don't you just mark the
> source data as volatile? Then it _can't_ assume it knows the length of
> the strcpy because it can't assume it knows the content:

That's what 3 does.

> If PTRRELOC cast the pointer type to
> 
> 	volatile void *
> 
> or something else suitable generic but volatile then this discussion might
> not be happening. It would at least move the optimisation into "definite
> compiler bug" if it still happens.

See the rest of the thread for why various people don't like that this
doesn't work 'as-is' anymore, and why other people don't like what it's
doing period (in C anyhow).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
