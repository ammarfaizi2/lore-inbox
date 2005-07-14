Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263047AbVGNPDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263047AbVGNPDg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 11:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbVGNPDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 11:03:36 -0400
Received: from graphe.net ([209.204.138.32]:43915 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263047AbVGNPC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 11:02:59 -0400
Date: Thu, 14 Jul 2005 08:02:21 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       vojtech@suse.cz, david.lang@digitalinsight.com, davidsen@tmr.com,
       kernel@kolivas.org, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <1121352941.4535.15.camel@mindpipe>
Message-ID: <Pine.LNX.4.62.0507140757200.31521@graphe.net>
References: <1121282025.4435.70.camel@mindpipe>  <d120d50005071312322b5d4bff@mail.gmail.com>
  <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
  <20050713211650.GA12127@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> 
 <20050714005106.GA16085@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> 
 <1121304825.4435.126.camel@mindpipe>  <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
  <20050714083843.GA4851@elte.hu> <1121352941.4535.15.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2005, Lee Revell wrote:

> On Thu, 2005-07-14 at 10:38 +0200, Ingo Molnar wrote:
> >  - there are real-time applications (robotic environments: fast rotating
> >    tools, media and mobile/phone applications, etc.) that want 10
> >    usecs precision. If such users increased HZ to 100,000 or even
> >    1000,000, the current timer implementation would start to creek: e.g.
> >    jiffies on 32-bit systems would wrap around in 11 hours or 1.1 hours.
> >    (To solve this cleanly, pretty much the only solution seems to be to
> >    increase the timeout to a 64 bit value. A non-issue for 64-bit
> >    systems, that's why i think we could eventually look at this 
> >    possibility, once all the other problems are hashed out.)
> > 
> 
> Those types of systems will not be 64 bit for many, many years, if
> ever...

Linux can already provide a response time within < 3 usecs from user space 
using f.e. the Altix RTC driver which can generate an interrupt that then 
sends a signal to an application. The Altix RTC clock is supported via POSIX
timer syscalls and can be accessed using CLOCK_SGI_CYCLE. This has been 
available in Linux since last fall and events can be specified with 50 
nanoseconds accurary.

Other clock sources like  HPET could do the same if someone would be 
willing to provide the hookup to the posix layer.

I doubt that increasing the timer frequency is the way to go to solve 
these issues. HZ should be as low as possible and we should strive for a 
tickless system.
