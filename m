Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWJBLBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWJBLBI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 07:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWJBLBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 07:01:08 -0400
Received: from rs384.securehostserver.com ([72.22.69.69]:35337 "HELO
	rs384.securehostserver.com") by vger.kernel.org with SMTP
	id S1750801AbWJBLAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 07:00:55 -0400
Subject: Re: [RFC][PATCH 0/2] Swap token re-tuned
From: Ashwin Chaugule <ashwin.chaugule@celunite.com>
Reply-To: ashwin.chaugule@celunite.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>
In-Reply-To: <1159774552.13651.80.camel@lappy>
References: <1159555312.2141.13.camel@localhost.localdomain>
	 <20061001155608.0a464d4c.akpm@osdl.org>  <1159774552.13651.80.camel@lappy>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 16:30:07 +0530
Message-Id: <1159786807.5574.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 09:35 +0200, Peter Zijlstra wrote:

> Being frustrated with these results - I mean the idea made sense, so
> what is going on - I came up with this answer:
> 
> Tasks owning the swap token will retain their pages and will hence swap
> less, other (contending) tasks will get less pages and will fault more
> frequent. This prio mechanism will favour exactly those tasks not
> holding the token. Which makes for token bouncing.
> 
Right. But, with the token bouncing around, effectively the RSS of the
processes at that time will keep increasing, and they should be able to
spend more time on execution than i/o. And meanwhile the priorities of
the tasks that were contending for the token, but didnt get it, will
increment. So since the fairness is preserved, all the tasks should get
their fair share for execution and it should result in a speedup as
compared to the current upstream implementation. I took a time
instrumentation of the vanilla 2.6.18 kernel build with -j 4 and I've
posted up the results in the previous mail. I'm testing on an ibm t42
1.69Ghz 64M system.

> So while I agree it would be nice to get rid of all magic variables
> (holding time in the current impl) this proposed solution hasn't
> convinced me (for one it introduces another).
> 
> (for the interrested, the various attempts I tried are available here:
>   http://programming.kicks-ass.net/kernel-patches/swap_token/ )

Cool!

Had you applied these patches when you posted your test results ?


Thanks
Ashwin


