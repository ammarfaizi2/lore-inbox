Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270498AbUJTT5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270498AbUJTT5l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270573AbUJTT5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:57:20 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:13787 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270491AbUJTTzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:55:24 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Timothy Miller <miller@techsource.com>,
       Andrea Arcangeli <andrea@novell.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Chris Wedgwood <cw@f00f.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <1098290345.1429.65.camel@krustophenia.net>
References: <593560000.1094826651@[10.10.2.4]>
	 <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
	 <20040910151538.GA24434@devserv.devel.redhat.com>
	 <20040910152852.GC15643@x30.random>
	 <20040910153421.GD24434@devserv.devel.redhat.com>
	 <41768858.8070709@techsource.com>
	 <20041020153521.GB21556@devserv.devel.redhat.com>
	 <1098290345.1429.65.camel@krustophenia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098298310.12411.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 20 Oct 2004 19:51:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-20 at 17:39, Lee Revell wrote:
> The IDE I/O completion in hardirq context means that one can run for
> almost 3ms.  Apparently at OLS it was decided that the target for
> desktop responsiveness was 1ms.  So this is a real problem.
> 
> What exactly do you mean by "draconian"?

It means "fix the ide layer", patches welcome. 

Doing 4K IRQ stacks is actually not the problem - nor really is nesting.
If that worries you then get_free_page() the irq structure and use the
rest for the stack for _that_ IRQ handler. You won't need that much
memory.

Alan

