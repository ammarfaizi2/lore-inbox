Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbTAUBAn>; Mon, 20 Jan 2003 20:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbTAUBAn>; Mon, 20 Jan 2003 20:00:43 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:8668 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265475AbTAUBAm>;
	Mon, 20 Jan 2003 20:00:42 -0500
Subject: Re: [patch] HT scheduler, sched-2.5.59-D7
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>, mingo@elte.hu
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Theurer <habanero@us.ibm.com>, Erich Focht <efocht@ess.nec.de>,
       Matthew Dobson <colpatch@us.ibm.com>, hch@infradead.org, rml@tech9.net,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, anton@samba.org, andrea@suse.de
In-Reply-To: <20030120142827.68c87059.akpm@digeo.com>
References: <264880000.1043092340@flay>
	<Pine.LNX.4.44.0301202204210.18235-100000@localhost.localdomain> 
	<20030120142827.68c87059.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Jan 2003 17:11:32 -0800
Message-Id: <1043111495.4747.567.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-20 at 14:28, Andrew Morton wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > 
> > the attached patch (against 2.5.59) is my current scheduler tree, it
> > includes two main areas of changes:
> > 
> >  - interactivity improvements, mostly reworked bits from Andrea's tree and 
> >    various tunings.
> > 
> 
> Thanks for doing this.  Initial testing with one workload which is extremely
> bad with 2.5.59: huge improvement.
> 
Initial testing on my NUMA box looks good.  So far, I only have
kernbench numbers, but the system time shows a nice decrease,
and the CPU % busy time has gone up.  

Kernbench:
                        Elapsed       User     System        CPU
           ingoD7-59    28.944s   285.008s    79.998s    1260.8%
             stock59    29.668s   283.762s    82.286s      1233%

I'll try to get more testing in over the next few days.

There was one minor build error introduced by the patch:

#define NODE_THRESHOLD          125

was removed, but the NUMA code uses this.

-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

