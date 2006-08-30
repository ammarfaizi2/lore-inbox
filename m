Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWH3LzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWH3LzY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 07:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWH3LzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 07:55:24 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:13278 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750821AbWH3LzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 07:55:23 -0400
Date: Wed, 30 Aug 2006 13:54:51 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Alexey Dobriyan <adobriyan@mail.ru>,
       Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH 1/7] introduce atomic_dec_and_lock_irqsave()
In-Reply-To: <20060830155140.GA193@oleg>
Message-ID: <Pine.LNX.4.64.0608301352000.6761@scrub.home>
References: <44F45045.70402@sw.ru> <44F4540C.8050205@sw.ru>
 <Pine.LNX.4.64.0608301156010.6762@scrub.home> <20060830145759.GA163@oleg>
 <Pine.LNX.4.64.0608301248420.6761@scrub.home> <20060830155140.GA193@oleg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 30 Aug 2006, Oleg Nesterov wrote:

> > AFAICT it's called via rcu, does that mean anything released via rcu has 
> > to be protected against interrupts?
> 
> RCU means softirq, probably we can use spin_lock_bh() to protect against deadlock.
> But free_uid() may be called with irqs disabled, we can't use local_bh_enable()
> in such a case.

Eek, I wasn't really aware of it and this would really suck. We should 
move things out of the interrupt context and not into it. :(
I would call it a bug in the rcu system.

bye, Roman
