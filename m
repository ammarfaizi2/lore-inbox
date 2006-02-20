Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWBTMHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWBTMHz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 07:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWBTMHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 07:07:55 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:16837 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964915AbWBTMHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 07:07:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Z2M76mbroaU7DmQOKuAgz5spOfV+QiSu9xWL8A50Q7JcCt/u7a7uaUH2N1+0eCzNGjUpNuN8oVH/8xuyj4YjBt5OpXiElFnghvcWFXWAepfV84QnotZovJWj8xT8uyqKIIp7ghaKwVQ6f/TScYBRMflnRNKT9ji5Kk/WoZ6ta4s=
Subject: Kernel panic when compiling with SMP support
From: Chris Largret <largret@gmail.com>
Reply-To: largret@gmail.com
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 04:07:51 -0800
Message-Id: <1140437271.7849.21.camel@shogun.daga.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a problem that I have been having for a while (since 2.6.12 or
so), but am just now getting around to reporting it. I'm using the
latest kernel prepatch (2.6.16-rc4) with an AMD X2 processor for these
print-outs.

In short, I only get these kernel panics when I enable SMP. I can
disable SMP and the kernel works great. I can work, play games, or just
about anything else. When I enable SMP, everything works until I peak
the processor with a compile, by starting Xorg, or something similar. As
soon as the processor becomes idle again, the kernel panics.

I have captures of two kernel panics here. If you need any extra
information or want me to test anything, please let me know.

Thanks in advance for your help.

--------------------------------------------------------------------
Capture 1

invalid opcode: 0000 [1] SMP
CPU 1 rated by 'liloconfig'
Modules linked in: snd_pcm_oss snd_mixer_oss md5 ipv6 ipt_recent
ipt_REJECT xt_state xt_tcpudp iptable_filter ip_tables x_tables nfs
lockd nfs_acl sunrpc uhci_hcd r8169 ohci1394 ieee1394 emu10k1_gp
gameport snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm
snd_seq_device snd_timer snd_page_alloc snd_util_mem snd_hwdep snd
tda9887 tuner cx8800 cx88xx video_buf ir_common tveeprom compat_ioctl32
v4l1_compat v4l2_common btcx_risc videodev forcedeth ohci_hcd
i2c_nforce2 ehci_hcd
Pid: 0, comm: swapper Not tainted 2.6.16-rc4-daga #1
RIP: 0010:[<ffffffff8100efa8>] <ffffffff8100efa8>{timer_interrupt+0}
RSP: 0018:ffff8100044d7f10 EFLAGS: 00010002
RAX: 0000000000000001 RBX: ffffffff812cde80 RCX: 0000000000000000
RDX: ffff8100044d1e38 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff8100044d1e38 R08: ffff8100044d0000 R09: ffff810003e7c960
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8100044d1e38
PS:  00002b116b65cb00(0000) GS:ffff8100bffa6768(0000)
kn1GS:0000000000000000
CS: 0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000005c0b50 CR3: 00000000045fc000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff8100044d0000, task
ffff8100bffaa100)
Stack: ffffffff81049787 0000000000000000 ffffffff81413d00
0000000000000000
       0000000000000000 ffffffff812cde80 ffff8100044d1e38
ffff8100044d7f88
       ffffffff8104985e ffff8100044d0000
Call Trace: <IRQ> <ffffffff81049787>{handle_IRQ_event+48}
       <ffffffff8104985e>{__do_IRQ+161} <ffffffff8100d8ec>{do_IRQ+59}
       <ffffffff81008d0f>{default_idle+0}
<ffffffff8100b002>{ret_from_intr+0} <EOI>
       <ffffffff81008d0f>{default_idle+0}
<ffffffff81008d3e>{default_idle+47}
       <ffffffff81008f44>{cpu_idle+103}
<ffffffff814270a1>{start_secondary+1189}

Code: 83 3d 7d d6 38 00 01 55 48 89 d7 48 89 e5 7f 13 e8 50 fc ff
RIP <ffffffff8100efa8>{timer_interrupt+0} RSP <ffff8100044d7f10>
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!


