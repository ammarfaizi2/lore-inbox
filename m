Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267777AbUJGVVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267777AbUJGVVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267936AbUJGVSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:18:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:35491 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267994AbUJGVEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:04:51 -0400
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
	memory placement
From: Matthew Helsley <matthltc@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <20041007125237.767e3a26.pj@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	 <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com>
	 <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au>
	 <821020000.1096814205@[10.10.2.4]> <20041003083936.7c844ec3.pj@sgi.com>
	 <834330000.1096847619@[10.10.2.4]> <835810000.1096848156@[10.10.2.4]>
	 <20041003175309.6b02b5c6.pj@sgi.com> <838090000.1096862199@[10.10.2.4]>
	 <20041003212452.1a15a49a.pj@sgi.com> <843670000.1096902220@[10.10.2.4]>
	 <Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
	 <58780000.1097004886@flay> <20041005172808.64d3cc2b.pj@sgi.com>
	 <1193270000.1097025361@[10.10.2.4]> <20041005190852.7b1fd5b5.pj@sgi.com>
	 <1097103580.4907.84.camel@arrakis> <20041007015107.53d191d4.pj@sgi.com>
	 <Pine.LNX.4.61.0410071439070.19964@openx3.frec.bull.fr>
	 <1250810000.1097160595@[10.10.2.4]> <20041007105425.02e26dd8.pj@sgi.com>
	 <20041007112531.674413f1.akpm@osdl.org>
	 <20041007125237.767e3a26.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1097183058.2673.2015.camel@stark>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 07 Oct 2004 14:04:18 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 12:52, Paul Jackson wrote:
<snip>
> Also the other means to poke the affinity masks, sched_setaffinity,
> mbind and set_mempolicy, need to be constrained to respect cpuset
> boundaries and honor exclusion.  I doubt you want them calling out to a
> user daemon either.
> 
> And the memory affinity mask, mems_allowed, seems to require updating
> within the current task context.  Perhaps someone else is smart enough
> to see an alternative, but I could not find a safe way to update this
> from outside the current context.  So it's updated on the path going
> into __alloc_pages().  I doubt you want a patch that calls out to my
> daemon on each call into __alloc_pages().
<snip>

	Just a thought: could a system-wide ld preload of some form be useful
here? You could use preload to add wrappers around the necessary calls
(you'd probably want to do this in /etc/ld.so.preload). Then have those
wrappers communicate with a daemon or open some /etc config files that
describe the topology you wish to enforce.

Cheers,
	-Matt Helsley

