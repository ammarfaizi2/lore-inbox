Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbVGWQag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVGWQag (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 12:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVGWQaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 12:30:35 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:7819 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262376AbVGWQaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 12:30:14 -0400
Date: Sat, 23 Jul 2005 09:30:03 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] Add schedule_timeout_{interruptible,uninterruptible}{,_msecs}() interfaces
Message-ID: <20050723163003.GB4951@us.ibm.com>
References: <20050707213138.184888000@homer> <20050708160824.10d4b606.akpm@osdl.org> <20050723002658.GA4183@us.ibm.com> <1122078715.5734.15.camel@localhost.localdomain> <Pine.LNX.4.61.0507231247460.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507231247460.3743@scrub.home>
X-Operating-System: Linux 2.6.13-rc3-mm1 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.2005 [12:50:45 +0200], Roman Zippel wrote:
> Hi,
> 
> On Fri, 22 Jul 2005, Arjan van de Ven wrote:
> 
> > Also I'd rather not add the non-msec ones... either you're raw and use
> > HZ, or you are "cooked" and use the msec variant.. I dont' see the point
> > of adding an "in the middle" one. (Yes this means that several users
> > need to be transformed to msecs but... I consider that progress ;)
> 
> What's wrong with using jiffies? It's simple and the current timeout 
> system is based on it. Calling it something else doesn't suddenly give you 
> more precision.

I agree, and for users that want a certain number of ticks (they are the
minority, in my experience), they can still use schedule_timeout() (so
maybe I should add back in the schedule_timeout_{,un}interruptible()
wrappers?

As far as precision, we *are* talking about a sleeping path, where the
concept of precision is vague at best :) Consider these functions
expressing the completeness of what msleep() and msleep_interruptible()
started, i.e. for the wait-queue case. And to be honest, we are not
changing the semantics of the schedule_timeout() family of functions.
The caller expresses their request in some units, the kenrel then does
what it can to satisfy the request, but is at liberty to be late (or
even early in these two cases).

Thanks,
Nish
