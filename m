Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268824AbUJEGKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268824AbUJEGKs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 02:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268831AbUJEGKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 02:10:48 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:37016 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268824AbUJEGKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 02:10:47 -0400
Message-ID: <41623AE1.2010202@yahoo.com.au>
Date: Tue, 05 Oct 2004 16:10:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: bug in sched.c:activate_task()
References: <200410050216.i952Gb620657@unix-os.sc.intel.com>
In-Reply-To: <200410050216.i952Gb620657@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Update p->timestamp to "now" in activate_task() doesn't look right
> to me at all.  p->timestamp records last time it was running on a
> cpu.  activate_task shouldn't update that variable when it queues
> a task on the runqueue.
> 
> This bug (and combined with others) triggers improper load balancing.
> 
> Patch against linux-2.6.9-rc3.  Didn't diff it against 2.6.9-rc3-mm2
> because mm tree has so many change in sched.c.
> 
> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
> 

Actually, now that I have the code in front of me, I was wrong
and this patch is right.

This timestamp is never used for anything, so the assignment is
pointless.
