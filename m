Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbWARNjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbWARNjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 08:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWARNjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 08:39:13 -0500
Received: from osmo2.osmosys.tv ([195.94.213.2]:61719 "EHLO osdark.osmosys.tv")
	by vger.kernel.org with ESMTP id S932536AbWARNjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 08:39:13 -0500
Message-ID: <43CE44F1.6020107@osmosys.tv>
Date: Wed, 18 Jan 2006 14:38:57 +0100
From: Aleksander Salwa <A.Salwa@osmosys.tv>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: divide error at sample_to_timespec
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I got a "divide error" message from the kernel in my system log file 
(x86, P4 HT, kernel 2.6.14-1.1653_FC4smp). System is still alive, but 
probably something bad happened with thread that made a syscall which 
caused that divide error. Should it be considered a kernel bug ?
It looks like there is an overflow (too big value in edx:aex divided by 
relatively small value in ebx).

Full message with call trace:

Jan 11 18:12:27 lompa kernel: divide error: 0000 [#1]
Jan 11 18:12:27 lompa kernel: SMP
Jan 11 18:12:27 lompa kernel: Modules linked in: loop i915 drm 
parport_pc lp parport autofs4 rfcomm l2cap bluetooth sunrpc dm_mod video 
button battery ac ipv6 uhci_hcd ehci_hcd i2c_i801 i2c_core snd_intel8x0 
snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event 
snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd 
soundcore snd_page_alloc tg3 floppy ext3 jbd ata_piix libata sd_mod scsi_mod
Jan 11 18:12:27 lompa kernel: CPU:    0
Jan 11 18:12:27 lompa kernel: EIP:    0060:[<c013420c>]    Not tainted VLI
Jan 11 18:12:27 lompa kernel: EFLAGS: 00010246   (2.6.14-1.1653_FC4smp)
Jan 11 18:12:27 lompa kernel: EIP is at sample_to_timespec+0x31/0x3d
Jan 11 18:12:27 lompa kernel: eax: ffc2f700   ebx: 3b9aca00   ecx: 
ffffffff   edx: ffffffff
Jan 11 18:12:27 lompa kernel: esi: dba19fa8   edi: dba19fa8   ebp: 
dba19000   esp: dba19f78
Jan 11 18:12:27 lompa kernel: ds: 007b   es: 007b   ss: 0068
Jan 11 18:12:27 lompa kernel: Process memcheck (pid: 27631, 
threadinfo=dba19000 task=db707030)
Jan 11 18:12:27 lompa kernel: Stack: 00000000 fffca086 dba19fa8 dba19000 
c01345f3 dba19fa8 ffc2f700 ffffffff
Jan 11 18:12:27 lompa kernel:        fffca086 00000000 fffca086 c013326a 
fffca086 00000000 fffca086 00000000
Jan 11 18:12:27 lompa kernel:        c0103995 fffca086 09e9b36c 00de0ff4 
00000000 fffca086 0eecdf18 ffffffda
Jan 11 18:12:27 lompa kernel: Call Trace:
Jan 11 18:12:27 lompa kernel:  [<c01345f3>] posix_cpu_clock_get+0x48/0xf9
Jan 11 18:12:27 lompa kernel:  [<c013326a>] sys_clock_gettime+0x16/0x82
Jan 11 18:12:27 lompa kernel:  [<c0103995>] syscall_call+0x7/0xb
Jan 11 18:12:27 lompa kernel: Code: 24 14 83 e0 03 83 f8 02 74 18 bb 00 
ca 9a 3b b8 fa 09 3d 00 f7 e2 f7 f3 89 56 04 89 06 5b 5e
5f 5d c3 bb 00 ca 9a 3b 89 d0 89 ca <f7> f3 89 56 04 89 06 5b 5e 5f 5d 
c3 55 57 56 53 83 ec 1c 89 c5

I haven't found a quick way to repeat it yet, but it happened a few 
times so far (in a few days or so). It happens in context of big 
multithreaded application that uses posix clocks to make some statistics 
of cpu usage per thread.

Best regards,
Aleksander

-- 
Aleksander Salwa
OSMOSYS Technologies
ul. Ro¼dzieñskiego 188B
Katowice, Poland
office: +48327810470
fax: +48618513128
http://www.osmosys.tv


