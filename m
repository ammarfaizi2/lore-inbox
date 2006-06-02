Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWFBIfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWFBIfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWFBIe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:34:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:38007 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751329AbWFBIeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:34:50 -0400
X-IronPort-AV: i="4.05,202,1146466800"; 
   d="scan'208"; a="45891006:sNHT14518791"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "Con Kolivas" <kernel@kolivas.org>
Cc: <linux-kernel@vger.kernel.org>, "'Chris Mason'" <mason@suse.com>,
       "Ingo Molnar" <mingo@elte.hu>
Subject: RE: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 01:34:50 -0700
Message-ID: <000201c6861f$6a2d4e20$0b4ce984@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaGHpHqISt/z0r4ToeFnah5ROkbWAAAHcQQ
In-Reply-To: <447FF6B8.1000700@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Friday, June 02, 2006 1:29 AM
> Con Kolivas wrote:
> > On Friday 02 June 2006 17:53, Nick Piggin wrote:
> > 
> >>This is a small micro-optimisation / cleanup we can do after
> >>smtnice gets converted to use trylocks. Might result in a little
> >>less cacheline footprint in some cases.
> > 
> > 
> > It's only dependent_sleeper that is being converted in these patches. The 
> > wake_sleeping_dependent component still locks all runqueues and needs to 
> 
> Oh I missed that.
> 
> > succeed in order to ensure a task doesn't keep sleeping indefinitely. That 
> 
> Let's make it use trylocks as well. wake_priority_sleeper should ensure
> things don't sleep forever I think? We should be optimising for the most
> common case, and in many workloads, the runqueue does go idle frequently.
> 

Ha, you beat me by one minute. It did cross my mind to use try lock there as
well, take a look at my version, I think I have a better inner loop.

- Ken
