Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263090AbVD3Adl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbVD3Adl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 20:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263092AbVD3Adl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 20:33:41 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:49651 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263090AbVD3AdT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 20:33:19 -0400
Subject: Re: [RFC][PATCH (1/4)] new timeofday core subsystem (v A4)
From: john stultz <johnstul@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: lkml <linux-kernel@vger.kernel.org>, albert@users.sourceforge.net,
       Paul Mackerras <paulus@samba.org>, schwidefsky@de.ibm.com,
       mahuja@us.ibm.com, donf@us.ibm.com, mpm@selenic.com
In-Reply-To: <1114818605.7182.299.camel@gaston>
References: <1114814747.28231.2.camel@cog.beaverton.ibm.com>
	 <1114818605.7182.299.camel@gaston>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 17:33:09 -0700
Message-Id: <1114821189.28616.5.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-30 at 09:50 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2005-04-29 at 15:45 -0700, john stultz wrote:
> > All,
> >         This patch implements the architecture independent portion of
> > the time of day subsystem. For a brief description on the rework, see
> > here: http://lwn.net/Articles/120850/ (Many thanks to the LWN team for
> > that clear writeup!)
> > 
> > Mostly this version is just a cleanup of the last release. One neat
> > feature is the new sysfs interface which allows you to manually override
> > the selected timesource while the system is running. 
> > 
> > Included below is timeofday.c (which includes all the time of day
> > management and accessor functions), ntp.c (which includes the ntp
> > scaling calculation code, leapsecond processing, and ntp kernel state
> > machine code), timesource.c (for timesource specific management
> > functions), interface definition .h files, the example jiffies
> > timesource (lowest common denominator time source, mainly for use as
> > example code) and minimal hooks into arch independent code.
> > 
> > The patch does not function without minimal architecture specific hooks
> > (i386, x86-64, ppc32, ppc64, ia64 and s390 examples to follow), and it
> > should be able to be applied to a tree without affecting the code.
> 
> My concern at this point is how to deal with the userland gettimofday
> implementation in the ppc64 vDSO ...

Hopefully in a method very similar to the way the vsyscall patch does
for i386/x86-64. The idea being that the core code makes an arch
specific call passing the core timekeeping values whenever they are
changed. Then the arch specific implementation can use those values in a
similar fashion to calculate time.

I'm not very familiar with ppc64's vDSO implementation, so please let me
know if there is a constraint that would make this difficult.

thanks
-john


