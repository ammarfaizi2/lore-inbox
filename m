Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWFHAbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWFHAbu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 20:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWFHAbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 20:31:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:20370 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932508AbWFHAbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 20:31:50 -0400
Subject: Re: mutex vs. local irqs (Was: 2.6.18 -mm merge plans)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       paulus@samba.org
In-Reply-To: <20060607132155.GB14425@elte.hu>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <1149652378.27572.109.camel@localhost.localdomain>
	 <20060606212930.364b43fa.akpm@osdl.org>
	 <1149656647.27572.128.camel@localhost.localdomain>
	 <20060606222942.43ed6437.akpm@osdl.org>
	 <1149662671.27572.158.camel@localhost.localdomain>
	 <20060607132155.GB14425@elte.hu>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 10:31:24 +1000
Message-Id: <1149726685.23790.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a better solution would be to install boot-time IRQ vectors that just do
> nothing but return. They dont mask, they dont ACK nor EOI - they just
> return. The only thing that could break this is a screaming interrupt,
> and even that one probably just slows things down a tiny bit until we
> get so far in the init sequence to set up the PIC.

Changing vectors on the fly is hard on some platforms.... We could
change our toplevel ppc_md.get_irq() on powerpc, but we still to do
something about decrementer interrupts.
A screaming level interrupt will lockup the machine at least on some
platforms.

The problem with all those approaches is that they require changes to
all archs interrupt handling to make the situation safe vs. mutexes...

I still don't think where is the suckage in just not hard-enabling in
the mutex debug code...

Ben.

 

