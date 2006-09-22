Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751713AbWIVGIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbWIVGIz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 02:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbWIVGIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 02:08:55 -0400
Received: from opersys.com ([64.40.108.71]:40709 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751712AbWIVGIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 02:08:54 -0400
Message-ID: <451382C4.6010108@opersys.com>
Date: Fri, 22 Sep 2006 02:29:24 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Ingo Molnar <mingo@elte.hu>, Martin Bligh <mbligh@google.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe
 management)
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu> <20060921214248.GA10097@Krystal>
In-Reply-To: <20060921214248.GA10097@Krystal>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And now for some friendly fire :) No just kidding, but I thought I'd
pour some water in your wine here.

Mathieu Desnoyers wrote:
> With all due respect, yes, there are Linux users different from the typical
> Redhat client. If your vision is still limited to this scope after a 500
> emails debate, I am afraid that there is very little I can do about it in
> one more.

Actually I think Ingo should be commended for having come around on
a significant number of crucial and sensitive issues. He's accepted
on principle the need for static markup, the fact that said markup
needs to somewhat be contextually accurate (variables, etc.) and the
fact that any form of markup made could be trivially used for
fast-path direct calls (albeit he wants you to package that as a
separate patch -- which you obviously don't like very much, but I
think I've fixed this one to the satisfaction of both of you below.)

Now, we should stop for a moment, look back and contrast Ingo's
current position to this week's painful thread, and we should thank
him for having come around on these things. I can't say any of it was
enjoyable myself and I'm sure others would agree, but it remains that
Ingo has taken a second look at things. He hasn't come to our specific
position, but that, I think, can be diplomatically resolved, more below.

Now with regards to the fact that Ingo works for RedHat, I think this
should only be used to understand his position. For if the "gut feeling"
of one of RedHat's top kernel engineers is that something is wrong,
then maybe we should try to understand why. Now I don't want to judge
or qualify whether he successfully conveyed the real essence of why he's
got this "gut feeling", we've lost enough time already on non-essential
banter. So let's stick to the facts. Just the facts ma'am. And to that
end, I suggest you and I (and everyone for that matter that agrees with
us) do some role-playing. Now what I say below could be off, but I'm
convinced there's some element of truth here -- and the reason I say this
is that I can imagine myself thinking the same as Ingo if I were in his
position *and* the assumptions I make below were correct.

I believe everyone at RedHat understands the value of tracing. In fact,
I believe their customers have been asking for just that. Their
investment in SystemTap can only be seen in this light. But why, oh
why, if the customers are asking for it is nobody just stick the
freeking thing in (all static) and be done with it? Well, it's
unfortunately not that simple. There are tons of issues (and that's
obviously why LTT has been held up for so many years -- the arguments
against it were just a big ball of wax and nobody ever took the time
to look at what that ball of wax was made of.) Some of them, indeed
I think the most important ones, we've already covered, and I don't
wish to get into those again. Suffice it to say, though, that we've
taken enough wax off the ball that some things have settled in:
some form of static markup being a major one.

Ingo's continued insistence, though, seems to point to the fact that
there's just a little bit more wax to remove. So on with my little
thought experiment.

Say you're RedHat -- and I'm just using RedHat as an example, but I'm
sure much of this applies to any other distro or distro maintainer. Say
you've been shipping LTT for a couple of versions (and, you'll have to
admit Mathieu, that's what we'd like), and obviously yours being the most
widely used distro out there, LTT gets a huge following and everybody
and his little sister uses it for tracing. All is well and everybody's
happy, right? Unfortunately not. Somewhere down the road somebody
tries to push a change into mainline that breaks a tracepoint. Ooops,
that's a problem for Ingo (and all other kernel developers from
RedHat I'd say) you see. Because then he has two nasty choices. Either
he opposes the change -- which may in context be totally nonsensical,
like trying to preserve a variable that doesn't exist no more or
worse a tracepoint that makes absolutely no sense (and I think that's
what Ingo means when he compares those calls to "System calls" that
will have to be maintained forever.) Or, and that's probably worse
from RedHat's position and Ingo's of course, somebody has to go fix
all of LTT's now complicated stack of analysis tools to get it to
continue working for the next release. Judging from the patches Ingo
has been pumping out for the last year, I'd say fixing up userspace
analysis tools isn't on his radars. Of course as the LTT maintainer,
in defense, you would say either: a) you don't need to fix LTT
because it gracefully fails when events go missing (which is true,
but doesn't help RedHat because now its customers don't get the
exact same analysis they were used to), b) that you'd obviously fix
LTT's analysis stack as a consequence (but this too is problematic
because of the reasons that follow.) And then Ingo could say:
1) you don't work for RedHat
2) even if you did work for RedHat (and Ingo could just pull your
   ear to have you "fix" LTT), there's nobody that can predict two
   or three years down the road what will have been built on top of
   your tool by 3rd parties and which may actually be used by RedHat
   customers.

