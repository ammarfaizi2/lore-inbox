Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288190AbSACENL>; Wed, 2 Jan 2002 23:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288191AbSACENC>; Wed, 2 Jan 2002 23:13:02 -0500
Received: from bexfield.research.canon.com.au ([203.12.172.125]:18475 "HELO
	b.mx.canon.com.au") by vger.kernel.org with SMTP id <S288190AbSACEMp>;
	Wed, 2 Jan 2002 23:12:45 -0500
Date: Thu, 3 Jan 2002 15:08:43 +1100
From: Cameron Simpson <cs@zip.com.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: C undefined behavior fix
Message-ID: <20020103150843.B644@zapff.research.canon.com.au>
Reply-To: cs@zip.com.au
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Jan 02, 2002 at 12:09:10PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 12:09:10PM -0700, Tom Rini <trini@kernel.crashing.org> wrote:
| On Wed, Jan 02, 2002 at 01:03:25AM +0200, Momchil Velikov wrote:
| > The GCC tries to replace the strcpy from a constant string source with
| > a memcpy, since the length is know at compile time.
| 
| Okay, here's a summary of all of the options we have:
| 1) Change this particular strcpy to a memcpy
| 2) Add -ffreestanding to the CFLAGS of arch/ppc/kernel/prom.o (If this
| optimization comes back on with this flag later on, it would be a
| compiler bug, yes?)
| 3) Modify the RELOC() marco in such a way that GCC won't attempt to
| optimize anything which touches it [1]. (Franz, again by Jakub)
| 4) Introduce a function to do the calculations [2]. (Corey Minyard)
| 5) 'Properly' set things up so that we don't need the RELOC() macros
| (-mrelocatable or so?), and forget this mess altogether.

Dudes, maybe I'm missing something here, but why don't you just mark the
source data as volatile? Then it _can't_ assume it knows the length of
the strcpy because it can't assume it knows the content:

If PTRRELOC cast the pointer type to

	volatile void *

or something else suitable generic but volatile then this discussion might
not be happening. It would at least move the optimisation into "definite
compiler bug" if it still happens.
-- 
Cameron Simpson, DoD#743        cs@zip.com.au    http://www.zip.com.au/~cs/

I think... Therefore I ride.  I ride... Therefore I am.
	- Mark Pope <erectus@yarrow.wt.uwa.edu.au>
