Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWDWILw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWDWILw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 04:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWDWILw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 04:11:52 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:17083
	"EHLO bifrost.lang.hm") by vger.kernel.org with ESMTP
	id S1751172AbWDWILw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 04:11:52 -0400
Date: Sun, 23 Apr 2006 01:11:50 -0700 (PDT)
From: David Lang <david@lang.hm>
X-X-Sender: dlang@david.lang.hm
To: linux-kernel@vger.kernel.org
Subject: i2o driver double free error in 2.6.17-rc2 (amd64)
Message-ID: <Pine.LNX.4.62.0604230042370.3287@qnivq.ynat.uz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the hardware:
nforce4-a939 mlb with a Athlon64 3800+ (dual core), 4G ram, 2x3-ware PATA 
cards (with 12x300G seagate drives), Adaptec 3120S raid controller with 2 
pairs of scsi drives

I've been having problems with this new machine locking up so I turned on 
just aobut every debugging option and setup a serial console, the full 
boot log (1.5M of it) is at http://lang.hm/linux/boot_log but the relavent 
portion of it seems to be blocks of the following errors

slab error in cache_free_debugcheck(): cache `i2o_iop0_msg_inpool': double free, or memory outside object was overwritten

<IRQ> <ffffffff802ae3d2>{__slab_error+36}
<ffffffff80232bb9>{cache_free_debugcheck+364} <ffffffff80207639>{kmem_cache_free+60}
<ffffffff80245f8a>{mempool_free_slab+18} <ffffffff8023017b>{mempool_free+113}
<ffffffff805c72b3>{i2o_block_request_fn+1164} <ffffffff804100d0>{serpent_setkey+2462}
<ffffffff8041e15a>{blk_start_queue+39} <ffffffff805c6aef>{i2o_block_reply+292}
<ffffffff805c2296>{i2o_driver_dispatch+475} <ffffffff805c3866>{i2o_pci_interrupt+52}
<ffffffff80210e74>{handle_IRQ_event+48} <ffffffff8029bf34>{__do_IRQ+163}
<ffffffff8026b00d>{do_IRQ+59} <ffffffff8026902f>{default_idle+0}
<ffffffff80260366>{ret_from_intr+0} <EOI> <ffffffff8026902f>{default_idle+0}
<ffffffff8026905e>{default_idle+47} <ffffffff8024a8d8>{cpu_idle+103}
<ffffffff80cf408d>{start_secondary+1134}
ffff81000135e050: redzone 1:0x170fc2a5, redzone 2:0x7cb8000.

I think I saw a compile-time error flash by (something about a cast 
between incompatable pointer types).

the kernel config is also on the website at http://lang.hm/linux/config

as this is a new box that I have not gotten working reliably yet I can't 
conclusivly rule out hardware problems. it's survived 48 hours of 
memtest86 and the various controller cards were out of an older system so 
they should be good.

David Lang
