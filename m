Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUJIA6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUJIA6P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 20:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUJIA6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 20:58:15 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:47802 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266357AbUJIA6F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 20:58:05 -0400
Subject: Re: [PATCH] cpusets - big numa cpu and memory placement
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Simon.Derr@bull.net,
       pwil3058@bigpond.net.au, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       sivanich@sgi.com
In-Reply-To: <20041008061426.6a84748c.pj@sgi.com>
References: <20041007015107.53d191d4.pj@sgi.com>
	 <200410071053.i97ArLnQ011548@owlet.beaverton.ibm.com>
	 <20041007072842.2bafc320.pj@sgi.com> <4165A31E.4070905@watson.ibm.com>
	 <20041008061426.6a84748c.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097283081.6470.138.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 08 Oct 2004 17:51:21 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 06:14, Paul Jackson wrote:
> So here I am with this new cpuset design (Simon Derr, primary
> architect, both Simon and I feel a strong sense of ownership)
> for numa placement, perhaps the 4th or 5th in SGI's history,
> and the 2nd in mine.  I am finding that it deliciously and
> elegantly reflects the needs of its anticipated users (Sylvain
> might demur, noting a couple of things I removed).
> 
> I am now being asked to morph it into a CKRM controller.
> 
> Further I deduce from the efforts over the last few days to talk
> me down from meeting all the requirements satisfied by my current
> cpuset patch that something of cpusets will be lost in the translation.
> 
> But I haven't figured out exactly what will be lost.  And I lack the
> mastery of CKRM that would enable me to engage in a constructive dialog
> on the various tradeoffs that come into play here.

I hope that *nothing* will be lost.  We (I) aim to still offer
users/admins named groupings of CPUs and memory.  They may not be called
cpusets, in favor of names like classes or domains, but they will
*still* be named groupings of CPUs and memory.  I further aim to not
change your API significantly.  I really like the filesystem API you
came up with to interact with cpusets from userspace.  I'd like to
incorporate this into CKRM's filesystem API (called rcfs) with minimal
changes.  I really like the exclusive cpusets you describe.  You tried
to implement them with some kernel exclusivity (your vitamin
precursors), while I'd like to see the kernel offer real exclusivity. 
This shouldn't affect your customers because real exclusivity will
*still* be offered.  I also aim to support what seems like a large
portion of your non-exclusive cpusets through nested, hierarchical
sched_domains.  And I hope to do all of this with less overhead.

Now, I'm certainly not saying my patch provides all these things now.  I
am saying that I believe the approach/model I'm using could do all these
things with some further work.


> And I am looking at trading what I thought had hope of being a
> Sept or Oct date for acceptance into Linus's kernel, into some
> unknown schedule that is definitely further out.
> 
> I've got the bacon sizzling on the skillet, I can smell it, my
> mouth is watering, and just as I go to lift it off the burner,
> Andrew asks me to consider trading it for a pig in a poke.
> Thanks a bunch, Andrew - you da man ;).

Andrew is da man.  Sometimes da man works with you, sometimes da man
works against you.  As the French say, c'est la vie.

I think we can figure out how to merge cpusets into CKRM's framework,
with minimal changes to both the cpusets API & functionality without
slipping that *too* much.  End of the year isn't unreasonable....


> Keep talking.

You asked for it!!! ;)

-Matt

