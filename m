Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289047AbSAGALA>; Sun, 6 Jan 2002 19:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289051AbSAGAKu>; Sun, 6 Jan 2002 19:10:50 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:64139
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289047AbSAGAKm>; Sun, 6 Jan 2002 19:10:42 -0500
Date: Sun, 6 Jan 2002 17:09:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>, Gabriel Dos Reis <gdr@codesourcery.com>,
        mike stump <mrs@windriver.com>, dewar@gnat.com, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020107000954.GO756@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <200201061824.KAA19536@kankakee.wrs.com> <flg05jb4go.fsf@riz.cmla.ens-cachan.fr> <15416.51411.874019.838220@argo.ozlabs.ibm.com> <20020106231940.F531@sunsite.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020106231940.F531@sunsite.ms.mff.cuni.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 11:19:40PM +0100, Jakub Jelinek wrote:
> On Mon, Jan 07, 2002 at 08:59:47AM +1100, Paul Mackerras wrote:
> > Gabriel Dos Reis writes:
> > 
> > > Personnally, I don't have any sentiment against the assembler
> > > solution.  Dewar said it was unnecessarily un-portable, but that the
> > > construct by itself *is* already unportable. 
> > 
> > I assume that what we're talking about is using an asm statement like:
> > 
> > 	asm("" : "=r" (x) : "0" (y));
> > 
> > to make the compiler treat x as a pointer that it knows nothing about,
> > given a pointer y that the compiler does know something about.  For
> > example, y might be (char *)((unsigned long)"foo" + offset).
> > 
> > My main problem with this is that it doesn't actually solve the
> > problem AFAICS.  Dereferencing x is still undefined according to the
> > rules in the gcc manual.
> > 
> > Thus, although this would make the problems go away at the moment,
> > they will come back at some time in the future, e.g. when gcc learns
> > to analyse asm statements and realises that the asm is just doing
> > x = y.  I would prefer a solution that will last, rather than one
> > which relies on details of the current gcc implementation.
> 
> Even if gcc learned to analyze asm statements (and use it in something other
> than scheduling), I'm sure this wouldn't be optimized away exactly because
> this construct is used by various projects exactly for this purpose (make
> gcc think it can have any value allowed for the type in question).

Yes, but there's no gaurentee of that.  It'd probably break a few things
if they did, but there's nothing stopping them from doing it.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
