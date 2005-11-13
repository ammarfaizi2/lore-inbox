Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbVKMSOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVKMSOK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 13:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbVKMSOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 13:14:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:51099 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751040AbVKMSOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 13:14:09 -0500
X-Authenticated: #20559227
Date: Sun, 13 Nov 2005 19:14:01 +0100
From: Wolfgang Pfeiffer <roto@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: debian-powerpc@lists.debian.org
Subject: [PPC] 2.6.14.1: Loading FireWire disk fails. Fix: "modprobe ieee1394 disable_irm=1"
Message-ID: <20051113181401.GA3038@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spoken-Languages: en, de
X-URL: http://www.wolfgangpfeiffer.com
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[The following 'ver_linux' output slightly reformatted for better readability:]
---------------------------------------------------------------
$ sh /home/[deleted]/linux-2.6.14/linux-2.6.11/scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux debby 2.6.14.1-not.orinoco.patched #1 Thu Nov 10 23:10:31 CET 2005 ppc GNU/Linux
 
Gnu C                  4.0.3
Gnu make               3.80
binutils               2.16.91
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre9
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          line
reiser4progs           line
quota-tools            3.13.
nfs-utils              1.0.7
Linux C Library        2.3.5
Dynamic linker (ldd)88   2.3.5
Procps                 3.2.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   073

Modules Loaded sbp2 eth1394 ohci1394 ieee1394 sd_mod radeon drm rfcomm
l2cap bluetooth ipt_state ip_conntrack iptable_filter ip_tables ipv6
apm_emu snd_powermac snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd
soundcore snd_page_alloc sg scsi_mod pcmcia firmware_class usbhid
ide_cd joydev cdrom evdev yenta_socket rsrc_nonstatic pcmcia_core
sungem sungem_phy uninorth_agp ohci_hcd usbcore agpgart
------------------------------------------------------------


---------------------------------------
$ cat /proc/cpuinfo 
processor       : 0
cpu             : 7455, altivec supported
clock           : 867MHz
revision        : 0.2 (pvr 8001 0302)
bogomips        : 865.18
machine         : PowerBook3,5
motherboard     : PowerBook3,5 MacRISC2 MacRISC Power Macintosh
detected as     : 80 (PowerBook Titanium IV)
pmac flags      : 0000001b
L2 cache        : 256K unified
memory          : 768MB
pmac-generation : NewWorld
---------------------------------------


Without the mentioned workaround: Firewire dead-ends on 2.6.14.1.

Works as expected on 2.6.12 without extra params for "modprobe ieee1394"


Here's how loading the FW disk fails on 2.6.14.1 without the
"disable_irm=1" parameter, IIRC: 


Nov 13 14:39:13 debby kernel: klogd 1.4.1#17, log source = /proc/kmsg started.
Nov 13 14:39:13 debby kernel: Inspecting /boot/System.map-2.6.14.1-not.orinoco.patched
Nov 13 14:39:13 debby kernel: Loaded 18013 symbols from /boot/System.map-2.6.14.1-not.orinoco.patched.
Nov 13 14:39:13 debby kernel: Symbols match kernel version 2.6.14.
Nov 13 14:39:13 debby kernel: No module symbols loaded - kernel modules not enabled. 
Nov 13 14:39:13 debby kernel: [    0.000000] Total memory = 768MB; using 2048kB for hash table (at c0400000)
Nov 13 14:39:13 debby kernel: [    0.000000] Linux version 2.6.14.1-not.orinoco.patched (root@debby) (gcc version 4.0.3 20051023 (prerelease) (Debian 4.0.2-3)) #1 Thu Nov 10 23:10:31 CET 2005

 [ ...... ]

..
Nov 13 14:39:13 debby kernel: [   38.741714] ieee1394: Error parsing configrom for node 0-00:1023
Nov 13 14:39:13 debby kernel: [   38.757533] ieee1394: Host added: ID:BUS[0-02:1023]  GUID[000393fffecde4c4]
Nov 13 14:39:13 debby kernel: [   39.043579] eth1394: $Rev: 1312 $ Ben Collins <bcollins@debian.org>
Nov 13 14:39:13 debby kernel: [   39.054433] eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Nov 13 14:39:13 debby kernel: [   40.856051] Adding 1535992k swap on /dev/hda3.  Priority:-1 extents:1 across:1535992k
Nov 13 14:39:13 debby kernel: [   41.085923] EXT3 FS on hda4, internal journal
Nov 13 14:39:13 debby kernel: [   42.033003] SCSI subsystem initialized
Nov 13 14:39:13 debby kernel: [   43.485550] apm_emu: APM Emulation 0.5 initialized.



or when plugging in (I think it was in, not out ... not being sure tho')
the firewire disk;

Nov 13 15:00:44 debby kernel: [ 1348.826766] ieee1394: Error parsing configrom for node 0-00:1023
Nov 13 15:00:44 debby kernel: [ 1348.827140] ieee1394: Node changed: 0-00:1023 -> 0-02:1023



The fix:

# lsmod | grep 1394
raw1394                29368  0 
eth1394                20552  0 
ohci1394               38580  0 
ieee1394              423984  3 raw1394,eth1394,ohci1394
# rmmod ohci1394
# rmmod eth1394
# rmmod raw1394
# rmmod ieee1394


# modprobe ieee1394 disable_irm=1 
# lsmod | grep 1394
ieee1394              423984  0 
# modprobe ohci1394               
# lsmod | grep 1394
eth1394                20760  1 
ohci1394               38580  0 
ieee1394              423984  3 eth1394,sbp2,ohci1394


To make this workaround permanent I put this line

--------------------------
options ieee1394 disable_irm=1

--------------------------
to /etc/modprobe.d/local and /etc/modutils/local

Seems to work, so far ... :)

So what's going on there? Is this a bug or am I too dumb to load the
new 1394 drivers correctly? This issue being ppc specific?

Please feel free to ask if you need more details.

Thanks in anticipation

Best Regards

Wolfgang

PS 0: Nearly forgot it: I lifted the workaround from
<http://lkml.org/lkml/2005/6/28/83>


PS 1: I don't believe it relevant, but anyway: if my lousy memory
serves me better than usually I patched 2.6.14 with
<http://lists.debian.org/debian-powerpc/2005/11/msg00215.html>

More on
<http://lists.debian.org/debian-powerpc/2005/11/msg00351.html>

-- 
Wolfgang Pfeiffer
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
Key fingerprint = A8CA 9D8C 54C4 4CC1 0B26  AA3C 9108 FB42 E303 7113
