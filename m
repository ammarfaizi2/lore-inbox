Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbWFHXAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWFHXAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWFHXAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:00:07 -0400
Received: from ozlabs.org ([203.10.76.45]:21889 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965050AbWFHXAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:00:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17544.44013.299585.169274@cargo.ozlabs.ibm.com>
Date: Fri, 9 Jun 2006 08:59:57 +1000
From: Paul Mackerras <paulus@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: mutex vs. local irqs (Was: 2.6.18 -mm merge plans)
In-Reply-To: <20060607132155.GB14425@elte.hu>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<1149652378.27572.109.camel@localhost.localdomain>
	<20060606212930.364b43fa.akpm@osdl.org>
	<1149656647.27572.128.camel@localhost.localdomain>
	<20060606222942.43ed6437.akpm@osdl.org>
	<1149662671.27572.158.camel@localhost.localdomain>
	<20060607132155.GB14425@elte.hu>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:

> a better solution would be to install boot-time IRQ vectors that just do
> nothing but return. They dont mask, they dont ACK nor EOI - they just
> return.

How would that help?  We'd just end up taking the interrupt over and
over again.  We have to either poke the PIC to tell it to shut up
somehow (which we can't do before ioremap is available) or arrange for
interrupts to be disabled after the return (which means that
might_sleep() will scream at us).

Paul.
