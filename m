Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTLMAwh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 19:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbTLMAwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 19:52:36 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:49061 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S262758AbTLMAw3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 19:52:29 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Rainer Schoenen <schoenen@schoenen-service.de>
Reply-To: schoenen@schoenen-service.de
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: messed-up symbol names like "mysym_R__ver_mysym"
Date: Sat, 13 Dec 2003 01:52:27 +0100
X-Mailer: KMail [version 1.4]
Organization: Ingenieurbuero Schoenen
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200312130152.27335.schoenen@schoenen-service.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

according to REPORTING-BUGS;
[1.] messed-up symbol names like "bpm_new_device_R__ver_bpm_new_device"
[2.] Full description of the problem/report:
I have a problem with messed-up symbol names like
"bpm_new_device_R__ver_bpm_new_device"
after compiling a hardware device driver module bpm.c
which should export function "bpm_new_device"
to other modules which require it.

This happens with Kernel "2.4.21-99-default",
the default kernel of the newest distribution SuSE 9.0.
I'm not able to use a newer version,
as it runs on a number of reliable router/servers.
I didn't have this problem with all earlier kernel versions.
My coding conforms mostly to "O'Reilly Device Drivers v2".

The only thing I Googled out was "broke modversions" in
http://www.ussg.iu.edu/hypermail/linux/kernel/0206.2/0202.html
but the fix/patch for "Rules.make" didn't match at all.

Does anyone have a fix (for the Makefile, *.c, *.h) or a patch ?
Any help is greatly appreciated.

--Rainer

[3.] Keywords (i.e., modules, networking, kernel):
modules, ksyms, R__ver

[4.] Kernel version (from /proc/version):
Linux version 2.4.21-99-default (root@i386.suse.de) (gcc version 3.3.1 (SuSE Linux)) #1 Wed Sep 24 13:30:51 UTC 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
No Oops.
># insmod bpm.o; ksyms | grep bpm
Address   Symbol                            Defined by
c9762450  bpm_new_device_R__ver_bpm_new_device  [bpm_2.4.21-99-default]
># insmod lcd.o (depends on that symbol)
/usr/beyond/modules/2.4.21-99-default/lcd.o: unresolved symbol bpm_new_device

[6.] A small shell script or example program which triggers the
     problem (if possible)
see [5]
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
> ## sh /usr/src/linux-2.4.21-99/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux router2 2.4.21-99-default #1 Wed Sep 24 13:30:51 UTC 2003 i686 i686 i386 GNU/Linux

Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.25
e2fsprogs              1.34
jfsutils               1.1.2
PPP                    2.4.1
isdn4k-utils           3.3
Linux C Library        x    1 root     root      1470060 Sep 23 18:22 /lib/libc.so.6
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 3.1.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         bpm_2.4.21-99-default videodev snd-pcm-oss snd-mixer-oss isa-pnp nfsd usbserial parport_pc lp parport snd-via82xx snd-pcm snd-timer snd-ac97-codec thermal snd-page-alloc snd-mpu401-uart snd-rawmidi snd-seq-device processor ipv6 snd fan button soundcore key battery ac sd_mod scsi_mod keybdev mousedev joydev evdev input usb-uhci usbcore raw1394 ieee1394 8139too mii reiserfs

[7.2.] Processor information (from /proc/cpuinfo):
> ## cat  /proc/cpuinfo
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 7
model name      : VIA Samuel 2
stepping        : 2
cpu MHz         : 797.903
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
bogomips        : 1568.76

[7.3.] Module information (from /proc/modules):
> ## m /proc/modules
bpm_2.4.21-99-default   40428   0 (unused)
videodev                5696   0 (autoclean)
snd-pcm-oss            45152   1 (autoclean)
snd-mixer-oss          13400   2 (autoclean) [snd-pcm-oss]
isa-pnp                30664   0 (unused)
nfsd                   73904   4 (autoclean)
usbserial              18620   0 (autoclean) (unused)
parport_pc             26248   1 (autoclean)
lp                      6208   0 (autoclean)
parport                22888   1 (autoclean) [parport_pc lp]
snd-via82xx            13504   3
snd-pcm                65124   0 [snd-pcm-oss snd-via82xx]
snd-timer              15040   0 [snd-pcm]
snd-ac97-codec         39512   0 [snd-via82xx]
thermal                 6148   0 (unused)
snd-page-alloc          6004   0 [snd-via82xx snd-pcm]
snd-mpu401-uart         3584   0 [snd-via82xx]
snd-rawmidi            14080   0 [snd-mpu401-uart]
snd-seq-device          4048   0 [snd-rawmidi]
processor               8248   0 [thermal]
ipv6                  209824  -1 (autoclean)
snd                    35172   0 [snd-pcm-oss snd-mixer-oss snd-via82xx snd-pcm snd-timer snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-device]
fan                     1472   0 (unused)
button                  2380   0 (unused)
soundcore               3588   0 [snd]
key                    63256   0 (autoclean) [ipv6]
battery                 5600   0 (unused)
ac                      1664   0 (unused)
sd_mod                 12320   0 (autoclean) (unused)
scsi_mod               97108   1 (autoclean) [sd_mod]
keybdev                 1996   0 (unused)
mousedev                4084   0 (unused)
joydev                  5120   0 (unused)
evdev                   3584   0 (unused)
input                   3360   0 [keybdev mousedev joydev evdev]
usb-uhci               22224   0 (unused)
usbcore                58668   1 [usbserial usb-uhci]
raw1394                16592   0 (unused)
ieee1394              183332   0 [raw1394]
8139too                13932   1
mii                     2320   0 [8139too]
reiserfs              200084   1 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
not relevant
[7.5.] PCI information ('lspci -vvv' as root)
not relevant
[7.6.] SCSI information (from /proc/scsi/scsi)
not relevant
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
This is how it should look like (made with SuSE 8.2, Kernel 2.4.20-4GB):
> ## ksyms | grep bpm
c6902440  bpm_new_device                    [bpm]

[X.] Other notes, patches, fixes, workarounds:
no

