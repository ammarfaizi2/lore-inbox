Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbVKCSpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbVKCSpG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbVKCSpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:45:05 -0500
Received: from weber.sscnet.ucla.edu ([128.97.42.3]:17351 "EHLO
	weber.sscnet.ucla.edu") by vger.kernel.org with ESMTP
	id S1030425AbVKCSpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:45:03 -0500
Message-ID: <436A5AB9.4080102@cogweb.net>
Date: Thu, 03 Nov 2005 10:45:13 -0800
From: David Liontooth <liontooth@cogweb.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.14 qc-usb oops on amd64 smp
References: <42ABBE6F.8080406@brturbo.com.br> <42ABC3C4.4050406@brturbo.com.br> <20050614170137.690e0328.akpm@osdl.org> <42AFF53A.5060107@cogweb.net>
In-Reply-To: <42AFF53A.5060107@cogweb.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 * amd64 dual opteron
 * vanilla linux 2.6.14
 * qc-usb-source 0.6.3-1
 * gcc 4.0
 * Debian sid

The driver did not work with motv, rmmod -f quickcam failed, and
unplugging the quickcam then caused the following oops.

The kernel is nvidia tainted; if relevant, I'll be happy to test without
the nvidia module. The quickcam worked in 2.6.12.

Dave

ohci_hcd 0000:03:00.0: leak ed ffff81007fcdb280 (#81) state 2
usb 1-3: USB disconnect, address 3
usb 1-3.1: USB disconnect, address 4
drivers/usb/input/hid-core.c: can't resubmit intr,
0000:03:00.0-3.2/input0, status -19
usb 1-3.2: USB disconnect, address 5
usb 1-2: USB disconnect, address 2
Unable to handle kernel paging request at 0000000300000063 RIP:
<ffffffff802dd8f1>{usb_kill_urb+33}
PGD 24045067 PUD 0
Oops: 0000 [1] SMP
CPU 1
Modules linked in: vmnet vmmon binfmt_misc nfs 8250_pnp 8250 serial_core
sata_promise libata bttv video_buf firmware_class i2c_algo_bit btcx_risc
tveeprom nls_cp437 dm_mod snd_bt87x quickcam ncpfs evdev cryptoloop loop
aes_x86_64 adm1026 lm92 lm87 lm63 w83792d i2c_amd8111 i2c_dev tvaudio
tvmixer i2o_proc i2o_core eeprom tda9887 tuner snd_seq_oss snd_seq_midi
snd_seq_midi_event snd_seq snd_rtctimer snd_pcm_oss snd_mixer_oss
snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer
snd_ac97_bus snd_page_alloc snd_util_mem snd_hwdep snd cpufreq_ondemand
nvidia nfsd lockd sunrpc sd_mod exportfs 3w_xxxx ipx psnap p8022 llc tg3
rtc joydev
Pid: 112, comm: khubd Tainted: P      2.6.14 #1
RIP: 0010:[<ffffffff802dd8f1>] <ffffffff802dd8f1>{usb_kill_urb+33}
RSP: 0018:ffff81007fc75ca8  EFLAGS: 00010206
RAX: 0000000300000003 RBX: ffff810036b8b600 RCX: ffff81007fd2a1c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff810036b8b600
RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff8029c460 R12: ffff81007e104318
R13: ffff81007ff56c20 R14: ffff81007ff3b420 R15: 0000000000000100
FS:  00002aaaad71def0(0000) GS:ffffffff804ab880(0000) knlGS:00000000556c72a0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000300000063 CR3: 00000000570a4000 CR4: 00000000000006e0
Process khubd (pid: 112, threadinfo ffff81007fc74000, task ffff8100032c0100)
Stack: ffff81007ff3b420 0000000000000100 ffff81007fc75ce8 ffffffff8012c30f
       0000000300000000 ffff81007ff56ca0 ffff81007e104318 0000000000000002
       ffff81007e104318 ffffffff88611110
Call Trace:<ffffffff8012c30f>{complete+63}
<ffffffff88611110>{:quickcam:qc_isoc_stop+224}
       <ffffffff886111d8>{:quickcam:qc_usb_disconnect+120}
       <ffffffff802d7f03>{usb_unbind_interface+83}
<ffffffff8029be6b>{__device_release_driver+107}
       <ffffffff8029c1f3>{device_release_driver+51}
<ffffffff8029b8a2>{bus_remove_device+146}
       <ffffffff8029a7c7>{device_del+55}
<ffffffff802de075>{usb_disable_device+165}
       <ffffffff802d8551>{usb_disconnect+209}
<ffffffff802daca6>{hub_thread+902}
       <ffffffff801499b0>{autoremove_wake_function+0}
<ffffffff802da920>{hub_thread+0}
       <ffffffff801494f0>{keventd_create_kthread+0}
<ffffffff80149779>{kthread+217}
       <ffffffff8012fd00>{schedule_tail+64} <ffffffff8010eb56>{child_rip+8}
       <ffffffff801494f0>{keventd_create_kthread+0}
<ffffffff801496a0>{kthread+0}
       <ffffffff8010eb4e>{child_rip+0}

Code: 48 8b 40 60 48 85 c0 0f 84 da 00 00 00 48 83 78 30 00 0f 84
RIP <ffffffff802dd8f1>{usb_kill_urb+33} RSP <ffff81007fc75ca8>
CR2: 0000000300000063

# lspci -nv
0000:00:06.0 0604: 1022:7460 (rev 07)
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: fca00000-feafffff
        Prefetchable memory behind bridge: f9600000-f96fffff
        Capabilities: [c0] #08 [0086]
        Capabilities: [f0] #08 [8000]

0000:00:07.0 0601: 1022:7468 (rev 05)
        Subsystem: 1022:7468
        Flags: bus master, 66MHz, medium devsel, latency 0

0000:00:07.1 0101: 1022:7469 (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: 1022:7469
        Flags: bus master, medium devsel, latency 32
        I/O ports at ffa0 [size=16]

0000:00:07.2 0c05: 1022:746a (rev 02)
        Subsystem: 1022:746a
        Flags: medium devsel, IRQ 9
        I/O ports at cc00 [size=32]

0000:00:07.3 0680: 1022:746b (rev 05)
        Subsystem: 1022:746b
        Flags: medium devsel

0000:00:0a.0 0604: 1022:7450 (rev 12)
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: fb900000-fc9fffff
        Prefetchable memory behind bridge: 00000000f9500000-00000000f9500000
        Capabilities: [a0]      Capabilities: [b8] #08 [8000]
        Capabilities: [c0] #08 [004a]

0000:00:0a.1 0800: 1022:7451 (rev 01) (prog-if 10)
        Subsystem: 1022:7451
        Flags: bus master, medium devsel, latency 0
        Memory at febfe000 (64-bit, non-prefetchable) [size=4K]

0000:00:0b.0 0604: 1022:7450 (rev 12)
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: f9800000-fb8fffff
        Prefetchable memory behind bridge: 00000000e9400000-00000000f9400000
        Capabilities: [a0]      Capabilities: [b8] #08 [8000]

0000:00:0b.1 0800: 1022:7451 (rev 01) (prog-if 10)
        Subsystem: 1022:7451
        Flags: bus master, medium devsel, latency 0
        Memory at febff000 (64-bit, non-prefetchable) [size=4K]

0000:00:18.0 0600: 1022:1100
        Flags: fast devsel
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]

0000:00:18.1 0600: 1022:1101
        Flags: fast devsel

0000:00:18.2 0600: 1022:1102
        Flags: fast devsel

0000:00:18.3 0600: 1022:1103
        Flags: fast devsel

0000:00:19.0 0600: 1022:1100
        Flags: fast devsel
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]

0000:00:19.1 0600: 1022:1101
        Flags: fast devsel

0000:00:19.2 0600: 1022:1102
        Flags: fast devsel

0000:00:19.3 0600: 1022:1103
        Flags: fast devsel

0000:01:03.0 0401: 1102:0008
        Subsystem: 1102:1001
        Flags: bus master, medium devsel, latency 64, IRQ 21
        I/O ports at 9c00 [size=64]
        Capabilities: [dc] Power Management version 2

0000:01:06.0 0300: 10de:0326 (rev a1)
        Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 20
        Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at fb8e0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2

0000:02:07.0 0104: 13c1:1001 (rev 01)
        Subsystem: 13c1:1001
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 19
        I/O ports at ac00 [size=16]
        Memory at fc9ffc00 (32-bit, non-prefetchable) [size=16]
        Memory at fc000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at fc9e0000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 1

0000:02:09.0 0200: 14e4:1648 (rev 03)
        Subsystem: 14e4:1644
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 17
        Memory at fc9a0000 (64-bit, non-prefetchable) [size=64K]
        Memory at fc990000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at fc980000 [disabled] [size=64K]
        Capabilities: [40]      Capabilities: [48] Power Management
version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-

0000:02:09.1 0200: 14e4:1648 (rev 03)
        Subsystem: 14e4:1644
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 18
        Memory at fc9d0000 (64-bit, non-prefetchable) [size=64K]
        Memory at fc9c0000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at fc9b0000 [disabled] [size=64K]
        Capabilities: [40]      Capabilities: [48] Power Management
version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-

0000:03:00.0 0c03: 1022:7464 (rev 0b) (prog-if 10)
        Subsystem: 1022:7464
        Flags: bus master, medium devsel, latency 64, IRQ 16
        Memory at feafd000 (32-bit, non-prefetchable) [size=4K]

0000:03:00.1 0c03: 1022:7464 (rev 0b) (prog-if 10)
        Subsystem: 1022:7464
        Flags: bus master, medium devsel, latency 64, IRQ 16
        Memory at feafe000 (32-bit, non-prefetchable) [size=4K]

0000:03:04.0 0400: 109e:036e (rev 11)
        Subsystem: 1461:0004
        Flags: bus master, medium devsel, latency 64, IRQ 22
        Memory at f96fe000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2

0000:03:04.1 0480: 109e:0878 (rev 11)
        Subsystem: 1461:0004
        Flags: bus master, medium devsel, latency 64, IRQ 5
        Memory at f96ff000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2

0000:03:05.0 0104: 105a:3373 (rev 02)
        Subsystem: 105a:6619
        Flags: bus master, 66MHz, medium devsel, latency 96, IRQ 23
        I/O ports at bc00 [size=64]
        I/O ports at b880 [size=16]
        I/O ports at b800 [size=128]
        Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
        Memory at feac0000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [60] Power Management version 2

0000:03:06.0 0300: 1002:4752 (rev 27)
        Flags: stepping, medium devsel, IRQ 216
        Memory at fd000000 (32-bit, non-prefetchable) [disabled] [size=16M]
        I/O ports at b000 [disabled] [size=256]
        Memory at fca00000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Expansion ROM at f9600000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2








