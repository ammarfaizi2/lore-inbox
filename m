Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVEPVeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVEPVeQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVEPVeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:34:11 -0400
Received: from ezoffice.mandriva.com ([84.14.106.134]:39432 "EHLO
	ezoffice.mandriva.com") by vger.kernel.org with ESMTP
	id S261905AbVEPVdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:33:08 -0400
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Cc: Yann Droneaud <ydroneaud@mandriva.com>
From: Yann Droneaud <ydroneaud@mandriva.com>
Subject: Oops with IPMI and ACPI disabled on command line
Date: 16 May 2005 23:33:01 +0200
Message-ID: <m27jhyzwj6.fsf@firedrake.mandriva.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I encounter an Oops with IPMI modules using acpi=ht|off,
I fixed it (only the Oops, IPMI is still not available on the system),
by two patches which follows.

Here is the Oops messages for reference:

May 16 11:18:29 localhost kernel: ipmi message handler version v33
May 16 11:18:29 localhost kernel: IPMI System Interface driver version v33, KCS version v33, SMIC version v33, BT version v33
May 16 11:18:29 localhost kernel:     ACPI-0166: *** Error: Invalid address flags 8
May 16 11:18:29 localhost kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
May 16 11:18:29 localhost kernel:  printing eip:
May 16 11:18:29 localhost kernel: c01ff793
May 16 11:18:29 localhost kernel: *pde = 3764b001
May 16 11:18:29 localhost kernel: Oops: 0000 [#1]
May 16 11:18:29 localhost kernel: SMP
May 16 11:18:29 localhost kernel: Modules linked in: ipmi_si ipmi_msghandler af_packet floppy bcm5700 isofs nls_base md ehci_
hcd uhci_hcd usbcore genrtc unix sd_mod qla2300 qla2xxx scsi_transport_fc cciss ata_piix libata
May 16 11:18:29 localhost kernel: CPU:    0
May 16 11:18:29 localhost kernel: EIP:    0060:[acpi_get_firmware_table+630/694]    Not tainted VLI
May 16 11:18:29 localhost kernel: EIP:    0060:[<c01ff793>]    Not tainted VLI
May 16 11:18:29 localhost kernel: EFLAGS: 00010202   (2.6.11.9-mdvc)
May 16 11:18:29 localhost kernel: EIP is at acpi_get_firmware_table+0x276/0x2b6
May 16 11:18:29 localhost kernel: eax: 00000000   ebx: c21602c0   ecx: 00000000   edx: c21602c0
May 16 11:18:29 localhost ipmi: Starting IPMI failed
May 16 11:18:29 localhost kernel: esi: 00001001   edi: c02bfc49   ebp: 00000008   esp: f7f11eec
May 16 11:18:30 localhost kernel: ds: 007b   es: 007b   ss: 0068
May 16 11:18:30 localhost kernel: Process modprobe (pid: 2413, threadinfo=f7f11000 task=f744d540)
May 16 11:18:30 localhost kernel: Stack: c0119583 f76bff44 00000001 00000000 00000000 00000000 00000008 7fff32c0
May 16 11:18:30 localhost kernel:        00000000 f7f11f40 ffffffed 00000000 00000000 00000000 f8b81453 f8b851f9
May 16 11:18:30 localhost kernel:        00000001 00000008 f7f11f3c 000047d9 00000296 ffffffed f7f11f78 00000000
May 16 11:18:30 localhost kernel: Call Trace:
May 16 11:18:30 localhost kernel:  [__wake_up_common+63/94] __wake_up_common+0x3f/0x5e
May 16 11:18:30 localhost kernel:  [<c0119583>] __wake_up_common+0x3f/0x5e
May 16 11:18:30 localhost kernel:  [pg0+947508307/1069655040] try_init_acpi+0x41/0x2a9 [ipmi_si]
May 16 11:18:30 localhost kernel:  [<f8b81453>] try_init_acpi+0x41/0x2a9 [ipmi_si]
May 16 11:18:30 localhost kernel:  [pg0+947512705/1069655040] init_one_smi+0x4e2/0x57d [ipmi_si]
May 16 11:18:30 localhost kernel:  [<f8b82581>] init_one_smi+0x4e2/0x57d [ipmi_si]
May 16 11:18:30 localhost kernel:  [vprintk+312/367] vprintk+0x138/0x16f
May 16 11:18:30 localhost kernel:  [<c011dc62>] vprintk+0x138/0x16f
May 16 11:18:30 localhost kernel:  [pg0+944169095/1069655040] init_ipmi_si+0x87/0x22f [ipmi_si]
May 16 11:18:30 localhost kernel:  [<f8852087>] init_ipmi_si+0x87/0x22f [ipmi_si]
May 16 11:18:30 localhost kernel:  [sys_init_module+371/531] sys_init_module+0x173/0x213
May 16 11:18:30 localhost kernel:  [<c01361d9>] sys_init_module+0x173/0x213
May 16 11:18:30 localhost kernel:  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
May 16 11:18:30 localhost kernel:  [<c0102fd5>] sysenter_past_esp+0x52/0x75
May 16 11:18:30 localhost kernel: Code: ff 83 c4 0c 85 c0 89 c6 75 1e 8b 54 24 10 8b 42 0c 8b 54 24 48 89 02 eb 0f 45 3b 6c 24 0c e9 4e ff ff ff be 06 00 00 00 8b 43 0c <ff> 70 04 50 e8 16 c5 fe ff 53 e8 a7 c4 fe ff 83 c4 0c 83 7c 24

Regards

-- 
Yann Droneaud <ydroneaud@mandriva.com>
Consulting Engineer
Professional Services
Mandriva http://mandriva.com/ (previously known as Mandrakesoft)
