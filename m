Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTFOO1o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 10:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTFOO1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 10:27:44 -0400
Received: from [62.81.235.111] ([62.81.235.111]:60384 "EHLO smtp11.eresmas.com")
	by vger.kernel.org with ESMTP id S262273AbTFOO1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 10:27:03 -0400
Message-ID: <3EEC84E5.5080007@wanadoo.es>
Date: Sun, 15 Jun 2003 16:38:29 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Subject: Re:GFDL in the kernel tree
Content-Type: multipart/mixed;
 boundary="------------020109020502000003030101"
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020109020502000003030101
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

hi,

Christoph Hellwig wrote:

> And of course there's still all those nasty issue with GFDL like
> invariant sections and cover texts that make at least the debian-devel
> list believe it's an unfree license..
> 
> Folks, could we please only use GPL-compatible licenses in the kernel
> tree?

speaking about licenses, Red Hat guys have included into the kernel a
new file, COPYING.modules, about modules license. It would be interesting
to have it into official kernels too.

more info about 'Proprietary kernel modules': http://people.redhat.com/rkeech/pkm.html

regards,
--
Software is like sex, it's better when it's bug free.

--------------020109020502000003030101
Content-Type: text/plain;
 name="COPYING.modules"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="COPYING.modules"

Date: Thu, 17 Oct 2002 10:08:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig 
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make LSM register functions GPLonly exports
In-Reply-To: <20021017175403.A32516@infradead.org>
Message-ID: <Pine.LNX.4.44.0210170958340.6739-100000@home.transmeta.com>

Note that if this fight ends up being a major issue, I'm just going to 
remove LSM and let the security vendors do their own thing. So far

 - I have not seen a lot of actual usage of the hooks
 - seen a number of people who still worry that the hooks degrade 
   performance in critical areas
 - the worry that people use it for non-GPL'd modules is apparently real, 
   considering Crispin's reply.

I will re-iterate my stance on the GPL and kernel modules:

  There is NOTHING in the kernel license that allows modules to be 
  non-GPL'd. 

  The _only_ thing that allows for non-GPL modules is copyright law, and 
  in particular the "derived work" issue. A vendor who distributes non-GPL 
  modules is _not_ protected by the module interface per se, and should 
  feel very confident that they can show in a court of law that the code 
  is not derived.

  The module interface has NEVER been documented or meant to be a GPL 
  barrier. The COPYING clearly states that the system call layer is such a 
  barrier, so if you do your work in user land you're not in any way 
  beholden to the GPL. The module interfaces are not system calls: there 
  are system calls used to _install_ them, but the actual interfaces are
  not.

  The original binary-only modules were for things that were pre-existing 
  works of code, ie drivers and filesystems ported from other operating 
  systems, which thus could clearly be argued to not be derived works, and 
  the original limited export table also acted somewhat as a barrier to 
  show a level of distance.

In short, Crispin: I'm going to apply the patch, and if you as a copyright 
holder of that file disagree, I will simply remove all of he LSM code from 
the kernel. I think it's very clear that a LSM module is a derived work, 
and thus copyright law and the GPL are not in any way unclear about it. 

If people think they can avoid the GPL by using function pointers, they 
are WRONG. And they have always been wrong.

			Linus

------------------------------------------------------------------------
Date: Fri, 19 Oct 2001 13:16:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Barnes
Subject: Re: GPL, Richard Stallman, and the Linux kernel

[ This is not, of course, a legal document, but if you want to forward it
  to anybody else, feel free to do so. And if you want to argue legal
  points with me or point somehting out, I'm always interested. To a
  point ;-]

On Fri, 19 Oct 2001, Barnes wrote:
>
> I've been exchanging e-mail with Richard Stallman for a couple of
> weeks about the finer points of the GPL.

I feel your pain.

> I've have spent time pouring through mailing list archives, usenet,
> and web search engines to find out what's already been covered about
> your statement of allowing dynamically loaded kernel modules with
> proprietary code to co-exist with the Linux kernel.  So far I've
> been unable to find anything beyond vague statements attributed to
> you.  If these issues are addressed somewhere already, please refer
> me.

Well, it really boils down to the equivalent of "_all_ derived modules
have to be GPL'd". An external module doesn't really change the GPL in
that respect.

There are (mainly historical) examples of UNIX device drivers and some
UNIX filesystems that were pre-existing pieces of work, and which had
fairly well-defined and clear interfaces and that I personally could not
really consider any kind of "derived work" at all, and that were thus
acceptable. The clearest example of this is probably the AFS (the Andrew
Filesystem), but there have been various device drivers ported from SCO
too.

> Issue #1
> ========
> Currently the GPL version 2 license is the only license covering the
> Linux kernel.  I cannot find any alternative license explaining the
> loadable kernel module exception which makes your position difficult
> to legally analyze.
>
> There is a note at the top of www.kernel.org/pub/linux/kernel/COPYING,
> but that states "user programs" which would clearly not apply to
> kernel modules.
>
> Could you clarify in writing what the exception precisely states?

