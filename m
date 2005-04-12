Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbVDLRWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVDLRWN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 13:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVDLRRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 13:17:09 -0400
Received: from palrel12.hp.com ([156.153.255.237]:30390 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262464AbVDLRP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 13:15:59 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16988.586.986381.393504@napali.hpl.hp.com>
Date: Tue, 12 Apr 2005 10:15:54 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: davidm@hpl.hp.com, "David S. Miller" <davem@davemloft.net>,
       tony.luck@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: unlocked context-switches
In-Reply-To: <20050412064253.GA1289@elte.hu>
References: <3R6Ir-89Y-23@gated-at.bofh.it>
	<ugoecowjci.fsf@panda.mostang.com>
	<20050409070738.GA5444@elte.hu>
	<16983.33049.962002.335198@napali.hpl.hp.com>
	<20050409155810.593d8f7b.davem@davemloft.net>
	<20050410064324.GA24596@elte.hu>
	<16987.7956.806699.617633@napali.hpl.hp.com>
	<20050412064253.GA1289@elte.hu>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 12 Apr 2005 08:42:53 +0200, Ingo Molnar <mingo@elte.hu> said:

  Ingo> * David Mosberger <davidm@napali.hpl.hp.com> wrote:

  >> Now, Ingo says that the order is reversed with his patch, i.e.,
  >> switch_mm() happens after switch_to().  That means flush_tlb_mm()
  >> may now see a current->active_mm which hasn't really been
  >> activated yet.  That should be OK since it would just mean that
  >> we'd do an early (and duplicate) activate_context().  While it
  >> does not give me a warm and fuzzy feeling to have this
  >> inconsistent state be observable by interrupt-handlers (and, in
  >> particular, IPI-handlers), I don't see any problem with it off
  >> hand.

  Ingo> thanks for the analysis. I fundamentally dont have any fuzzy
  Ingo> feeling from having _any_ portion of the context-switch path
  Ingo> nonatomic, but with more complex hardware it's just not
  Ingo> possible it seems.

No kidding! ;-)

I _think_ the change is OK.  I'll need testing, of course.
Sure would be nice to have 2.7.xx...

Thanks,

	--david
