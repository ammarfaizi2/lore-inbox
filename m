Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbTIYMnc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 08:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbTIYMnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 08:43:32 -0400
Received: from darville.vm.bytemark.co.uk ([212.13.199.38]:7684 "EHLO
	david.darville.name") by vger.kernel.org with ESMTP id S261316AbTIYMnb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 08:43:31 -0400
Date: Thu, 25 Sep 2003 13:43:28 +0100
From: David Darville <david@darville.name>
To: linux-kernel@vger.kernel.org
Subject: Fusion MPT SCSI driver in 2.4.22 crashes with highmem
Message-ID: <20030925124328.GA574@david.darville.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to use a diagnostics tool for for my tape drives, I get a kernel
oops. The tape drives are attached to a LSI Logic 53c1030 based Ultra320
controller on a dual Xeon box, and I am using the Fusion MPT driver included
in the version 2.4.22 kernel.
While trying to debug the problem, I found out that everything works when I
compile the kernel without highmem support.


The oops I get is:
kernel BUG in header file at line 162
kernel BUG at panic.c:141!
invalid operand: 0000
CPU:    0
EIP:    0010:[__out_of_line_bug+15/36] Tainted: P
EFLAGS: 00010086
eax: 00000026   ebx: f7928a00   ecx: 00000002 edx: 02000000
esi: c3e8207c   edi: f79ba1f0   ebp: f79ba1d8 esp: f6fabc68
ds: 0018   es: 0018   ss: 0018
Process hp_ltt (pid: 590, stackpage=f6fab000)
Stack: c026fa80 000000a2 c0202f38 000000a2 f7928a00 c3e8207c f79ba1c0 f79ba1d8
       c02c2934 c0132070 00000000 00000000 ffffffff 00000000 0000000e 00000060
       00000000 00000002 c0204831 c3e8207c f7928a00 f79ba1c0 0000005a 00000293
Call Trace:    [mptscsih_AddSGE+200/832] [__alloc_pages+64/352]
 [mptscsih_qcmd+621/1288]  [scsi_dispatch_cmd+649/904] [scsi_old_done+0/1500]
 [scsi_request_fn+826/892]  [__scsi_insert_special+110/128]
 [scsi_insert_special_req+26/32] [scsi_do_req+328/368]
 [sg_common_write+587/604] [sg_cmd_done_bh+0/912] [sg_new_write+539/576]
 [sg_ioctl+616/3004] [journal_dirty_metadata+356/396] [__alloc_pages+64/352]
 [do_wp_page+112/668] [handle_mm_fault+135/184] [do_page_fault+380/1178]
 [do_page_fault+0/1178] [sys_rt_sigaction+159/324] [sys_ioctl+685/746]
 [error_code+52/60] [system_call+51/56]

Code: 0f 0b 8d 00 a6 fa 26 c0 eb fe 8d 74 26 00 8d bc 27 00 00 00

---
David Darville
