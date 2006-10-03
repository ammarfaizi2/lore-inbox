Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbWJDAcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWJDAcG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbWJDAcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:32:05 -0400
Received: from mga07.intel.com ([143.182.124.22]:29887 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161002AbWJDAcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:32:03 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,252,1157353200"; 
   d="scan'208"; a="126528432:sNHT136468997"
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Andrew Morton <akpm@osdl.org>
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       leonid.i.ananiev@intel.com
In-Reply-To: <20061003170705.6a75f4dd.akpm@osdl.org>
References: <1159916644.8035.35.camel@localhost.localdomain>
	 <20061003170705.6a75f4dd.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel
Date: Tue, 03 Oct 2006 16:42:56 -0700
Message-Id: <1159918976.8035.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 17:07 -0700, Andrew Morton wrote:

> > 
> > introduced 40% more 2nd level cache miss to tbench workload
> > being run in a loop back mode on a Core 2 machine.  I think the
> > introduction of the local variables to WARN_ON and WARN_ON_ONCE
> > 
> > typeof(x) __ret_warn_on = (x);
> > typeof(condition) __ret_warn_once = (condition);
> > 
> > results in the extra cache misses.
> 
> I don't see why it should.
> 

Before the WARN_ON/WARN_ON_ONCE patch, the condition given to
WARN_ON/WARN_ON_ONCE is evaluated once and that's it.  But after the
patch, the condition is stored in a variable and returned later.  I
think that accessing this variable causes cache misses.

> Perhaps the `static int __warn_once' is getting put in the same cacheline
> as some frequently-modified thing.   Perhaps try marking that as __read_mostly?
> 

I'll give that a try to see if it will improve things.

Tim
