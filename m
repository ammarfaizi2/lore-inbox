Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWD2TwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWD2TwX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 15:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWD2TwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 15:52:23 -0400
Received: from bay101-f35.bay101.hotmail.com ([64.4.56.45]:31068 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1750807AbWD2TwW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 15:52:22 -0400
Message-ID: <BAY101-F3554D73ACD8CD3AFCF5D8081B30@phx.gbl>
X-Originating-IP: [131.252.248.66]
X-Originating-Email: [senior_goat@hotmail.com]
From: "Senior Goat" <senior_goat@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: ramfs reports 0 free
Date: Sat, 29 Apr 2006 19:52:16 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 29 Apr 2006 19:52:21.0953 (UTC) FILETIME=[6DFB7310:01C66BC6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

    ramfs erroneously reports 0 bytes free, which confuses some programs.

[2.] Full description of the problem/report:

    The system call on a mounted ramfs, as indicated by df, reports 0 bytes 
total, used, and free.  If ramfs is expected to perform like a filesystem, 
it should not do this.

[3.] Keywords (i.e., modules, networking, kernel):

    ramfs, free space, used space, total space, zero, 0, module, kernel, 
filesystem, ram, statfs, ustat

[4.] Kernel version (from /proc/version):

    Linux version 2.6.16-1-686 (Debian 2.6.16-9) (waldi@debian.org) (gcc 
version 4.0.3 (Debian 4.0.3-1)) #2 Thu Apr 20 20:35:02 UTC 2006

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

  no oops.

[6.] A small shell script or example program which triggers the
     problem (if possible)

  (modprobe ramfs)
  mkdir ramfs
  mount none ramfs -t ramfs
  df ramfs/

[7.] Environment

  not relevant

[7.1.] Software (add the output of the ver_linux script here)

Linux spider 2.6.16-1-486 #2 Tue Apr 25 20:33:31 UTC 2006 i686 GNU/Linux

Gnu C                  4.0.4
Gnu make               3.81
binutils               2.16.91
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39-WIP
reiserfsprogs          line
reiser4progs           line
nfs-utils              1.0.7
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.94
Modules Loaded         ipv6 pcspkr snd_via82xx gameport snd_ac97_codec 
snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi 
snd_seq_device snd soundcore i2c_viapro vt8231 i2c_isa i2c_core parport_pc 
parport shpchp pci_hotplug via_agp agpgart uhci_hcd usbcore e100 via_rhine 
mii via_ircc irda crc_ccitt dm_mod psmouse ide_generic ide_cd cdrom rtc ext3 
jbd ide_disk generic via82cxxx ide_core evdev mousedev

[7.2.] Processor information (from /proc/cpuinfo):

not relevant, but including because it only draws 4W

processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 7
model name      : VIA Samuel 2
stepping        : 3
cpu MHz         : 533.507
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 mtrr pge mmx 3dnow
bogomips        : 1067.94


[7.3.] Module information (from /proc/modules):

not relevant

using compiled in ramfs, not as a module

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

not relevant

[7.5.] PCI information ('lspci -vvv' as root)

not relevant

[7.6.] SCSI information (from /proc/scsi/scsi)

none / not relevant

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):



[X.] Other notes, patches, fixes, workarounds:

   I read that Linus himself wrote this module.  For some reason he decided 
to report 0, but I can't figure why.  Perhaps the overhead for finding 
information was too great.

  Couldn't you add up the amount of filesystem cache with the free memory 
and get a crude, but quick estimate of the amount of free space available 
for any given ramfs.

  I'm not sure how to handle the total space, since you probably don't want 
that fluctuating too much, except that you might just report the total 
amount of ram(which won't fluctuate), and then report the used ram.  This is 
all information that /free/ reports from system calls with little delay.

  The only other place I can think that ramfs might get memory is when the 
kernel swaps out other processes, but you can't count on that.

  To sum it up, the best way to get a semi-valid report would be:
total:  total ram
used: used ram (which takes into account memory used in the ramfs, 
coincidentally)
free:  total - used  (which ignores disk cache, since that should be freed 
when needed)


   The other option would be to make all the little programs (like Debian's 
package manager) check if the filesystem it wants to write to is a ramfs 
before reporting an error, but this is a blatant hack.


