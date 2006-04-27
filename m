Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWD0A7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWD0A7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 20:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWD0A7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 20:59:15 -0400
Received: from 200.138.116-99.ctame705.e.brasiltelecom.net.br ([200.138.116.99]:43562
	"EHLO scadufax.mrgnetwork.com.br") by vger.kernel.org with ESMTP
	id S964787AbWD0A7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 20:59:15 -0400
Message-ID: <4450168B.4030001@mrgnetwork.com.br>
Date: Wed, 26 Apr 2006 21:55:39 -0300
From: Marlon <marlon@mrgnetwork.com.br>
User-Agent: Mail/News 1.5 (X11/20060219)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at arch/i386/mm/pageattr.c:152!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using kernel 2.6.16.9 with Con Kolivas patch-2.6.16-ck6.bz2.
On boot I got the following message:

kernel BUG at arch/i386/mm/pageattr.c:152!
invalid opcode: 0000 [#1]
Modules linked in: nvidiafb powernow_k8 freq_table cryptoloop aes fuse 
pcspkr tsdev usblp pcmcia yenta_socket rsrc_nonstatic pcmcia_core video 
thermal processor fan container button battery ac snd_via82xx gameport 
snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc 
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore i2c_viapro 
ehci_hcd uhci_hcd shpchp usbcore pci_hotplug amd64_agp agpgart 8250_pnp 
sk98lin skge parport_pc parport 8250 serial_core psmouse serio_raw 
capability commoncap evdev
CPU:    0
EIP:    0060:[<c01160b3>]    Tainted: G  R   VLI
EFLAGS: 00010082   (2.6.16.9 #1)
EIP is at __change_page_attr+0x1b3/0x1e0
eax: 0000ac00   ebx: 36500000   ecx: c100ac00   edx: 00000163
esi: c0560f64   edi: c1000000   ebp: f6500000   esp: f5ce1e4c
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 4574, threadinfo=f5ce0000 task=f6cdc030)
Stack: <0>f6500000 f64ff000 364001e3 c16ca000 00000010 00000246 00000011 
c0116116
       c16ca000 00000163 f6debe20 f88e0000 f6f6c5c0 00000004 c0115d19 
c16c9e00
       00000011 00000163 f6f6c5c0 f7c87048 f8886650 f88e0000 00000090 
f6f6c5c0
Call Trace:
 [<c0116116>] change_page_attr+0x36/0x60
 [<c0115d19>] iounmap+0xa9/0xe0
 [<f8886650>] agp_generic_free_gatt_table+0x30/0xd0 [agpgart]
 [<f88842ae>] agp_backend_cleanup+0x5e/0x80 [agpgart]
 [<f8884490>] agp_remove_bridge+0x10/0x70 [agpgart]
 [<f887ae32>] agp_amd64_remove+0x42/0x50 [amd64_agp]
 [<c02b7606>] pci_device_remove+0x36/0x40
 [<c0312bb9>] __device_release_driver+0xa9/0xe0
 [<c0312cc5>] driver_detach+0x95/0x97
 [<c03123be>] bus_remove_driver+0x3e/0x70
 [<c0313080>] driver_unregister+0x10/0x20
 [<c02b7893>] pci_unregister_driver+0x13/0x20
 [<f887aee4>] agp_amd64_cleanup+0x34/0x38 [amd64_agp]
 [<c0134667>] sys_delete_module+0x197/0x1d0
 [<c015c1f1>] sys_close+0x51/0x70
 [<c010306f>] sysenter_past_esp+0x54/0x75
Code: 24 18 83 c4 1c c3 89 f6 0b 5c 24 24 89 1e e9 29 ff ff ff 90 8d 74 
26 00 f6 06 80 75 0e 0b 5c 24 24 89 1e ff 49 04 e9 21 ff ff ff <0f> 0b 
98 00 c5 c7 45 c0 e9 14 ff ff ff 8b 51 0c e9 43 ff ff ff

cpuinfo:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 12
model name      : AMD Athlon(tm) 64 Processor 3000+
stepping        : 0
cpu MHz         : 1000.000
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 
3dnowext 3dnow ts fid vid ttp
bogomips        : 2004.79

lspci:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 12
model name      : AMD Athlon(tm) 64 Processor 3000+
stepping        : 0
cpu MHz         : 1000.000
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 
3dnowext 3dnow ts fid vid ttp
bogomips        : 2004.79


subsystems version:


Linux arwen 2.6.16.9 #1 Thu Apr 20 22:25:39 BRT 2006 i686 athlon i386 
GNU/Linux

Gnu C                  3.4.3
Gnu make               3.80
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.1
e2fsprogs              1.38
reiserfsprogs          3.6.19
reiser4progs           1.0.5
xfsprogs               2.6.36
pcmcia-cs              3.2.8
Linux C Library        2.3.90
Dynamic linker (ldd)   2.3.90
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   071
Modules Loaded         ipv6 nvidiafb powernow_k8 freq_table cryptoloop 
aes fuse pcspkr tsdev usblp pcmcia yenta_socket rsrc_nonstatic 
pcmcia_core video thermal processor fan container button battery ac 
snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_pcm snd_timer 
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 
i2c_viapro ehci_hcd uhci_hcd shpchp usbcore pci_hotplug amd64_agp 
agpgart 8250_pnp sk98lin skge parport_pc parport 8250 serial_core 
psmouse serio_raw capability commoncap evdev


regards,

Marlon
