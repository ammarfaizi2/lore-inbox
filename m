Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWALRhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWALRhm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWALRhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:37:42 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:63976 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932456AbWALRhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:37:41 -0500
Date: Thu, 12 Jan 2006 18:37:52 +0100
From: Alexander Wagner <a.wagner@physik.uni-wuerzburg.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1[4,5]: battery info lost
Message-ID: <20060112173752.GN16769@wptx44.physik.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem: Linux seems to loose the battery information in recent kernels.

Keywords: Battery, ACPI, 2.6.14.x, 2.6.15

Description:

Since 2.6.14 I notice that after some time the Kernel seems
to loose the battery information via ACPI. This behaviour
is reproducable though I do not know how to provoke it (it
just happens). Occurs as well on the R52 from which are the
logs below as on my T41p. On LKML this problem seems also
to be mentioned by Narayan Desai and the same issues seems
to be reported by Alejandro Bonilla Beeche and Geoff Mishkin
mentioning this problem on other IBMs. As the latter uesed
some binary modules there was the request to reproduce it in
plain vanilla. I could provide this, including hopefully
something usefull below. It seems to be linked or the same
as
http://www.ussg.iu.edu/hypermail/linux/kernel/0511.0/2386.html
If further input is needed I'd happily provide it to get
sorted things out though I'll unfortunately not be able to
come up with a patch as this is far beyond my capabilities.

----------------------------------------------------------------------
Linux version 2.6.15.090106 (root@wptd64) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1 PREEMPT Mon Jan 9 14:59:36 CET 2006)))

----------------------------------------------------------------------
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux wptd64 2.6.15.090106 #1 PREEMPT Mon Jan 9 14:59:36 CET 2006 i686 GNU/Linux
 
Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.6.20
pcmcia-cs              3.2.5
quota-tools            3.12.
PPP                    2.4.3
nfs-utils              1.0.6
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   056
Modules Loaded         pcmcia parport_pc lp parport thermal fan button ac battery eth1394 tg3 ahci snd_intel8x0m 8250_pci 8250 serial_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd intel_agp agpgart uhci_hcd usbcore firmware_class ohci1394 yenta_socket rsrc_nonstatic pcmcia_core ext3 jbd sbp2 ieee1394 ide_cd nvram acpi_cpufreq processor


----------------------------------------------------------------------
wptd64:~# cat /proc/modules 
pcmcia 29220 2 - Live 0xe0afd000
parport_pc 33284 1 - Live 0xe09ec000
lp 8388 2 - Live 0xe0941000
parport 28872 2 parport_pc,lp, Live 0xe09f6000
thermal 11080 0 - Live 0xe08b1000
fan 3396 0 - Live 0xe08c1000
button 5008 0 - Live 0xe08be000
ac 3524 0 - Live 0xe08bc000
battery 8388 0 - Live 0xe08b5000
eth1394 16072 0 - Live 0xe09d6000
tg3 85956 0 - Live 0xe0995000
ahci 9540 0 - Live 0xe0a3a000
snd_intel8x0m 13196 0 - Live 0xe0ad5000
8250_pci 16704 0 - Live 0xe0a57000
8250 16340 1 8250_pci, Live 0xe0a62000
serial_core 15936 1 8250, Live 0xe0a5d000
snd_intel8x0 25948 0 - Live 0xe0acd000
snd_ac97_codec 80224 2 snd_intel8x0m,snd_intel8x0, Live 0xe0ae8000
snd_ac97_bus 1920 1 snd_ac97_codec, Live 0xe0a23000
snd_pcm_oss 42016 0 - Live 0xe0ac1000
snd_mixer_oss 14336 1 snd_pcm_oss, Live 0xe0a52000
snd_pcm 69768 4 snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss, Live 0xe0a67000
snd_timer 18948 1 snd_pcm, Live 0xe0a3e000
snd 43428 7 snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer, Live 0xe0a46000
soundcore 7136 1 snd, Live 0xe0a34000
snd_page_alloc 7944 3 snd_intel8x0m,snd_intel8x0,snd_pcm, Live 0xe0a27000
ehci_hcd 25288 0 - Live 0xe0a2c000
intel_agp 18012 1 - Live 0xe0a1d000
agpgart 26632 1 intel_agp, Live 0xe09ce000
uhci_hcd 27408 0 - Live 0xe098d000
usbcore 102596 3 ehci_hcd,uhci_hcd, Live 0xe0a02000
firmware_class 7488 1 pcmcia, Live 0xe0945000
ohci1394 28660 0 - Live 0xe0931000
yenta_socket 22092 2 - Live 0xe08e4000
rsrc_nonstatic 10368 1 yenta_socket, Live 0xe090a000
pcmcia_core 32976 3 pcmcia,yenta_socket,rsrc_nonstatic, Live 0xe0927000
ext3 113352 1 - Live 0xe0949000
jbd 47572 1 ext3, Live 0xe091a000
sbp2 20356 0 - Live 0xe08ec000
ieee1394 80824 3 eth1394,ohci1394,sbp2, Live 0xe08f5000
ide_cd 34372 0 - Live 0xe08d2000
nvram 6920 1 - Live 0xe0808000
acpi_cpufreq 4936 1 - Live 0xe080b000
processor 19712 2 thermal,acpi_cpufreq, Live 0xe0898000

----------------------------------------------------------------------
wptd64:~# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 2.00GHz
stepping        : 8
cpu MHz         : 798.216
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe est tm2
bogomips        : 1599.11


----------------------------------------------------------------------
wptd64:~# cat /var/log/syslog:

Jan 12 15:29:12 localhost kernel:     ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
Jan 12 15:29:12 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node dfecbbe0), AE_AML_METHOD_LIMIT
Jan 12 15:29:13 localhost kernel:     ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
Jan 12 15:29:13 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node dfecbbe0), AE_AML_METHOD_LIMIT
Jan 12 15:29:14 localhost kernel:     ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
Jan 12 15:29:14 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node dfecbbe0), AE_AML_METHOD_LIMIT
Jan 12 15:29:16 localhost kernel:     ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
Jan 12 15:29:16 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node dfecbbe0), AE_AML_METHOD_LIMIT
Jan 12 15:29:18 localhost kernel:     ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
Jan 12 15:29:18 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node dfecbbe0), AE_AML_METHOD_LIMIT
Jan 12 15:29:18 localhost kernel:     ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)

-- 

Kind regards,                /                 War is Peace.
                            |            Freedom is Slavery.
Alexander Wagner            |         Ignorance is Strength.
                            |
                            | Theory     : G. Orwell, "1984"
                           /  In practice:   USA, since 2001
