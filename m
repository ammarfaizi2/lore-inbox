Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318100AbSHDF1x>; Sun, 4 Aug 2002 01:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318101AbSHDF1x>; Sun, 4 Aug 2002 01:27:53 -0400
Received: from mailhost1-sfldmi.sfldmi.ameritech.net ([206.141.193.105]:25992
	"EHLO mailhost.det2.ameritech.net") by vger.kernel.org with ESMTP
	id <S318100AbSHDF1w>; Sun, 4 Aug 2002 01:27:52 -0400
Date: Sun, 4 Aug 2002 01:31:25 -0400 (EDT)
From: Vladimir Dergachev <volodya@mindspring.com>
X-X-Sender: volodya@node2.localnet.net
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
To: linux-kernel@vger.kernel.org
Subject: reboot at the end of fsck (2.4.19)
Message-ID: <Pine.LNX.4.44.0208040118150.24641-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a strange problem.. Hopefully someone will offer a solution.

In a nutshell my computer reboots, at random moments. I think I have
traced this to hard disk activity, in particular:

In single user mode (nothing is running and only root mounted), when I do
fsck it always reboots after Step 5. This happens on one partition only,
ext3, which is on 18gig scsi disk. The reboot happens right after the disk
does "zzzzzz" it always does in the end of fsck on large partition. (the
partition in question is 17gig)

Help is appreciated. (and more details follow).

                   thanks !

                       Vladimir Dergachev
PS ---------------------- Details -----------------------

Kernel: 2.4.19, with alsa drivers.

Partition: ext3, there were a number of reboots without fsck
(it's a development box), on /dev/sda3
------------------- cat /proc/interupts ----------------------
          CPU0
  0:      31275          XT-PIC  timer
  1:          6          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       1887          XT-PIC  usb-uhci, usb-uhci
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:       2174          XT-PIC  eth0
 11:      12883          XT-PIC  sym53c8xx, CS46XX, ehci-hcd
 12:          0          XT-PIC  usb-uhci, PS/2 Mouse
 14:        338          XT-PIC  ide0
 15:          1          XT-PIC  ide1
NMI:          0
LOC:      31231
ERR:          0
MIS:          0

Note: same happens when IO-APIC is turned off.

--------------------- cat /proc/modules -----------------------
serial                 41952   0 (autoclean)
usbkbd                  2880   0 (autoclean) (unused)
usbmouse                1792   0 (autoclean) (unused)
nfs                    70684   1 (autoclean)
keybdev                 1664   0 (unused)
mousedev                3808   1
input                   3136   0 [usbkbd usbmouse keybdev mousedev]
ehci-hcd               20064   0 (unused)
uhci                   24744   0 (unused)
usbcore                60512   1 [usbkbd usbmouse ehci-hcd uhci]
snd-pcm-oss            35268   0 (unused)
snd-mixer-oss           8864   0 [snd-pcm-oss]
snd-cs46xx             69316   0
gameport                1308   0 [snd-cs46xx]
snd-pcm                46592   0 [snd-pcm-oss snd-cs46xx]
snd-timer               9952   0 [snd-pcm]
snd-rawmidi            11712   0 [snd-cs46xx]
snd-seq-device          3728   0 [snd-rawmidi]
snd-ac97-codec         23172   0 [snd-cs46xx]
snd                    23880   0 [snd-pcm-oss snd-mixer-oss snd-cs46xx
snd-pcm snd-timer snd-rawmidi snd-seq-device snd-ac97-codec]
soundcore               3332   5 [snd]
nfsd                   65408   1 (autoclean)
lockd                  46688   1 (autoclean) [nfs nfsd]
sunrpc                 56660   1 (autoclean) [nfs nfsd lockd]
tulip                  37504   1
vfat                    9212   1 (autoclean)
fat                    28856   0 (autoclean) [vfat]
---------------------------------------------------------------
Anything else ? - just ask

