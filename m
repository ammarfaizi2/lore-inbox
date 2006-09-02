Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWIBVwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWIBVwF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 17:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWIBVwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 17:52:05 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:61160 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751634AbWIBVwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 17:52:02 -0400
Date: Sat, 2 Sep 2006 23:48:40 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-rc5 with GRE, iptables and Speedtouch ADSL, PPP over ATM
Message-ID: <20060902214839.GA27295@electric-eye.fr.zoreil.com>
References: <m3odty57gf.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3odty57gf.fsf@defiant.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> :
[...]
> =======================================================
> [ INFO: possible circular locking dependency detected ]
> -------------------------------------------------------
> swapper/0 is trying to acquire lock:
>  (&dev->queue_lock){-+..}, at: [<c02c8c46>] dev_queue_xmit+0x56/0x290
> 
> but task is already holding lock:
>  (&dev->_xmit_lock){-+..}, at: [<c02c8e14>] dev_queue_xmit+0x224/0x290
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&dev->_xmit_lock){-+..}:
>        [<c012e7b6>] lock_acquire+0x76/0xa0
>        [<c0336241>] _spin_lock_bh+0x31/0x40
>        [<c02d25a9>] dev_activate+0x69/0x120
[...]
>        [<c0169957>] vfs_ioctl+0x57/0x290
>        [<c0169bc9>] sys_ioctl+0x39/0x60
>        [<c0102c8d>] sysenter_past_esp+0x56/0x8d

> 
> -> #0 (&dev->queue_lock){-+..}:
>        [<c012e7b6>] lock_acquire+0x76/0xa0
>        [<c03361fc>] _spin_lock+0x2c/0x40
>        [<c02c8c46>] dev_queue_xmit+0x56/0x290
[...]
>        [<c01194b5>] __do_softirq+0x55/0xc0
>        [<c0104b13>] do_softirq+0x63/0xd0

dev_activate takes BH disabling locks only. How could a softirq happen
on the same cpu and trigger a deadlock ?

-- 
Ueimor

-- 
VGER BF report: U 0.500151
