Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVE3VNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVE3VNI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 17:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVE3VMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 17:12:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:2696 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261763AbVE3VIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 17:08:16 -0400
Date: Mon, 30 May 2005 14:07:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ake.Sandgren@hpc2n.umu.se (Ake)
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Andrew Vasquez <andrew.vasquez@qlogic.com>
Subject: Re: 2.6.12-rc5: sleeping function called from invalid context
 (qla2xxx/scsi_transport_fc?)
Message-Id: <20050530140700.5a4fafa1.akpm@osdl.org>
In-Reply-To: <20050530125118.GG17514@hpc2n.umu.se>
References: <20050530125118.GG17514@hpc2n.umu.se>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ake.Sandgren@hpc2n.umu.se (Ake) wrote:
>
> Hi!
> I got the following when i pulled the FC cable from one of my qla2312
> cards.
> This is a 2.6.12-rc5 kernel (with udm1 patches for 2.6.12-rc2)
> 
> 
> May 30 14:12:45 ican-i kernel: [ 1109.864830] qla2300 0000:03:09.0: LOOP DOWN detected.
> May 30 14:12:45 ican-i kernel: [ 1109.875948] Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
> May 30 14:12:45 ican-i kernel: [ 1109.894492] in_atomic():1, irqs_disabled():1
> May 30 14:12:45 ican-i kernel: [ 1109.903864]  [dump_stack+30/48] dump_stack+0x1e/0x30
> May 30 14:12:45 ican-i kernel: [ 1109.913648]  [__might_sleep+167/176] __might_sleep+0xa7/0xb0
> May 30 14:12:45 ican-i kernel: [ 1109.924003]  [device_for_each_child+35/144] device_for_each_child+0x23/0x90
> May 30 14:12:45 ican-i kernel: [ 1109.935865]  [pg0+944279047/1069622272] scsi_target_block+0x57/0x60 [scsi_mod]
> May 30 14:12:45 ican-i kernel: [ 1109.949142]  [pg0+944996009/1069622272] fc_remote_port_block+0x39/0x60 [scsi_transport_fc]
> May 30 14:12:45 ican-i kernel: [ 1109.964649]  [pg0+946826440/1069622272] qla2x00_mark_all_devices_lost+0x78/0x80 [qla2xxx]
> May 30 14:12:45 ican-i kernel: [ 1109.980000]  [pg0+946857000/1069622272] qla2x00_async_event+0x4b8/0xd20 [qla2xxx]
> May 30 14:12:45 ican-i kernel: [ 1109.993778]  [pg0+946855321/1069622272] qla2300_intr_handler+0x149/0x220 [qla2xxx]
> May 30 14:12:45 ican-i kernel: [ 1110.007748]  [handle_IRQ_event+51/112] handle_IRQ_event+0x33/0x70
> May 30 14:12:45 ican-i kernel: [ 1110.018709]  [__do_IRQ+230/320] __do_IRQ+0xe6/0x140
> May 30 14:12:45 ican-i kernel: [ 1110.028321]  [do_IRQ+55/112] do_IRQ+0x37/0x70
> May 30 14:12:45 ican-i kernel: [ 1110.037362]  [common_interrupt+26/32] common_interrupt+0x1a/0x20
> May 30 14:12:45 ican-i kernel: [ 1110.048270]  [cpu_idle+114/128] cpu_idle+0x72/0x80
> May 30 14:12:45 ican-i kernel: [ 1110.057657]  [start_kernel+407/480] start_kernel+0x197/0x1e0
> May 30 14:12:45 ican-i kernel: [ 1110.068222]  [L6+0/2] 0xc010020e
> May 30 14:13:03 ican-i kernel: [ 1127.266792] qla2300 0000:03:09.0: LIP reset occured (f8e8).
> May 30 14:13:03 ican-i kernel: [ 1127.373378] qla2300 0000:03:09.0: LIP occured (f7e8).
> May 30 14:13:03 ican-i kernel: [ 1127.384479] qla2300 0000:03:09.0: LOOP UP detected (2 Gbps).
> 

This was reported (and anaylsed) a month ago:

	http://lkml.org/lkml/2005/4/29/82

I don't know if anything has been done about it yet though?
