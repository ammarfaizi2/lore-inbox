Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267258AbUHIVY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267258AbUHIVY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267249AbUHIVX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:23:58 -0400
Received: from zero.aec.at ([193.170.194.10]:55044 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267264AbUHIVXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:23:19 -0400
To: Vladislav Bolkhovitin <vst@vlnb.net>
cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH] x86 bitops.h commentary on instruction reordering
References: <2pY7Y-W1-7@gated-at.bofh.it> <2qdJL-3sh-27@gated-at.bofh.it>
	<2qePx-4eM-21@gated-at.bofh.it> <2qf8S-4pI-31@gated-at.bofh.it>
	<2qg4V-54c-17@gated-at.bofh.it> <2qgoh-5og-29@gated-at.bofh.it>
	<2qhkn-649-41@gated-at.bofh.it> <2rkgh-zP-45@gated-at.bofh.it>
	<2rlFk-1wC-27@gated-at.bofh.it> <2rmhX-20I-17@gated-at.bofh.it>
	<2roWw-40d-19@gated-at.bofh.it> <2roWw-40d-17@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 09 Aug 2004 23:23:12 +0200
In-Reply-To: <2roWw-40d-17@gated-at.bofh.it> (Vladislav Bolkhovitin's
 message of "Mon, 09 Aug 2004 22:30:12 +0200")
Message-ID: <m3657st39b.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladislav Bolkhovitin <vst@vlnb.net> writes:

> Marcelo Tosatti wrote:
>> Vladislav, There is no cache coherency issues on x86, it handles the
>> cache coherency
>> on hardware.
>
> Well, Marcelo, sorry if I'm getting too annoying, but we had a race
> with cache coherency during SCST (SCSI target mid-level)
> development. We discovered that on P4 Xeon after atomic_set() there is
> very small window, when atomic_read() on another CPUs returns the old
> value. We had to rewrite the code without using atomic_set(). Isn't it
> cache coherency issue?

Add an rmb() after the atomic_set. atomic_set doesn't have one by itself
(it is non locked on Linux/x86)

> And, BTW, returning to the original topic, would it be better to make
> set_bit() and friends guarantee not to be reordered on all
> architectures, instead of just add the comment. Otherwise, what is the

That makes them a *lot* slower on some systems. And most of the
set_bits in the kernel don't need strong ordering.

> difference with versions with `__` prefix (__set_bit(), for example)?
> Just adding the comments will lead to creating different functions
> with gurantees by everyone who need it in all over the kernel. Is it
> the right thing? In some places in SCST we heavy rely on non-ordering
> guarantees.

Better add lots of memory barriers then.

-Andi

