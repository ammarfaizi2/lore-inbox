Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267326AbUHIW3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUHIW3B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 18:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267318AbUHIWZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 18:25:53 -0400
Received: from the-village.bc.nu ([81.2.110.252]:42955 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267319AbUHIWYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 18:24:22 -0400
Subject: Re: [PATCH] x86 bitops.h commentary on instruction reordering
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vladislav Bolkhovitin <vst@vlnb.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4117DAA0.1020601@vlnb.net>
References: <20040805200622.GA17324@logos.cnet> <411392E0.6080507@vlnb.net>
	 <20040806143359.GC20911@logos.cnet> <4113A579.5060702@vlnb.net>
	 <20040806155328.GA21546@logos.cnet> <4113B752.7050808@vlnb.net>
	 <20040806170931.GA21683@logos.cnet> <411794E8.6000806@vlnb.net>
	 <20040809155009.GB6361@logos.cnet> <4117B5DB.7060602@vlnb.net>
	 <20040809183437.GD6361@logos.cnet>  <4117DAA0.1020601@vlnb.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092086514.14770.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 09 Aug 2004 22:21:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-09 at 21:12, Vladislav Bolkhovitin wrote:
> Well, Marcelo, sorry if I'm getting too annoying, but we had a race with 
> cache coherency during SCST (SCSI target mid-level) development. We 
> discovered that on P4 Xeon after atomic_set() there is very small 
> window, when atomic_read() on another CPUs returns the old value. We had 
> to rewrite the code without using atomic_set(). Isn't it cache coherency 
> issue?

atomic_set/atomic_read are _atomic_ operations. Nothing is said about
ordering. You get old or new but not half and half. Two atomic_inc's
will both occur and so on.

If you want ordering you need locks otherwise there is nothing defining
the time order of both processors.

How can you even measure such a window without locking to know what the
state of the processors is ?

> And, BTW, returning to the original topic, would it be better to make 
> set_bit() and friends guarantee not to be reordered on all 
> architectures, instead of just add the comment. Otherwise, what is the 

x86 and some other platforms have certain ordering guarantees. set_bit
doesn't guarantee them but it happens to unavoidably work for most
(ab)uses.

> right thing? In some places in SCST we heavy rely on non-ordering 
> guarantees.

Then you will get burned on most hardware.
