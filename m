Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269806AbUJSU4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269806AbUJSU4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 16:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267359AbUJSUuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 16:50:17 -0400
Received: from vsmtp4alice-fr.tin.it ([212.216.176.150]:62099 "EHLO
	vsmtp4.tin.it") by vger.kernel.org with ESMTP id S269731AbUJSUqc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 16:46:32 -0400
Subject: oops in kernel 2.6.9
From: Stefano Vesa <stefanovesa@tiscali.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 19 Oct 2004 22:59:12 +0200
Message-Id: <1098219553.3569.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running kernel 2.6.9 fully preentible on a Slackware 10 with 
udev-040 ,hotplug 2004_09_23 and module-init-tools-3.0
I can reproduce a oops when I try, after unmounting the device, to
disconnect or power off a Plextor PX-W4824 USB burner from a uhci_hcd
host. When in X the machine hangs.
My machine is a pentium 3 on a 440BX chipset.

No problem with kernel 2.6.7.

Sorry if I have not made a subscription to the mailing list but
I am a newbie and don't understand very much the topics I read in it.
I hope it can be useful...

Oct 19 17:59:46 chopin kernel: sr 0:0:0:0: Illegal state transition
cancel->offline
Oct 19 17:59:46 chopin kernel: Badness in scsi_device_set_state at
drivers/scsi/scsi_lib.c:1688
Oct 19 17:59:46 chopin kernel:  [<c896bcc9>] scsi_device_set_state
+0xc9/0x120 [scsi_mod]
Oct 19 17:59:46 chopin kernel:  [<c89699ae>] scsi_eh_offline_sdevs
+0x6e/0x90 [scsi_mod]
Oct 19 17:59:46 chopin kernel:  [<c8969e83>] scsi_unjam_host+0xc3/0xd0
[scsi_mod]
Oct 19 17:59:46 chopin kernel:  [<c8969f38>] scsi_error_handler
+0xa8/0xd0 [scsi_mod]
Oct 19 17:59:46 chopin kernel:  [<c8969e90>] scsi_error_handler+0x0/0xd0
[scsi_mod]
Oct 19 17:59:46 chopin kernel:  [<c01023bd>] kernel_thread_helper
+0x5/0x18
Oct 19 17:59:46 chopin kernel: Unable to handle kernel paging request at
virtual address 5f6c656e
Oct 19 17:59:46 chopin kernel:  printing eip:
Oct 19 17:59:46 chopin kernel: c02281f3
Oct 19 17:59:46 chopin kernel: *pde = 00000000
Oct 19 17:59:46 chopin kernel: Oops: 0000 [#1]
Oct 19 17:59:46 chopin kernel: PREEMPT 
Oct 19 17:59:46 chopin kernel: Modules linked in: nls_utf8 isofs
nls_base sr_mod usb_storage scsi_mod snd_ice1712 snd_ice17xx_ak4xxx
snd_pcm snd_timer snd_page_alloc snd_ak4xxx_adda snd_cs8427
snd_ac97_codec snd_i2c snd_mpu401_uart snd_rawmidi snd soundcore usbhid
3c59x uhci_hcd usbcore intel_agp agpgart rtc
Oct 19 17:59:46 chopin kernel: CPU:    0
Oct 19 17:59:46 chopin kernel: EIP:    0060:[<c02281f3>]    Not tainted
VLI
Oct 19 17:59:46 chopin kernel: EFLAGS: 00010083   (2.6.9) 
Oct 19 17:59:46 chopin kernel: EIP is at as_requeue_request+0x93/0xf0
Oct 19 17:59:46 chopin kernel: eax: 5f6c656e   ebx: 00000000   ecx:
c7e50028   edx: c7f048b0
Oct 19 17:59:46 chopin kernel: esi: c7f048b0   edi: c7fd7740   ebp:
00000202   esp: c3895f04
Oct 19 17:59:46 chopin kernel: ds: 007b   es: 007b   ss: 0068
Oct 19 17:59:46 chopin kernel: Process scsi_eh_0 (pid: 3130,
threadinfo=c3894000 task=c7b94020)
Oct 19 17:59:46 chopin kernel: Stack: 00000000 c010479d 00000000
c01023bd c7f048b0 c3bb4040 c7e50028 c021f846 
Oct 19 17:59:46 chopin kernel:        c7e50028 c7f048b0 c7f048b0
c3bb4040 c02221cd c7e50028 c7f048b0 c7b94020 
Oct 19 17:59:46 chopin kernel:        00000286 c7a08800 c3bb4040
c7fd0a00 00001057 c896a247 c7e50028 c7f048b0 
Oct 19 17:59:46 chopin kernel: Call Trace:
Oct 19 17:59:46 chopin kernel:  [<c010479d>] print_context_stack
+0x2d/0x70
Oct 19 17:59:46 chopin kernel:  [<c01023bd>] kernel_thread_helper
+0x5/0x18
Oct 19 17:59:46 chopin kernel:  [<c021f846>] elv_requeue_request
+0x26/0x60
Oct 19 17:59:46 chopin kernel:  [<c02221cd>] blk_insert_request
+0xdd/0xe0
Oct 19 17:59:46 chopin kernel:  [<c896a247>] scsi_queue_insert+0x77/0xb0
[scsi_mod]
Oct 19 17:59:46 chopin kernel:  [<c8969daf>] scsi_eh_flush_done_q
+0x9f/0xb0 [scsi_mod]
Oct 19 17:59:46 chopin kernel:  [<c8969e4f>] scsi_unjam_host+0x8f/0xd0
[scsi_mod]
Oct 19 17:59:46 chopin kernel:  [<c8969f38>] scsi_error_handler
+0xa8/0xd0 [scsi_mod]
Oct 19 17:59:46 chopin kernel:  [<c8969e90>] scsi_error_handler+0x0/0xd0
[scsi_mod]
Oct 19 17:59:46 chopin kernel:  [<c01023bd>] kernel_thread_helper
+0x5/0x18
Oct 19 17:59:46 chopin kernel: Code: ff c7 43 38 02 00 00 00 8b 43 18 85
c0 74 19 8b 40 10 85 c0 74 12 ff 40 10 eb 0d 90 90 90 90 90 90 90 90 90
90 90 90 90 8b 47 2c <8b> 10 89 72 04 89 16 89 46 04 89 30 8b 5c 24 10
89 7c 24 20 8b 
Oct 19 17:59:46 chopin kernel:  <6>note: scsi_eh_0[3130] exited with
preempt_count 1


