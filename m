Return-Path: <linux-kernel-owner+w=401wt.eu-S932988AbWL0QXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932988AbWL0QXo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 11:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932983AbWL0QXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 11:23:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41785 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932988AbWL0QXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 11:23:44 -0500
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
From: Arjan van de Ven <arjan@infradead.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0612270814m30fe8813mad20f22f9d188896@mail.gmail.com>
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
	 <20061216165738.GA5165@elte.hu>
	 <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com>
	 <20061217085859.GB2938@elte.hu> <20061217090943.GA9246@elte.hu>
	 <20061217092828.GA14181@elte.hu> <20061217094143.GA15372@elte.hu>
	 <b0943d9e0612270814m30fe8813mad20f22f9d188896@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 27 Dec 2006 17:23:38 +0100
Message-Id: <1167236618.3281.3986.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-27 at 16:14 +0000, Catalin Marinas wrote:
> On 17/12/06, Ingo Molnar <mingo@elte.hu> wrote:
> > it would be nice to record 1) the jiffies value at the time of
> > allocation, 2) the PID and the comm of the task that did the allocation.
> > The jiffies timestamp would be useful to see the age of the allocation,
> > and the PID/comm is useful for context.
> 
> Trying to copy the comm with get_task_comm, I get the lockdep report
> below, caused by acquiring the task's alloc_lock. Any idea how to go
> around this?

well you take the lock from irq context, which means it needs to use
_irqsave/restore everywhere. (and all locks taken inside it must be irq
safe as well)

maybe.. not use  comm in irq context? it doesn't actually mean anything
there anyway...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

