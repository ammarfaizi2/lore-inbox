Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVC2JAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVC2JAg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 04:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVC2I6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:58:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24738 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262229AbVC2IrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:47:13 -0500
Subject: Re: [ubuntu-hardened] Re: Collecting NX information
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Brandon Hale <brandon@smarterits.com>, ubuntu-hardened@lists.ubuntu.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <424911FF.1080702@comcast.net>
References: <42484B13.4060408@comcast.net>
	 <1112035059.6003.44.camel@laptopd505.fenrus.org>
	 <4248520E.1070602@comcast.net>
	 <1112036121.6003.46.camel@laptopd505.fenrus.org>
	 <424857B0.4030302@comcast.net>
	 <1112043246.10117.5.camel@localhost.localdomain>
	 <4248828B.20708@comcast.net>
	 <1112080581.6282.1.camel@laptopd505.fenrus.org>
	 <4249096B.7020802@comcast.net>
	 <1112083762.6282.23.camel@laptopd505.fenrus.org>
	 <424911FF.1080702@comcast.net>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 10:46:56 +0200
Message-Id: <1112086016.6282.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 03:29 -0500, John Richard Moser wrote:

> >>MF_PAX_PAGEEXEC
> >>  ON:   ET_EXEC enforced.  Stack NX.  Heap NX.  Code PROT_EXEC.
> >>  OFF:  Stack and heap default to +X
> >>  The PAGEEXEC flag will basically mandate the automated non-executable
> >>  setting for the stack and heap.  When off, these areas are executable
> >>  (like when PT_GNU_STACK is on)
> > 
> > 
> > how is this one different from PT_GNU_STACK
> > 
> 
> PT_GNU_STACK is on/off, PT_PAX_FLAGS settings are all on/off/neutral.
> The neutral state becomes on or off depending on whether some kind of
> compatibility mode is used.

Hmmmm you either need an executable stack or you don't. Can you explain
why you think there is a strong advantage for a "neutral" setting on
this one?

>  
> >>MF_PAX_EMUTRAMP:

