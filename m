Return-Path: <linux-kernel-owner+w=401wt.eu-S1751083AbWLQUCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWLQUCN (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 15:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWLQUCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 15:02:13 -0500
Received: from smtp-out.rrz.uni-koeln.de ([134.95.19.53]:34404 "EHLO
	smtp-out.rrz.uni-koeln.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbWLQUCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 15:02:12 -0500
X-Greylist: delayed 2114 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 15:02:12 EST
Message-ID: <45859609.8050502@rrz.uni-koeln.de>
Date: Sun, 17 Dec 2006 20:10:01 +0100
From: Berthold Cogel <cogel@rrz.uni-koeln.de>
User-Agent: IceDove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG linux-2.6-20-rc1: kernel BUG at drivers/cpufreq/cpufreq_userspace.c
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've found a kernel bug in linux-2.6-20-rc1 from kernel.org:

Dec 17 19:12:56 localhost kernel: kernel BUG at
drivers/cpufreq/cpufreq_userspace.c:140!
Dec 17 19:12:56 localhost kernel: invalid opcode: 0000 [#1]
Dec 17 19:12:56 localhost kernel: PREEMPT
Dec 17 19:12:56 localhost kernel: Modules linked in: acpi_cpufreq
freq_table processor sg scsi_mod usbhid hid joydev nsc_ircc pcmcia
snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm_oss snd_mixer_oss
firmware_class snd_pcm snd_timer irda tifm_7xx1 tifm_sd mmc_block
mmc_core ide_cd crc_ccitt i2c_i801 snd soundcore snd_page_alloc
tifm_core psmouse ohci1394 ieee1394 ehci_hcd uhci_hcd yenta_socket
rsrc_nonstatic pcmcia_core rtc pcspkr cdrom usbcore intel_agp agpgart
evdev unix
Dec 17 19:12:56 localhost kernel: CPU:    0
Dec 17 19:12:56 localhost kernel: EIP:    0060:[<c022fe0d>]    Not
tainted VLI
Dec 17 19:12:56 localhost kernel: EFLAGS: 00010246   (2.6.20-rc1-vanilla #1)
Dec 17 19:12:56 localhost kernel: EIP is at
cpufreq_governor_userspace+0x32/0x134
Dec 17 19:12:56 localhost kernel: eax: c1b85480   ebx: c1b85480   ecx:
c0308220   edx: 00000000
Dec 17 19:12:56 localhost kernel: esi: 00000000   edi: ffffffea   ebp:
c1b85480   esp: f7f2bdb4
Dec 17 19:12:56 localhost kernel: ds: 007b   es: 007b   ss: 0068
Dec 17 19:12:56 localhost kernel: Process modprobe (pid: 2098,
ti=f7f2a000 task=c1938a70 task.ti=f7f2a000)
Dec 17 19:12:56 localhost kernel: Stack: c1b85480 00000000 00000001
c022ef25 f7f2be04 00000000 00000000 c1b85480
Dec 17 19:12:56 localhost kernel:        c022f023 c1b854ac c1b85480
f7f2be04 c1b854ac c022f1e4 c1b85480 f9b1c918
Dec 17 19:12:56 localhost kernel:        f7f2bea4 c022fb42 c03498e8
00000000 00000001 00000002 00000000 00186a00
Dec 17 19:12:56 localhost kernel: Call Trace:
Dec 17 19:12:56 localhost kernel:  [<c022ef25>] __cpufreq_governor+0x56/0x87
Dec 17 19:12:56 localhost kernel:  [<c022f023>]
__cpufreq_set_policy+0xcd/0x100
Dec 17 19:12:56 localhost kernel:  [<c022f1e4>] cpufreq_set_policy+0x2a/0x5f
Dec 17 19:12:56 localhost kernel:  [<c022fb42>] cpufreq_add_dev+0x1f1/0x269
Dec 17 19:12:56 localhost kernel:  [<c022f1b2>] handle_update+0x0/0x8
Dec 17 19:12:56 localhost kernel:  [<c020f7ff>]
sysdev_driver_register+0x4c/0x94
Dec 17 19:12:56 localhost kernel:  [<c022fd5c>]
cpufreq_register_driver+0xa2/0x112
Dec 17 19:12:56 localhost kernel:  [<f9b3504a>]
acpi_cpufreq_init+0x4a/0x4c [acpi_cpufreq]
Dec 17 19:12:56 localhost kernel:  [<c012e538>]
sys_init_module+0x147a/0x15b3
Dec 17 19:12:56 localhost kernel:  [<c0102c56>] sysenter_past_esp+0x5f/0x85
Dec 17 19:12:56 localhost kernel:  =======================
Dec 17 19:12:56 localhost kernel: Code: 08 83 fa 02 74 7f 83 fa 03 0f 84
bb 00 00 00 31 ff 4a 0f 85 0f 01 00 00 bf ea ff ff ff 85 f6 0f 85 02 01
00 00 83 78 20 00 75 04 <0f> 0b eb fe b8 4c 82 30 c0 e8 dd 2c 05 00 8d
43 58 ba 58 82 30
Dec 17 19:12:56 localhost kernel: EIP: [<c022fe0d>]
cpufreq_governor_userspace+0x32/0x134 SS:ESP 0068:f7f2bdb4
Dec 17 19:12:56 localhost kernel:  <7>ieee80211_crypt: registered
algorithm 'NULL'

...

My system is a Debian unstable/testing:

Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.3-pre2
e2fsprogs              1.40-WIP
reiserfsprogs          3.6.19
xfsprogs               2.8.18
pcmciautils            014
PPP                    2.4.4
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
udev                   103
wireless-tools         28


Regards,

Berthold Cogel
