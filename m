Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269540AbUJLIzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269540AbUJLIzX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 04:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269547AbUJLIzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 04:55:22 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:38038 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S269540AbUJLIyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 04:54:15 -0400
Date: Tue, 12 Oct 2004 10:50:28 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Matthew Dobson <colpatch@us.ibm.com>
cc: Paul Jackson <pj@sgi.com>, Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Simon.Derr@bull.net,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
In-Reply-To: <1097532415.4038.50.camel@arrakis>
Message-ID: <Pine.LNX.4.61.0410121008540.12035@openx3.frec.bull.fr>
References: <20041007072842.2bafc320.pj@sgi.com> 
 <200410071905.i97J57TS014336@owlet.beaverton.ibm.com>  <20041009191556.06e09c67.pj@sgi.com>
 <1097532415.4038.50.camel@arrakis>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1216282016-196811267-1097569724=:12035"
Content-ID: <Pine.LNX.4.61.0410121029000.12035@openx3.frec.bull.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1216282016-196811267-1097569724=:12035
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-ID: <Pine.LNX.4.61.0410121029001.12035@openx3.frec.bull.fr>
Content-Transfer-Encoding: 8BIT

> One of the cool thing about using sched_domains as your partitioning
> element is that in reality, tasks run on *CPUs*, not *domains*.  So if
> you have threads 'a1' & 'a2' running on CPUs 0 & 1 (small job 'a') and
> threads 'b1' & 'b2' running on CPUs 2 & 3 (small job 'b'), you can
> suspend threads a1, a2, b1 & b2 and remove the domains they were running
> in to allow job A (big job with threads A1, A2, A3, & A4) to run on the
> larger 4 CPU domain.  When you then suspend A1-A4 again to allow the
> smaller jobs to proceed, you can pretty trivially create the 2 CPU
> domains underneath the 4 CPU domain and resume the jobs.  Those jobs (a
> & b) have been suspended on the CPUs they were originally running on,
> and thus will resume on the same CPUs without any extra effort.  They
> will simply run on those CPUs, and at load balance time, the domains
> attached to those CPUs will be consulted to determine where the tasks
> can be relocated to if there is a heavy load.  The domains will tell the
> scheduler that the tasks cannot be relocated outside the 2 CPUs in each
> respective domain.  Viola!  (sorta ;)
Voilà ;-)

I agree that this looks really smooth from a scheduler point of view.

>From a user point of view, remains the issue of suspending the tasks:
-find which tasks to suspend : how do you know that job 'a' consists 
exactly of 'a1' and 'a2'
-suspend them (btw, how do you achieve this ? kill -STOP ?)


I've been away from my mail and still trying to catch up, nevermind if the 
above does not makes sense to you.

	Simon.

---1216282016-196811267-1097569724=:12035--
