Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266216AbUI0Hpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUI0Hpq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 03:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUI0Hpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 03:45:46 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:57313
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S266216AbUI0Hpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 03:45:39 -0400
Message-ID: <4157C407.20406@bio.ifi.lmu.de>
Date: Mon, 27 Sep 2004 09:40:55 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.8.1: kernel oops (__crc_pm_idle)
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get regularly kernel oopses with 2.6.8.1 on one of our hosts. Its an Athlon
XP 3000+ with an Asus A7V8X-X mainboard. I've five identical hosts running the
same software, but I see the oopses just on this host, and it show always this
"__crc_pm_idle" in the EIP value. Does that indicate some error with power
management (pm)?
The bios settings for all hosts are the same (powermanagement enabled in the bios,
but no timeouts set for anything), and the kernel has acpi compiled in. The
messages about apci etc. from boot.msg are identical on all hosts.
I could not relate the oops to some special action or process, there are no
other messages in /var/log/messages right before or after the ops. They are
always some minutes earlier or later.

Here's the output from /var/log/messages and ksymoops. Hope this helps!

cu,
Frank

Sep 27 07:49:58 turan kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Sep 27 07:49:58 turan kernel:  printing eip:
Sep 27 07:49:58 turan kernel: f8ab4ad5
Sep 27 07:49:58 turan kernel: *pde = 00000000
Sep 27 07:49:58 turan kernel: Oops: 0000 [#6]
Sep 27 07:49:58 turan kernel: Modules linked in: osst edd evdev joydev st via_ircc irda crc_ccitt ehci_hcd sg usb_storage uhci_hcd usbcore ohci1394 ieee1394 
nls_utf8 vfat fat udf sr_mod fglrx snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_via82xx snd_ac97_codec snd_pcm ipv6 snd_timer 
snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore it87 i2c_sensor i2c_isa i2c_core ide_cd subfs dm_mod
Sep 27 07:49:58 turan kernel: CPU:    0
Sep 27 07:49:59 turan kernel: EIP:    0060:[__crc_pm_idle+1723478/2974522]    Tainted: PF
Sep 27 07:49:59 turan kernel: EIP:    0060:[<f8ab4ad5>]    Tainted: PF
Sep 27 07:49:59 turan kernel: EFLAGS: 00010086   (2.6.8-1.6-bio-default)
Sep 27 07:49:59 turan kernel: EIP is at sig_notifier+0x5/0x50 [fglrx]
Sep 27 07:49:59 turan kernel: eax: f8ad7f88   ebx: f36d4088   ecx: 00000000   edx: f25b38b0
Sep 27 07:49:59 turan kernel: esi: 00000013   edi: e5208000   ebp: 00000012   esp: e5209ecc
Sep 27 07:49:59 turan kernel: ds: 007b   es: 007b   ss: 0068
Sep 27 07:49:59 turan kernel: Process sproingies (pid: 6838, threadinfo=e5208000 task=f25b38b0)
Sep 27 07:49:59 turan kernel: Stack: f36d4088 c0123369 00000000 e5209f28 00000000 e5209f28 f25b38b0 f25b3dd4
Sep 27 07:49:59 turan kernel:        c0123473 e5208000 f25b3dd4 e5208000 ffffe000 c01246d9 e5208000 f25b3dd4
Sep 27 07:49:59 turan kernel:        e5209fc4 e5209f28 e5209fc4 f25b3dd4 e5208000 e5208000 c01059c9 f7c4bf4c
Sep 27 07:49:59 turan kernel: Call Trace:
Sep 27 07:49:59 turan kernel:  [__dequeue_signal+137/336] __dequeue_signal+0x89/0x150
Sep 27 07:49:59 turan kernel:  [<c0123369>] __dequeue_signal+0x89/0x150
Sep 27 07:49:59 turan kernel:  [dequeue_signal+67/112] dequeue_signal+0x43/0x70
Sep 27 07:49:59 turan kernel:  [<c0123473>] dequeue_signal+0x43/0x70
Sep 27 07:49:59 turan kernel:  [get_signal_to_deliver+89/720] get_signal_to_deliver+0x59/0x2d0
Sep 27 07:49:59 turan kernel:  [<c01246d9>] get_signal_to_deliver+0x59/0x2d0
Sep 27 07:49:59 turan kernel:  [do_signal+73/240] do_signal+0x49/0xf0
Sep 27 07:49:59 turan kernel:  [<c01059c9>] do_signal+0x49/0xf0
Sep 27 07:50:00 turan kernel:  [end_that_request_last+84/192] end_that_request_last+0x54/0xc0
Sep 27 07:50:00 turan kernel:  [<c026e414>] end_that_request_last+0x54/0xc0
Sep 27 07:50:00 turan kernel:  [elv_queue_empty+20/32] elv_queue_empty+0x14/0x20
Sep 27 07:50:00 turan kernel:  [<c026b084>] elv_queue_empty+0x14/0x20
Sep 27 07:50:00 turan kernel:  [ide_do_request+155/800] ide_do_request+0x9b/0x320
Sep 27 07:50:00 turan kernel:  [<c02a72ab>] ide_do_request+0x9b/0x320
Sep 27 07:50:00 turan kernel:  [schedule+390/1120] schedule+0x186/0x460
Sep 27 07:50:00 turan kernel:  [<c035d226>] schedule+0x186/0x460
Sep 27 07:50:00 turan kernel:  [handle_IRQ_event+48/96] handle_IRQ_event+0x30/0x60
Sep 27 07:50:00 turan kernel:  [<c0108160>] handle_IRQ_event+0x30/0x60
Sep 27 07:50:00 turan kernel:  [do_notify_resume+55/64] do_notify_resume+0x37/0x40
Sep 27 07:50:00 turan kernel:  [<c0105aa7>] do_notify_resume+0x37/0x40
Sep 27 07:50:00 turan kernel:  [<c0105aa7>] do_notify_resume+0x37/0x40
Sep 27 07:50:00 turan kernel:  [work_notifysig+19/21] work_notifysig+0x13/0x15
Sep 27 07:50:00 turan kernel:  [<c0105c8e>] work_notifysig+0x13/0x15
Sep 27 07:50:00 turan kernel: Code: 8b 51 04 8b 1a 85 db 78 07 b8 01 00 00 00 5b c3 8b 1a 81 e3

 

ksymoops output:

Sep 27 07:49:58 turan kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Sep 27 07:49:58 turan kernel: f8ab4ad5
Sep 27 07:49:58 turan kernel: *pde = 00000000
Sep 27 07:49:58 turan kernel: Oops: 0000 [#6]
Sep 27 07:49:58 turan kernel: CPU:    0
Sep 27 07:49:59 turan kernel: EIP:    0060:[__crc_pm_idle+1723478/2974522]    Tainted: PF
Sep 27 07:49:59 turan kernel: EIP:    0060:[<f8ab4ad5>]    Tainted: PF
Sep 27 07:49:59 turan kernel: EFLAGS: 00010086   (2.6.8-1.6-bio-default)
Sep 27 07:49:59 turan kernel: eax: f8ad7f88   ebx: f36d4088   ecx: 00000000   edx: f25b38b0
Sep 27 07:49:59 turan kernel: esi: 00000013   edi: e5208000   ebp: 00000012   esp: e5209ecc
Sep 27 07:49:59 turan kernel: ds: 007b   es: 007b   ss: 0068
Warning (Oops_read): Code line not seen, dumping what data is available


 >>EIP; f8ab4ad5 <__crc_pm_idle+1a4c56/2d633a>   <=====

 >>eax; f8ad7f88 <__crc_pm_idle+1c8109/2d633a>
 >>ebx; f36d4088 <__crc_close_private_file+33a30/225ab0>
 >>edx; f25b38b0 <__crc___down_failed+92d3a/b07d8>
 >>edi; e5208000 <__crc_kill_block_super+4539d/6a4ba5>
 >>esp; e5209ecc <__crc_kill_block_super+47269/6a4ba5>

Sep 27 07:49:59 turan kernel: Stack: f36d4088 c0123369 00000000 e5209f28 00000000 e5209f28 f25b38b0 f25b3dd4
Sep 27 07:49:59 turan kernel:        c0123473 e5208000 f25b3dd4 e5208000 ffffe000 c01246d9 e5208000 f25b3dd4
Sep 27 07:49:59 turan kernel:        e5209fc4 e5209f28 e5209fc4 f25b3dd4 e5208000 e5208000 c01059c9 f7c4bf4c
Sep 27 07:49:59 turan kernel: Call Trace:
Sep 27 07:49:59 turan kernel:  [<c0123369>] __dequeue_signal+0x89/0x150
Sep 27 07:49:59 turan kernel:  [<c0123473>] dequeue_signal+0x43/0x70
Sep 27 07:49:59 turan kernel:  [<c01246d9>] get_signal_to_deliver+0x59/0x2d0
Sep 27 07:49:59 turan kernel:  [<c01059c9>] do_signal+0x49/0xf0
Sep 27 07:50:00 turan kernel:  [<c026e414>] end_that_request_last+0x54/0xc0
Sep 27 07:50:00 turan kernel:  [<c026b084>] elv_queue_empty+0x14/0x20
Sep 27 07:50:00 turan kernel:  [<c02a72ab>] ide_do_request+0x9b/0x320
Sep 27 07:50:00 turan kernel:  [<c035d226>] schedule+0x186/0x460
Sep 27 07:50:00 turan kernel:  [<c0108160>] handle_IRQ_event+0x30/0x60
Sep 27 07:50:00 turan kernel:  [<c0105aa7>] do_notify_resume+0x37/0x40
Sep 27 07:50:00 turan kernel:  [<c0105c8e>] work_notifysig+0x13/0x15
Sep 27 07:50:00 turan kernel: Code: 8b 51 04 8b 1a 85 db 78 07 b8 01 00 00 00 5b c3 8b 1a 81 e3

Trace; c0123369 <__dequeue_signal+89/150>
Trace; c0123473 <dequeue_signal+43/70>
Trace; c01246d9 <get_signal_to_deliver+59/2d0>
Trace; c01059c9 <do_signal+49/f0>
Trace; c026e414 <end_that_request_last+54/c0>
Trace; c026b084 <elv_queue_empty+14/20>
Trace; c02a72ab <ide_do_request+9b/320>
Trace; c035d226 <schedule+186/460>
Trace; c0108160 <handle_IRQ_event+30/60>
Trace; c0105aa7 <do_notify_resume+37/40>
Trace; c0105c8e <work_notifysig+13/15>

Code;  f8ab4ad5 <__crc_pm_idle+1a4c56/2d633a>
00000000 <_EIP>:
Code;  f8ab4ad5 <__crc_pm_idle+1a4c56/2d633a>
    0:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  f8ab4ad8 <__crc_pm_idle+1a4c59/2d633a>
    3:   8b 1a                     mov    (%edx),%ebx
Code;  f8ab4ada <__crc_pm_idle+1a4c5b/2d633a>
    5:   85 db                     test   %ebx,%ebx
Code;  f8ab4adc <__crc_pm_idle+1a4c5d/2d633a>
    7:   78 07                     js     10 <_EIP+0x10>
Code;  f8ab4ade <__crc_pm_idle+1a4c5f/2d633a>
    9:   b8 01 00 00 00            mov    $0x1,%eax
Code;  f8ab4ae3 <__crc_pm_idle+1a4c64/2d633a>
    e:   5b                        pop    %ebx
Code;  f8ab4ae4 <__crc_pm_idle+1a4c65/2d633a>
    f:   c3                        ret
Code;  f8ab4ae5 <__crc_pm_idle+1a4c66/2d633a>
   10:   8b 1a                     mov    (%edx),%ebx
Code;  f8ab4ae7 <__crc_pm_idle+1a4c68/2d633a>
   12:   81 e3 00 00 00 00         and    $0x0,%ebx

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
