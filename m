Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTJRAVS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 20:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263662AbTJRAVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 20:21:18 -0400
Received: from palrel12.hp.com ([156.153.255.237]:33717 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263646AbTJRAVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 20:21:15 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16272.34681.443232.246020@napali.hpl.hp.com>
Date: Fri, 17 Oct 2003 17:21:13 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
In-Reply-To: <20031017165543.2f7e9d49.akpm@osdl.org>
References: <200310171610.36569.bjorn.helgaas@hp.com>
	<20031017155028.2e98b307.akpm@osdl.org>
	<200310171725.10883.bjorn.helgaas@hp.com>
	<20031017165543.2f7e9d49.akpm@osdl.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 17 Oct 2003 16:55:43 -0700, Andrew Morton <akpm@osdl.org> said:

  >> If we really believe copy_*_user() must correctly handle *all* faults,
  >> isn't the "p >= __pa(high_memory)" test superfluous?

  Andrew> This code was conceived before my time and I don't recall seeing much
  Andrew> discussion, so this is all guesswork..

  Andrew> I'd say that the high_memory test _is_ superfluous and that
  Andrew> if anyone cared, we would remove it and establish a
  Andrew> temporary pte against the address if it was outside the
  Andrew> direct-mapped area.  But nobody cares enough to have done
  Andrew> anything about it.

What about memory-mapped device registers?  Isn't all memory
physically contiguous on x86 and that's why the "p >=
__pa(high_memory)" test saves you from that?

  >> On ia64, a read to non-existent physical memory causes the processor
  >> to time out and take a machine check.  I'm not sure it's even possible
  >> to recover from that.

  Andrew> ick.  That would be very poor form.

Reasonable people can disagree on that.  One philosophy states that if
your kernel touches random addresses, it's better to signal a visible
error (machine-check) than to risk silent data corruption.

	--david
