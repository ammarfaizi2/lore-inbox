Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262872AbVA2HqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbVA2HqM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 02:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVA2HqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 02:46:12 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:40107 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262872AbVA2Hpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 02:45:50 -0500
Message-ID: <41FB3F53.8050507@comcast.net>
Date: Sat, 29 Jan 2005 02:46:27 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org>  <20050127101322.GE9760@infradead.org>  <41F92721.1030903@comcast.net> <1106848051.5624.110.camel@laptopd505.fenrus.org> <41F92D2B.4090302@comcast.net> <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alright, I'll bite.

Someone told me to bring this up after reading all the complaints about
breakage, so again we get back to PaX.  I'm more interested in "this
patch is bad" than "PaX is better" for this argument, but whatever.


Compatibility has been repetedly mentioned here.  Breaking things has
been mentioned.  Things inside the distro won't break becaues the distro
maintainers mark them; third party vendors should mark them too.  If
they don't, they STILL won't break, if the distribution is crafted to do
really ugly things I hate to enter ultimate-global-super-compatibility-mode.

Last year I started on my master's thesis for computer security.
Granted, next semester i'm *hoping* to get my AS in computer science,
but I wanted to start writing early.  So out of the 18 pages, I'll pull
one little bit from section 4 (Deployment) subsection 2 (Executable
Space Protections).  This'll be a big read.

- ---CUT---
2.  Executable Space Protections

Executable Space Protections can be deployed on many architectures using
PaX.  A number of methods of deployment could be used, each ranging its
own ratio of security vs. compatibility.  The recommended course of
action is to allow the administrator to control how protections are
applied, either by setting an automatic default method or by being asked
where protections should be applied on a case by case basis.

Any binary which may function under full restrictions should be set to
function under full restrictions automatically, without asking.  There
may be an option to ask the administrator in every case including those
where the greatest security is used by default; but in most cases, the
administrator will not want to be bothered unless a security concern is
raised.

There are three states for restrictions.  In the Default state, the
restriction is not explicitly enabled or disabled; PaX decides whether
to use the restriction based on the Softmode setting.  If the system is
in Softmode, PaX does not enable restrictions in the Default state; if
the system is not in Softmode, PaX enables restrictions in the Default
state.  Contrastingly, restrictions in the Enabled state are enabled
under PaX regardless of Softmode, while restrictions in the Disabled
state are disabled under PaX regardless of Softmode.

Here, the term "compatibility" is used to indicate how much software
doesn't work.  A system with low compatibility will have software that
does not run due to security restrictions; while a system with high
compatibility will run most if not all software, including third party
software.

There are four basic methods of PaX flag control, each detailed briefly
below.  As stated above, the administrator should choose which method to
employ.

A.  Manual Control

  Manual Control is not recommended as a default.  Under Manual Control,
  all restrictions remain in the Default state on all binaries at
  installation time.  This imposes the most added administrative duty
  and the least compatibility.

B.  Selective Disable

  Selective Disable is the most basic form of control, allowing the
  implementation to ship with everything working.  Under Selective
  Disable, binaries known to break due to PaX restrictions have those
  restrictions set to the Disabled state when installed, leaving the
  rest in the Default state.  This relieves most administrative duty and
  increases compatibility, although third party binaries may not come
  marked.

C.  Inheritive Selective Disable

  Inheritive Selective Disable is similar to Selective Disable, except
  that libraries are also marked and tabs are kept on these.  When
  software is installed which uses a library, the Disabled features of
  the executable and each library are masked together to come up with
  the final mask to apply to the executable.  These masks can later be
  generated for third party programs with an administrative tool in
  order to enhance compatibility further; although third party programs
  and libraries requiring other markings in themselves not also needed
  by other libraries will still break.

D.  Selective Enable

  Selective Enable is the only method leveraging Softmode to enhance
  compatibility.  It is also the only method which will leave third
  party binaries completely exposed with no reason aside from that they
  are not explicitly packaged with a set of listed restrictions.  Under
  Selective Enable, executable binaries have all restrictions except
  those known to break them set to Enabled, leaving the rest in the
  Default state.  Third party binaries which come with no markings will
  have no restrictions in Softmode, and so full compatibility is reached
  with the maximum justifiable trade-off in the range of executables
  protected by PaX.

The above methods become progressively more compatible, but at the same
time less secure.  Both the standard and Inheritive variations of the
Selective Disable method are about on par in principle; the
administrator will obviously disable protections on third party software
that breaks, so attempting to preempt this by identifying what
absolutely will break the software may prevent shotgunning (disabling
everything that could possibly cause a problem).  This is a best-effort
compatibility model; anything obviously incompatible is adjusted, but
some things may be missed.

