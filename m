Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282978AbSABTKa>; Wed, 2 Jan 2002 14:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287908AbSABTKR>; Wed, 2 Jan 2002 14:10:17 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:49025
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S287905AbSABTJ2>; Wed, 2 Jan 2002 14:09:28 -0500
Date: Wed, 2 Jan 2002 12:09:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Momchil Velikov <velco@fadata.bg>
Cc: linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 01:03:25AM +0200, Momchil Velikov wrote:

> The GCC tries to replace the strcpy from a constant string source with
> a memcpy, since the length is know at compile time.

Okay, here's a summary of all of the options we have:
1) Change this particular strcpy to a memcpy
2) Add -ffreestanding to the CFLAGS of arch/ppc/kernel/prom.o (If this
optimization comes back on with this flag later on, it would be a
compiler bug, yes?)
3) Modify the RELOC() marco in such a way that GCC won't attempt to
optimize anything which touches it [1]. (Franz, again by Jakub)
4) Introduce a function to do the calculations [2]. (Corey Minyard)
5) 'Properly' set things up so that we don't need the RELOC() macros
(-mrelocatable or so?), and forget this mess altogether.

I think that if we're going to make sure that gcc-3.0.x works with 2.4.x
kernels, we should pick one of the first 4 initially.  If this is only a
2.5.x matter, we should probably try and do #5 as a long-term goal, and
pick something else for now.  But either way I do think it's time to
pick some solution.  Comments?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

[1] http://lists.linuxppc.org/linuxppc-dev/200109/msg00155.html
[2] http://lists.linuxppc.org/linuxppc-dev/200112/msg00038.html
