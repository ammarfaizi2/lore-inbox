Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbTIWO71 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 10:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTIWO7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 10:59:25 -0400
Received: from palrel10.hp.com ([156.153.255.245]:40835 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263378AbTIWO7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 10:59:20 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16240.24511.375148.520203@napali.hpl.hp.com>
Date: Tue, 23 Sep 2003 07:59:11 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, bcrl@kvack.org, ak@suse.de,
       iod00d@hp.com, peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
In-Reply-To: <20030923035118.578203d5.davem@redhat.com>
References: <16234.33565.64383.838490@wombat.disy.cse.unsw.edu.au>
	<20030919043847.GA2996@cup.hp.com>
	<20030919044315.GC7666@wotan.suse.de>
	<16234.36238.848366.753588@wombat.chubb.wattle.id.au>
	<20030919055304.GE16928@wotan.suse.de>
	<20030919064922.B3783@kvack.org>
	<16239.38154.969505.748461@wombat.chubb.wattle.id.au>
	<20030922203629.B21836@kvack.org>
	<20030922232237.28a5ac4a.davem@redhat.com>
	<16240.8965.91289.460763@wombat.chubb.wattle.id.au>
	<20030923035118.578203d5.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 23 Sep 2003 03:51:18 -0700, "David S. Miller" <davem@redhat.com> said:

  David> On Tue, 23 Sep 2003 20:40:05 +1000 Peter Chubb
  David> <peter@chubb.wattle.id.au> wrote:

  >> How expensive is it to take the trap and do a fix up, compared to
  >> making an aligned copy?  As it involves raising and handling a
  >> fault disassembling the instruction that caused the fault, etc.,
  >> I'd be surprised if it's much less than 1000 cycles, even without
  >> the printk, although I haven't measured it yet, and can't find
  >> enough info in the architecture manuals to know what it is.

  David> A cache miss can cause 100 or so cycles. :)

  David> And unlike the fixup trap, the printk wakes up a process and
  David> causes disk activity as syslogd writes to the kernel message
  David> log file.

The printk() is rate-controlled and doesn't happen for every unaligned
access.  It's average cost can be made as low as we want to, by adjusting
the rate.

	--david