The Selective Enable method, on the other hand, will take compatibility
out to its edge and switch completely to a best-effort security model,
where anything obviously compatible is secured, but anything not defined
is left alone to avoid breakage.  Microsoft's implementation of NX
protections on 64 bit Windows XP SP2 allows a mode which is akin to
this, in which only core system software is protected[24].

In any protection method, third party vendors can mark their binaries to
explicitly enable and disable protections to be compatible under any
method.  If this additional information could be guaranteed from third
party vendors, the Inheritive Selective Disable method could be
completed by masking the still Enabled protections with the inherited
Disabled protections to produce the final mask, giving guaranteed
compatibility with least privileges.
- ---CUT---

Blah blah blah blah with softmode, PaX can be made to function only on
the programs that the distribution maintainers have touched.  This
provides better protection for the base system, and removes all
protection for third party binaries, which makes the system infinitely
compatible with third party software.

Reminder, I hate option (D).  You take the security away from the huge
realm of third party software to save yourself 3 seconds of `chpax
- -psemrx` or `paxctl -psemrx` which would do the same thing to most lkely
exactly one or at least less than ten special cases.

I believe that if you want your product to work, you should mark it for
PaX, since (hey!) the kernel ignores EI_PAX and PT_PAX_FLAGS anyway
unless it has PaX (I've tested this, and in fact Gentoo I believe
compiles with PT_PAX_FLAGS regardless of kernel used, but I'm not sure).

Now of course if vendors are forced to "release a patch" and continue to
maintain their product with a little extra command in the build/package
process, they'll just have to do it; but we wouldn't want to burden them
with 5 seconds more work (somebody always clips me on this one with "and
another 5 seconds, and another, until it takes 1000 years to release a
product").

Then again, a quick google will probably turn up "Oracle breaks on
<insert OS with protection that breaks oracle here>"  "This is easy,
there's a command called 'paxctl'....."  I mean hell, how many "tweaks"
are there that idiots put into there computer that start with "Microsoft
packages a tool with Windows called 'regedit'"?

This thread and this argument isn't about PaX.  My point is that coarse,
mid, and fine-grained control should all be available to let a large
bane of power be weielded with respect.  PaX does this by allowing you
to completely disable PaX (kernel compilation, not runtime; I'd love to
see runtime as well); set its exec protections into "softmode" where it
only goes for explicit "On" tristates for options on individual
binaries; explicitly disable protections on individual binaries; or
disable ASLR for the entire system.

Maybe I just like being able to fiddle with little knobs too much, but
it seems to me that I don't have to fiddle with them just because
they're there; my distribution can do it for me, and that's important to
me.  *I* want to toy with them, but *you* shouldn't have to.

. . . what was my point?  Oh yeah.  it's possible to deploy huge
randomization and VM splitting and crap without breaking third party
software, see above for explaination.

Linus Torvalds wrote:
> 
> On Thu, 27 Jan 2005, John Richard Moser wrote:
> 
>>What the hell?
> 
> 
> John. Stop frothing at the mouth already!
> 
> Your suggestion of 256MB of randomization for the stack SIMPLY IS NOT 
> ACCEPTABLE for a lot of uses. People on 32-bit archtiectures have issues 
> with usable virtual memory areas etc.
> 
> 
>>Red Hat is all smoke and mirrors anyway when it comes to security, just
>>like Microsoft.  This just reaffirms that.
> 
> 
> No. This just re-affirms that you are an inflexible person who cannot see 
> the big picture. You concentrate on your issues to the point where 
> everybody elses issues don't matter to you at all. That's a bad thing, in 
> case you haven't realized.
> 
> Intelligent people are able to work constructively in a world with many 
> different (and often contradictory) requirements. 
> 
> A person who cannot see outside his own sphere of interest can be very 
> driven, and can be very useful - in the "please keep uncle Fred tinkering 
> in the basement, but don't show him to any guests" kind of way. 
> 
> I have a clue for you: until PaX people can work with the rest of the
> world, PaX is _never_ going to matter in the real world. Rigidity is a
> total failure at all levels. 
> 
> Real engineering is about doing a good job balancing different issues.
> 
> Please remove me from the Cc when you start going off the deep end, btw.
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+z9ShDd4aOud5P8RAgOBAJ9ABXCQQDMKL2rcxDTZbAMKiGP8/QCfQ8HS
Pp3qP1W1Mi2CD9V1OgC61J8=
=i2Bl
-----END PGP SIGNATURE-----
