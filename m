Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbVLNCYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbVLNCYH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 21:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbVLNCYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 21:24:07 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:44223
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932617AbVLNCYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 21:24:06 -0500
Date: Tue, 13 Dec 2005 18:23:40 -0800 (PST)
Message-Id: <20051213.182340.102535288.davem@davemloft.net>
To: ak@suse.de
Cc: hch@lst.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] sanitize building of fs/compat_ioctl.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <p73r78g8nft.fsf@verdi.suse.de>
References: <20051213173434.GP9286@parisc-linux.org>
	<20051213.145109.20744871.davem@davemloft.net>
	<p73r78g8nft.fsf@verdi.suse.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: 14 Dec 2005 02:41:42 +0100

> "David S. Miller" <davem@davemloft.net> writes:
> 
> > What do you really still need it for at this point?
> 
> input needs it :/ Take a look at drivers/input/evdev.c:evdev_write_compat
 ...
> I have given in for now. Assuming the test is done on a flag that is only set
> by the system call entry path. But I still think it will result in
> a lot of ugly code. For for read/write it's hard to avoid because
> there are so many variants and we have too many message passing
> protocols now.

I suppose.  We could also funnel down ->compat_{read,write}() and
so on down the call chain, but that would likely be even uglier.

I guess with is_compat_task() we can do the netlink and pfkeyv2 compat
stuff on ia64/x86_64.  I don't look forward to reviewing a patch
implementing that, however :-/