Well, there really is no exception. However, copyright law obviously
hinges on the definition of "derived work", and as such anything can
always be argued on that point.

I personally consider anything a "derived work" that needs special hooks
in the kernel to function with Linux (ie it is _not_ acceptable to make a
small piece of GPL-code as a hook for the larger piece), as that obviously
implies that the bigger module needs "help" from the main kernel.

Similarly, I consider anything that has intimate knowledge about kernel
internals to be a derived work.

What is left in the gray area tends to be clearly separate modules: code
that had a life outside Linux from the beginning, and that do something
self-containted that doesn't really have any impact on the rest of the
kernel. A device driver that was originally written for something else,
and that doesn't need any but the standard UNIX read/write kind of
interfaces, for example.

> Issue #2
> ========
> I've found statements attributed to you that you think only 10% of
> the code in the current kernel was written by you.  By not being the
> sole copyright holder of the Linux kernel, a stated exception to
> the GPL seems invalid unless all kernel copyright holders agreed on
> this exception.  How does the exception cover GPL'd kernel code not
> written by you?  Has everyone contributing to the kernel forfeited
> their copyright to you or agreed with the exception?

Well, see above about the lack of exception, and about the fundamental
gray area in _any_ copyright issue. The "derived work" issue is obviously
a gray area, and I know lawyers don't like them. Crazy people (even
judges) have, as we know, claimed that even obvious spoofs of a work that
contain nothing of the original work itself, can be ruled to be "derived".

I don't hold views that extreme, but at the same time I do consider a
module written for Linux and using kernel infrastructures to get its work
done, even if not actually copying any existing Linux code, to be a
derived work by default. You'd have to have a strong case to _not_
consider your code a derived work..

> Issue #3
> ========
> This issue is related to issue #1.  Exactly what is covered by the
> exception?  For example, all code shipped with the Linux kernel
> archive and typically installed under /usr/src/linux, all code under
> /usr/src/linux except /usr/src/linux/drivers, or just the code in
> the /usr/src/linux/kernel directory?

See above, and I think you'll see my point.

The "user program" exception is not an exception at all, for example, it's
just a more clearly stated limitation on the "derived work" issue. If you
use standard UNIX system calls (with accepted Linux extensions), your
program obviously doesn't "derive" from the kernel itself.

Whenever you link into the kernel, either directly or through a module,
the case is just a _lot_ more muddy. But as stated, by default it's
obviously derived - the very fact that you _need_ to do something as
fundamental as linking against the kernel very much argues that your
module is not a stand-alone thing, regardless of where the module source
code itself has come from.

> Issue #4
> ========
> This last issue is not so much a issue for the Linux kernel
> exception, but a request for comment.
>
> Richard and I both agree that a "plug-in" and a "dynamically
> loaded kernel module" are effectively the same under the GPL.

Agreed.

The Linux kernel modules had (a long time ago), a more limited interface,
and not very many functions were actually exported. So five or six years
ago, we could believably claim that "if you only use these N interfaces
that are exported from the standard kernel, you've kind of implicitly
proven that you do not need the kernel infrastructure".

That was never really documented either (more of a guideline for me and
others when we looked at the "derived work" issue), and as modules were
more-and-more used not for external stuff, but just for dynamic loading of
standard linux modules that were distributed as part of the kernel anyway,
the "limited interfaces" argument is no longer a very good guideline for
"derived work".

So these days, we export many internal interfaces, not because we don't
think that they would "taint" the linker, but simply because it's useful
to do dynamic run-time loading of modules even with standard kernel
modules that _are_ supposed to know a lot about kernel internals, and are
obviously "derived works"..

> However we disagree that a plug-in for a GPL'd program falls
> under the GPL as asserted in the GPL FAQ found in the answer:
> http://www.gnu.org/licenses/gpl-faq.html#GPLAndPlugins.

I think you really just disagree on what is derived, and what is not.
Richard is very extreme: _anything_ that links is derived, regardless of
what the arguments against it are. I'm less extreme, and I bet you're even
less so (at least you would like to argue so for your company).

> My assertion is that plug-ins are written to an interface, not a
> program.  Since interfaces are not GPL'd, a plug-in cannot be GPL'd
> until the plug-in and program are placed together and run.  That is
> done by the end user, not the plug-in creator.

I agree, but also disrespectfully disagree ;)

It's an issue of what a "plug-in" is - is it a way for the program to
internally load more modules as it needs them, or is it _meant_ to be a
public, published interface.

For example, the "system call" interface could be considered a "plug-in
interface", and running a user mode program under Linux could easily be
construed as running a "plug-in" for the Linux kernel. No?

And there, I obviously absolutely agree with you 100%: the interface is
published, and it's _meant_ for external and independent users. It's an
interface that we go to great lengths to preserve as well as we can, and
it's an interface that is designed to be independent of kernel versions.

