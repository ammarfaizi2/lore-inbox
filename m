Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWGGTJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWGGTJH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWGGTJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:09:06 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48094
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932265AbWGGTJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:09:05 -0400
Date: Fri, 07 Jul 2006 12:09:36 -0700 (PDT)
Message-Id: <20060707.120936.98532669.davem@davemloft.net>
To: arjan@infradead.org
Cc: davej@redhat.com, akpm@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: auro deadlock
From: David Miller <davem@davemloft.net>
In-Reply-To: <1152295989.3111.116.camel@laptopd505.fenrus.org>
References: <20060707171916.GA16343@redhat.com>
	<1152295989.3111.116.camel@laptopd505.fenrus.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>
Date: Fri, 07 Jul 2006 20:13:09 +0200

> Now a question for netdev: what is the interrupt-or-softirq rules for
> the sk_receive_queue.lock?
> 
> Anyway, the patch below fixes this deadlock; it may or may not be the
> correct solution depending on the netdev answer, but the deadlock is
> gone ;)

The lockdep fixes are starting to cause us to go in and start adding
hard IRQ protection to many socket layer objects and I want this
thinking to end quickly :)

The netlink wireless fix is another example of this, but I accept the
temporary fix for that one for the time being.

To reiterate, nothing socket or SKB level should be taking anything
deeper than software IRQ locking.

If drivers manage local SKB queues in hard IRQ context, they need to
use a seperate lockdep identifier for that queue's lock.