> > do you actually need this? the number of apps that have actual
> > trampolines is *really really* low. At that point you get to a balance
> > between complexity and very limited added security. And the answer is
> > really not straight forward since complexity is a security risk in
> > itself; or more direct, by allowing this at all you in theory can open
> > other security holes. (note the "can" here. I'm not saying the
> > implementation does, but there sure is added complexity which in turn
> > means added chances for bugs. If the number of things that need this is
> > really low (and it should be) the balance isn't so clear).
> > 
> 
> - -rw-r--r--   1 root  src      10485 Mar 29 00:47 emu_tramp.diff
> 
> I was surprised it wasn't that complex,

10k lines of patch. And you introduce a mechanism to bypass non-exec-
stack.... sometimes a 10 line patch can be "complex" in that sense.
So I'll repeat my question about the gains of this, you only answered by
showing something about the complexity.


> >>.
> >>MF_PAX_RANDMMAP:
> >>  ON:  stack, heap, mmap() base randomized
> >>  OFF: Nothing is randomized in memory
> >>  RANDMMAP should probably be called "RANDADDR" instead.  When set, the
> >>  kernel randomizes anything that can be randomized in the address
> >>  space (support determining).
> > 
> > 
> > This one could in theory be useful. However need info on what breaks. I
> > know that if you do full blown ES/PaX level randomisation the build
> > process of some older emacsen, and build process won't benefit from such
> > a flag unless you can make the toolchain insert it automatic (I suspect
> > that will be hard); once it's manual and during build only using setarch
> > is sufficient to cover that one.
> 
> There's a patch that makes the toolchain spit out PT_PAX_FLAGS.

that's not an answer to what I said though. You propose a new
implementation for something, for that you should say why this one is
useful, not "because something else does it".

> Consider that PT_PAX_FLAGS are all tristates.

I think that's a bad idea though.


>   A compatibility mode
> personality (think linux32 for 64 bit systems) could allow for a shell
> to be spawned (`nopax make` or something dumb like that) which puts
> everything into softmode. 

setarch flags are inherited too (not by setuid of course); and that
mechanism already exists. What does your proposed solution add value
wise to that?

>  Anything not marked (binutils with the patch
> emits ----x- PT_PAX_FLAGS, hard-disabling RANDEXEC because it's a bad
> hack) will of course run as if it had psemrx (emutramp is useless anyway
> with an executable heap/stack) in softmode and PSeMrX (emutramp isn't
> used by default, near nothing needs it so why risk a "potential security
> risk" if it even is) in hardmode.

we're talking here about randomisation; I don't see where emutrap comes
in at all????


> > 
> >>MF_PAX_RANDEXEC:
> >>  ON:  Fixed-position things are also randomized
> >>  OFF: Fixed-position things are at fixed positions
> >>  RANDEXEC allows things that normally can't be placed randomly to be
> >>  placed randomly if hacks exist to do it.  Any hacks 100% safe that
> >>  don't cause excess overhead are for RANDMMAP; any that may cause
> >>  instability or excessive overhead go under RANDEXEC.  OFF BY DEFAULT
> >>  in any mode.
> > 
> > 
> > Is this what PIE would be for? Eg if you change binaries why not just
> > change them to be PIE ?
> > 
> 
> Not everything (mplayer!  And last year KDE really hated it too)
> compiles PIE. 

Hmmm we'd need details in a bug report to investigate, I can't think of
a fundamental reason for this...

(other than mplayer doing the wine thing, which indeed means it needs to
be very careful to not trump over certain VA regions; but that is a
separate problem)

The rest of your comment suggests that you consider this one not too
valueable. PIE imo is a pretty nice solution to the problem, and does
not have the performance costs that you get with forcing non-PIE
binaries to be randomized.


> > 
> >>MF_PAX_MPROTECT:
> > 
> > Actually SELinux currently has stuff for this. Does this need to be in
> > the binary or would SELinux policy be enough (I assume that any hardened
> > linux distro nowadays also enables selinux so this question is quite
> > relevant).
> > 
> 
> See my other reply, an LSM hook would be nice for reading PT_PAX_FLAGS,
> controlling them just before they're finally applied.

hmm I again might be missing the point here.... if selinux policy is
enforcing this behavior, why would the executable need a built-in-the-
binary flag for this *in addition* ?


> >>EMUTRAMP. . . I think I've got a patch for trampoline emulation, which
> >>should let red hat use Exec Shield with fewer PT_GNU_STACK markings.
> > 
> > 
> > actually fc4 and such don't have that many markings so I wonder what the
> > usefulness is. (most of the spurious markings we had in the past were
> > due to assembly files not being correctly marked, not due to recursive
> > functions)
> > 
> 
> To get rid of the rest of those few markings?  Particularly Alsa used to
> have TWO nesteds. . . .

Alsa got fixed for one.



> > 
> > since you duplicate PT_GNU_STACK exactly it seems (well inverse meaning
> > but a ! in C is cheap) I think there's no point in obsoleting
> > PT_GNU_STACK. I realize some people see PT_GNU_STACK as an Exec-Shield
> > thing and thus evil, but lets ignore all that politics and stick to
> > facts here: No need to obsolete/remove existing things if they're not
> > broken and are good enough.
> 
> No, it's not that.  I have no problem with PT_GNU_STACK doing what it
> does, but it's a whole field where PaX already has a 2 bit tristate.
> I'm also told that PT_GNU_STACK is on/off, not tristated.  No need to
> maintain 2 fields; and the tristate is perfectly perfect for making a
> compatibility mode/personality that actually honors "we definitely know
> this is good so we marked it hard."

but the stack thing you KNOW. You either need stack exec or you don't.
It's like your wife being pregnant, she either is or isn't. Using
tristates when there is no real third state just looks odd to me,
especially if the third state is the only advantage of something over an
existing thing.


