Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266054AbTHSJDe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 05:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266985AbTHSJDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 05:03:33 -0400
Received: from trained-monkey.org ([209.217.122.11]:42505 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S266054AbTHSJDc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 05:03:32 -0400
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 19 Aug 2003 05:03:33 -0400
In-Reply-To: <20030818111522.A12835@devserv.devel.redhat.com>
Message-ID: <m33cfyt3x6.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pete" == Pete Zaitcev <zaitcev@redhat.com> writes:

>> It isn't even implemented on most platforms - only x86_64 and ia64
>> have support for it, while on the remaining archs using it
>> according to the docs (with non-default value) could mean Oops or
>> something like that.

Pete> Before you go for that, I'd rather see you implementing the
Pete> double/tripple calls in drivers, check for effects, THEN go for
Pete> removal of the mask. If you cannot do it, plea SGI people to
Pete> test it on SN-2 for you (or same for Intel Tiger box).

Hi Pete,

That would be totally messy. Having drivers do the accounting of what
mask is currently set and have them switch back and forth depending on
what type of allocation is currently being used would be a nightmare
to debug.

Pete> The consistent mask looks a little distasteful to me, and I
Pete> think it should not buy us performance because consistent
Pete> allocations are not supposed to be fast. They are bad, but what
Pete> you are doing is worse: you are trying to ruin the day of
Pete> legitimate users.  Please, be reasonable. Get SGI buy-in and
Pete> come back.

The thing is that we really want to do 32-bit allocations for
consistent allocations if we can in anyway do it since it means the
card can do SAC for all access to control structures. However as you
mention there are cases where this isn't possible and we will have to
take the hit of DAC cycles.

Cheers,
Jes
