Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271857AbTGRPjg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271850AbTGRPij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:38:39 -0400
Received: from [193.137.96.140] ([193.137.96.140]:21130 "EHLO dwarf.utad.pt")
	by vger.kernel.org with ESMTP id S263752AbTGRPhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 11:37:20 -0400
X-Spam-Filter: check_local@dwarf.utad.pt by digitalanswers.org
X-Spam-Header: 550.Reject.Received:count_Received
Message-ID: <3F1815A1.4070409@alvie.com>
Date: Fri, 18 Jul 2003 16:43:29 +0100
From: Alvaro Lopes <alvieboy@alvie.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Oops with ALSA and OSS emulation - 2.6.0-test1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following oops when I start some audio applications:

Jul 15 16:05:25 supernova kernel: Unable to handle kernel paging request 
at virtual address d0a07000
Jul 15 16:05:25 supernova kernel:  printing eip:
Jul 15 16:05:25 supernova kernel: d09b5b37
Jul 15 16:05:25 supernova kernel: *pde = 0ff7f067
Jul 15 16:05:25 supernova kernel: *pte = 00000000
Jul 15 16:05:25 supernova kernel: Oops: 0000 [#1]
Jul 15 16:05:25 supernova kernel: CPU:    0
Jul 15 16:05:25 supernova kernel: EIP:    
0060:[__crc_send_group_sig_info+5177760/5680417]    Tainted: P
Jul 15 16:05:25 supernova kernel: EFLAGS: 00210202
Jul 15 16:05:25 supernova kernel: EIP is at resample_expand+0x343/0x377 
[snd_pcm_oss]
Jul 15 16:05:25 supernova kernel: eax: d09b5b37   ebx: 00000000   ecx: 
000007ff   edx: 00000000
Jul 15 16:05:25 supernova kernel: esi: d0a80166   edi: c3355610   ebp: 
d0a06ffe   esp: c4f55e54
Jul 15 16:05:25 supernova kernel: ds: 007b   es: 007b   ss: 0068
Jul 15 16:05:25 supernova kernel: Process fltk-eclient (pid: 668, 
threadinfo=c4f54000 task=c7478080)
Jul 15 16:05:25 supernova kernel: Stack: d09b2fb1 c3355580 c3c644e0 
c4f55e80 00000000 c4f5007b ffffff00 ffffffff
Jul 15 16:05:25 supernova kernel:        d09b595b d09b5aaf d09b5b37 
c33555f0 00000000 00000004 00000004 00000001
Jul 15 16:05:25 supernova kernel:        00000000 000003ee 0000045a 
00000400 c3355580 c6975580 d09b5fe1 c3355580
Jul 15 16:05:25 supernova kernel: Call Trace:
Jul 15 16:05:25 supernova kernel:  
[__crc_send_group_sig_info+5166618/5680417] 
snd_pcm_plug_playback_channels_mask+0x72/0xd8 [snd_pcm_oss]
Jul 15 16:05:25 supernova kernel:  
[__crc_send_group_sig_info+5177284/5680417] resample_expand+0x167/0x377 
[snd_pcm_oss]
Jul 15 16:05:25 supernova kernel:  
[__crc_send_group_sig_info+5177624/5680417] resample_expand+0x2bb/0x377 
[snd_pcm_oss]
Jul 15 16:05:25 supernova kernel:  
[__crc_send_group_sig_info+5177760/5680417] resample_expand+0x343/0x377 
[snd_pcm_oss]
Jul 15 16:05:25 supernova kernel:  
[__crc_send_group_sig_info+5178954/5680417] rate_transfer+0x59/0x5d 
[snd_pcm_oss]
Jul 15 16:05:25 supernova kernel:  
[__crc_send_group_sig_info+5167602/5680417] 
snd_pcm_plug_write_transfer+0x95/0xf4 [snd_pcm_oss]
Jul 15 16:05:25 supernova kernel:  
[__crc_send_group_sig_info+5151219/5680417] 
snd_pcm_oss_write2+0xd0/0x13c [snd_pcm_oss]
Jul 15 16:05:25 supernova kernel:  
[__crc_send_group_sig_info+5151752/5680417] 
snd_pcm_oss_write1+0x1a9/0x1d0 [snd_pcm_oss]
Jul 15 16:05:25 supernova kernel:  
[__crc_send_group_sig_info+5159856/5680417] snd_pcm_oss_write+0x43/0x5d 
[snd_pcm_oss]
Jul 15 16:05:25 supernova kernel:  
[__crc_send_group_sig_info+5159789/5680417] snd_pcm_oss_write+0x0/0x5d 
[snd_pcm_oss]
Jul 15 16:05:25 supernova kernel:  [vfs_write+176/281] vfs_write+0xb0/0x119
Jul 15 16:05:25 supernova kernel:  [do_gettimeofday+25/134] 
do_gettimeofday+0x19/0x86
Jul 15 16:05:25 supernova kernel:  [sys_write+66/99] sys_write+0x42/0x63
Jul 15 16:05:25 supernova kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 15 16:05:25 supernova kernel:
Jul 15 16:05:25 supernova kernel: Code: 8b 45 00 eb ac 0f b6 45 00 c1 e0 
08 eb a3 81 fa 00 80 00 00

The card is a intel8x0 (Intel 82801CA/CAM AC'97)
Kernel is tainted due to nvidia drivers.

Any ideas on what might be ?


Álvaro

