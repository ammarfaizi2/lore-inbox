Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424367AbWKJGSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424367AbWKJGSS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 01:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966098AbWKJGSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 01:18:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:13699 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S966097AbWKJGSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 01:18:17 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,408,1157353200"; 
   d="scan'208"; a="14113802:sNHT17221392"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "Ingo Molnar" <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>, <akpm@osdl.org>,
       <mm-commits@vger.kernel.org>, <nickpiggin@yahoo.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: RE: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
Date: Thu, 9 Nov 2006 22:18:13 -0800
Message-ID: <000001c70490$01cea4b0$8bc8180a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccCtq36ugzbGGuGQuSrjfJoHyRsNwB13Xdw
In-Reply-To: <Pine.LNX.4.64.0611071339001.5893@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Tuesday, November 07, 2006 1:50 PM
> On Tue, 7 Nov 2006, Chen, Kenneth W wrote:
> > > What broke the system was the disabling of interrupts over long time 
> > > periods during load balancing.
> > The previous global load balancing tasket could be an interesting data point.
> 
> Yup seems also very interesting to me. We could drop the staggering code 
> f.e. if we would leave the patch as is. Maybe there are other ways to 
> optimize the code because we know that there are no concurrent 
> balance_tick() functions running.
> 
> > Do you see a lot of imbalance in the system with the global tasket?  Does it
> > take prolonged interval to reach balanced system from imbalance?
> 
> I am rather surprised that I did not see any problems but I think we would 
> need some more testing. It seems that having only one load balance 
> running at one time speeds up load balacing in general since there is 
> less lock contention.


I ran majority of micro-benchmarks from LKP project with global load
balance tasklet. (http://kernel-perf.sourceforge.net)

Result is here:
http://kernel-perf.sourceforge.net/sched/global-load-bal.txt

All results are within noise range.  The global tasklet does a fairly good job especially on context switch intensive workload like
aim7, volanomark, tbench
etc.  Note all machines are non-numa platform.

Base on the data, I think we should make the load balance tasklet one per numa
node instead of one per CPU.

- Ken
