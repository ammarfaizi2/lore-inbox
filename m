Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbVGHRbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbVGHRbH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 13:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbVGHRbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 13:31:06 -0400
Received: from ms-smtp-02-smtplb.tampabay.rr.com ([65.32.5.132]:57500 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S262724AbVGHRbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 13:31:03 -0400
Message-ID: <42CEB851.1000004@tampabay.rr.com>
Date: Fri, 08 Jul 2005 13:30:57 -0400
From: Nathan Boyle <nboyle@tampabay.rr.com>
Reply-To: nboyle@tampabay.rr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050514
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] Oops: EIP is at sysfs_release+0x34/0x80
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was logging in on vc2 to find out why my Quake3 game was being
sluggish and this came up right after agetty:

Unable to handle kernel paging request at virtual address 762f7473
  printing eip:
c0183c14
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: rtc nls_utf8 snd_emu10k1_synth snd_emu10k1
snd_emux_synth snd_seq_virmidi snd_rawmidi snd_pcm_oss snd_ac97_codec
snd_seq_midi_event snd_seq_midi_emul snd_seq snd_pcm ehci_hcd ide_cd
usbhid snd_mixer_oss snd_timer uhci_hcd af_packet ohci_hcd cdrom
snd_seq_device snd_page_alloc floppy isofs usbcore snd_hwdep ntfs snd
tulip snd_util_mem soundcore evdev crc32 smbfs ext2 nls_base unix
CPU:    0
EIP:    0060:[<c0183c14>]    Not tainted VLI
EFLAGS: 00010202   (2.6.13-rc2-GIT-08-7-2005-0)
EIP is at sysfs_release+0x34/0x80
eax: 00000001   ebx: dc7c2000   ecx: d1979860   edx: 00000001
esi: 762f7373   edi: d5ba26a0   ebp: d9368544   esp: dc7c3f80
ds: 007b   es: 007b   ss: 0068
Process udev (pid: 31802, threadinfo=dc7c2000 task=c7c19040)
Stack: df468c40 df798140 dffe4140 c0153c08 d5a9edbc df468c40 df798140
00000000
        dc7c2000 c01523d3 00000000 00000003 080ac568 00000003 c0103101
00000003
        080ac568 00000004 080ac568 00000003 08057198 00000006 0000007b
0000007b
Call Trace:
  [<c0153c08>] __fput+0xf8/0x110
  [<c01523d3>] filp_close+0x43/0x70
  [<c0103101>] syscall_call+0x7/0xb
Code: 8b 41 0c 8b 40 48 8b 58 14 8b 41 48 8b 40 14 85 db 8b 70 04 74 07
89 d8 e8 9a 11 02 00 85 f6 74 1f bb 00 e0 ff ff 21 e3 ff 43 14 <ff> 8e
00 01 00 00 83 3e 02 74 32 8b 43 08 ff 4b 14 a8 08 75 21
  <6>note: udev[31802] exited with preempt_count 1

I was still able to log in afterwards (I still haven't rebooted the
machine and I'm typing this on it) but hotplug processes are reproducing
like rodents and I think the kernel is starting them (I kill everything
related and they all come back). This was around 5-10 minutes after my
first boot with this kernel.

