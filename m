Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbVLGQzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVLGQzt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVLGQzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:55:49 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:23963 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751205AbVLGQzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:55:48 -0500
Date: Wed, 7 Dec 2005 17:55:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, rostedt@goodmis.org, johnstul@us.ibm.com
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
Message-ID: <20051207165550.GA2426@elte.hu>
References: <20051206000126.589223000@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512061628050.1610@scrub.home> <1133908082.16302.93.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512070347450.1609@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512070347450.1609@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > Sorry if it was previously your idea and if we didnt credit you for it.
> > I did not keep track of each word said in these endless mail threads. We
> > credited every suggestion and idea which we picked up from you, see our
> > previous emails. If we missed one, it was definitely not intentional.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112755827327101
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112760582427537
> 
> A bit later ktime_t looked pretty much like the 64bit part of my 
> ktimespec.

and Thomas credited you for that point in his announcement:

 " Roman pointed out that the penalty for some architectures
   would be quite big when using the nsec_t (64bit) scalar time
   storage format. "

  http://marc.theaimsgroup.com/?l=linux-kernel&m=112794069605537&w=2

also, once you came up with actual modifications to the ktimers concept 
(the ptimer queue) we noticed a further refinement of ktime_t in that 
code: the elimination of the plain scalar type. We gave you credit 
again:

" - eliminate the plain s64 scalar type, and always use the union.
    This simplifies the arithmetics. Idea from Roman Zippel. "

see:

   http://marc.theaimsgroup.com/?l=linux-kernel&m=113339663027117&w=2
   http://marc.theaimsgroup.com/?l=linux-kernel&m=113382965626004&w=2

we couldnt take your actual patch/code though, due to the way you 
created the ptimer queue: you took our ktimer queue, added a dozen 
changes to it (intermixed, without keeping/disclosing the changes), then 
you split up the resulting queue. This structure made it largely 
incompatible with our queue, the diff between ktimers and ptimers was 
larger than the two patches themselves, due to the stacked changed! This 
is not a complaint - we are happy you are writing ktimer based code - 
this is just an explanation of why we couldnt take the code/patch as-is 
but had to redo that portion from scratch, based on your idea.

> I don't won't to imply any intention, but please try to see this from 
> my perspective, after this happens a number of times.

What the hell are you talking about? I bloody well know how it all 
happened, because i did those simplifications to ktime.h myself, and i 
added the changelog too, crediting you for the idea.

	Ingo