--------------------------------------------------------------------
Capture 2

Unable to handle kernel NULL pointer dereference at 0000000000000001
RIP:
<ffffffff8100cfa8>{timer_interrupt+0}
PGD be657067 PUD b1c2a067 PMD 0
Oops: 0002 [1] SMP
CPU 1
Modules linked in: parport_pc parport snd_pcm_oss snd_mixer_oss md5 ipv6
ipt_recent ipt_REJECT xt_state xt_tcpudp iptable_filter ip_tables
x_tables nfs lockd nfs_acl sunrpc uhci_hcd r8169 ohci1394 ieee1394
emu10k1_gp gameport snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus
snd_pcm snd_seq_device snd_timer snd_page_alloc snd_util_mem snd_hwdep
snd tda9887 tuner cx8800 cx88xx video_buf ir_common tveeprom
compat_ioctl32 v4l1_compat v4l2_common btcx_risc videodev forcedeth
ohci_hcd i2c_nforce2 ehci_hcd
Pid: 0, comm: swapper Not tainted 2.6.16-rc4-daga #1 0:00.00
[watchdog/1]
RIP: 0010:[<ffffffff8100cfa8>] <ffffffff8100efa8>{timer_interrupt+0}/0]
RSP: 0018:ffff8100044d7f10  EFLAGS: 000100020
RAX: 0000000000000001 RBX: ffffffff812cde80 RCX: 0000000000000000
RDX: ffff8100044d1e38 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff8100044d7f48 R08: ffff8100044d0000 R09: ffff810003e7c960
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8100044d1e38
FS:  00002b759a0a8b00(0000) GS:ffff8100bffa6768(0000)
kn1GS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b0
CR2: 0000000000000001 CR3: 00000000b2db0000 CR4: 0000000000000be0
Process swapper (pid: 0, threadinfo ffff8100044d0000, task
ffff8100bffaa100)
Stack: ffffffff81049787 0000000000000000 ffffffff81413d00
0000000000000000
       0000000000000000 ffffffff812cde80 ffff8100044d1e38
ffff8100044d7f88
       ffffffff8104985e ffff8100044d0000
Call Trace: <IRQ> <ffffffff81049787>{handle_IRQ_event+48}
       <ffffffff8104985e>{__do_IRQ+161} <ffffffff8100d8ec>{do_IRQ+59}
       <ffffffff81008d0f>{default_idle+0}
<ffffffff8100b002>{ret_from_intr+0} <EOI>
       <ffffffff81008d0f>{default_idle+0}
<ffffffff81008d3e>{default_idle+47}
       <ffffffff81008f44>{cpu_idle+103}
<ffffffff814270a1>{start_secondary+1189}

Code: 83 3d 7d d6 38 00 01 55 48 89 d7 48 89 e5 7f 13 e8 50 fc ff
RIP <ffffffff8100efa8>{timer_interrupt+0} RSP <ffff8100044d7f10>
CRZ: 0000000000000001
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

--------------------------------------------------------------------
other information (pulled from a non-SMP kernel)

$ uname -a
Linux shogun 2.6.16-rc4-daga #2 Mon Feb 20 01:10:33 PST 2006 x86_64 AMD
Athlon(tm) 64 X2 Dual Core Processor 4200+ AuthenticAMD GNU/Linux


$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 43
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4200+
stepping        : 1
cpu MHz         : 2210.800
cache size      : 512 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 4428.43
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp


