Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVE3MvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVE3MvZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 08:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVE3MvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 08:51:24 -0400
Received: from egg.hpc2n.umu.se ([130.239.45.244]:34712 "EHLO egg.hpc2n.umu.se")
	by vger.kernel.org with ESMTP id S261520AbVE3MvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 08:51:22 -0400
Date: Mon, 30 May 2005 14:51:18 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc5: sleeping function called from invalid context (qla2xxx/scsi_transport_fc?)
Message-ID: <20050530125118.GG17514@hpc2n.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Ake.Sandgren@hpc2n.umu.se (Ake)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I got the following when i pulled the FC cable from one of my qla2312
cards.
This is a 2.6.12-rc5 kernel (with udm1 patches for 2.6.12-rc2)


May 30 14:12:45 ican-i kernel: [ 1109.864830] qla2300 0000:03:09.0: LOOP DOWN detected.
May 30 14:12:45 ican-i kernel: [ 1109.875948] Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
May 30 14:12:45 ican-i kernel: [ 1109.894492] in_atomic():1, irqs_disabled():1
May 30 14:12:45 ican-i kernel: [ 1109.903864]  [dump_stack+30/48] dump_stack+0x1e/0x30
May 30 14:12:45 ican-i kernel: [ 1109.913648]  [__might_sleep+167/176] __might_sleep+0xa7/0xb0
May 30 14:12:45 ican-i kernel: [ 1109.924003]  [device_for_each_child+35/144] device_for_each_child+0x23/0x90
May 30 14:12:45 ican-i kernel: [ 1109.935865]  [pg0+944279047/1069622272] scsi_target_block+0x57/0x60 [scsi_mod]
May 30 14:12:45 ican-i kernel: [ 1109.949142]  [pg0+944996009/1069622272] fc_remote_port_block+0x39/0x60 [scsi_transport_fc]
May 30 14:12:45 ican-i kernel: [ 1109.964649]  [pg0+946826440/1069622272] qla2x00_mark_all_devices_lost+0x78/0x80 [qla2xxx]
May 30 14:12:45 ican-i kernel: [ 1109.980000]  [pg0+946857000/1069622272] qla2x00_async_event+0x4b8/0xd20 [qla2xxx]
May 30 14:12:45 ican-i kernel: [ 1109.993778]  [pg0+946855321/1069622272] qla2300_intr_handler+0x149/0x220 [qla2xxx]
May 30 14:12:45 ican-i kernel: [ 1110.007748]  [handle_IRQ_event+51/112] handle_IRQ_event+0x33/0x70
May 30 14:12:45 ican-i kernel: [ 1110.018709]  [__do_IRQ+230/320] __do_IRQ+0xe6/0x140
May 30 14:12:45 ican-i kernel: [ 1110.028321]  [do_IRQ+55/112] do_IRQ+0x37/0x70
May 30 14:12:45 ican-i kernel: [ 1110.037362]  [common_interrupt+26/32] common_interrupt+0x1a/0x20
May 30 14:12:45 ican-i kernel: [ 1110.048270]  [cpu_idle+114/128] cpu_idle+0x72/0x80
May 30 14:12:45 ican-i kernel: [ 1110.057657]  [start_kernel+407/480] start_kernel+0x197/0x1e0
May 30 14:12:45 ican-i kernel: [ 1110.068222]  [L6+0/2] 0xc010020e
May 30 14:13:03 ican-i kernel: [ 1127.266792] qla2300 0000:03:09.0: LIP reset occured (f8e8).
May 30 14:13:03 ican-i kernel: [ 1127.373378] qla2300 0000:03:09.0: LIP occured (f7e8).
May 30 14:13:03 ican-i kernel: [ 1127.384479] qla2300 0000:03:09.0: LOOP UP detected (2 Gbps).

-- 
Ake Sandgren, HPC2N, Umea University, S-90187 Umea, Sweden
Internet: ake@hpc2n.umu.se	Phone: +46 90 7866134 Fax: +46 90 7866126
Mobile: +46 70 7716134 WWW: http://www.hpc2n.umu.se
