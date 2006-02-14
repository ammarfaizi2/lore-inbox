Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWBNFrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWBNFrh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbWBNFrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:47:37 -0500
Received: from fmr23.intel.com ([143.183.121.15]:49602 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030294AbWBNFrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:47:36 -0500
Message-Id: <200602140547.k1E5lNg19060@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <nickpiggin@yahoo.com.au>, <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch 0/2] fix perf. bug in wake-up load balancing for aim7 and db workload
Date: Mon, 13 Feb 2006 21:47:22 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYxGJFIQSeLxpczTkiETdGkKh6yfgADluWQ
In-Reply-To: <20060213193856.696bf1f0.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Monday, February 13, 2006 7:39 PM
> Post-mortem time.   Why was it merged?
> 
> This patch was added to -mm on 8 November 2006.  Was merged into mainline
> 12 January 2006.  That's two months in -mm and one month in mainline.
> 
> I don't think it's reasonable to stretch the latency of scheduler patches
> to even longer than three months and I doubt if that'll solve the problem.
> 
> Oh well, at least we found it.

I guess I'm the one to blame :-(  Our kernel performance project needs to
be more active in testing pending performance patches that sits in -mm.


> > We should back out the above commit and add a sysctl variable to control the
> > behavior of load balancing in wake up path, so user can dynamically select
> > a mode that best fit for the workload environment.  And kernel can achieve
> > best performance in two extreme ends of incompatible workload environments.
> 
> Well I don't see any benchmark numbers in the original patch.  Just an
> assertion that it "should" help something.
> 
> I'm more inclined to revert it and not add the sysctl (ugh) until we have a
> good reason to do so.

The discussion on wake-up load balancing started July 28 last year [1].
In that post, it was outlined that the performance patch gave 2.3% gain
for db transaction processing workload.  It was then followed up by a
couple of iterations, including one from Ingo[2] and one from Nick[3].

I think we just demonstrated that there are two workloads exist today
which has completely opposite requirement on load balancing in the
wake up path.  People has tried to make kernel smart and detect work-
load environment, but so far it hasn't worked.  And hence the sysctl
that I'm proposing right now.


[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=112259224917701&w=2
[2] http://marc.theaimsgroup.com/?l=linux-kernel&m=112265450426975&w=2
[3] http://marc.theaimsgroup.com/?l=linux-kernel&m=113051195601837&w=2

