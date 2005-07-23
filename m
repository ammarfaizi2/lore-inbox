Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVGWTL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVGWTL0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 15:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVGWTL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 15:11:26 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:46559 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261258AbVGWTLY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 15:11:24 -0400
Date: Sat, 23 Jul 2005 12:10:04 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] Add schedule_timeout_{interruptible,uninterruptible}{,_msecs}() interfaces
Message-ID: <20050723191004.GB4345@us.ibm.com>
References: <20050708160824.10d4b606.akpm@osdl.org> <20050723002658.GA4183@us.ibm.com> <1122078715.5734.15.camel@localhost.localdomain> <Pine.LNX.4.61.0507231247460.3743@scrub.home> <1122116986.3582.7.camel@localhost.localdomain> <Pine.LNX.4.61.0507231340070.3743@scrub.home> <1122123085.3582.13.camel@localhost.localdomain> <Pine.LNX.4.61.0507231456000.3728@scrub.home> <20050723164310.GD4951@us.ibm.com> <Pine.LNX.4.61.0507231911540.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507231911540.3743@scrub.home>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.2005 [19:17:37 +0200], Roman Zippel wrote:
> Hi,
> 
> On Sat, 23 Jul 2005, Nishanth Aravamudan wrote:
> 
> > > Keep the thing as simple as possible and jiffies _are_ simple. Please show 
> > > me the problem, that needs to be fixed.
> > 
> > I am not sure why jiffies are any simpler than milliseconds. In the
> > millisecond case, conversion happens in common code and only needs to be
> > audited once. In the jiffies case, I have to check *every* caller to see
> > if they are doing stupid math :)
> 
> Jiffies are the basic time unit for kernel timers, hiding that fact gives 
> users only wrong expectations about them.

We already have msleep() and msleep_interruptible(), which hide jiffies
in milliseconds. These interfaces are their parallel in the wait-queue
case. If you don't want to use them, or their use is not appropriate,
then the callers won't be changed.

> I don't mind using helper functions, but constant conversion can already 
> happen at compile time and for variable timeouts the user should seriously 
> consider using jiffies directly instead of constantly converting time 
> values.

My goal is to distinguish between these cases in sleeping-logic:

1) tick-oriented
	use schedule_timeout(), add_timer(), etc.

2) time-oriented
	use schedule_timeout_msecs()

I am not going to run some global sed script to change the whole kernel.
I may not always be successful, but I do try to be cautious in my
patches. Only those callers that can benefit from using a millisecond
interface will be changed.

Another question (actually the same question expressed again), do Andrew
or Arjan think I should reinsert the
schedule_timeout_{,un}interruptible() functions for the 1) case above?

Thanks,
Nish
