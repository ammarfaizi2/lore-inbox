Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287007AbSABUo0>; Wed, 2 Jan 2002 15:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287981AbSABUoQ>; Wed, 2 Jan 2002 15:44:16 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:31106
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S287005AbSABUmW>; Wed, 2 Jan 2002 15:42:22 -0500
Date: Wed, 2 Jan 2002 13:42:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joe Buck <jbuck@synopsys.com>
Cc: Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020102204221.GJ1803@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <200201022013.MAA20576@atrus.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201022013.MAA20576@atrus.synopsys.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 12:13:34PM -0800, Joe Buck wrote:
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
> 2) will prevent any future gcc from ever assuming it can transform the
> strcpy into anything but a call to strcpy, or assume anything about the
> semantics of strcpy.

If we go with this, it also might make sense to split all of the
{PTR,UN,}RELOC() macro users into a different file or split up btext.c a
bit more, just to be safe.

> Be careful with 3), as trying to fool the optimizer
> is likely to be only a temporary solution (meaning that the kernel people
> will return to flame the gcc people when the optimizer gets changed
> again).

Well, it's one of those changes that really should stop gcc, unless
there's a bug on the gcc side, if I read the patch/comments about it
right.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
