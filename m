Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbTHYIu2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 04:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbTHYIu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 04:50:28 -0400
Received: from trained-monkey.org ([209.217.122.11]:38916 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S261620AbTHYIuW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 04:50:22 -0400
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfyt3x6.fsf@trained-monkey.org>
	<1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
	<20030819095547.2bf549e3.davem@redhat.com>
	<m34r0dwfrr.fsf@defiant.pm.waw.pl> <m38ypl29i4.fsf@defiant.pm.waw.pl>
	<m3isoo2taz.fsf@trained-monkey.org> <m3n0dz5kfg.fsf@defiant.pm.waw.pl>
	<20030824060057.7b4c0190.davem@redhat.com>
	<m365kmltdy.fsf@defiant.pm.waw.pl>
From: Jes Sorensen <jes@wildopensource.com>
Date: 25 Aug 2003 04:50:24 -0400
In-Reply-To: <m365kmltdy.fsf@defiant.pm.waw.pl>
Message-ID: <m3vfsmm88f.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Krzysztof" == Krzysztof Halasa <khc@pm.waw.pl> writes:

Krzysztof> "David S. Miller" <davem@redhat.com> writes:
>> See, to show something is broken, you have to show a device that
>> will break currently.

Krzysztof> SBE wanXL sync serial adapter. 32 bits for buffers but 28
Krzysztof> bits for consistent data.

Well if the buffers are dynamic, why would they want to be allocated
using the consistent interface?

Krzysztof> I can't imagine all devices work properly on all platforms
Krzysztof> wrt consistent allocs. Say, sound drivers setting only
Krzysztof> dma_mask to < 32 bits and expecting consistent alloc will
Krzysztof> use that and not consistent_dma_mask.

If sound drivers set the dma_mask to something and expect that to
apply to the consistent allocations, then they aren't complying with
the current API and needs to be fixed.

Krzysztof> Of course, there is a question if we want to support such
Krzysztof> sound cards on Itaniums and Opterons? Of course they work
Krzysztof> on i386 as i386 pci_alloc_consistent() ignores
Krzysztof> consistent_dma_mask.

So fix it on ia32 to respect that mask for consistent allocations,
problem solved.

Jes
