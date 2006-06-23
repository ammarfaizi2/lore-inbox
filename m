Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932859AbWFWG20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932859AbWFWG20 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 02:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbWFWG20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 02:28:26 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:49839 "EHLO mail47.e.nsc.no")
	by vger.kernel.org with ESMTP id S932859AbWFWG20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 02:28:26 -0400
Message-ID: <449B8A0D.60607@online.no>
Date: Fri, 23 Jun 2006 08:28:29 +0200
From: Knut J Bjuland <knutjbj@online.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: I can cause kernel panic by using native alsa midi with 2.6.17.1
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can cause kernel panic by either alsasound stop or using a native midi player
like pmidi. osss midi player does not cause crash.pmidi -p 17:1 midifile.
1./sbin/modprobe snd-emu10k1-synth
2./bin/asfxload *.sf2
3.pmidi -p 17.0 any.midi file
4. hit ctrl-c during playing a midi file  


ksymoops 2.4.9 on i686 2.6.17-1.2138_FC5smp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.17-1.2138_FC5 (specified)
     -m /boot/System.map-2.6.17-1.2138_FC5 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jun 21 21:04:53 knutjorgen kernel: kernel BUG at include/linux/list.h:58!
Jun 21 21:04:53 knutjorgen kernel: CPU:    0
Jun 21 21:04:53 knutjorgen kernel: EIP:    0060:[<f8a31234>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 21 21:04:53 knutjorgen kernel: EFLAGS: 00010082   (2.6.17-1.2138_FC5 #1) 
Jun 21 21:04:53 knutjorgen kernel: eax: 00000044   ebx: f767a768   ecx: c06bcfd0
Jun 21 21:04:53 knutjorgen kernel: esi: f767a768   edi: f56d67e8   ebp: f56d6760
Jun 21 21:04:53 knutjorgen kernel: ds: 007b   es: 007b   ss: 0068
Jun 21 21:04:53 knutjorgen kernel: Stack: f8a32432 f767a768 f56d67e8 f56d67fc
f56d67f0 00000282 22222222 22222222 
Jun 21 21:04:53 knutjorgen kernel:        f56d6760 f75973e0 f75973e0 f4ebc734
f8a2c1bc f56d6760 f8a2c26e 00000000 
Jun 21 21:04:53 knutjorgen kernel:        f7597568 00000008 f56d6760 f8a2c2bc
00000008 c045e00e 00000000 f71d0340 
Jun 21 21:04:53 knutjorgen kernel: Call Trace:
Jun 21 21:04:53 knutjorgen kernel:  <f8a2c1bc> seq_free_client1+0x8/0x7e
Jun 21 21:04:53 knutjorgen kernel:  <f8a2c2bc> snd_seq_release+0x12/0x31
Jun 21 21:04:53 knutjorgen kernel:  <c045b940> filp_close+0x52/0x59  <c0402cb3>
Jun 21 21:04:53 knutjorgen kernel: Code: 00 00 74 6d 8b 9d 88 00 00 00 8b b5 8c


>>EIP; f8a31234 <END_OF_CODE+3827b234/????>   <=====

>>ecx; c06bcfd0 <log_wait+10/18>

Trace; f8a2c1bc <END_OF_CODE+382761bc/????>
Trace; f8a2c2bc <END_OF_CODE+382762bc/????>
Trace; c045b940 <filp_close+52/59>

Code;  f8a31234 <END_OF_CODE+3827b234/????>
00000000 <_EIP>:
Code;  f8a31234 <END_OF_CODE+3827b234/????>   <=====
   0:   00 00                     add    %al,(%eax)   <=====
Code;  f8a31236 <END_OF_CODE+3827b236/????>
   2:   74 6d                     je     71 <_EIP+0x71>
Code;  f8a31238 <END_OF_CODE+3827b238/????>
   4:   8b 9d 88 00 00 00         mov    0x88(%ebp),%ebx
Code;  f8a3123e <END_OF_CODE+3827b23e/????>
   a:   8b b5 8c 00 00 00         mov    0x8c(%ebp),%esi

b7 9e c7 <0f> 0b 3a 00 1d 24 a3 f8 8b 06 39 d8 74 1c 89 5c 24 04 89 44 24 
Jun 21 21:04:53 knutjorgen kernel: EIP: [<f8a31234>]
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; f8a31234 <END_OF_CODE+3827b234/????>   <=====


1 warning and 1 error issued.  Results may not be reliable.







Jun 21 21:04:53 knutjorgen kernel: ------------[ cut here ]------------
Jun 21 21:04:53 knutjorgen kernel: kernel BUG at include/linux/list.h:58!
Jun 21 21:04:53 knutjorgen kernel: invalid opcode: 0000 [#1]
Jun 21 21:04:53 knutjorgen kernel: last sysfs file: /class/sound/midiC0D3/dev
Jun 21 21:04:53 knutjorgen kernel: Modules linked in: snd_seq_midi snd_rtctimer
snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul ipv6 autofs4
hidp l2cap bluetooth sunrpc ip_conntrack_netbios_ns ipt_REJECT xt_state
ip_conntrack nfnetlink xt_tcpudp iptable_filter ip_tables x_tables video button
battery ac lp parport_pc parport usblp ohci1394 ieee1394 usb_storage uhci_hcd
ehci_hcd floppy sg snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus
snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss
bt878 tuner tda9887 msp3400 snd_pcm snd_seq_device snd_timer snd_page_alloc
snd_util_mem snd_hwdep snd bttv video_buf ir_common compat_ioctl32 i2c_algo_bit
v4l2_common soundcore btcx_risc tveeprom tg3 videodev emu10k1_gp gameport
i2c_i801 i2c_core dm_snapshot dm_zero dm_mirror dm_mod ata_piix ext3 jbd ahci
libata sd_mod scsi_mod
Jun 21 21:04:53 knutjorgen kernel: CPU:    0
Jun 21 21:04:53 knutjorgen kernel: EIP:    0060:[<f8a31234>]    Not tainted VLI
Jun 21 21:04:53 knutjorgen kernel: EFLAGS: 00010082   (2.6.17-1.2138_FC5 #1) 
Jun 21 21:04:53 knutjorgen kernel: EIP is at snd_seq_delete_all_ports+0x60/0x176
[snd_seq]
Jun 21 21:04:53 knutjorgen kernel: eax: 00000044   ebx: f767a768   ecx: c06bcfd0
  edx: f7f7a000
Jun 21 21:04:53 knutjorgen kernel: esi: f767a768   edi: f56d67e8   ebp: f56d6760
  esp: f4edef30
Jun 21 21:04:53 knutjorgen kernel: ds: 007b   es: 007b   ss: 0068
Jun 21 21:04:53 knutjorgen kernel: Process pmidi (pid: 2994, threadinfo=f4ede000
task=f7f7a000)
Jun 21 21:04:53 knutjorgen kernel: Stack: f8a32432 f767a768 f56d67e8 f56d67fc
f56d67f0 00000282 22222222 22222222 
Jun 21 21:04:53 knutjorgen kernel:        f56d6760 f75973e0 f75973e0 f4ebc734
f8a2c1bc f56d6760 f8a2c26e 00000000 
Jun 21 21:04:53 knutjorgen kernel:        f7597568 00000008 f56d6760 f8a2c2bc
00000008 c045e00e 00000000 f71d0340 
Jun 21 21:04:53 knutjorgen kernel: Call Trace:
Jun 21 21:04:53 knutjorgen kernel:  <f8a2c1bc> seq_free_client1+0x8/0x7e
[snd_seq]  <f8a2c26e> seq_free_client+0x3c/0x78 [snd_seq]
Jun 21 21:04:53 knutjorgen kernel:  <f8a2c2bc> snd_seq_release+0x12/0x31
[snd_seq]  <c045e00e> __fput+0xb2/0x158
Jun 21 21:04:53 knutjorgen kernel:  <c045b940> filp_close+0x52/0x59  <c0402cb3>
syscall_call+0x7/0xb
Jun 21 21:04:53 knutjorgen kernel: Code: 00 00 74 6d 8b 9d 88 00 00 00 8b b5 8c
00 00 00 8b 43 04 39 f0 74 1c 89 74 24 04 89 44 24 08 c7 04 24 32 24 a3 f8 e8 8f
b7 9e c7 <0f> 0b 3a 00 1d 24 a3 f8 8b 06 39 d8 74 1c 89 5c 24 04 89 44 24 
Jun 21 21:04:53 knutjorgen kernel: EIP: [<f8a31234>]
snd_seq_delete_all_ports+0x60/0x176 [snd_seq] SS:ESP 0068:f4edef30
Jun 21 21:04:53 knutjorgen kernel:  <0>Fatal exception: panic in 5 seconds


https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=196149 and
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=194597



    #6736  <http://bugzilla.kernel.org/show_bug.cgi?id=6736>

