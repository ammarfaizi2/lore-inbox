Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTKEJAu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 04:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbTKEJAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 04:00:49 -0500
Received: from vitelus.com ([64.81.243.207]:53150 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S262758AbTKEJAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 04:00:48 -0500
Date: Wed, 5 Nov 2003 00:58:17 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org
Subject: Badness in as_completed_request
Message-ID: <20031105085817.GH21853@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been seeing this about every day for the past month or so, while
tracking 2.6.0-test*. Usually by the time I feel like reporting it I'm
a few revisions behind and decide to upgrade before complaining about
it. Now I'm running -test9 and it still happens. This happens every
few day or so under normal load and every few minutes under high I/O
load. I'm running an x86 system with a 3ware RAID5:

Badness in as_completed_request at drivers/block/as-iosched.c:919
Call Trace:
 [<c021675d>] as_completed_request+0x1ad/0x1e0
 [<c020f84f>] elv_completed_request+0x1f/0x30
 [<c0211a4c>] __blk_put_request+0x3c/0xc0
 [<c0212902>] end_that_request_last+0x52/0xa0
 [<c0238b72>] scsi_end_request+0xb2/0xe0
 [<c0238f0b>] scsi_io_completion+0x1bb/0x470
 [<c02437ea>] sd_rw_intr+0x5a/0x1e0
 [<c02351db>] scsi_finish_command+0x7b/0xc0
 [<c011feeb>] update_wall_time+0xb/0x40
 [<c02350ee>] scsi_softirq+0xae/0xe0
 [<c011c250>] do_softirq+0x90/0xa0
 [<c010ab05>] do_IRQ+0xc5/0xe0
 [<c0105000>] _stext+0x0/0x30
 [<c01090a8>] common_interrupt+0x18/0x20
 [<c0105000>] _stext+0x0/0x30
 [<c0106e13>] default_idle+0x23/0x30
 [<c0106e7c>] cpu_idle+0x2c/0x40
 [<c035c69f>] start_kernel+0x13f/0x150
 [<c035c430>] unknown_bootoption+0x0/0x100

