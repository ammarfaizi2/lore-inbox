Return-Path: <linux-kernel-owner+w=401wt.eu-S932162AbWLNJuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWLNJuA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 04:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWLNJuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 04:50:00 -0500
Received: from ultra1.univ-paris12.fr ([193.51.100.100]:55756 "EHLO
	ultra1.univ-paris12.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162AbWLNJt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 04:49:58 -0500
X-Greylist: delayed 1415 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 04:49:58 EST
Message-ID: <458118BB.5050308@univ-paris12.fr>
Date: Thu, 14 Dec 2006 10:26:19 +0100
From: Franck Pommereau <pommereau@univ-paris12.fr>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Executability of the stack
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux developers,

I recently discovered that the Linux kernel on 32 bits x86 processors
reports the stack as being non-executable while it is actually
executable (because located in the same memory segment).

# grep maps /proc/self/maps
bfce8000-bfcfe000 rw-p bfce8000 00:00 0          [stack]

I think there is here a serious security concern has one could consider
to be protected against the execution of code injected on the stack (or
heap) while this is not the case.

Is there any reason for this situation? Is it possible to correct it?
Maybe it comes from sharing source code for 64 bits and 32 bits
architectures but if so, it should be possible (and highly desirable) to
treat 32 bits differently.

Best regards,
Franck Pommereau

-----------------------------------------------------------------------
Below is the output from the ver_linux script:
-----------------------------------------------------------------------
Linux pixie 2.6.17-10-386 #2 Tue Dec 5 22:26:18 UTC 2006 i686 GNU/Linux

Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
jfsutils               1.1.8
reiserfsprogs          3.6.19
reiser4progs           1.0.5
xfsprogs               2.8.10
pcmcia-cs              3.2.8
PPP                    2.4.4
Linux C Library        > libc.2.4
Dynamic linker (ldd)   2.4
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.96
udev                   093
Modules Loaded         vmnet vmmon binfmt_misc rfcomm hidp l2cap ipv6
usbhid speedstep_centrino cpufreq_userspace cpufreq_stats freq_table
cpufreq_powersave cpufreq_ondemand cpufreq_conservative video tc1100_wmi
sbs sony_acpi pcc_acpi i2c_ec hotkey dock dev_acpi button battery
container ac asus_acpi deflate zlib_deflate twofish serpent aes blowfish
des sha256 sha1 crypto_null af_key af_packet dm_mod md_mod visor
usbserial parport_pc lp parport pcmcia sr_mod cdrom yenta_socket joydev
rsrc_nonstatic pcmcia_core nvidia snd_hda_intel snd_hda_codec tsdev
hci_usb sg snd_pcm_oss snd_mixer_oss bluetooth snd_pcm snd_timer evdev
tg3 serio_raw i2c_core intel_agp pcspkr psmouse snd soundcore
snd_page_alloc agpgart rtc shpchp pci_hotplug xt_tcpudp xt_state
iptable_filter ipt_MASQUERADE iptable_nat ip_nat ip_conntrack nfnetlink
ip_tables x_tables ext3 jbd ehci_hcd uhci_hcd usbcore ide_generic sd_mod
generic ata_piix libata scsi_mod thermal processor fan capability
commoncap vesafb fbcon tileblit font bitblit softcursor
-----------------------------------------------------------------------
