Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751631AbWIUWAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbWIUWAp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbWIUWAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:00:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:45712 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751630AbWIUWAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:00:44 -0400
Subject: Re: [PATCH 2/3] FRV: Permit __do_IRQ() to be dispensed with
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Howells <dhowells@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
In-Reply-To: <339.1158844334@warthog.cambridge.redhat.com>
References: <1157786802.31071.171.camel@localhost.localdomain>
	 <20060908153236.21015.56106.stgit@warthog.cambridge.redhat.com>
	 <20060908153240.21015.67367.stgit@warthog.cambridge.redhat.com>
	 <20060909051211.GA6922@elte.hu>
	 <339.1158844334@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 07:59:42 +1000
Message-Id: <1158875982.26347.125.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 14:12 +0100, David Howells wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > It can't optimize __do_IRQ() out in any case if one uses
> > generic_handle_irq() because of the test in there which can't be
> > predicted at compile time.
> 
> Do you realise that powerpc still uses __do_IRQ if CONFIG_IRQSTACKS=y?  You
> should probably fix that.

At the moment, there is no hurry as this code is shared with arch/ppc
which hasn't been ported to genirq, so we need to handle both cases.
(Though I'm not sure we ever get CONFIG_IRQSTACKS with arch/ppc ... I
should probably check). The code uses desc->handle_irq and falls back to
__do_IRQ() if that is NULL.

Ben.


