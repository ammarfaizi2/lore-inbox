Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVFNQKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVFNQKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 12:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVFNQKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 12:10:40 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:19887 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261217AbVFNQKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 12:10:12 -0400
To: karim@opersys.com
cc: dwalker@mvista.com, paulmck@us.ibm.com, Andrea Arcangeli <andrea@suse.de>,
       Bill Huey <bhuey@lnxw.com>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, hch@infradead.org, akpm@osdl.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Attempted summary of "RT patch acceptance" thread 
In-reply-to: Your message of Mon, 13 Jun 2005 18:00:10 EDT.
             <42AE01EA.10905@opersys.com> 
Date: Tue, 14 Jun 2005 09:09:39 -0700
Message-Id: <E1DiDyt-0003qN-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Jun 2005 18:00:10 EDT, Karim Yaghmour wrote:
> 
> Daniel Walker wrote:
> > I wouldn't work on RT if mainline integration wasn't on the agenda. 
> 
> Mainline integration IS what I'm talking about. It's just not done
> the same way.
> 
> > There is going to be positive , and negative discussion on this. I think
> > in the end the maintainers (Linus, and Andrew) don't want "people" to
> > get a patch or modification from the outside. It's best if the community
> > is not separated .. If you make a clean integration , and people want
> > what you are doing, there is no reason for it to be rejected.
> 
> I'm not suggesting the separation of the community, I'm suggesting
> a strategy of integration based on the fact that a large portion of
> kernel contributors don't necessarily care about RT, and most don't
> want to care about it in their day-to-day work (though I think most
> would care that Linux could have an additional spade down its
> sleeve, and would certainly try to help in as much they can from
> time to time.)
 
It is probably worth pointing out that when companies like IBM and
SGI (and many others that I don't want to slight) committed to
making Linux scalable, they faced very similar issues to what you
are facing now.  Specifically, the community at that time (and even in
many cases now) were not concerned about scalability _at all_.

Hence, the burdn was on those advocating scalability to find ways that
minimized the code impact, that minimized the need for distinct CONFIG
options, that allowed distros to build "one version" which worked
everywhere, and at the same time simplified, or, at least, did not
add substantial complexity.

I believe that any effort towards mainline support of RT has to follow
a similar set of guidelines.  And, I believe strongly that *most* of the
RT code should be crafted so that every single laptop user is running
most of the code *and* benefiting from it.  If most of the RT code goes
unused by most of the population, and the only way to get an RT kernel
of any reasonable level is to ask the distros to build yet another
configuration, RT will always be a poor, undertested, underutilized
ugly stepchild of Linux.

And, in fact, RT has some goals which are very much in common with
many Linux users.  Simply the focus on audio and video playback and
record capabilities and the realtime needs for those common applications
should provide the basis for commonality in approach and implementation
of RT code in the current mainline.

Of course, this leaves a not inconsiderable burden on the RT community
to bridge their knowledge with the overall community goals of simplicity,
code cleanliness, comprehensibility, maintainability, etc.  But such an
approach has a greater chance of success than replicating a "kernel in
a kernel" approach where a CONFIG option enables an entirely different set
of RT based characteristics from the mainline kernel that is most widely
used.

> I'm not suggesting asking "people" to get patches from the outside.
> What I'm saying is that those developing mainstream code shouldn't
> need to worry about anything real-time, including modifications to
> locking primitives in headers (be they defined out or in).
 
I would disagree a bit.  Making it *simple* to give the kernel RT
behavior in more and more subsystems will over time work much like
scalability does today.  If patches are agressively vetted, reviewed,
tested, and commented on as they come in, e.g. via the -mm tree, it
is possible to drive common development towards better and better RT
behavior.   Of course, this requires simple APIs, lots of education,
occasional tools like sparse, or simple patches to measure latency as
has been done many times in the past.

> In essence, what you ask can only hold if all kernel developers
> intend for Linux to become QNX. Clearly this isn't going to happen.
> Whatever changes are made to such core functionality as locking
> primitives and interrupt handling can hardly be "transparent"
> simply by wrapping #ifdef CONFIG_X around it in mainstream headers.

Not all kernel developers need to subscribe to any philosophy, ever.
However, by making it simple to validate patches for the capabilities
you wish to advocate, it *is* possible to reject patches which detract
from your capabilities or impede your ability to deploy those capabilities.
And, when rejecting such patches, the burden will fall to the RT community
to show *why* the patch won't work, as well as help identify better means
for accomplishing the original patches intent, while also enabling better
RT support.

No, this is not an easy path.  But I believe it is a path towards the
ultimate success of Linux being able to provide increasingly better RT
support over time.

> From my point of view, determinism and best overall performance are
> conflicting goals. Having separate derectories for something as
> fundamentally different from best overall performance as determinism
> is not too much to ask.

I remember a day when many claimed that desktop responsiveness and
scalability were conflicting goals.  I don't see those people as
active any more and further, I note that over time, scalability
improvements have in many cases furthered desktop responsiveness as well.
You've taken the first step which is to identify the apparent conflict
of goals.  The next step is to find solutions which actually can address
both of those goals, and do it with simple, clean, easy to maintain
code.  Not easy, but I know there are a lot of smart people out here who
can rise to that particular challenge.  ;)

gerrit