This is as best I make of Ingo's continued insistence on keeping the
direct call stuff out of tree. Because if it's dynamic, then the
above issue *somewhat* goes away: If it's a statically-marked-up dynamic
point, then even if he doesn't control the stack of tools that get
built around those, he can certainly hack up the SystemTap scripts to
continue showing the same "events" to the upper-layer stack, even if
somebody down the line makes the event obsolete. With a tool that
depends on direct non-dynamic instrumentation point, he wouldn't be
able to do that. He'd then have to maintain a RedHat-specific patch
for making that event continue showing up, and looking at the list
of patches those distros end up including, I'm sure he's got zero
interest in doing that. And with the temporary hack in the SystemTap
scripts done, he can then hand that off to someone else and inform
them that eventually that specific event has become obsolete. With
a tool that depends on direct static calls he can't do that. The
stack of analysis tools breaks right away. So when Ingo insists that
you keep your direct call stuff out of tree, what he's really
telling you is that he doesn't want to have to fix your stuff for
your users. If your users depend on your external script to make it
work, RedHat (and therefore Ingo in some way) is not accountable for
that (though it could be some contract work), you are.

Now bare with me, I'm not asking you to drop your position, I think
there's a middle ground everybody will agree on -- of course if I
got the above right.

So below is kind of like a "review" of all the mechanisms that have
been put forth and how they rank depending on perspective. The closer
to "1" the better. And here are the mechanisms I'm reviewing:
- kprobes
- djprobes
- bprobes (Martin's thing amended with a 5-byte filler per instrumented
  function.)
- direct calls (i.e. "static" stuff.)

I've deliberately included Martin's idea here because everything I
have seen about it points to it working. Within the specific case
of where a 5-byte filler "single instruction" is put at the entry of
a function of interest, then djprobes can be safely used to get to
an alternate function. And don't worry, I was one of the first to
actually doubt that djprobes could work. See the SystemTap archives
if you don't believe me. What I've always doubted, and continue to
doubt actually, is its ability to replace bytes covering multiple
instructions with a 5-byte jump. But that's a different topic. Very
early on in my argumentation against djprobes on the SystemTap list,
it became evident that it could be used to effectively replace
anything that had 5 bytes or more. And I knew about the errata
stuff, but this ability was confirmed by the folks at IBM who had
to deal with this errata before. So if they said it works, I had
no reason to doubt that it could safely do what it claimed it could.
So, in sum, unless somebody can mount a solid case against Martin's
slightly-amended proposed mechanism (with the 5-byte filler) in
combination with djprobes, I think we can proceed. Note that the
need for djprobes is x86-specific. On other archs errata limitations
may not be present. And, if worse came to worse, the filler could
be a simple static-jump to an outside replacement (without any
parameters being passed); even with that crude a method the
advantages of bprobes would remain unchanged: a) fast (both while
dormant or active), b) flexible, c) easily used by distro kernel
maintainers for trivially fixing up instrumentation.

One more thing. I sometimes make a distinction below about
djprobes. The "full djprobes" is djprobes that can replace
instructions of any length -- this hasn't been figured out yet as
others have stated. The "limited djprobes" is djprobes that can
replace any instruction of 5 bytes or more. I've yet to see
anything showing this can't work today.

So here's the summary of this "review" with a comment on which
of Ingo or Mathieu insists on which. There are, of course, many
other people that may agree with either, but let's just keep
this simple for now.

In terms of runtime speed of event-to-log (this view of things
is favored by Mathieu):
1- direct calls
2- bprobes
3- full djprobes
4- kprobes

It could be argued that 1, 2, and 3 are the same here, and I
won't disagree too much with that -- if 3 existed.

