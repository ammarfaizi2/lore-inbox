Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbTJAIBD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 04:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTJAIBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 04:01:03 -0400
Received: from ns.suse.de ([195.135.220.2]:26604 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262021AbTJAIBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 04:01:01 -0400
Date: Wed, 1 Oct 2003 10:00:33 +0200
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20031001080033.GP15853@wotan.suse.de>
References: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com.suse.lists.linux.kernel> <20031001053833.GB1131@mail.shareable.org.suse.lists.linux.kernel> <20030930224853.15073447.akpm@osdl.org.suse.lists.linux.kernel> <20031001061348.GE1131@mail.shareable.org.suse.lists.linux.kernel> <20030930233258.37ed9f7f.akpm@osdl.org.suse.lists.linux.kernel> <20031001065705.GI1131@mail.shareable.org.suse.lists.linux.kernel> <p73brt1zahk.fsf@oldwotan.suse.de> <20031001075551.GL1131@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001075551.GL1131@mail.shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 08:55:51AM +0100, Jamie Lokier wrote:
> Andi Kleen wrote:
> > Jamie Lokier <jamie@shareable.org> writes:
> > > It is easy enough to fix by making the fault handler not take
> > > mmap_sem if the fault's in the kernel address range.  (With apologies
> > > to the folk running kernel mode userspace...)
> > 
> > It won't work because kernel can cause user space faults
> > (think get_user). And handling these must be protected.
> 
> Are we mis-communicating?  By "fault in the kernel address range", I

Yep, we were. I read it as "instruction faulting is in kernel range"
(aka you check the ring0 bit in the error_code), not checking cr2 >= TASK_SIZE.

-Andi
