Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbTLCJxF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 04:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbTLCJxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 04:53:05 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:45841 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S264526AbTLCJw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 04:52:58 -0500
Date: Wed, 3 Dec 2003 20:52:55 +1100 (EST)
From: Tim Connors <tconnors+linuxkernel031203@astro.swin.edu.au>
X-X-Sender: tconnors@tellurium.ssi.swin.edu.au
To: linux-kernel@vger.kernel.org
Subject: Alsa oops, 2.6.0-test8
Message-ID: <Pine.LNX.4.53.0312032050320.10546@tellurium.ssi.swin.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2 oopses, both alsa, different scenarios, different traces in syslog:
2.6.0-test8+kraxel-1 from bytesex.org (possibly not relevant - this seems to be an alsa oops)
Sound card is ES1371.
(I have downloaded 2.6.0-test11+kraxel-1, but haven't rebooted yet. I will
try the same avi files, to see whtehr I can reproduce...)

The first time, I was recoding /dev/dsp, and doing a debian dist-upgrade at the time. I
didn't notice the oops until I next tried to play something a day later. The recording was
complete, despite the oops half way through. The mplayer process segfaulted, but I thought at
the time that might have been due to a corrupted .avi file. But I was just found out that the
oops is repeatable at least on that file. This time, a hard lock.