$ cat /proc/modules
nls_iso8859_1 5824 0 - Live 0xffffffff8800c000
usb_storage 71104 0 - Live 0xffffffff88240000
ohci_hcd 20612 0 - Live 0xffffffff88000000
ext2 66768 0 - Live 0xffffffff8822e000
mbcache 9992 1 ext2, Live 0xffffffff8822a000
vfat 14336 0 - Live 0xffffffff88225000
fat 54192 1 vfat, Live 0xffffffff88216000
snd_pcm_oss 52544 0 - Live 0xffffffff88208000
snd_mixer_oss 18176 2 snd_pcm_oss, Live 0xffffffff88202000
md5 5120 1 - Live 0xffffffff881ff000
ipv6 259136 10 - Live 0xffffffff881bc000
ipt_recent 11288 2 - Live 0xffffffff881b8000
ipt_REJECT 6528 1 - Live 0xffffffff881b5000
xt_state 2880 4 - Live 0xffffffff881b3000
xt_tcpudp 4160 10 - Live 0xffffffff881b0000
iptable_filter 3776 1 - Live 0xffffffff881ae000
ip_tables 13216 1 iptable_filter, Live 0xffffffff881a9000
x_tables 14792 5 ipt_recent,ipt_REJECT,xt_state,xt_tcpudp,ip_tables,
Live 0xffffffff881a4000
nfs 211248 2 - Live 0xffffffff8816f000
lockd 64080 2 nfs, Live 0xffffffff8815e000
nfs_acl 4288 1 nfs, Live 0xffffffff8815b000
sunrpc 156616 4 nfs,lockd,nfs_acl, Live 0xffffffff88133000
uhci_hcd 31904 0 - Live 0xffffffff8812a000
r8169 29384 0 - Live 0xffffffff88121000
ohci1394 33544 0 - Live 0xffffffff88117000
ieee1394 100792 1 ohci1394, Live 0xffffffff880fd000
emu10k1_gp 4672 0 - Live 0xffffffff880fa000
gameport 16720 2 emu10k1_gp, Live 0xffffffff880f4000
snd_emu10k1 118788 2 - Live 0xffffffff880d5000
snd_rawmidi 27840 1 snd_emu10k1, Live 0xffffffff880cd000
snd_ac97_codec 104472 1 snd_emu10k1, Live 0xffffffff880b2000
snd_ac97_bus 3136 1 snd_ac97_codec, Live 0xffffffff880b0000
snd_pcm 92684 3 snd_pcm_oss,snd_emu10k1,snd_ac97_codec, Live
0xffffffff88098000
snd_seq_device 10000 2 snd_emu10k1,snd_rawmidi, Live 0xffffffff88094000
snd_timer 25096 2 snd_emu10k1,snd_pcm, Live 0xffffffff8808c000
snd_page_alloc 11984 2 snd_emu10k1,snd_pcm, Live 0xffffffff88088000
snd_util_mem 5824 1 snd_emu10k1, Live 0xffffffff88085000
snd_hwdep 11528 1 snd_emu10k1, Live 0xffffffff88081000
snd 61352 11
snd_pcm_oss,snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_ac97_codec,snd_pcm,snd_seq_device,snd_timer,snd_hwdep, Live 0xffffffff88071000
tda9887 17872 0 - Live 0xffffffff8806b000
tuner 53356 0 - Live 0xffffffff8805c000
cx8800 34828 1 - Live 0xffffffff88052000
cx88xx 68708 1 cx8800, Live 0xffffffff88040000
video_buf 24196 2 cx8800,cx88xx, Live 0xffffffff88039000
ir_common 11012 1 cx88xx, Live 0xffffffff88035000
tveeprom 17168 1 cx88xx, Live 0xffffffff8802f000
compat_ioctl32 9280 1 cx8800, Live 0xffffffff8802b000
v4l1_compat 12548 1 cx8800, Live 0xffffffff88026000
v4l2_common 10112 3 tuner,cx8800,compat_ioctl32, Live 0xffffffff88022000
btcx_risc 5704 2 cx8800,cx88xx, Live 0xffffffff8801f000
videodev 12096 3 cx8800,cx88xx, Live 0xffffffff8801b000
forcedeth 24580 0 - Live 0xffffffff88013000
i2c_nforce2 8000 0 - Live 0xffffffff88009000


----------------------------------------------------------------

And that's all I have for now. Thanks for reading through everything. :)


--
Chris Largret <http://daga.dyndns.org>

