Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbVDLRSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbVDLRSc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 13:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVDLRRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 13:17:42 -0400
Received: from palrel13.hp.com ([156.153.255.238]:28632 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262508AbVDLROQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 13:14:16 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16988.477.530205.502023@napali.hpl.hp.com>
Date: Tue, 12 Apr 2005 10:14:05 -0700
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: davidm@hpl.hp.com, Ingo Molnar <mingo@elte.hu>,
       "David S. Miller" <davem@davemloft.net>, tony.luck@intel.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched: unlocked context-switches
In-Reply-To: <1113271965.5090.24.camel@npiggin-nld.site>
References: <3R6Ir-89Y-23@gated-at.bofh.it>
	<ugoecowjci.fsf@panda.mostang.com>
	<20050409070738.GA5444@elte.hu>
	<16983.33049.962002.335198@napali.hpl.hp.com>
	<20050409155810.593d8f7b.davem@davemloft.net>
	<20050410064324.GA24596@elte.hu>
	<16987.7956.806699.617633@napali.hpl.hp.com>
	<1113271965.5090.24.camel@npiggin-nld.site>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 12 Apr 2005 12:12:45 +1000, Nick Piggin <nickpiggin@yahoo.com.au> said:

  >> Now, Ingo says that the order is reversed with his patch, i.e.,
  >> switch_mm() happens after switch_to().  That means flush_tlb_mm()
  >> may now see a current->active_mm which hasn't really been
  >> activated yet.

  Nick> If that did bother you, could you keep track of the actually
  Nick> activated mm in your arch code? Or would that involve more
  Nick> arch hooks and general ugliness in the scheduler?

I'm sorry, but I don't see the point of this.  We are already tracking
care of ownership, just not atomically.  What's the point of putting
another level of (atomic) tracking on top of it.  That seems
exceedingly ugly.

	--david
