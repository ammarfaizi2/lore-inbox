Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266652AbUGQJab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266652AbUGQJab (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 05:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266667AbUGQJab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 05:30:31 -0400
Received: from holomorphy.com ([207.189.100.168]:40882 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266652AbUGQJa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 05:30:29 -0400
Date: Sat, 17 Jul 2004 02:30:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: [RFC] Lock free fd lookup
Message-ID: <20040717093017.GN3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
References: <40F8E868.7000008@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F8E868.7000008@colorfullife.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Keith Owens wrote:
>>> It requires type stable storage.  That is, once a data area has been
>>>  allocated to a particular structure type, it always contains that
>>>  structure type, even when it has been freed from the list.  Each list
>>>  requires its own free pool, which can never be returned to the OS.

wli wrote
>>The last of these is particularly lethal.

On Sat, Jul 17, 2004 at 10:50:48AM +0200, Manfred Spraul wrote:
> It might be possible to combine such a lock free algorithms with RCU and 
> then set Hugh's SLAB_DESTROY_BY_RCU: It inserts a call_rcu between 
> leaving the free pool and returning the page to the OS.

At least I would prefer such a hybrid algorithm if things of this kind
were used in the kernel. From the looks of it, in such algorithms the
structure is still valid for checking of tickets after a voluntary
preemption, in this RCU hybrid not.


-- wli
