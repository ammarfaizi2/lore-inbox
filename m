Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVACQRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVACQRD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 11:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVACQRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 11:17:02 -0500
Received: from vvtp.tn.tudelft.nl ([130.161.252.29]:37057 "HELO
	vvtp.tudelft.nl") by vger.kernel.org with SMTP id S261485AbVACQQx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 11:16:53 -0500
Date: Mon, 3 Jan 2005 17:15:57 +0100
From: Konrad Wojas <wojas@vvtp.tudelft.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9 oops in poll()?
Message-ID: <20050103161556.GD31250@vvtp.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Detect-Self: dd61600cfe762340a29ea869157aecee
User-Agent: Mutt/1.5.6+20040907i
X-AntiVirus: scanned on vvtp.tudelft.nl for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My stock debian kernel (2.6.9-1-686) crashed this morning while running
bittornado (btlaunchmanycurses). At that moment only one torrent was
being downloaded. It looks to me like the problem is somewhere in poll()
in combination with threading.

I haven't tested it using 2.6.10 as I don't even know if I can reproduce
this using 2.6.9. If I do, I'll let you know.

I've included the raw oops and the output of ksymoops below. I'm not 
subscribed to lkml.

===================== RAW ======================

Jan  3 07:07:26 wojas kernel: c02b5513
Jan  3 07:07:26 wojas kernel: PREEMPT 
Jan 3 07:07:26 wojas kernel: Modules linked in: sch_ingress cls_u32
sch_sfq sch_cbq ip6table_filter ip6t_LOG ip6_tables ipt_limit lp msr
cpuid ipt_state ipt_MASQUERADE ipt_LOG iptable_mangle iptable_filter
dummy af_packet es1371 ac97_codec pci_hotplug intel_agp floppy pcspkr
rtc sd_mod reiserfs ext2 dm_mod capability commoncap tsdev mousedev
joydev evdev wacom usbhid psmouse usb_storage uhci_hcd usbcore eeprom
lm75 i2c_sensor i2c_dev i2c_piix4 i2c_core aha152x ipv6 binfmt_misc
ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack mga agpgart
snd_pcm_oss snd_mixer_oss snd_ens1371 snd_rawmidi snd_seq_device
snd_pcm snd_timer snd_page_alloc snd_ac97_codec snd gameport ipt_REJECT
ip_tables ne2k_pci 8390 via_rhine mii crc32 sound soundcore sg
scsi_mod parport_pc parport ide_cd cdrom ext3 jbd mbcache ide_generic
piix ide_disk ide_core unix fbcon font vesafb cfbcopyarea cfbimgblt
cfbfillrect
Jan  3 07:07:26 wojas kernel: CPU:    0
Jan  3 07:07:26 wojas kernel: EIP:    0060:[__func__.4+64363/135712]    Not tainted VLI
Jan  3 07:07:26 wojas kernel: EFLAGS: 00010246   (2.6.9-1-686) 
Jan  3 07:07:26 wojas kernel: EIP is at 0xc02b5513
Jan  3 07:07:26 wojas kernel: eax: 00000000   ebx: c0325c00   ecx: c61e57e0   edx: d35b85e0
Jan  3 07:07:26 wojas kernel: esi: c46082b9   edi: c61e57e4   ebp: 00000056   esp: d5f35f1c
Jan  3 07:07:26 wojas kernel: ds: 007b   es: 007b   ss: 0068
Jan  3 07:07:26 wojas kernel: Process python (pid: 30488, threadinfo=d5f34000 task=c0f0faa0)
Jan  3 07:07:26 wojas kernel: Stack: c022db99 c61e57e0 d35b85e0 00000000 00000145 c016c995 c61e57e0 00000000 
Jan  3 07:07:26 wojas kernel:        c4608000 d5f35f64 d5f35f68 0000001a c016ca0a 00000063 c4608008 d5f35f64 
Jan  3 07:07:26 wojas kernel:        d5f35f68 d5f34000 00000000 00000002 00000000 c4608000 000001ff 082b0d90 
Jan  3 07:07:26 wojas kernel: Call Trace:
Jan  3 07:07:26 wojas kernel:  [sock_poll+41/64] sock_poll+0x29/0x40
Jan  3 07:07:26 wojas kernel:  [do_pollfd+149/160] do_pollfd+0x95/0xa0
Jan  3 07:07:26 wojas kernel:  [do_poll+106/208] do_poll+0x6a/0xd0
Jan  3 07:07:26 wojas kernel:  [sys_poll+353/576] sys_poll+0x161/0x240
Jan  3 07:07:26 wojas kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Jan  3 07:07:26 wojas kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan  3 07:07:26 wojas kernel: Code: 79 70 74 6f 2f 63 69 70 68 65 72 2e 63 00 69 6e 63 6c 75 64 65 2f 6c 69 6e 75 78 2f 63 72 79 70 74 6f 2e 68 00 6e 61 6d 65 20 20 <20> 20 20 20 20 20 20 3a 20 25 73 0a 00 6d 6f 64 75 6c 65 20 20 

===================== KSYMOOPS  ======================

ksymoops 2.4.9 on i686 2.6.9-1-686.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.9-1-686/ (default)
     -m /boot/System.map-2.6.9-1-686 (default)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jan  3 07:07:26 wojas kernel: c02b5513
Jan  3 07:07:26 wojas kernel: CPU:    0
Jan  3 07:07:26 wojas kernel: EIP:    0060:[__func__.4+64363/135712]    Not tainted VLI
Jan  3 07:07:26 wojas kernel: EFLAGS: 00010246   (2.6.9-1-686) 
Jan  3 07:07:26 wojas kernel: eax: 00000000   ebx: c0325c00   ecx: c61e57e0   edx: d35b85e0
Jan  3 07:07:26 wojas kernel: esi: c46082b9   edi: c61e57e4   ebp: 00000056   esp: d5f35f1c
Jan  3 07:07:26 wojas kernel: ds: 007b   es: 007b   ss: 0068
Jan  3 07:07:26 wojas kernel: Stack: c022db99 c61e57e0 d35b85e0 00000000 00000145 c016c995 c61e57e0 00000000 
Jan  3 07:07:26 wojas kernel:        c4608000 d5f35f64 d5f35f68 0000001a c016ca0a 00000063 c4608008 d5f35f64 
Jan  3 07:07:26 wojas kernel:        d5f35f68 d5f34000 00000000 00000002 00000000 c4608000 000001ff 082b0d90 
Jan  3 07:07:26 wojas kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>ebx; c0325c00 <devinet_sysctl+460/4e0>
>>ecx; c61e57e0 <pg0+5e3b7e0/3fc54400>
>>edx; d35b85e0 <pg0+1320e5e0/3fc54400>
>>esi; c46082b9 <pg0+425e2b9/3fc54400>
>>edi; c61e57e4 <pg0+5e3b7e4/3fc54400>
>>esp; d5f35f1c <pg0+15b8bf1c/3fc54400>

Jan  3 07:07:26 wojas kernel: Code: 79 70 74 6f 2f 63 69 70 68 65 72 2e 63 00 69 6e 63 6c 75 64 65 2f 6c 69 6e 75 78 2f 63 72 79 70 74 6f 2e 68 00 6e 61 6d 65 20 20 <20> 20 20 20 20 20 20 3a 20 25 73 0a 00 6d 6f 64 75 6c 65 20 20 
Using defaults from ksymoops -t elf32-i386 -a i386


Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   79 70                     jns    72 <_EIP+0x72>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   74 6f                     je     73 <_EIP+0x73>
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   2f                        das    
Code;  ffffffda <__kernel_rt_sigreturn+1b9a/????>
   5:   63 69 70                  arpl   %bp,0x70(%ecx)
Code;  ffffffdd <__kernel_rt_sigreturn+1b9d/????>
   8:   68 65 72 2e 63            push   $0x632e7265
Code;  ffffffe2 <__kernel_rt_sigreturn+1ba2/????>
   d:   00 69 6e                  add    %ch,0x6e(%ecx)
Code;  ffffffe5 <__kernel_rt_sigreturn+1ba5/????>
  10:   63 6c 75 64               arpl   %bp,0x64(%ebp,%esi,2)
Code;  ffffffe9 <__kernel_rt_sigreturn+1ba9/????>
  14:   65                        gs
Code;  ffffffea <__kernel_rt_sigreturn+1baa/????>
  15:   2f                        das    
Code;  ffffffeb <__kernel_rt_sigreturn+1bab/????>
  16:   6c                        insb   (%dx),%es:(%edi)
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   69 6e 75 78 2f 63 72      imul   $0x72632f78,0x75(%esi),%ebp
Code;  fffffff3 <__kernel_rt_sigreturn+1bb3/????>
  1e:   79 70                     jns    90 <_EIP+0x90>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   74 6f                     je     91 <_EIP+0x91>
Code;  fffffff7 <__kernel_rt_sigreturn+1bb7/????>
  22:   2e                        cs
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   68 00 6e 61 6d            push   $0x6d616e00
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   65 20 20                  and    %ah,%gs:(%eax)
Code;  00000000 Before first symbol
  2b:   20 20                     and    %ah,(%eax)
Code;  00000002 Before first symbol
  2d:   20 20                     and    %ah,(%eax)
Code;  00000004 Before first symbol
  2f:   20 20                     and    %ah,(%eax)
Code;  00000006 Before first symbol
  31:   20 3a                     and    %bh,(%edx)
Code;  00000008 Before first symbol
  33:   20 25 73 0a 00 6d         and    %ah,0x6d000a73
Code;  0000000e Before first symbol
  39:   6f                        outsl  %ds:(%esi),(%dx)
Code;  0000000f Before first symbol
  3a:   64                        fs
Code;  00000010 Before first symbol
  3b:   75 6c                     jne    a9 <_EIP+0xa9>
Code;  00000012 Before first symbol
  3d:   65 20 20                  and    %ah,%gs:(%eax)

2 warnings and 1 error issued.  Results may not be reliable.

Kind regards,
-- 
Konrad Wojas                          .~.
~  wojas@vvtp.tudelft.nl             / V \
~                                   /(   )\
:wq       GnuPG key 0x588C85B1        ^ ^

