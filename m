Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWDISXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWDISXO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 14:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWDISXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 14:23:14 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.4.204]:2854 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750838AbWDISXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 14:23:13 -0400
Date: Sun, 09 Apr 2006 14:23:06 -0400
From: Nick Orlov <bugfixer@list.ru>
Subject: 2.6.17-rc1-mm2: badness in 3w_xxxx driver
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       James Bottomley <James.Bottomley@SteelEye.com>
Mail-followup-to: linux-kernel <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
 James Bottomley <James.Bottomley@SteelEye.com>
Message-id: <20060409182306.GA4680@nickolas.homeunix.com>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch: x86-kmap_atomic-debugging.patch exposed a badness
in 3w_xxx driver. I'm getting a lot of:

Apr  9 13:00:04 nickolas kernel: kmap_atomic: local irqs are enabled while using KM_IRQn
Apr  9 13:00:04 nickolas kernel:  <c0104103> show_trace+0x13/0x20   <c010412e> dump_stack+0x1e/0x20
Apr  9 13:00:04 nickolas kernel:  <c01159c9> kmap_atomic+0x79/0xe0   <c028b885> tw_transfer_internal+0x85/0xa0
Apr  9 13:00:04 nickolas kernel:  <c028ca7e> tw_interrupt+0x3fe/0x820   <c0143b9e> handle_IRQ_event+0x3e/0x80
Apr  9 13:00:04 nickolas kernel:  <c0143c70> __do_IRQ+0x90/0x100   <c01057a6> do_IRQ+0x26/0x40
Apr  9 13:00:04 nickolas kernel:  <c010396e> common_interrupt+0x1a/0x20   <c0101cdd> cpu_idle+0x4d/0xb0
Apr  9 13:00:04 nickolas kernel:  <c010f2cc> start_secondary+0x24c/0x4b0   <00000000> 0x0
Apr  9 13:00:04 nickolas kernel:  <c214ffb4> 0xc214ffb4  

I'm running 32 bit kernel on AMD64x2 w/ HIGHMEM enabled.
I think this is an old bug since the 3w_xxxx.c has not been changed for
a long time (at least since 2.6.16-rc1-mm4).

Please let me know if you want me to try some patches.

-- 
With best wishes,
	Nick Orlov.

