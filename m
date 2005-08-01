Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVHAW6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVHAW6O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 18:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVHAW6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 18:58:13 -0400
Received: from hermes.domdv.de ([193.102.202.1]:56846 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261283AbVHAW5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 18:57:47 -0400
Message-ID: <42EEA8E9.5090107@domdv.de>
Date: Tue, 02 Aug 2005 00:57:45 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050724)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcel@holtmann.org
CC: rml@tech9.net, Dominik Brodowski <linux@dominikbrodowski.net>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: 2.6.13-rc4-git4: bluetooth oops on pcmcia shutdown
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------020201090308040708030208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020201090308040708030208
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

The attached bluetooth oops can be reliably reproduced on my x86_64
laptop. It happens when hciattach is still running while a sequence of
"cardctl eject" and then "killproc /sbin/cardmgr" is executed.
Though this seems to point to preempt I could manage to cause similar
oopses on non-preemptible kernels a while ago.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------020201090308040708030208
Content-Type: text/plain;
 name="bluez_oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez_oops.txt"

Unable to handle kernel NULL pointer dereference at 0000000000000014 RIP: 
<ffffffff802cc1fb>{uart_flush_buffer+43}
PGD 0 
Oops: 0002 [1] PREEMPT 
CPU 0 
Modules linked in: hci_usb serial_cs pcmcia yenta_socket rsrc_nonstatic pcmcia_core ehci_hcd uhci_hcd parport_pc parport snd_via82xx_modem snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss hfc_usb ipaq usbhid pl2303 usbserial usb_storage snd_via82xx gameport sd_mod snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device hisax isdn nls_iso8859_15 nls_cp850 ip_conntrack_ftp ipt_state ip_conntrack ipt_ULOG iptable_filter ipt_REJECT ip_tables nfsd exportfs lockd sunrpc autofs4 cifs sbp2
Pid: 2995, comm: hciattach Not tainted 2.6.13-rc4-git4-gringo
RIP: 0010:[<ffffffff802cc1fb>] <ffffffff802cc1fb>{uart_flush_buffer+43}
RSP: 0018:ffff81001c0b9b68  EFLAGS: 00010013
RAX: 0000000000000000 RBX: ffff810002208c80 RCX: ffff81001e6d3018
RDX: 0000000000000000 RSI: ffff81001c0b9b58 RDI: 0000000000000001
RBP: ffff81001e6d3000 R08: ffff81003f01ce98 R09: 0000000000000001
R10: 00000000ffffffff R11: 0000000000000246 R12: ffff81003d76ba80
R13: ffffffff8052e6c0 R14: 0000000000000000 R15: 0000000000000000
FS:  00002aaaaaf3edb0(0000) GS:ffffffff8061c800(0000) knlGS:00000000556d16b0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000014 CR3: 000000001b1a2000 CR4: 00000000000006e0
Process hciattach (pid: 2995, threadinfo ffff81001c0b8000, task ffff81001f94f4a0)
Stack: 0000000000000292 ffff81003db82200 ffff81001e6d3000 ffffffff803567ac 
       0000000000000000 ffff81003db82200 ffff81002614ac00 ffffffff803567e4 
       ffffffff8052e6c0 ffffffff80356931 
Call Trace:<ffffffff803567ac>{hci_uart_flush+92} <ffffffff803567e4>{hci_uart_close+20}
       <ffffffff80356931>{hci_uart_tty_close+49} <ffffffff802b108d>{release_dev+1805}
       <ffffffff80159a7f>{free_hot_cold_page+239} <ffffffff80163876>{free_pgd_range+1078}
       <ffffffff802617f6>{_atomic_dec_and_lock+38} <ffffffff8018f863>{dput+35}
       <ffffffff802b1191>{tty_release+17} <ffffffff80177642>{__fput+178}
       <ffffffff80175cbe>{filp_close+110} <ffffffff80132813>{put_files_struct+115}
       <ffffffff801331da>{do_exit+522} <ffffffff8013b745>{__dequeue_signal+501}
       <ffffffff80133dad>{do_group_exit+269} <ffffffff8013d8eb>{get_signal_to_deliver+1515}
       <ffffffff8010ce9f>{do_signal+159} <ffffffff80408174>{thread_return+0}
       <ffffffff80408250>{thread_return+220} <ffffffff80139b31>{lock_timer_base+49}
       <ffffffff80139be8>{del_timer+104} <ffffffff80408f6c>{schedule_timeout+156}
       <ffffffff8013a7c0>{process_timeout+0} <ffffffff8010db2f>{sysret_signal+28}
       <ffffffff8010de17>{ptregscall_common+103} 

Code: c7 40 14 00 00 00 00 c7 40 10 00 00 00 00 ff 34 24 9d bf 01 
RIP <ffffffff802cc1fb>{uart_flush_buffer+43} RSP <ffff81001c0b9b68>
CR2: 0000000000000014
 <1>Fixing recursive fault but reboot is needed!
scheduling while atomic: hciattach/0x00000001/2995

Call Trace:<ffffffff80407caa>{schedule+122} <ffffffff801330c6>{do_exit+246}
       <ffffffff802bf5c5>{do_unblank_screen+21} <ffffffff8011d95f>{do_page_fault+1807}
       <ffffffff8010e399>{error_exit+0} <ffffffff802cc1fb>{uart_flush_buffer+43}
       <ffffffff802cc1f7>{uart_flush_buffer+39} <ffffffff803567ac>{hci_uart_flush+92}
       <ffffffff803567e4>{hci_uart_close+20} <ffffffff80356931>{hci_uart_tty_close+49}
       <ffffffff802b108d>{release_dev+1805} <ffffffff80159a7f>{free_hot_cold_page+239}
       <ffffffff80163876>{free_pgd_range+1078} <ffffffff802617f6>{_atomic_dec_and_lock+38}
       <ffffffff8018f863>{dput+35} <ffffffff802b1191>{tty_release+17}
       <ffffffff80177642>{__fput+178} <ffffffff80175cbe>{filp_close+110}
       <ffffffff80132813>{put_files_struct+115} <ffffffff801331da>{do_exit+522}
       <ffffffff8013b745>{__dequeue_signal+501} <ffffffff80133dad>{do_group_exit+269}
       <ffffffff8013d8eb>{get_signal_to_deliver+1515} <ffffffff8010ce9f>{do_signal+159}
       <ffffffff80408174>{thread_return+0} <ffffffff80408250>{thread_return+220}
       <ffffffff80139b31>{lock_timer_base+49} <ffffffff80139be8>{del_timer+104}
       <ffffffff80408f6c>{schedule_timeout+156} <ffffffff8013a7c0>{process_timeout+0}
       <ffffffff8010db2f>{sysret_signal+28} <ffffffff8010de17>{ptregscall_common+103}
       

--------------020201090308040708030208--