Nov 25 23:32:46 bohr kernel: Unable to handle kernel paging request at virtual address d8882000
Nov 25 23:32:46 bohr kernel:  printing eip:
Nov 25 23:32:46 bohr kernel: d8963964
Nov 25 23:32:46 bohr kernel: *pde = 17efa067
Nov 25 23:32:46 bohr kernel: *pte = 00000000
Nov 25 23:32:46 bohr kernel: Oops: 0000 [#1]
Nov 25 23:32:46 bohr kernel: CPU:    0
Nov 25 23:32:46 bohr kernel: EIP:    0060:[__crc_generic_file_aio_write+945096/1760761]    Not tainted
Nov 25 23:32:46 bohr kernel: EFLAGS: 00010202
Nov 25 23:32:46 bohr kernel: EIP is at resample_expand+0x2e4/0x320 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel: eax: d8963964   ebx: 00000002   ecx: d8a32ff2   edx: 00080007
Nov 25 23:32:46 bohr kernel: esi: d330b710   edi: d330b6f0   ebp: d8881ffe   esp: c6a05e7c
Nov 25 23:32:46 bohr kernel: ds: 007b   es: 007b   ss: 0068
Nov 25 23:32:46 bohr kernel: Process mplayer (pid: 6604, threadinfo=c6a04000 task=d5bbf2e0)
Nov 25 23:32:46 bohr kernel: Stack: 00000008 ffffffff d8949f88 c3b8f380 d89638d9 d8963964 00000000 00000004
Nov 25 23:32:46 bohr kernel:        00000004 00000001 00070007 000002a9 00000bff 00000400 d330b680 c1b05880
Nov 25 23:32:46 bohr kernel:        d8963dff d330b680 c1b05c80 c1b05880 00000400 00000bff d330b680 00000400
Nov 25 23:32:46 bohr kernel: Call Trace:
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+944957/1760761] resample_expand+0x259/0x320 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+945096/1760761] resample_expand+0x2e4/0x320 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+946275/1760761] rate_transfer+0x3f/0x60 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+935698/1760761] snd_pcm_plug_write_transfer+0x6e/0xc0 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+918773/1760761] snd_pcm_oss_write2+0xb1/0x120 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+919303/1760761] snd_pcm_oss_write1+0x1a3/0x1e0 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+927767/1760761] snd_pcm_oss_write+0x33/0x60 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [vfs_write+142/224] vfs_write+0x8e/0xe0
Nov 25 23:32:46 bohr kernel:  [sys_write+43/96] sys_write+0x2b/0x60
Nov 25 23:32:46 bohr kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 25 23:32:46 bohr kernel:
Nov 25 23:32:46 bohr kernel: Code: 8b 45 00 e9 80 fe ff ff 8a 45 00 83 f0 80 89 c2 c1 e2 08 eb
Nov 25 23:32:46 bohr kernel:  <1>Unable to handle kernel paging request at virtual address d8882000
Nov 25 23:32:46 bohr kernel:  printing eip:
Nov 25 23:32:46 bohr kernel: d8963964
Nov 25 23:32:46 bohr kernel: *pde = 17efa067
Nov 25 23:32:46 bohr kernel: *pte = 00000000
Nov 25 23:32:46 bohr kernel: Oops: 0000 [#2]
Nov 25 23:32:46 bohr kernel: CPU:    0
Nov 25 23:32:46 bohr kernel: EIP:    0060:[__crc_generic_file_aio_write+945096/1760761]    Not tainted
Nov 25 23:32:46 bohr kernel: EFLAGS: 00010202
Nov 25 23:32:46 bohr kernel: EIP is at resample_expand+0x2e4/0x320 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel: eax: d8963964   ebx: 00000002   ecx: d8a32ff2   edx: 00000000
Nov 25 23:32:46 bohr kernel: esi: d330b710   edi: d330b6f0   ebp: d8881ffe   esp: c6a05bc4
Nov 25 23:32:46 bohr kernel: ds: 007b   es: 007b   ss: 0068
Nov 25 23:32:46 bohr kernel: Process mplayer (pid: 6604, threadinfo=c6a04000 task=d5bbf2e0)
Nov 25 23:32:46 bohr kernel: Stack: c6a00000 00000000 00000000 ffffffff d89638d9 d8963964 00000000 00000004
Nov 25 23:32:46 bohr kernel:        00000004 00000001 00000000 000002a9 00000bff 00000400 d330b680 c1b05880
Nov 25 23:32:46 bohr kernel:        d8963dff d330b680 c1b05c80 c1b05880 00000400 00000bff d330b680 00000400
Nov 25 23:32:46 bohr kernel: Call Trace:
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+944957/1760761] resample_expand+0x259/0x320 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+945096/1760761] resample_expand+0x2e4/0x320 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+946275/1760761] rate_transfer+0x3f/0x60 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+935698/1760761] snd_pcm_plug_write_transfer+0x6e/0xc0 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+918773/1760761] snd_pcm_oss_write2+0xb1/0x120 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+920249/1760761] snd_pcm_oss_sync1+0x55/0x120 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Nov 25 23:32:46 bohr kernel:  [sk_free+87/192] sk_free+0x57/0xc0
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+793624/1760761] snd_pcm_format_set_silence+0x74/0x180 [snd_pcm]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+920612/1760761] snd_pcm_oss_sync+0xa0/0x1c0 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+925730/1760761] snd_pcm_oss_release+0x1e/0xc0 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__fput+238/288] __fput+0xee/0x120
Nov 25 23:32:46 bohr kernel:  [filp_close+67/128] filp_close+0x43/0x80
Nov 25 23:32:46 bohr kernel:  [put_files_struct+82/192] put_files_struct+0x52/0xc0
Nov 25 23:32:46 bohr kernel:  [do_exit+340/992] do_exit+0x154/0x3e0
Nov 25 23:32:46 bohr kernel:  [do_page_fault+0/1189] do_page_fault+0x0/0x4a5
Nov 25 23:32:46 bohr kernel:  [die+187/192] die+0xbb/0xc0
Nov 25 23:32:46 bohr kernel:  [do_page_fault+419/1189] do_page_fault+0x1a3/0x4a5
Nov 25 23:32:46 bohr kernel:  [scheduler_tick+522/1120] scheduler_tick+0x20a/0x460
Nov 25 23:32:46 bohr kernel:  [update_process_times+41/64] update_process_times+0x29/0x40
Nov 25 23:32:46 bohr kernel:  [update_wall_time+11/64] update_wall_time+0xb/0x40
Nov 25 23:32:46 bohr kernel:  [do_timer+197/224] do_timer+0xc5/0xe0
Nov 25 23:32:46 bohr kernel:  [run_timer_softirq+262/416] run_timer_softirq+0x106/0x1a0
Nov 25 23:32:46 bohr kernel:  [schedule+80/1408] schedule+0x50/0x580
Nov 25 23:32:46 bohr kernel:  [do_softirq+140/160] do_softirq+0x8c/0xa0
Nov 25 23:32:46 bohr kernel:  [do_page_fault+0/1189] do_page_fault+0x0/0x4a5
Nov 25 23:32:46 bohr kernel:  [error_code+45/64] error_code+0x2d/0x40
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+945096/1760761] resample_expand+0x2e4/0x320 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+945096/1760761] resample_expand+0x2e4/0x320 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+944957/1760761] resample_expand+0x259/0x320 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+945096/1760761] resample_expand+0x2e4/0x320 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+946275/1760761] rate_transfer+0x3f/0x60 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+935698/1760761] snd_pcm_plug_write_transfer+0x6e/0xc0 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+918773/1760761] snd_pcm_oss_write2+0xb1/0x120 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+919303/1760761] snd_pcm_oss_write1+0x1a3/0x1e0 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+927767/1760761] snd_pcm_oss_write+0x33/0x60 [snd_pcm_oss]
Nov 25 23:32:46 bohr kernel:  [vfs_write+142/224] vfs_write+0x8e/0xe0
Nov 25 23:32:46 bohr kernel:  [sys_write+43/96] sys_write+0x2b/0x60
Nov 25 23:32:46 bohr kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 25 23:32:46 bohr kernel:
Nov 25 23:32:46 bohr kernel: Code: 8b 45 00 e9 80 fe ff ff 8a 45 00 83 f0 80 89 c2 c1 e2 08 eb

The second time, I was using esdplay to play an .au file, and it segfaulted, and the kernel
hung hard. alt-sysrq s,u,b didn't seem to flash any hd lights, but the oops made it to syslog:

