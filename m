Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWKCXCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWKCXCK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 18:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWKCXCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 18:02:10 -0500
Received: from smtp-out.rrz.uni-koeln.de ([134.95.19.53]:53703 "EHLO
	smtp-out.rrz.uni-koeln.de") by vger.kernel.org with ESMTP
	id S932479AbWKCXCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 18:02:09 -0500
Message-ID: <454BCA68.4020904@rrz.uni-koeln.de>
Date: Sat, 04 Nov 2006 00:02:00 +0100
From: Berthold Cogel <cogel@rrz.uni-koeln.de>
User-Agent: IceDove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.18 Oops: unable to handle kernel paging request at virtual
 address 766565af
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I got an Oops with linux-2.6.18 ('homemade' kernel.org, unpatched) while
testing a new USB headset (Logitech Premium Notebook Headset).

My System: Debian unstable/testing. Notebook Acer Extensa 3002 WLMi.

The headset is recognised by the system and the modules are loaded.
After restarting the gnome mixer applet, I can hear the sound from the
microfon in the headset speaker. I'm able to mute and unmute the speaker
and the microfon of headset in the mixer.

I tried to get the output from XMMS to the headset. Therefor I
configured the alsa plugin for XMMS to use the headset, which didn't
work. I was also unable to get the sound from the microfon to the system
speaker. Then I removed the headset and closed XMMS. This was when the
Oops happened.

I haven't been able to reproduce the Oops yet.


/var/log/kern.log

Nov  3 18:47:38 localhost kernel: usb 4-2: new full speed USB device
using uhci_hcd and address 2
Nov  3 18:47:38 localhost kernel: usb 4-2: configuration #1 chosen from
1 choice
Nov  3 18:47:40 localhost kernel: usbcore: registered new driver
snd-usb-audio
Nov  3 18:55:38 localhost kernel: cannot submit datapipe for urb 5,
error -28: not enough bandwidth
Nov  3 18:56:19 localhost kernel: cannot submit datapipe for urb 5,
error -28: not enough bandwidth
Nov  3 18:56:58 localhost kernel: usb 4-2: USB disconnect, address 2
Nov  3 18:57:42 localhost kernel: BUG: unable to handle kernel paging
request at virtual address 766565af
Nov  3 18:57:42 localhost kernel:  printing eip:
Nov  3 18:57:42 localhost kernel: c014af57
Nov  3 18:57:42 localhost kernel: *pde = 00000000
Nov  3 18:57:42 localhost kernel: Oops: 0002 [#1]
Nov  3 18:57:42 localhost kernel: PREEMPT
Nov  3 18:57:42 localhost kernel: Modules linked in: snd_usb_audio
snd_usb_lib snd_hwdep binfmt_misc rfcomm l2cap bluetooth nfs lockd
nfs_acl sunrpc af_packet thermal fan button sbs i2c_ec autofs4
snd_intel8x0m dm_mirror ipw2200 b44 mii ieee80211_crypt_tkip
ieee80211_crypt_ccmp ieee80211_crypt_wep ieee80211 ieee80211_crypt
cpufreq_conservative cpufreq_ondemand cpufreq_performance
cpufreq_powersave acpi_cpufreq freq_table processor sg scsi_mod
snd_intel8x0 usbhid snd_ac97_codec snd_ac97_bus pcmcia firmware_class
snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss snd_seq_midi
snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device
intel_agp joydev nsc_ircc snd i2c_i801 yenta_socket rsrc_nonstatic
agpgart uhci_hcd ehci_hcd soundcore irda ohci1394 evdev pcspkr usbcore
snd_page_alloc crc_ccitt ieee1394 pcmcia_core ide_cd cdrom psmouse rtc unix
Nov  3 18:57:42 localhost kernel: CPU:    0
Nov  3 18:57:42 localhost kernel: EIP:    0060:[<c014af57>]    Not
tainted VLI
Nov  3 18:57:42 localhost kernel: EFLAGS: 00010202   (2.6.18.1-vanilla #1)
Nov  3 18:57:42 localhost kernel: EIP is at __fput+0xae/0x152
Nov  3 18:57:42 localhost kernel: eax: f2506000   ebx: f2458d20   ecx:
f7dbfc40   edx: 7665642f
Nov  3 18:57:42 localhost kernel: esi: f1842980   edi: f2458d20   ebp:
f24e5570   esp: f2507f34
Nov  3 18:57:42 localhost kernel: ds: 007b   es: 007b   ss: 0068
Nov  3 18:57:42 localhost kernel: Process xmms (pid: 4805, ti=f2506000
task=f24ada90 task.ti=f2506000)
Nov  3 18:57:42 localhost kernel: Stack: c18e6dc0 f1842980 00000000
f7868200 ef6d8280 c0148a99 f1842980 f7868200
Nov  3 18:57:42 localhost kernel:        f1842980 f7868200 f7868200
00000001 00000030 c011733f f1842980 f7868200
Nov  3 18:57:42 localhost kernel:        00000000 00000000 f7868200
f24ada90 00000001 f2507fac c0118354 00000000
Nov  3 18:57:42 localhost kernel: Call Trace:
Nov  3 18:57:42 localhost kernel:  [<c0148a99>] filp_close+0x50/0x59
Nov  3 18:57:42 localhost kernel:  [<c011733f>] put_files_struct+0x62/0xa2
Nov  3 18:57:42 localhost kernel:  [<c0118354>] do_exit+0x1d0/0x760
Nov  3 18:57:42 localhost kernel:  [<c0118963>] sys_exit_group+0x0/0x11
Nov  3 18:57:42 localhost kernel:  [<c0102be9>] sysenter_past_esp+0x56/0x79
Nov  3 18:57:42 localhost kernel: Code: d0 5b 58 8b 87 f4 00 00 00 85 c0
74 07 50 e8 36 67 00 00 59 8b 46 10 85 c0 74 3c 8b 10 85 d2 74 36 89 e0
25 00 e0 ff ff ff 40 14 <ff> 8a 80 01 00 00 83 3a 02 75 0b 8b 82 08 02
00 00 e8 f2 7f fc
Nov  3 18:57:42 localhost kernel: EIP: [<c014af57>] __fput+0xae/0x152
SS:ESP 0068:f2507f34
Nov  3 18:57:42 localhost kernel:  <1>Fixing recursive fault but reboot
is needed!
Nov  3 18:57:42 localhost kernel: BUG: scheduling while atomic:
xmms/0x00000001/4805
Nov  3 18:57:42 localhost kernel:  [<c027a9c1>] schedule+0x43/0x52b
Nov  3 18:57:42 localhost kernel:  [<c0119fe4>] __do_softirq+0x34/0x75
Nov  3 18:57:42 localhost kernel:  [<c01164d4>] printk+0x14/0x18
Nov  3 18:57:42 localhost kernel:  [<c0118257>] do_exit+0xd3/0x760
Nov  3 18:57:42 localhost kernel:  [<c0103ee2>] die+0x21b/0x223
Nov  3 18:57:42 localhost kernel:  [<c0111559>] do_page_fault+0x3a3/0x469
Nov  3 18:57:42 localhost kernel:  [<c01111b6>] do_page_fault+0x0/0x469
Nov  3 18:57:42 localhost kernel:  [<c01036b1>] error_code+0x39/0x40
Nov  3 18:57:42 localhost kernel:  [<c01a007b>]
blk_unregister_queue+0x38/0x41
Nov  3 18:57:42 localhost kernel:  [<c014af57>] __fput+0xae/0x152
Nov  3 18:57:42 localhost kernel:  [<c0148a99>] filp_close+0x50/0x59
Nov  3 18:57:42 localhost kernel:  [<c011733f>] put_files_struct+0x62/0xa2
Nov  3 18:57:42 localhost kernel:  [<c0118354>] do_exit+0x1d0/0x760
Nov  3 18:57:42 localhost kernel:  [<c0118963>] sys_exit_group+0x0/0x11
Nov  3 18:57:42 localhost kernel:  [<c0102be9>] sysenter_past_esp+0x56/0x79


Regards,

Berthold Cogel