Lowest cost in "dormant" state (this view of things is favored
by Ingo):
1- kprobes/full djprobes
2- bprobes (single 5byte filler for each instrumented function,
   no matter how many events)
3- direct call (linearly incrementing cost with each event)

Technical simplicity of implementation on x86 (this one is tricky)
(this view of things is favored by Roman -- well, ok, he's not part
of my two choice rule above):
1- direct calls
2- bprobes without binary fixup (filler is direct call or funnction
   pointer -- not elegant, but very simple)
3- kprobes
4- limited djprobes (can replace any instruction of 5 bytes or more)
5- bprobes with binary fixup (filler is 5-byte replaced using
   limited djprobes.)
6- full djprobes (can replace any length of instruction -- this
   has yet to be shown to work.)

Technical simplicity of implementation on "non-errata" arch:
1- direct calls
2- bprobes without binary fixup
3- bprobes with binary fixup
4- kprobes
5- djprobes

Least potential for maintainability nightmare for vendor kernel
engineers (a.k.a. simplicity of fixup in case event doesn't exist
no more or variables are rendered non-relevant) (this is inferred
by me as being Ingo's point-of-view, but I could be wrong):
1- kprobes/full djprobes/bprobes
2- direct calls

Note: I've put bprobes up there with kprobes and djprobes in this
evaluation because I think that the above mind-experiment about
how Ingo could do a simple fixup without imposing the requirement
for a patch to the kernel shipped by RedHat works in the same way.
IOW, what works for SystemTap scripts in this regards, works just
fine for bprobes. I'll take Ingo's positive comments on Martin's
idea as an indication that my conclusion here is correct. And
indeed Martin himself would like to have this in order to avoid
having to do with SystemTap scripts altogether.

How closely does the fixup environment mimic normal kernel code
hacking (this would be Martin's point-of-view):
1- direct calls / bprobes
2- kprobes / full djprobes (in the form of SystemTap of course)

Ability to insert probe points on non-previously marked up regions
(I think everybody would agree on this one):
1- kprobes / full djprobes
2- bprobes (even if the given event we're looking for isn't
   specifically marked up, if the encompassing function is, then
   we can still get our way.)
3- direct calls (of course this sucks, you've got to recompile,
   and that's why it comes strong third and would likely move
   down the list if other mechanisms were found that didn't
   require rebuilding.)

And there may be other criteria which I missed, but I think the
important ones are there.

Now, if you tally this whole thing up, I think you would get that
bprobes is the single thing that would make everyone content.
Really, it does. It's very fast during active tracing, there is no
correlation between the number of markers in a function and
the cost on that function when no tracing is conducted, it should
be relatively easy to implement (all right, I'm using the word
"easy" quite liberally here), it's easy to fixup for distro kernel
maintainers, it provides a work environment which kernel developers
are already very familiar with (the kernel source code), etc.

Now I've never been a fan of binary gunk work. But, gut feelings
running rampant here, I was kind of naturally attracted to
Martin's idea. The above more rational analysis seems to support
such intuition.

For all these reasons, I think bprobes warrants some very serious
investigation. If made to work, and I have yet to see any reason
why it shouldn't, I think it would make most everybody happy --
at least that's what I can make up of all this. Mathieu, in fact,
if you look at it from the LTT perspective, this is just fine,
it provides the events without perturbing the system. And for
Ingo, he gets to be able to do very much what he would have been
able to do with SystemTap for fixing up events without having to
go fix some userspace analysis tool.

And with regards to the fate of embedded systems, which trust me
I know everything about, then I'm sure Ingo won't object to your
markers generating direct static calls if that's tied to
CONFIG_EMBEDDED. And if you talk to him on a sunny day, he might
just agree that direct static calls would just be fine on m68k
too ;)

And if, and only if, bprobes can't be made to work, then you might
just have to keep that static direct call outside the tree until
you can prove to Ingo that on the long run you'll be able to manage
keeping LTT in-sync with kernel changes -- or unless Ingo's point
of view is ignored by everybody upstairs, which I have my doubts
about. Which, of course, wouldn't preclude RedHat shipping LTT so
long as it depended on a mechanism which allowed Ingo to fix up
events for it and not have to delve into fixing the LTT analysis
stack for RedHat customers to be happy.

Hope this helps dissipate some confusion and focus attention where
progress would help achieving a more universal consensus,

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546

