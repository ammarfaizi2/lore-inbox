Return-Path: <linux-kernel-owner+w=401wt.eu-S1751419AbXAFPpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbXAFPpQ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 10:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbXAFPpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 10:45:16 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:42929 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbXAFPpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 10:45:15 -0500
Date: Sat, 6 Jan 2007 21:15:06 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070106154506.GC24274@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061217223416.GA6872@tv-sign.ru> <20061218162701.a3b5bfda.akpm@osdl.org> <20061219004319.GA821@tv-sign.ru> <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070106151036.GA951@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070106151036.GA951@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 06:10:36PM +0300, Oleg Nesterov wrote:
> Increment hotplug_sequence earlier, under CPU_DOWN_PREPARE. We can't
> miss the event, the task running flush_workqueue() will be re-scheduled
> at least once before CPU actually disappears from cpu_online_map.

Eww ..what happens if flush_workqueue() starts after CPU_DOWN_PREPARE?

CPU_DOWN_PREPARE(8)
	hotplug_sequence++ = 10

					flush_workqueue()
						sequence = 10
						flush cpus 1 ....7

CPU_DEAD(8)
	take_over_work(8->1)

					return not flushing dead cpu8 (=BUG)


??
 
-- 
Regards,
vatsa
