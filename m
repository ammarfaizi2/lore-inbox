Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161120AbWHDJlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbWHDJlY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 05:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWHDJlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 05:41:23 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39054 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030300AbWHDJlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 05:41:23 -0400
Subject: Re: [PATCH 2.4.32] Fix AVM C4 ISDN card init problems with newer
	CPUs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Karsten Keil <kkeil@suse.de>
Cc: Jukka Partanen <jspartanen@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060803173104.GA22317@pingi.kke.suse.de>
References: <d50597c30608030953l41e8661dg1c10faeac31cc87f@mail.gmail.com>
	 <20060803173104.GA22317@pingi.kke.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Aug 2006 11:00:46 +0100
Message-Id: <1154685646.23655.185.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-03 am 19:31 +0200, ysgrifennodd Karsten Keil:
> Yes, that should be go in.
> 
> AVM C4 ISDN NIC: Add three memory barriers, taken from 2.6.7,
> (they are there in 2.6.17.7 too), to fix module initialization
> problems appearing with at least some newer Celerons and
> Pentium III.
> 
> Acked-by: Karsten Keil <kkeil@suse.de>
> Signed-off-by: Jukka Partanen <jspartanen@gmail.com>

NAK: Alan Cox <alan@redhat.com>

Two reasons

#1	You should use cpu_relax in such loops
#2	The readl (which c4inmeml is a pointless #define of) is defined to be
a volatile reference itself

That means that the real bug would appear to be different and either you
have a gcc bug which is possible or you have something stranger going
on, such as the continued polling busying the microcontroller the other
end, in which case you need a delay not the lucky chance that mb() is
slowish on some x86 systems.

So you either want

		cpu_relax + other fixes
	or	udelay(something)


Alan

