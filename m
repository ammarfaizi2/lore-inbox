Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWBAAxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWBAAxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 19:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWBAAxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 19:53:20 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:52200 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751259AbWBAAxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 19:53:19 -0500
Date: Tue, 31 Jan 2006 19:50:17 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: boot-time slowdown for measure_migration_cost
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Ingo Molnar <mingo@elte.hu>,
       linux-ia64 <linux-ia64@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Message-ID: <200601311952_MC3-1-B742-9F59@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060130200026.GA5081@agluck-lia64.sc.intel.com>

On Mon, 30 Jan 2006, Tony Luck wrote:

> Might it be wise to see whether the 2% variation that I saw can be
> repeated on some other architecture?  Bjorn's initial post was just
> questioning whether we need to spend this much time during boot to acquire
> this data.  Now we have *one* data point that on an ia64 with four cpus
> with 9MB cache in a single domain that we can speed the calculation by
> a factor of three with only a 2% loss of accuracy.  Can someone else try
> this patch and post the before/after values for migration_cost from dmesg?

Before:

messages.1:Jan 24 01:19:45 d2 kernel: [    6.377117] migration_cost=9352
messages.1:Jan 27 21:07:55 d2 kernel: [    6.384871] migration_cost=9329
messages.1:Jan 28 11:00:32 d2 kernel: [    6.384215] migration_cost=9338
messages.1:Jan 28 12:55:03 d2 kernel: [    6.389189] migration_cost=9364


After:

messages:Jan 31 07:55:07 d2 kernel: [    1.859359] migration_cost=9274


This was on a dual PII Xeon with 2MB L2 cache.  About 3.5x as fast and
only 1% change.

Maybe the default could be to run the quick test with an option to run the
more-accurate one?

-- 
Chuck
