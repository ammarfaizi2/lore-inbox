Return-Path: <linux-kernel-owner+w=401wt.eu-S1762947AbWLKRGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762947AbWLKRGk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 12:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762949AbWLKRGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 12:06:39 -0500
Received: from wp004.webpack.hosteurope.de ([80.237.132.11]:41289 "EHLO
	wp004.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762947AbWLKRGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 12:06:39 -0500
Date: Mon, 11 Dec 2006 17:35:06 +0100
From: Joscha Ihl <joscha@grundfarm.de>
To: linux-kernel@vger.kernel.org
Cc: ihl@fh-brandenburg.de
Subject: Nokia E61 and the kernel BUG at mm/slab.c:594
Message-ID: <20061211173506.5c8cb479@localhost>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using the Nokia E61 phone on my Fujitsu Siemens Amilo D Celeron
2.8GHz Notebook as an USB-Modem (cdc_acm 2-1:1.10: ttyACM0: USB ACM
device) to connect over UMTS to the internet.

If I plug the USB-cable in the Notebook the system will freeze or I
only get the following message: [  158.496128] ------------[ cut
here ]------------ [  158.496136] kernel BUG at mm/slab.c:594!
[  158.496138] invalid opcode: 0000 [#1]
[  158.496139] SMP 
[  158.496142] Modules linked in: rndis_host cdc_ether usbnet cdc_acm
mii binfmt_misc ipv6 radeon drm speedstep_lib cpufreq_userspace
cpufreq_stats cpufreq_powersave cpufreq_ondemand freq_table
cpufreq_conservative video sbs thermal i2c_ec i2c_core processor fan
button battery container ac asus_acpi af_packet sbp2 lp joydev tsdev
pcmcia sr_mod psmouse ohci1394 natsemi serio_raw yenta_socket
rsrc_nonstatic pcmcia_core parport_pc snd_intel8x0 evdev snd_ac97_codec
snd_ac97_bus parport snd_pcm_oss snd_mixer_oss pcspkr shpchp
pci_hotplug snd_pcm snd_timer snd soundcore ide_cd snd_page_alloc
intel_agp agpgart ehci_hcd uhci_hcd cdrom usbcore [  158.496192]
CPU:    0 [  158.496192] EIP:    0060:[<c016e069>]    Not tainted VLI
[  158.496194] EFLAGS: 00010006   (2.6.19.061201 #1) [  158.496202] EIP
is at kfree+0x79/0x90 [  158.496206] eax: 40000060   ebx: ffffffe0
ecx: d36ed000   edx: c126dcc0 [  158.496209] esi: d36e6d8d   edi:
00000286   ebp: d36ed400   esp: d2867d98 [  158.496211] ds: 007b   es:
007b   ss: 0068 [  158.496215] Process modprobe (pid: 3827, ti=d2866000
task=d2833560 task.ti=d2866000) [  158.496216] Stack: ffffffe0 e0b4be60
d36ed006 e0b4b25c c1584c80 dfeaca90 dfeaca90 c156bb54
[  158.496223]        c036e449 d2867e40 00000086 00000286 c012ce00
d3ea3adc ffffffff 00000286 [  158.496229]        dbd41e00 e0b51800
d36ed000 d2dc5d08 d3ea3800 d3ea3800 e085ce7c d3ea3800 [  158.496235]
Call Trace: [  158.496246]  [<e0b4b25c>] usbnet_probe+0x2cc/0x5e0
[usbnet] [  158.496261]  [<c036e449>] schedule+0x3f9/0xb60
[  158.496271]  [<c012ce00>] lock_timer_base+0x20/0x50 [  158.496291]
[<e085ce7c>] usb_resume_both+0x6c/0xe0 [usbcore] [  158.496322]
[<e085cf8a>] usb_autoresume_device+0x4a/0x60 [usbcore] [  158.496347]
[<e085da0b>] usb_probe_interface+0x9b/0xe0 [usbcore] [  158.496371]
[<c02a458b>] really_probe+0x3b/0x110 [  158.496377]  [<c02a46a9>]
driver_probe_device+0x49/0xc0 [  158.496391]  [<c02a484e>]
__driver_attach+0x9e/0xa0 [  158.496400]  [<c02a3b1a>]
bus_for_each_dev+0x3a/0x60 [  158.496415]  [<c02a4496>]
driver_attach+0x16/0x20 [  158.496418]  [<c02a47b0>]
__driver_attach+0x0/0xa0 [  158.496421]  [<c02a3eab>]
bus_add_driver+0x7b/0x1a0 [  158.496436]  [<e085d4c3>]
usb_register_driver+0x83/0x100 [usbcore] [  158.496465]  [<c01412fb>]
sys_init_module+0x15b/0x1be0 [  158.496538]  [<c0103151>]
sysenter_past_esp+0x56/0x79 [  158.496554]  [<c037007b>]
rt_mutex_lock+0x2b/0x40

I also tested this with the kernel 2.6.19 without SMP -> the same
effect, only the message was different:

[  109.237821] BUG: unable to handle kernel NULL pointer dereference at
virtual address 0000002a [  109.237925]  printing eip:
[  109.237970] c0113a12
[  109.237971] *pde = 00000000
[  109.238019] Oops: 0002 [#1]
[  109.238065] Modules linked in: ip_conntrack nfnetlink rndis_host
cdc_ether usbnet cdc_acm mii binfmt_misc ipv6 radeon drm speedstep_lib
cpufreq_userspace cpufreq_stats cpufreq_powersave cpufreq_ondemand
freq_table cpufreq_conservative video sbs thermal i2c_ec i2c_core
processor fan button battery container ac asus_acpi af_packet sbp2 lp
joydev tsdev pcmcia sr_mod snd_intel8x0 snd_ac97_codec snd_ac97_bus
yenta_socket rsrc_nonstatic pcmcia_core snd_pcm_oss snd_mixer_oss
natsemi ohci1394 psmouse parport_pc ide_cd snd_pcm snd_timer evdev
serio_raw parport uhci_hcd pcspkr cdrom intel_agp agpgart ehci_hcd
shpchp pci_hotplug usbcore snd soundcore snd_page_alloc [  109.240533]
CPU:    0 [  109.240533] EIP:    0060:[<c0113a12>]    Not tainted VLI
[  109.240535] EFLAGS: 00010202   (2.6.19.061208 #1) [  109.240680] EIP
is at dup_fd+0x182/0x2e0 [  109.240728] eax: 00000100   ebx: 00000002
ecx: d3728408   edx: 00000016 [  109.240779] esi: db0e3660   edi:
cf80b2e0   ebp: d67ca80c   esp: d2613ed8 [  109.240830] ds: 007b   es:
007b   ss: 0068 [  109.240878] Process bash (pid: 3876, ti=d2612000
task=d1df6030 task.ti=d2612000) [  109.240929] Stack: 00000016 00000100
c15919c0 d3728400 db7f5a80 d09e4b80 000000e0 d11b7a70
[  109.241290]        00000000 d1df6030 d11b7a70 c0113bb2 00000001
01200011 c01142d9 0fddb065 [  109.241652]        cfdd44a8 cf861080
000004a8 c014a849 d11b7b2c d2613fbc bf84e520 00000000 [  109.242014]
Call Trace: [  109.242123]  [<c0113bb2>] copy_files+0x42/0x60
[  109.242215]  [<c01142d9>] copy_process+0x4f9/0x10e0 [  109.242311]
[<c014a849>] __handle_mm_fault+0x669/0x890 [  109.242412]  [<c0125056>]
alloc_pid+0x16/0x240 [  109.242518]  [<c011512d>] do_fork+0x7d/0x1f0
[  109.242614]  [<c015b85d>] sys_llseek+0x8d/0xb0 [  109.242704]
[<c0101212>] sys_clone+0x32/0x40 [  109.242791]  [<c0102e9d>]
sysenter_past_esp+0x56/0x79 [  109.242886]  [<c034007b>]
vcc_getsockopt+0x7b/0x180

A side-effect of this is that I can't shut down the system. It only
works if I let the USB-Cable connected to the pc. If you need more
informations about the problem please ask me.

Thanks

Joscha Ihl