Nov 26 22:55:18 bohr kernel: Unable to handle kernel paging request at virtual address d8996000
Nov 26 22:55:18 bohr kernel:  printing eip:
Nov 26 22:55:18 bohr kernel: d8963964
Nov 26 22:55:18 bohr kernel: *pde = 17efa067
Nov 26 22:55:18 bohr kernel: *pte = 00000000
Nov 26 22:55:18 bohr kernel: Oops: 0000 [#1]
Nov 26 22:55:18 bohr kernel: CPU:    0
Nov 26 22:55:18 bohr kernel: EIP:    0060:[__crc_generic_file_aio_write+945096/1760761]    Not tainted
Nov 26 22:55:18 bohr kernel: EFLAGS: 00010202
Nov 26 22:55:18 bohr kernel: EIP is at resample_expand+0x2e4/0x320 [snd_pcm_oss]
Nov 26 22:55:18 bohr kernel: eax: d8963964   ebx: 00000001   ecx: d8a05ff0   edx: 00000000
Nov 26 22:55:18 bohr kernel: esi: d599840c   edi: d59983f0   ebp: d8995ffe   esp: d593de1c
Nov 26 22:55:18 bohr kernel: ds: 007b   es: 007b   ss: 0068
Nov 26 22:55:18 bohr kernel: Process esdplay (pid: 14013, threadinfo=d593c000 task=cca40cc0)
Nov 26 22:55:18 bohr kernel: Stack: 00000000 ffffffff d6b72ffa d893d30b d89638d9 d8963964 00000000 00000002
Nov 26 22:55:18 bohr kernel:        00000002 00000000 00000000 000002a6 00002ffa 00001000 d5998380 d2224bc0
Nov 26 22:55:18 bohr kernel:        d8963dff d5998380 d2224c00 d2224bc0 00001000 00002ffa d5998380 00001000
Nov 26 22:55:18 bohr kernel: Call Trace:
Nov 26 22:55:18 bohr kernel:  [__crc_generic_file_aio_write+787823/1760761] snd_pcm_lib_write_transfer+0x6b/0xc0 [snd_pcm]
Nov 26 22:55:18 bohr kernel:  [__crc_generic_file_aio_write+944957/1760761] resample_expand+0x259/0x320 [snd_pcm_oss]
Nov 26 22:55:18 bohr kernel:  [__crc_generic_file_aio_write+945096/1760761] resample_expand+0x2e4/0x320 [snd_pcm_oss]
Nov 26 22:55:18 bohr kernel:  [__crc_generic_file_aio_write+946275/1760761] rate_transfer+0x3f/0x60 [snd_pcm_oss]
Nov 26 22:55:18 bohr kernel:  [__crc_generic_file_aio_write+935698/1760761] snd_pcm_plug_write_transfer+0x6e/0xc0 [snd_pcm_oss]
Nov 26 22:55:18 bohr kernel:  [__crc_generic_file_aio_write+918773/1760761] snd_pcm_oss_write2+0xb1/0x120 [snd_pcm_oss]
Nov 26 22:55:18 bohr kernel:  [__crc_generic_file_aio_write+787716/1760761] snd_pcm_lib_write_transfer+0x0/0xc0 [snd_pcm]
Nov 26 22:55:18 bohr kernel:  [__crc_generic_file_aio_write+920249/1760761] snd_pcm_oss_sync1+0x55/0x120 [snd_pcm_oss]
Nov 26 22:55:18 bohr kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Nov 26 22:55:18 bohr kernel:  [__crc_generic_file_aio_write+918773/1760761] snd_pcm_oss_write2+0xb1/0x120 [snd_pcm_oss]
Nov 26 22:55:18 bohr kernel:  [__crc_generic_file_aio_write+793624/1760761] snd_pcm_format_set_silence+0x74/0x180 [snd_pcm]
Nov 26 22:55:18 bohr kernel:  [__crc_generic_file_aio_write+920612/1760761] snd_pcm_oss_sync+0xa0/0x1c0 [snd_pcm_oss]
Nov 26 22:55:18 bohr kernel:  [__crc_generic_file_aio_write+925730/1760761] snd_pcm_oss_release+0x1e/0xc0 [snd_pcm_oss]
Nov 26 22:55:18 bohr kernel:  [__fput+238/288] __fput+0xee/0x120
Nov 26 22:55:18 bohr kernel:  [filp_close+67/128] filp_close+0x43/0x80
Nov 26 22:55:18 bohr kernel:  [sys_close+83/128] sys_close+0x53/0x80
Nov 26 22:55:18 bohr kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 26 22:55:18 bohr kernel:
Nov 26 22:55:18 bohr kernel: Code: 8b 45 00 e9 80 fe ff ff 8a 45 00 83 f0 80 89 c2 c1 e2 08 eb


-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
The path to enlightenment_0.16.5-6 is through apt-get
