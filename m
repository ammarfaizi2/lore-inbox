Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUEYEnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUEYEnJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 00:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbUEYEnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 00:43:09 -0400
Received: from palrel13.hp.com ([156.153.255.238]:20694 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264643AbUEYEnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 00:43:05 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16562.52948.981913.814783@napali.hpl.hp.com>
Date: Mon, 24 May 2004 21:43:00 -0700
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
In-Reply-To: <20040525042054.GU29378@dualathlon.random>
References: <1085369393.15315.28.camel@gaston>
	<Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
	<1085371988.15281.38.camel@gaston>
	<Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
	<1085373839.14969.42.camel@gaston>
	<Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
	<20040525034326.GT29378@dualathlon.random>
	<Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
	<20040525042054.GU29378@dualathlon.random>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 25 May 2004 06:20:54 +0200, Andrea Arcangeli <andrea@suse.de> said:

  Andrea> the only architecture that has the accessed bit in
  Andrea> _hardware_ via page faults I know is ia64, but I don't know
  Andrea> if it has a mode to set it without page faults

No, it doesn't.

  Andrea> and how it is implementing the accessed bit in linux.

If the "accessed" or "dirty" bits are zero, accessing/writing the
page will cause a fault which will be handled in a low-level
fault handler.  The Linux version of these handlers simply turn
on the respective bit.  See daccess_bit(), iaccess_bit(), and dirty_bit()
in arch/ia64/kernel/ivt.S.

Note: I'm on travel and haven't seen the context of this discussion
and don't expect to have time to think about this until I return on
Thursday.  So if you don't hear from me, it's not because I'm ignoring
you... ;-)

	--david
