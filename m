Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbTCBUlS>; Sun, 2 Mar 2003 15:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbTCBUlS>; Sun, 2 Mar 2003 15:41:18 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35737
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261900AbTCBUlR>; Sun, 2 Mar 2003 15:41:17 -0500
Subject: Re: 2.5.63: 'Debug: sleeping function called from illegal context
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>
In-Reply-To: <3E61DBAB.1040206@colorfullife.com>
References: <3E61DBAB.1040206@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046642093.3700.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 02 Mar 2003 21:54:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-02 at 10:23, Manfred Spraul wrote:
> sleeping - e.g. on a NUMA arch an IPI to the right node could be necessary.
> What about fixing ide? If ide can't handle early interrupts, then it can use
> 
>     disable_irq();

disable_irq(n) isn't something all platforms seem to define before the
IRQ is requested, In addition disable_irq() is not supported on some
systems the IDE code supports. I have to have local CPU interrupts
disabled on the CPU at the point the IRQ becomes live.

The former we could probably solve with "SA_DISABLE" to request an IRQ
that is disabled, but I'm not sure how we deal with platforms which
plain and simply do not have 'mask irq' functionality but are using a
level triggered interrupt.

