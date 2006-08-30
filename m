Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWH3L1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWH3L1j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 07:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWH3L1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 07:27:39 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:51645 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1750757AbWH3L1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 07:27:38 -0400
Date: Wed, 30 Aug 2006 19:51:40 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Alexey Dobriyan <adobriyan@mail.ru>,
       Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH 1/7] introduce atomic_dec_and_lock_irqsave()
Message-ID: <20060830155140.GA193@oleg>
References: <44F45045.70402@sw.ru> <44F4540C.8050205@sw.ru> <Pine.LNX.4.64.0608301156010.6762@scrub.home> <20060830145759.GA163@oleg> <Pine.LNX.4.64.0608301248420.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608301248420.6761@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30, Roman Zippel wrote:
> Hi,
> 
> On Wed, 30 Aug 2006, Oleg Nesterov wrote:
> 
> > > Why does this need protection against interrupts?
> > 
> > uidhash_lock can be taken from irq context. For example, delayed_put_task_struct()
> > does __put_task_struct()->free_uid().
> 
> AFAICT it's called via rcu, does that mean anything released via rcu has 
> to be protected against interrupts?

RCU means softirq, probably we can use spin_lock_bh() to protect against deadlock.
But free_uid() may be called with irqs disabled, we can't use local_bh_enable()
in such a case.

Oleg.

