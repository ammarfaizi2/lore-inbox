Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWHCN7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWHCN7i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 09:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWHCN7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 09:59:38 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:64152 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932466AbWHCN7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 09:59:37 -0400
Date: Thu, 3 Aug 2006 17:59:25 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Arnd Hannemann <arnd@arndnet.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: problems with e1000 and jumboframes
Message-ID: <20060803135925.GA28348@2ka.mipt.ru>
References: <44D1FEB7.2050703@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44D1FEB7.2050703@arndnet.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 03 Aug 2006 17:59:28 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 03:48:39PM +0200, Arnd Hannemann (arnd@arndnet.de) wrote:
> Hi,
> 
> im running vanilla 2.6.17.6 and if i try to set the mtu of my e1000 nic
> to 9000 bytes, page allocation failures occur (see below).
> 
> However the box is a VIA Epia MII12000 with 1 GB of Ram and 1 GB of swap
> enabled, so there should be plenty of memory available. HIGHMEM support
> is off. The e1000 nic seems to be an 82540EM, which to my knowledge
> should support jumboframes.

But it does not support splitting them into page sized chunks, so it
requires the whole jumbo frame allocation in one contiguous chunk, 9k
will be transferred into 16k allocation (order 3), since SLAB uses
power-of-2 allocation.

> However I can't always reproduce this on a freshly booted system, so
> someone else may be the culprit and leaking pages?

You will almost 100% reproduce it after "find / > /dev/null".

> Any ideas how to debug this?

It can not be debugged - you have cought a memory fragmentation problem,
which is quite common.

> > kswapd0: page allocation failure. order:3, mode:0x20

e1000 tries to allocate 3-order pages atomically?
Well, that's wrong.
 
> Thanks,
> Arnd Hannemann

-- 
	Evgeniy Polyakov
