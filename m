Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262783AbULQK6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbULQK6Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 05:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbULQK6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 05:58:16 -0500
Received: from f19.mail.ru ([194.67.57.49]:44300 "EHLO f19.mail.ru")
	by vger.kernel.org with ESMTP id S262783AbULQK6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 05:58:10 -0500
From: =?koi8-r?Q?=E9=C7=CF=D2=D8=20=E2=CF=C7=CF=C7=CD=C1=DA=CF=D7=20?= 
	<ygrex@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: usb-storage bug
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 192.168.10.16 via proxy [195.209.240.169]
Date: Fri, 17 Dec 2004 13:58:09 +0300
Reply-To: =?koi8-r?Q?=E9=C7=CF=D2=D8=20=E2=CF=C7=CF=C7=CD=C1=DA=CF=D7?= 
	  <ygrex@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1CfFoH-000505-00.ygrex-mail-ru@f19.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While using usb HDD i've met a bug.

I mounted usb HDD (USB2.0 interface, but my motherboard supports USB1.0 only; does it has meaning?), "cd /mnt/usb && ls". All work properly. I can go through all HDD without any warning. Then i tried to write to this drive some files. A couple of files was copied, then i saw a strange messages 'bout I/O error on some blocks (does it occured while flushing buffers?), i've not copied. After a while i got the following:
{

------------[ cut here ]------------
kernel BUG at drivers/block/as-iosched.c:1852!
invalid operand: 0000 [#1]
Modules linked in: sd_mod usb_storage uhci_hcd usblp usbcore pcspkr psmouse snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_event snd_seq_midi_emul snd_seq snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device
snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd soundcore nls_koi8_r nls_cp866 vfat fat nls_base rtc
CPU:    0
EIP:    0060:[<c01cc89c>]    Not tainted VLI
EFLAGS: 00010283   (2.6.9)
EIP is at as_exit+0x5c/0x70
eax: c10f62d4   ebx: c10f62c0   ecx: 00000252   edx: c0395e98
esi: c11c70b4   edi: 00000282   ebp: c110d2b4   esp: c0395ed8
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_0 (pid: 1284, threadinfo=c0395000 task=c007baa0)
Stack: c11c7028 c01c4454 c11c7028 c11c7034 c01c62b6 c11c7028 c1705424 c1705400
       c01e669d c11c7028 c17055a8 c02b2410 c02b2440 c110d2d8 c01c0744 c1705584
       c019f807 c17055a8 c17055c0 c019f810 c1705400 00000246 c019fb25 c17055a8
Call Trace:
 [<c01c4454>] elevator_exit+0x14/0x20
 [<c01c62b6>] blk_cleanup_queue+0x26/0x70
 [<c01e669d>] scsi_device_dev_release+0xcd/0xe0
 [<c01c0744>] device_release+0x14/0x50
 [<c019f807>] kobject_cleanup+0x67/0x70
 [<c019f810>] kobject_release+0x0/0x10
 [<c019fb25>] kref_put+0x25/0x70
 [<c019f836>] kobject_put+0x16/0x20
 [<c019f810>] kobject_release+0x0/0x10
 [<c01e09ee>] __scsi_iterate_devices+0x4e/0x60
 [<c01e2ceb>] scsi_eh_stu+0x8b/0xf0
 [<c01e3397>] scsi_eh_ready_devs+0x17/0x60
 [<c01e34ef>] scsi_unjam_host+0x8f/0xa0
 [<c01e35a6>] scsi_error_handler+0xa6/0xd0
 [<c01e3500>] scsi_error_handler+0x0/0xd0
 [<c0102315>] kernel_thread_helper+0x5/0x10
Code: 83 cc 00 00 00 50 e8 c4 b6 ff ff 8b 43 30 50 e8 bb 63 f6 ff 83 c4 0c 89 5c 24 08 5b e9 ae 63 f6 ff 0f 0b 3d 07 c3 1b 25 c0 eb cb <0f> 0b 3c 07 c3 1b 25 c0 eb b9 8d 76 00 8d bc 27 00 00 00 00 55

}

I use ASP Linux distro (if it's important) and linux-2.6.9
Then current tty was busy, drive (with light HDD indicator) was busy, to kill process usb-storage is impossible (i used "kill PID" in another tty), when i tried to kill cp process it appeared again or did nothing at all (i tried about 10 times).
I probed kill or term all processes with SysRq magic key but in vain. Ctrl-Alt-Del showed me "Killing all processes" and nothing else. All what i was able to do is press reset key on a system box.
Then i tried to write to this drive files again but with a same result.

Please, what can i do for you are able to conceive this circumstance? To learn english better e.g. :)
Help me with using usb HDD please.
