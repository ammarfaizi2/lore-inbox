Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275296AbTHMSqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275356AbTHMSoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:44:55 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:23289 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S275355AbTHMSom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:44:42 -0400
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030813153235.GB21081@wotan.suse.de>
References: <20030813025542.32429718.akpm@osdl.org.suse.lists.linux.kernel>
	 <1060772769.8009.4.camel@localhost.localdomain.suse.lists.linux.kernel>
	 <20030813042544.5064b3f4.akpm@osdl.org.suse.lists.linux.kernel>
	 <1060774803.8008.24.camel@localhost.localdomain.suse.lists.linux.kernel>
	 <p7365l17o70.fsf@oldwotan.suse.de>
	 <1060778924.8008.39.camel@localhost.localdomain>
	 <20030813131457.GD32290@wotan.suse.de>
	 <1060783794.8008.62.camel@dhcp23.swansea.linux.org.uk>
	 <20030813142055.GC9179@wotan.suse.de>
	 <1060788009.8957.5.camel@dhcp23.swansea.linux.org.uk>
	 <20030813153235.GB21081@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060800263.9130.29.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 13 Aug 2003 19:44:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-13 at 16:32, Andi Kleen wrote:
> The AMD slides assume all very big data sets ;-)
> 
> I would recommend to remove it.

I'll do some timings when I get a moment - the prefetching mmx copy
was a win (and faster than the others for small data as well as large
on the K7-550 (really a K7 not "Athlon" 8)) way back when.

> > What else checks the 3Dnow bit ?
> 
> Nothing in kernel AFAIK, but it's possible that it is used by user space
> reading /proc/cpuinfo.

DaveJ and your docs are right on 3dnow it turns out so sorry about that
and ignore me on prefetchw, its just the prefetch side thats 3 way.

> BTW we saw it mainly in the x86-64 copy_*_user and csum_copy_* functions
> which do also prefetches. LTP would sometimes trigger it when it tests
> how the kernel behaves with invalid addresses. But it happened very
> rarely in the dcache hash too. But still it's hard to trigger, the
> linked list one is very hard to hit. I tried to reproduce it in user space,
> but failed. The LTP one is much easier, but still not that common.

Thanks

