Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUHGXSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUHGXSc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 19:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUHGXSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 19:18:32 -0400
Received: from the-village.bc.nu ([81.2.110.252]:37060 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264639AbUHGXS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 19:18:26 -0400
Subject: Re: [PATCH] x86 bitops.h commentary on instruction reordering
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <cf10v3$h9l$1@terminus.zytor.com>
References: <20040805200622.GA17324@logos.cnet>
	 <20040806155328.GA21546@logos.cnet> <4113B752.7050808@vlnb.net>
	 <20040806170931.GA21683@logos.cnet>  <cf10v3$h9l$1@terminus.zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091916965.19077.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 07 Aug 2004 23:16:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-06 at 23:33, H. Peter Anvin wrote:
> > > So, there is no platform independent way for doing that in the kernel?
> > Not really. x86 doesnt have such an instruction.
> Actually it does (sfence, lfence, mfence); they only apply to SSE
> loads and stores since all other x86 operations are guaranteed to be
> strictly ordered.

The ordering guarantees on x86 are not completely strict and they refer
to the observed order of store on the bus rather than execution order.
So while code will generate the same observable results as if it was in
order you can get burned on timing suprises in some odd cases. Some of
the devices will even do weakly ordered stores to memory and fix up the
bus transactions by snooping them and spotting the impending problem.

Secondly on PPro and some others there are various chip errata where not
using locking operations _does_ cause observable out of order stores.
Thats why our unlock path for PPro uses lock movb.

Also for pedants only we support IDT Winchips (ancestor of the VIA C3)
which we do run with weak store ordering from an external view (not an
internal one). On those x86 variants the barrier instructions do what
you would expect.

Alan