But maybe somebody wrote his program with the intention to dynamically
load "actors" as they were needed, as a way to maintain a good modularity,
and to try to keep the problem spaces well-defined. In that case, the
"plug-in" may technically follow all the same rules as the system call
interface, even though the author doesn't intend it that way.

So I think it's to a large degree a matter of intent, but it could
arguably also be considered a matter of stability and documentation (ie
"require recompilation of the plug-in between version changes"  would tend
to imply that it's an internal interface, while "documented binary
compatibility across many releases" implies a more stable external
interface, and less of a derived work)

Does that make sense to you?

> I asked Richard to comment on several scenarios involving plug-ins
> explain whether or not they were in violation of the GPL.  So far he
> as only addressed one and has effectively admitted a hole.  This is
> the one I asked that he's responded to:
>     [A] non-GPL'd plug-in writer writes a plug-in for a non-GPL'd
>     program.  Another author writes a GPL'd program making the
>     first author's plug-ins compatible with his program.  Are now
>     the plug-in author's plug-ins now retroactively required to be
>     GPL'd?
>
> His response:
>     No, because the plug-in was not written to extend this program.
>
> I find it suspicious that whether or not the GPL would apply to the
> plug-in depends on the mindset of the author.

The above makes no sense if you think of it as a "plug in" issue, but it
makes sense if you think of it as a "derived work" issue, along with
taking "intent" into account.

I know lawyers tend to not like the notion of "intent", because it brings
in another whole range of gray areas, but it's obviously a legal reality.

Ok, enough blathering from me. I'd just like to finish off with a few
comments, just to clarify my personal stand:

 - I'm obviously not the only copyright holder of Linux, and I did so on
   purpose for several reasons. One reason is just because I hate the
   paperwork and other cr*p that goes along with copyright assignments.

   Another is that I don't much like copyright assignments at all: the
   author is the author, and he may be bound by my requirement for GPL,
   but that doesn't mean that he should give his copyright to me.

   A third reason, and the most relevant reason here, is that I want
   people to _know_ that I cannot control the sources. I can write you a
   note to say that "for use XXX, I do not consider module YYY to be a
   derived work of my kernel", but that would not really matter that much.
   Any other Linux copyright holder might still sue you.

   This third reason is what makes people who otherwise might not trust me
   realize that I cannot screw people over. I am bound by the same
   agreement that I require of everybody else, and the only special status
   I really have is a totally non-legal issue: people trust me.

   (Yes, I realize that I probably would end up having more legal status
   than most, even apart from the fact that I still am the largest single
   copyright holder, if only because of appearances)

 - I don't really care about copyright law itself. What I care about is my
   own morals. Whether I'd ever sue somebody or not (and quite frankly,
   it's the last thing I ever want to do - if I never end up talking to
   lawyers in a professional context, I'll be perfectly happy. No
   disrespect intended) will be entirely up to whether I consider what
   people do to me "moral" or not. Which is why intent matters to me a
   lot - both the intent of the person/corporation doign the infringement,
   _and_ the intent of me and others in issues like the module export
   interface.

   Another way of putting this: I don't care about "legal loopholes" and
   word-wrangling.

 - Finally: I don't trust the FSF. I like the GPL a lot - although not
   necessarily as a legal piece of paper, but more as an intent. Which
   explains why, if you've looked at the Linux COPYING file, you may have
   noticed the explicit comment about "only _this_ particular version of
   the GPL covers the kernel by default".

   That's because I agree with the GPL as-is, but I do not agree with the
   FSF on many other matters. I don't like software patents much, for
   example, but I do not want the code I write to be used as a weapon
   against companies that have them. The FSF has long been discussing and
   is drafting the "next generation" GPL, and they generally suggest that
   people using the GPL should say "v2 or at your choice any later
   version".

   Linux doesn't do that. The Linux kernel is v2 ONLY, apart from a few
   files where the author put in the FSF extension (and see above about
   copyright assignments why I would never remove such an extension).

The "v2 only" issue might change some day, but only after all documented
copyright holders agree on it, and only after we've seen what the FSF
suggests. From what I've seen so far from the FSF drafts, we're not likely
to change our v2-only stance, but there might of course be legal reasons
why we'd have to do something like it (ie somebody challenging the GPLv2
in court, and part of it to be found unenforceable or similar would
obviously mean that we'd have to reconsider the license).

		Linus

PS. Historically, binary-only modules have not worked well under Linux,
quite regardless of any copyright issues. The kernel just develops too
quickly for binary modules to work well, and nobody really supports them.
Companies like Red Hat etc tend to refuse to have anything to do with
binary modules, because if something goes wrong there is nothing they can
do about it. So I just wanted to let you know that the _legal_ issue is
just the beginning. Even though you probably don't personally care ;)

--------------020109020502000003030101--


