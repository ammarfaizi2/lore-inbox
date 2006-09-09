Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWIIJV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWIIJV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 05:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWIIJV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 05:21:57 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23994
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751082AbWIIJVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 05:21:55 -0400
Date: Sat, 09 Sep 2006 02:22:28 -0700 (PDT)
Message-Id: <20060909.022228.41644790.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: mchan@broadcom.com, segher@kernel.crashing.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: TG3 data corruption (TSO ?)
From: David Miller <davem@davemloft.net>
In-Reply-To: <1157751962.31071.102.camel@localhost.localdomain>
References: <9EAEC3B2-260E-444E-BCA1-3C9806340F65@kernel.crashing.org>
	<1157745256.5344.8.camel@rh4>
	<1157751962.31071.102.camel@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 09 Sep 2006 07:46:02 +1000

> I don't think that in general, you have ordering guarantees between
> cacheable and non-cacheable stores unless you use explicit barriers.

In fact, on most systems you absolutely do have ordering between
MMIO and memory accesses.

So you are making an extremely poor engineering decision
by trying to fixup all the drivers to match PowerPC's
semantics.  I think a smart engineer would decrease his
debugging burdon, by matching his platform's MMIO accessors
such that it matches what other platforms do and therefore
inheriting the testing coverage provided by all platforms.

Otherwise you will be hunting down these kinds of memory
barrier issues forever.
