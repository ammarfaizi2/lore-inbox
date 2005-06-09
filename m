Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVFIRlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVFIRlJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 13:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVFIRlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 13:41:09 -0400
Received: from palrel12.hp.com ([156.153.255.237]:22509 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262421AbVFIRlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 13:41:03 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17064.32552.507932.62892@napali.hpl.hp.com>
Date: Thu, 9 Jun 2005 10:40:56 -0700
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 07/10] IOCHK interface for I/O error handling/detecting
In-Reply-To: <42A83CF2.90304@jp.fujitsu.com>
References: <42A8386F.2060100@jp.fujitsu.com>
	<42A83CF2.90304@jp.fujitsu.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hidetoshi,

>>>>> On Thu, 09 Jun 2005 21:58:26 +0900, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com> said:

  Hidetoshi> +/*
  Hidetoshi> + * Some I/O bridges may poison the data read, instead of
  Hidetoshi> + * signaling a BERR.  The consummation of poisoned data
  Hidetoshi> + * triggers a local, imprecise MCA.
  Hidetoshi> + * Note that the read operation by itself does not consume
  Hidetoshi> + * the bad data, you have to do something with it, e.g.:
  Hidetoshi> + *
  Hidetoshi> + *	ld.8	r9=[r10];;	// r10 == I/O address
  Hidetoshi> + *	add.8	r8=r9,r9;;	// fake operation
  Hidetoshi> + */
  Hidetoshi> +#define ia64_poison_check(val)					\
  Hidetoshi> +{	register unsigned long gr8 asm("r8");			\
  Hidetoshi> +	asm volatile ("add %0=%1,r0" : "=r"(gr8) : "r"(val)); }
  Hidetoshi> +
  Hidetoshi> #endif /* CONFIG_IOMAP_CHECK  */

I have only looked that this briefly and I didn't see off hand where you get
the "r9=[r10]" sequence from --- I hope you're not relying on the compiler
happening to generate this sequence!

More importantly: please avoid inline "asm" and use the intrinsics
defined by gcc_intrin.h instead (if you need something new, we can add
that), but I think ia64_getreg() will do much of what you want already.

Thanks,

	--david

