Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbVCPD5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbVCPD5V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 22:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVCPD5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 22:57:20 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:63203 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262488AbVCPD5Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 22:57:16 -0500
Subject: Re: [topic change] jiffies as a time value
From: john stultz <johnstul@us.ibm.com>
To: George Anzinger <george@mvista.com>
Cc: Matt Mackall <mpm@selenic.com>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
In-Reply-To: <4237693A.30300@mvista.com>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
	 <20050313004902.GD3163@waste.org>
	 <1110825765.30498.370.camel@cog.beaverton.ibm.com>
	 <423620EA.3040205@mvista.com>
	 <1110849062.30498.450.camel@cog.beaverton.ibm.com>
	 <4237693A.30300@mvista.com>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 19:57:09 -0800
Message-Id: <1110945429.30498.576.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George,
	I'm still digesting your mail. For now I'll just answer the easy bits,
and I'll owe you a better reply once I get all of this absorbed. 

On Tue, 2005-03-15 at 15:01 -0800, George Anzinger wrote:
> We also need, IMNSHO to recognize that, at lest with some hardware, that 
> interrupt IS in fact the clock and is the only reasonable way we have of reading 
> it.  This is true, for example, on the x86.  The TSC we use as a fill in for 
> between interrupts is not stable in the long term and should only be used to 
> interpolate over 1 to 10 ticks or so.

Yep, the TSC is a terrible time source, but everyone still loves it! Its
so fast! However since every timesource isn't so bad, I don't feel we
need to punish everyone with the bugs interpolation can cause. 

So my plan is an "interpolated timesource", which will fit into my
current framework without any changes. Basically it will work as the
current tsc/tick code does, but just in its own timesource driver, so
the core code stays pretty and sane. It will still preserve some of the
issues we see now with the interpolated time code, but since we're in a
more flexible environment, we might be able more easily try new
workarounds.

thanks
-john

