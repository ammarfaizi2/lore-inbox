Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTLaK4U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 05:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbTLaK4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 05:56:20 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:28647 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S264252AbTLaK4Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 05:56:16 -0500
Date: Wed, 31 Dec 2003 05:52:27 -0500
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-mm2] slab corruption during packet flood on e100
Message-ID: <20031231105227.GA9429@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Lennert Buytenhek <buytenh@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When routing a large stream of UDP packets through this machine, coming
in on eth1 (e100), headed towards dummy0, I get a flood of slab corruption
messages a la below.  Box is a 2-way HT SMP machine.

Is this a known problem with the e100 driver perhaps?


thanks,
Lennert


Dec 31 11:42:05 phi kernel: Slab corruption: start=306ef74c, expend=306eff4b, problemat=306ef75e
Dec 31 11:42:05 phi kernel: Last user: [<02279033>](kfree_skbmem+0x13/0x30)
Dec 31 11:42:05 phi kernel: Data: *[snip]*28 A0 *[snip]*
Dec 31 11:42:05 phi kernel: *[snip]*
Dec 31 11:42:05 phi kernel: *[snip]*A5
Dec 31 11:42:05 phi kernel: Next: 71 F0 2C .33 90 27 02 ************************
Dec 31 11:42:05 phi kernel: slab error in check_poison_obj(): cache `size-2048': object was modified after freeing
Dec 31 11:42:05 phi kernel: Call Trace:
Dec 31 11:42:05 phi kernel:  [<0214bee9>] check_poison_obj+0x109/0x1a0
Dec 31 11:42:05 phi kernel:  [<0214dfb1>] __kmalloc+0x211/0x270
Dec 31 11:42:05 phi kernel:  [<02278e07>] alloc_skb+0x47/0xf0
Dec 31 11:42:05 phi kernel:  [<02278e07>] alloc_skb+0x47/0xf0
Dec 31 11:42:05 phi kernel:  [<42b4671e>] e100_poll+0x1ae/0x6c0 [e100]
Dec 31 11:42:05 phi kernel:  [<0210e1e8>] do_nmi+0x38/0x60
Dec 31 11:42:05 phi kernel:  [<0227dff5>] net_rx_action+0x85/0x140
Dec 31 11:42:05 phi kernel:  [<0212cff7>] do_softirq+0xc7/0xd0
Dec 31 11:42:06 phi kernel:  [<0210efaa>] do_IRQ+0x11a/0x160
Dec 31 11:42:06 phi kernel:  [<02126c10>] remove_wait_queue+0x50/0x80
Dec 31 11:42:06 phi kernel:  [<0217a2ee>] poll_freewait+0x2e/0x50
Dec 31 11:42:06 phi kernel:  [<0217b0fc>] sys_poll+0x22c/0x260
Dec 31 11:42:06 phi kernel:  [<0217a310>] __pollwait+0x0/0xd0
Dec 31 11:42:06 phi kernel:

