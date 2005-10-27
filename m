Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbVJ0Bwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbVJ0Bwk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 21:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbVJ0Bwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 21:52:40 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:45515 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932623AbVJ0Bwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 21:52:39 -0400
Subject: Re: 2.6.14-rc4-rt7
From: john stultz <johnstul@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: William Weston <weston@lysdexia.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       george@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU
In-Reply-To: <1130377056.21118.102.camel@localhost.localdomain>
References: <1129852531.5227.4.camel@cmn3.stanford.edu>
	 <20051021080504.GA5088@elte.hu> <1129937138.5001.4.camel@cmn3.stanford.edu>
	 <20051022035851.GC12751@elte.hu>
	 <1130182121.4983.7.camel@cmn3.stanford.edu>
	 <1130182717.4637.2.camel@cmn3.stanford.edu>
	 <1130183199.27168.296.camel@cog.beaverton.ibm.com>
	 <20051025154440.GA12149@elte.hu>
	 <1130264218.27168.320.camel@cog.beaverton.ibm.com>
	 <435E91AA.7080900@mvista.com> <20051026082800.GB28660@elte.hu>
	 <435FA8BD.4050105@mvista.com> <435FBA34.5040000@mvista.com>
	 <435FEAE7.8090104@rncbc.org>
	 <Pine.LNX.4.58.0510261449310.20155@echo.lysdexia.org>
	 <1130371042.21118.76.camel@localhost.localdomain>
	 <1130373953.27168.370.camel@cog.beaverton.ibm.com>
	 <1130375244.21118.91.camel@localhost.localdomain>
	 <1130376147.27168.381.camel@cog.beaverton.ibm.com>
	 <1130377056.21118.102.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 26 Oct 2005 18:52:27 -0700
Message-Id: <1130377947.27168.392.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 21:37 -0400, Steven Rostedt wrote:
> On Wed, 2005-10-26 at 18:22 -0700, john stultz wrote:
> 
> > 
> > I don't know if that would really fix it, because ideally you want to
> > read the prev_mono_time at the same point you calculate the time inside
> > the read lock'ed critical section.
> 
> Ideally yes, but this is just for debugging, so as long as prev is read
> before now, this should prevent false positives due to ordering.  

Ah, you're right, good point! I was being overly paranoid.

So as long as the writing of the 64bit value is atomic (which it isn't,
but that can be fixed) there shouldn't be ordering problems w/ your
patch. 

And sure enough, it seems to take care of the warnings on my box.

Great debugging job!
-john

