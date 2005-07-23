Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVGWQnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVGWQnM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 12:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVGWQnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 12:43:12 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:48513 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261529AbVGWQnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 12:43:10 -0400
Date: Sat, 23 Jul 2005 09:43:10 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] Add schedule_timeout_{interruptible,uninterruptible}{,_msecs}() interfaces
Message-ID: <20050723164310.GD4951@us.ibm.com>
References: <20050707213138.184888000@homer> <20050708160824.10d4b606.akpm@osdl.org> <20050723002658.GA4183@us.ibm.com> <1122078715.5734.15.camel@localhost.localdomain> <Pine.LNX.4.61.0507231247460.3743@scrub.home> <1122116986.3582.7.camel@localhost.localdomain> <Pine.LNX.4.61.0507231340070.3743@scrub.home> <1122123085.3582.13.camel@localhost.localdomain> <Pine.LNX.4.61.0507231456000.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507231456000.3728@scrub.home>
X-Operating-System: Linux 2.6.13-rc3-mm1 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.2005 [15:04:44 +0200], Roman Zippel wrote:
> Hi,
> 
> On Sat, 23 Jul 2005, Arjan van de Ven wrote:
> 
> > > > > What's wrong with using jiffies? 
> > > > 
> > > > A lot of the (driver) users want a wallclock based timeout. For that,
> > > > miliseconds is a more obvious API with less chance to get the jiffies/HZ
> > > > conversion wrong by the driver writer.
> > > 
> > > We have helper functions for that.
> > 
> > I think we just disagree then... I consider this one a helper function
> > as well, one with a simpler API that wraps the more complex and powerful
> > api.
> 
> How is it more powerful? The next step in introducing such API is that 
> people start complaining, they don't get ms precision, which of course is 
> fixed by the next patch, with then results in that the whole timer system 
> becomes more complex for a few misguided users.

Do people complain about not getting jiffy precision? I think the whole
idea of discussing precision in this particular sleeping path is
ludicrous. Some users of this are requesting up to 100s of millisecond
delays!

And, please, don't confuse this patch with my other work. The soft-timer
rework was an RFC, meaning I was hoping to start a discussion and get
some comments. I got comments from you and others, which I greatly
appreciate. But, I think you interpret that patch as being a final
version, which is ready for mainline. It very explicitly is not. I am
intent on dealing with your issues (perhaps moving to usecs...), but
this patch has nothing to do with that. It has everything to do with my
experience replacing caller after caller of schedule_timeout() and a
request from Andrew for a compact interface (the milliseconds were
admittedly my idea, but he hasn't said no to that yet :) ).

> Keep the thing as simple as possible and jiffies _are_ simple. Please show 
> me the problem, that needs to be fixed.

I am not sure why jiffies are any simpler than milliseconds. In the
millisecond case, conversion happens in common code and only needs to be
audited once. In the jiffies case, I have to check *every* caller to see
if they are doing stupid math :)

Thanks,
Nish
