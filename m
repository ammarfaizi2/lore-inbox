Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267952AbTHSJVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 05:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268160AbTHSJVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 05:21:11 -0400
Received: from trained-monkey.org ([209.217.122.11]:46089 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S267952AbTHSJVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 05:21:08 -0400
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030817233705.0bea9736.davem@redhat.com>
	<m3r83jyw2k.fsf@defiant.pm.waw.pl>
	<20030818054341.2ef07799.davem@redhat.com>
	<m365kvufjx.fsf@defiant.pm.waw.pl>
From: Jes Sorensen <jes@wildopensource.com>
Date: 19 Aug 2003 05:21:08 -0400
In-Reply-To: <m365kvufjx.fsf@defiant.pm.waw.pl>
Message-ID: <m3u18erojf.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Krzysztof" == Krzysztof Halasa <khc@pm.waw.pl> writes:

Krzysztof> "David S. Miller" <davem@redhat.com> writes:
>> The ia64 support code to do things with consistent_dma_mask just
>> isn't in the tree yet.

Krzysztof> Ok. Any pointer so I can see how is it used?

drivers/net/tg3.c was the case where we needed it first. If you grab
the official ia64 kernel patch and look in the arch/ia64/sn/io code
you will find places that consider it.

>> Because the other platforms don't to do anything special wrt. this
>> they can just ignore consitent_dma_mask altogether.

Krzysztof> No. The documentation states that consistent_dma_mask (and
Krzysztof> not dma_mask) will be used when doing
Krzysztof> pci_alloc_consistent(). This is, obviously, false on most
Krzysztof> platforms.

It's not being used on those platforms because I couldn't implement it
on all of them - I just don't have the hardware. We implemented it on
ia64 because thats where we needed it, Andi Kleen then implemented it
on x86_64 because he needed it there. If there are PPC boxes out there
with similar issues then I am sure that the PPC maintainers will
implement support for this when they need it.

Krzysztof> It is perfectly reasonable to expect that
Krzysztof> setting consistent_dma_mask to, say, 28 bits will cause
Krzysztof> pci_alloc_consistent to return memory from first 256
Krzysztof> MB. This is not true on most platforms, for example i386
Krzysztof> happily allocs memory near the top in such case.

The default for pci_alloc_consistent() on ia32 is that
pci_dev->consistent_dma_mask == 32 bit. If you need something else for
a reason, please feel free to implement support for it.

Krzysztof> If we really need two masks, they can't be ignored on some
Krzysztof> archs.

So *fix* it! This is Linux, it's Free Software, you have the source,
you have the right to fix bugs!

Jes
