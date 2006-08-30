Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWH3Q6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWH3Q6t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWH3Q6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:58:48 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:11143 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751153AbWH3Q6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:58:47 -0400
Date: Wed, 30 Aug 2006 22:28:51 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Kirill Korotaev <dev@sw.ru>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Alexey Dobriyan <adobriyan@mail.ru>,
       Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH 1/7] introduce atomic_dec_and_lock_irqsave()
Message-ID: <20060830165851.GA8481@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <44F45045.70402@sw.ru> <44F4540C.8050205@sw.ru> <Pine.LNX.4.64.0608301156010.6762@scrub.home> <20060830145759.GA163@oleg> <Pine.LNX.4.64.0608301248420.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608301248420.6761@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 12:51:28PM +0200, Roman Zippel wrote:
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

No. You need protection only if you have are using some 
data that can also be used by the RCU callback. For example,
if your RCU callback just calls kfree(), you don't have to 
do a spin_lock_bh().

Thanks
Dipankar
