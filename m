Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285828AbSAFWSl>; Sun, 6 Jan 2002 17:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbSAFWRq>; Sun, 6 Jan 2002 17:17:46 -0500
Received: from sunsite.ms.mff.cuni.cz ([195.113.19.66]:45579 "EHLO
	sunsite.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S285828AbSAFWQt>; Sun, 6 Jan 2002 17:16:49 -0500
Date: Sun, 6 Jan 2002 23:19:40 +0100
From: Jakub Jelinek <jakub@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Gabriel Dos Reis <gdr@codesourcery.com>, mike stump <mrs@windriver.com>,
        dewar@gnat.com, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        trini@kernel.crashing.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020106231940.F531@sunsite.ms.mff.cuni.cz>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <200201061824.KAA19536@kankakee.wrs.com> <flg05jb4go.fsf@riz.cmla.ens-cachan.fr> <15416.51411.874019.838220@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <15416.51411.874019.838220@argo.ozlabs.ibm.com>; from Paul Mackerras on Mon, Jan 07, 2002 at 08:59:47AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 08:59:47AM +1100, Paul Mackerras wrote:
> Gabriel Dos Reis writes:
> 
> > Personnally, I don't have any sentiment against the assembler
> > solution.  Dewar said it was unnecessarily un-portable, but that the
> > construct by itself *is* already unportable. 
> 
> I assume that what we're talking about is using an asm statement like:
> 
> 	asm("" : "=r" (x) : "0" (y));
> 
> to make the compiler treat x as a pointer that it knows nothing about,
> given a pointer y that the compiler does know something about.  For
> example, y might be (char *)((unsigned long)"foo" + offset).
> 
> My main problem with this is that it doesn't actually solve the
> problem AFAICS.  Dereferencing x is still undefined according to the
> rules in the gcc manual.
> 
> Thus, although this would make the problems go away at the moment,
> they will come back at some time in the future, e.g. when gcc learns
> to analyse asm statements and realises that the asm is just doing
> x = y.  I would prefer a solution that will last, rather than one
> which relies on details of the current gcc implementation.

Even if gcc learned to analyze asm statements (and use it in something other
than scheduling), I'm sure this wouldn't be optimized away exactly because
this construct is used by various projects exactly for this purpose (make
gcc think it can have any value allowed for the type in question).

	Jakub
