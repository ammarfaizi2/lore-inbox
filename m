Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263506AbTDWUSV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 16:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbTDWUSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 16:18:21 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:43185 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263506AbTDWUSU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 16:18:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] HT scheduler, sched-2.5.68-B2
Date: Wed, 23 Apr 2003 15:14:44 -0500
User-Agent: KMail/1.4.3
References: <Pine.LNX.4.44.0304231816210.10779-100000@localhost.localdomain> <200304231253.09520.habanero@us.ibm.com> <1538380000.1051123399@flay>
In-Reply-To: <1538380000.1051123399@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304231514.44451.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 April 2003 13:43, Martin J. Bligh wrote:
> >> >  - turn off the more agressive idle-steal variant. This could fix the
> >> >    low-load regression reported by Martin J. Bligh.
> >>
> >> Yup, that fixed it (I tested just your first version with just that
> >> bit altered).
> >
> > Can we make this an arch specific option?  I have a feeling the HT
> > performance on low loads will actually drop with this disabled.
>
> Is it really an arch thing? Or is it a load level thing? I get the feeling
> it might be switchable dynamically, dependant on load ...

Well on high load, you shouldn't have an idle cpu anyway, so you would never 
pass the requirements for the agressive -idle- steal even if it was turned 
on.   On low loads on HT, without this agressive balance on cpu bound tasks, 
you will always load up one core before using any of the others.  When you 
fork/exec, the child will start on the same runqueue as the parent, the idle 
sibling will start running it, and it will never get a chance to balance 
properly while it's in a run state.  This is the same behavior I saw with the 
NUMA-HT solution, because I didn't have this agressive balance (although it 
could be added I suppose), and as a result it consistently performed less 
than Ingo's solution (but still better than no patch at all).

-Andrew Theurer
