Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVHVX2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVHVX2O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbVHVX2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:28:14 -0400
Received: from fmr22.intel.com ([143.183.121.14]:16105 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751242AbVHVX2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:28:12 -0400
Date: Mon, 22 Aug 2005 16:27:28 -0700
From: tony.luck@intel.com
Message-Id: <200508222327.j7MNRSBR020922@agluck-lia64.sc.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davem@davemloft.net, jasonuhl@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PRINTK_TIME woes
In-Reply-To: <20050822153838.186ac336.akpm@osdl.org>
References: <200508221742.j7MHgMJI020020@agluck-lia64.sc.intel.com>
	<20050822.132052.65406121.davem@davemloft.net>
	<20050822203306.GA897956@dragonfly.engr.sgi.com>
	<20050822.134226.35468933.davem@davemloft.net>
	<200508222233.j7MMXGWj020872@agluck-lia64.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Ah, thanks.  Presumably it'll be considerably longer with %d's and %s's in
>there.  But still, ~10 usecs is good resolution for I/O operations.

The variation in times from one call to the next seems to be
greater than the time to evaluate 4 "%d" arguments.

So we are back to how to get a timestamp in printk().

Earlier I said that it would be possible to provide a simplified
do_gettimeofday() call that met the no locks requirement.  I still
think this is possible, but most architectures would only get
jiffie resolution from this (only ia64, sparc64 and HPET users
have time interpolators registered).

-Tony
