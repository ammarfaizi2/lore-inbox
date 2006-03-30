Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWC3Enw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWC3Enw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 23:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWC3Enw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 23:43:52 -0500
Received: from mx2.netapp.com ([216.240.18.37]:18556 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1750763AbWC3Env (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 23:43:51 -0500
X-IronPort-AV: i="4.03,145,1141632000"; 
   d="scan'208"; a="370954376:sNHT209210640"
Subject: Re: fs/locks.c: Fix sys_flock() race
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060329164125.04c66c6b.akpm@osdl.org>
References: <1143651308.8697.10.camel@lade.trondhjem.org>
	 <20060329164125.04c66c6b.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance, Inc
Date: Wed, 29 Mar 2006 23:43:49 -0500
Message-Id: <1143693829.7914.13.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-OriginalArrivalTime: 30 Mar 2006 04:43:50.0291 (UTC) FILETIME=[8A1B6E30:01C653B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-29 at 16:41 -0800, Andrew Morton wrote:

> hm, you've extended lock_kernel() coverage (why?  Does this help fix the
> race??) but we still have a cond_resched() inside the now-newly-locked
> region.  If that cond_resched() drops the bkl, is the race reopened?

No. The race fix is not dependent on the extension in BKL coverage. I
removed the unlock_kernel()/lock_kernel() pair simply because they are
redundant: the locks_alloc_lock() and cond_resched() will automatically
release the BKL for you.

Might as well save a couple of bytes.

Cheers,
  Trond
