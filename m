Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269958AbUJHNUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269958AbUJHNUq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 09:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269971AbUJHNUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 09:20:45 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:12205 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269958AbUJHNRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 09:17:37 -0400
Date: Fri, 8 Oct 2004 06:14:26 -0700
From: Paul Jackson <pj@sgi.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: ricklind@us.ibm.com, colpatch@us.ibm.com, mbligh@aracnet.com,
       Simon.Derr@bull.net, pwil3058@bigpond.net.au, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041008061426.6a84748c.pj@sgi.com>
In-Reply-To: <4165A31E.4070905@watson.ibm.com>
References: <20041007015107.53d191d4.pj@sgi.com>
	<200410071053.i97ArLnQ011548@owlet.beaverton.ibm.com>
	<20041007072842.2bafc320.pj@sgi.com>
	<4165A31E.4070905@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, thank-you, Hubertus, for comparing me to a puppy, rather
than a kitten.  I am definitely a dog person, not a cat person,
and I appreciate your considerate choice of analog.

I gather from the tone of your post yesterday that there is
a disconnect between us - you speak with the frustration of
someone who has been shouting into the wind and not being
heard.

I suspect that the disconnect, if such be, is not where you
think it is:

Hubertus wrote:
> 
> The disconnect is that you do not want to recognize that CKRM does NOT 
> have to be systemwide. Once you open your mind to the fact that CKRM can 
> be deployed with in a subset of disconnected resources (cpu domains)
> and manages shares independently within that domain, I truely don't see
> what the problem is.

I have recognized for months that eventually we'd want to allow
for cpuset-relative CKRM domains, and I'm pretty sure I've
dropped comments to that affect one time or another here on lkml.

I suspect instead that "CKRM" is one layer more abstract than
I am normally comfortable with.

As best as I can tell, CKRM has evolved from its origins as a
fair share scheduler, into a framework (*) for things called by
such names as classes and controllers.  As you may recall from
an inconclusive thread between us on the ckrm-tech email list two
months ago, I find those terms uncomfortably vague and abstract.

In general, frameworks are high risk business.  What they
gain in generality, covering a wider range of situations in
a uniform pattern, they lose in down to earth concreteness,
leaving their users less confident of what works, and less able
to rely on their intuitions.  The risk of serious design flaws,
shrouded for a long time in the fog of abstraction, is higher.

The more successful frameworks, such as vfs for example,
typically have deep roots in prior art, and a sizable population
of journeyman and master practitioners.

CKRM is young, its roots more shallow, and the population of
its practitioners small.

 (*) P.S. - It's more like CKRM is now the combination of
     a virtual resource manager framework and a particular
     instance of such (the fair shair controllers that have
     their conceptual origins in IBM's WLM, I suspect).  If
     numa placement controllers (aka cpusets) are going to
     exist as well, then CKRM needs to split into (1) a
     virtual resource manager framework (vrm), and (2) the
     fair share stuff.  The vrm framework should be neutral
     of either fair share or numa placement bias.

===

So here I am with this new cpuset design (Simon Derr, primary
architect, both Simon and I feel a strong sense of ownership)
for numa placement, perhaps the 4th or 5th in SGI's history,
and the 2nd in mine.  I am finding that it deliciously and
elegantly reflects the needs of its anticipated users (Sylvain
might demur, noting a couple of things I removed).

I am now being asked to morph it into a CKRM controller.

Further I deduce from the efforts over the last few days to talk
me down from meeting all the requirements satisfied by my current
cpuset patch that something of cpusets will be lost in the translation.

But I haven't figured out exactly what will be lost.  And I lack the
mastery of CKRM that would enable me to engage in a constructive dialog
on the various tradeoffs that come into play here.

I look at the CKRM patch, and see something that looks an order
of magnitude larger than my cpuset patch.  With its increased
number of hooks in the kernel, and its more abstract style
(it is a framework afterall), I also see something with a
higher risk of performance impact, especially on the large NUMA
configurations that I care about.

And I am looking at trading what I thought had hope of being a
Sept or Oct date for acceptance into Linus's kernel, into some
unknown schedule that is definitely further out.

I've got the bacon sizzling on the skillet, I can smell it, my
mouth is watering, and just as I go to lift it off the burner,
Andrew asks me to consider trading it for a pig in a poke.
Thanks a bunch, Andrew - you da man ;).

Putting aside for a moment my personal frustrations (which
are after all my problem - and my dogs) I am simply unable to
make sense yet of how deep would be the hit on the capabilities
of cpusets, if so morphed, and I am painfully aware of the
undetermined schedule delays and increased risks to product
performance and even ultimate success that attend such a change.

>From what my field engineers tell me, whom I've been polling
furiously on this matter the last few days, at least in the
markets that SGI frequents, there is very little overlap between
system configurations which benefit from fair share resource
management and those which benefit from numa placement resource
management.  So, if that experience is generally applicable, we
are at risk of marrying a helicopter and a boat, just because
both have a motor and a hull, to the detriment of both.

Merging projects always has risks.  The payoff for synergies
gained is not always greater than the cost of the inefficiencies
and compromises introduced, and the less immediate involvement
of the participants in the end result.

I cannot in good conscience recommend such a change.

Keep talking.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
