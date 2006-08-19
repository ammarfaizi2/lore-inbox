Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWHSCve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWHSCve (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 22:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWHSCve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 22:51:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62879 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751422AbWHSCvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 22:51:32 -0400
Date: Fri, 18 Aug 2006 19:44:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Phillips <phillips@google.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, riel@redhat.com, tgraf@suug.ch,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
Message-Id: <20060818194435.25bacee0.akpm@osdl.org>
In-Reply-To: <44E650C1.80608@google.com>
References: <20060808211731.GR14627@postel.suug.ch>
	<44DBED4C.6040604@redhat.com>
	<44DFA225.1020508@google.com>
	<20060813.165540.56347790.davem@davemloft.net>
	<44DFD262.5060106@google.com>
	<20060813185309.928472f9.akpm@osdl.org>
	<1155530453.5696.98.camel@twins>
	<20060813215853.0ed0e973.akpm@osdl.org>
	<44E3E964.8010602@google.com>
	<20060816225726.3622cab1.akpm@osdl.org>
	<44E5015D.80606@google.com>
	<20060817230556.7d16498e.akpm@osdl.org>
	<44E62F7F.7010901@google.com>
	<20060818153455.2a3f2bcb.akpm@osdl.org>
	<44E650C1.80608@google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006 16:44:01 -0700
Daniel Phillips <phillips@google.com> wrote:

> handwaving

- The mmap(MAP_SHARED)-the-whole-world scenario should be fixed by
  mm-tracking-shared-dirty-pages.patch.  Please test it and if you are
  still able to demonstrate deadlocks, describe how, and why they
  are occurring.

- We expect that the lots-of-dirty-anon-memory-over-swap-over-network
  scenario might still cause deadlocks.  

  I assert that this can be solved by putting swap on local disks.  Peter
  asserts that this isn't acceptable due to disk unreliability.  I point
  out that local disk reliability can be increased via MD, all goes quiet.

  A good exposition which helps us to understand whether and why a
  significant proportion of the target user base still wishes to do
  swap-over-network would be useful.

- Assuming that exposition is convincing, I would ask that you determine
  at what level of /proc/sys/vm/min_free_kbytes the swap-over-network
  deadlock is no longer demonstrable.

If there are any remaining demonstrable deadlock scenarios, please describe
how they were created and, if possible, perform some analysis of them for
us.  sysrq-T and sysrq-M traces would be helpful.

Once we have this information in hand, we will be in a better position to
work out how to solve these problems.

Thanks.
