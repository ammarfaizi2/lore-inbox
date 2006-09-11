Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWIKJq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWIKJq3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 05:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWIKJq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 05:46:29 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11680 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932203AbWIKJq2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 05:46:28 -0400
Subject: Re: [RFC] MMIO accessors & barriers documentation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <1157966269.3879.23.camel@localhost.localdomain>
References: <1157947414.31071.386.camel@localhost.localdomain>
	 <1157965071.23085.84.camel@localhost.localdomain>
	 <1157966269.3879.23.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Sep 2006 11:07:41 +0100
Message-Id: <1157969261.23085.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-11 am 19:17 +1000, ysgrifennodd Benjamin Herrenschmidt:
> > >  3- memcpy_to_io, memcpy_from_io: #1 semantics apply (all MMIO loads or
> > > stores are performed in order to each other). #2+#4 (stores) or #3
> > 
> > What is "in order" here. "In ascending order of address" would be
> > tighter.
> 
> In program order. Every time I say "in order", I mean "in program
> order". I agree that this is not enough precision as it's not obvious
> that memcpy will copy in ascending order of addresses (it doesn't have
> to), I'll add that precision... or not. THat could be another question.
> What do we want here ? I would rather have those strongly ordered for
> Class 1.

I'd rather memcpy_to/from_io only made guarantees about the start/end of
the transfer and not order of read/writes or size of read/writes. The
reason being that a more restrictive sequence can be efficiently
expressed using read/writefoo but the reverse is not true.

> > "Except where the underlying device is marked as cachable or
> > prefetchable"
> 
> You aren't supposed to use MMIO accessors on cacheable memory, are you ?

Why not. Providing it is in MMIO space, consider ROMs for example or
write path consider frame buffers.

> with cacheable mappings of anything behind HT... I'd keep use of
> cacheable mapping as an arch specific special case for now, and that
> definitely doesn't allow for MMIO accessors ...

I'm describing existing semantics 8)


