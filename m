Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbTJTSsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 14:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbTJTSsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 14:48:37 -0400
Received: from palrel13.hp.com ([156.153.255.238]:4323 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262709AbTJTSsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 14:48:31 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16276.11771.903857.778036@napali.hpl.hp.com>
Date: Mon, 20 Oct 2003 11:48:27 -0700
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
In-Reply-To: <200310200917.11074.bjorn.helgaas@hp.com>
References: <200310171610.36569.bjorn.helgaas@hp.com>
	<20031017165543.2f7e9d49.akpm@osdl.org>
	<16272.34681.443232.246020@napali.hpl.hp.com>
	<200310200917.11074.bjorn.helgaas@hp.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 20 Oct 2003 09:17:10 -0600, Bjorn Helgaas <bjorn.helgaas@hp.com> said:

  Bjorn> On Friday 17 October 2003 6:21 pm, David Mosberger wrote:
  >> What about memory-mapped device registers?  Isn't all memory
  >> physically contiguous on x86 and that's why the "p >=
  >> __pa(high_memory)" test saves you from that?

  Bjorn> As others have mentioned, using read/write on /dev/mem to get
  Bjorn> at memory-mapped registers is unlikely to work on ia64
  Bjorn> anyway, because read/write use cacheable mappings.  Using
  Bjorn> mmap does work (using uncacheable mappings), and my patch
  Bjorn> doesn't change that path.

True, I just find this whole thing rather disgusting: different
behavior for read/write vs. mmap; but you're right, it's nothing
new and probably the most pragmatic "solution".

  Bjorn> I bet that ia32 does have page tables for this case, and that
  Bjorn> an attempt to read non-existent physical memory will cause a
  Bjorn> TLB miss from which copy_*_user() can easily recover.

True, but even this doesn't help for MMIO space, where a device may
decode less than a full page.  So you'd still end up accessing address
holes.  Just that x86 returns garbage in that case (I think).

	--david
