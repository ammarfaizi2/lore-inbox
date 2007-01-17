Return-Path: <linux-kernel-owner+w=401wt.eu-S932261AbXAQKZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbXAQKZK (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 05:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbXAQKZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 05:25:09 -0500
Received: from main.gmane.org ([80.91.229.2]:57309 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932261AbXAQKZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 05:25:07 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicolas Bareil <nico@chdir.org>
Subject: Linux 2.6.19.2 : Oops 
Date: Wed, 17 Jan 2007 11:21:59 +0100
Message-ID: <873b6a6ji0.fsf@boz.loft.chdir.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 88.191.14.36
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.92 (gnu/linux)
Cancel-Lock: sha1:Cvj5LX4R1o740b1KNVtNsj2fl1Y=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Since 2.6.19, I get the following Oops once a day, always with the same
process, newspipe[1] which use a lot of CPU, threads and I/O.

The kernel is patched by Grsecurity. The ext3 filesystem is on a
software RAID device (the two disks are SATA2). I tested the 
hardware (RAM, SMART disks) but nothing seem problematic.

kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 00000004
kernel: printing eip:
kernel: b0176344
kernel: *pgd =    0
kernel: *pmd =    0
kernel: Oops: 0000 [#1]
kernel: CPU:    0
kernel: EIP:    0060:[<b0176344>]    Not tainted VLI
kernel: EFLAGS: 00210286   (2.6.19.2-grsec #1)
kernel: EIP is at do_generic_mapping_read+0x34/0x4e0
kernel: eax: d8deeb50   ebx: 0000001b   ecx: 00000000   edx: ed6e1df4
kernel: esi: 00000000   edi: ed6e1e1c   ebp: e6235a40   esp: ed6e1dac
kernel: ds: 0068   es: 0068   ss: 0068
kernel: Process python (pid: 13360, ti=ed6e0000 task=daf1f030 task.ti=ed6e0000)
kernel: Stack: d8deeb50 00000001 00000000 00001000 00000010 00000000 00000000 ed6e1df4 
kernel: d8deeb50 00000010 00000000 00000010 00000010 0000000e 000105a5 00000000 
kernel: 00000000 00001000 00000000 00000020 00000000 00000020 0000000f 00000000 
kernel: Call Trace:
kernel: [<b01788f3>] generic_file_aio_read+0xf3/0x230
kernel: [<b0175a80>] file_read_actor+0x0/0x130
kernel: [<b019444d>] do_sync_read+0xed/0x130
kernel: [<b016a6d0>] autoremove_wake_function+0x0/0x60
kernel: [<b01848fc>] __vma_link+0x3c/0x70
kernel: [<b0185318>] vma_link+0x38/0xc0
kernel: [<b0194ed4>] vfs_read+0xd4/0x1c0
kernel: [<b019539b>] sys_read+0x4b/0x80
kernel: [<b0140047>] syscall_call+0x7/0xb
kernel: [<b014005f>] restore_all+0x0/0x18
kernel: =======================
kernel: Code: 83 ec 70 8b 84 24 84 00 00 00 8d 54 24 48 89 d7 8b b4 24 88 00 00 00 fc 8b 00 89 54 24 1c 89 44 24 20 f3 a5 8b b4 24 90 00 00 00 <8b> 5e 04 8b 0e 8b b4 24 94 00 00 00 89 da c1 fa 0c 89 c8 89 54 
kernel: EIP: [<b0176344>] do_generic_mapping_read+0x34/0x4e0 SS:ESP 0068:ed6e1dac

My config is available on http://chdir.org/~nbareil/config-2.6.19.2-grsec.gz

Thank you!

Footnotes: 
[1]  http://newspipe.sourceforge.net/

-- 
Nicolas Bareil                                  http://chdir.org/~nico/
OpenPGP=0xAE4F7057 Fingerprint=34DB22091049FB2F33E6B71580F314DAAE4F7057

