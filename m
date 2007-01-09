Return-Path: <linux-kernel-owner+w=401wt.eu-S1751044AbXAIFE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbXAIFE1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 00:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbXAIFE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 00:04:27 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:34082 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbXAIFE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 00:04:26 -0500
Date: Tue, 9 Jan 2007 10:34:17 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070109050417.GC589@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20070104091850.c1feee76.akpm@osdl.org> <20070106151036.GA951@tv-sign.ru> <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106111117.54bb2307.akpm@osdl.org> <20070107110013.GD13579@in.ibm.com> <20070107115957.6080aa08.akpm@osdl.org> <20070107210139.GA2332@tv-sign.ru> <20070108155428.d76f3b73.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108155428.d76f3b73.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 03:54:28PM -0800, Andrew Morton wrote:
> Furthermore I don't know which of these need to be tossed overboard if/when
> we get around to using the task freezer for CPU hotplug synchronisation.
> Hopefully, a lot of them.  I don't really understand why we're continuing
> to struggle with the existing approach before that question is settled.

Good point!

Fundamentally, I think we need to answer this question:

"Do we provide *some* mechanism to block concurrent hotplug operations
from happening? By hotplug operations I mean both changes to the bitmap
and execution of all baclbacks in CPU_DEAD/ONLINE etc"

If NO, then IMHO we will be forever fixing races

If YES, then what is that mechanism? freeze_processes()? or a magical
lock?

freeze_processes() cant be that mechanism, if my understanding of it is
correct - see http://lkml.org/lkml/2007/1/8/149 and 
http://marc.theaimsgroup.com/?l=linux-kernel&m=116817460726058.

I would be happy to be corrected if the above impression of
freeze_processes() is corrected ..

-- 
Regards,
vatsa
