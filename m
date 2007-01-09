Return-Path: <linux-kernel-owner+w=401wt.eu-S1750871AbXAIBMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbXAIBMa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 20:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbXAIBMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 20:12:30 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:50101 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbXAIBM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 20:12:29 -0500
Date: Tue, 9 Jan 2007 06:41:06 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Oleg Nesterov" <oleg@tv-sign.ru>, "Andrew Morton" <akpm@osdl.org>,
       "David Howells" <dhowells@redhat.com>,
       "Christoph Hellwig" <hch@infradead.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Linus Torvalds" <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Gautham shenoy" <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070109011106.GD31263@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20070108170635.GA448@tv-sign.ru> <EB12A50964762B4D8111D55B764A845401169937@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EB12A50964762B4D8111D55B764A845401169937@scsmsx413.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 10:37:25AM -0800, Pallipadi, Venkatesh wrote:
> One other approach I was thinking about, was to do all the hardwork in
> workqueue CPU_DOWN_PREPARE callback rather than in CPU_DEAD.

Between DOWN_PREPARE and DEAD, more work can get added to the cpu's
workqueue. So DOWN_PREPARE is kind of early to take_over_work ..

> We can call cleanup_workqueue_thread and take_over_work in DOWN_PREPARE,
> With that, I don't think we need to hold the workqueue_mutex across 
> these two callbacks and eliminate the deadlocks related to
> flush_workqueue.
> Do you think this approach would simply things around here?

-- 
Regards,
vatsa
