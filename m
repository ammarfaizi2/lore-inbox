Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287005AbSACBEY>; Wed, 2 Jan 2002 20:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287915AbSACBEQ>; Wed, 2 Jan 2002 20:04:16 -0500
Received: from mxzilla1.xs4all.nl ([194.109.6.54]:26891 "EHLO
	mxzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287005AbSACBEA>; Wed, 2 Jan 2002 20:04:00 -0500
Date: Thu, 3 Jan 2002 02:03:58 +0100
From: jtv <jtv@xs4all.nl>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Momchil Velikov <velco@fadata.bg>, paulus@samba.org,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020103020358.G19933@xs4all.nl>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <15411.37817.753683.914033@argo.ozlabs.ibm.com> <877kr0uyc5.fsf@fadata.bg> <20020102233452.GQ1803@cpe-24-221-152-185.az.sprintbbd.net> <20020103011905.D19933@xs4all.nl> <20020103002935.GT1803@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020103002935.GT1803@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Jan 02, 2002 at 05:29:35PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 05:29:35PM -0700, Tom Rini wrote:
>
> > Which it may do with another function *or expression* as well, because
> > the real bug has already happened before the function call comes into
> > the issue.
> 
> What's the bug?  The 'funny' arithmetic?
 
That depends on your definition of bug--symptom, "sighting" (thank you
Intel), or underlying problem.  The funny arithmetic, in C terms, is
the underlying problem.  The symptom is obvious.  The sighting involves
calls to what appear to be calls to the standard library, but in this
case happen not to be.  We'd still have the same problem if this really 
were the standard C library.


> > As far as I'm concerned the options are: fix RELOC;
> 
> How?

That's the EUR 64 * 10^6 question, isn't it?  It's likely to cost some
performance, but I suspect this would be the easiest solution.


> > obviate RELOC; use
> > an appropriate gcc option if available (-fPIC might be it, -ffreestanding
> > certainly isn't--see above);
> 
> Maybe for 2.5.  Too invasive for 2.4.x (initially at least).
 
I'm not saying these are attractive or even feasible, just prioritizing
the options I see.  I'm sure I'll have forgotten some, but I'm convinced
-ffreestanding isn't among them.

Let's say RELOC also broke in other places, for the exact same reason but
without (names familiar from) the standard library come into play.  How
would one recognize those cases?  And once diagnosed, how to go about
working around them?  Even worse, what if gcc tries to help but still
uses the stricter assumptions in some forgotten case?

Those would take time, and I can't see why none of these would arise
at some point.  That's why I feel -ffreestanding is too brittle as a
workaround.


> > *extend* (not fix, extend) gcc; or work
> > around all individual cases.  In rough descending order of preference.
> 
> Er, say what?

In rough descending order of _my_ preference, that is--falls within the
scope of the "as far as I'm concerned."  :)

But yes, requiring gcc to support RELOC through anything else than an
existing option (and once again, -ffreestanding only works around one 
instance where it breaks) would be an extension to gcc.  If it didn't
break in the past, that was essentially a coincidence.  Unless it's in 
some forgotten corner of the docs: possible, but not probable AFAICS.

Optimizing C is hard to do.  Pointer arithmetic is hell on an optimizer,
and the rules were made to give the latter a fair chance of doing a
good job.  I'm not arguing against having some specific option to relax 
those rules--kernels need to be written, and written in C.  But that 
option is by definition a compiler-specific extension to the language.


Jeroen

