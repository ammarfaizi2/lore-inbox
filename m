Return-Path: <linux-kernel-owner+w=401wt.eu-S1751799AbXAOEdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbXAOEdP (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 23:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbXAOEdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 23:33:15 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:44282 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbXAOEdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 23:33:14 -0500
Date: Mon, 15 Jan 2007 10:03:04 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070115043304.GA16435@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20070107210139.GA2332@tv-sign.ru> <20070108155428.d76f3b73.akpm@osdl.org> <20070109050417.GC589@in.ibm.com> <20070108212656.ca77a3ba.akpm@osdl.org> <20070109150755.GB89@tv-sign.ru> <20070109155908.GD22080@in.ibm.com> <20070109163815.GA208@tv-sign.ru> <20070109164604.GA17915@in.ibm.com> <20070109165655.GA215@tv-sign.ru> <20070114235410.GA6165@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070114235410.GA6165@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 02:54:10AM +0300, Oleg Nesterov wrote:
> How about the pseudo-code below?

Some quick comments:

- singlethread_cpu needs to be hotplug safe (broken currently)

- Any reason why cpu_populated_map is not modified on CPU_DEAD?

- I feel more comfortable if workqueue_cpu_callback were to take
  workqueue_mutex in LOCK_ACQ and release it in LOCK_RELEASE 
  notifications. This will provide stable access to cpu_populated_map
  to functions like __create_workqueue.

Finally, I wonder if these changes will be unnecessary if we move to
process freezer based hotplug locking ...

-- 
Regards,
vatsa
