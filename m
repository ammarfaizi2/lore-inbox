Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130816AbQLMRiz>; Wed, 13 Dec 2000 12:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130781AbQLMRio>; Wed, 13 Dec 2000 12:38:44 -0500
Received: from whiterose.net ([199.245.105.145]:39446 "EHLO whiterose.net")
	by vger.kernel.org with ESMTP id <S130558AbQLMRif>;
	Wed, 13 Dec 2000 12:38:35 -0500
Date: Wed, 13 Dec 2000 12:08:15 -0500 (EST)
From: M Sweger <mikesw@whiterose.net>
To: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: linux 2.2.18  inconsistencies/problems (minor)
Message-ID: <Pine.LNX.4.21.0012131159540.23922-100000@whiterose.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all/alan,

	I've got linux 2.2.18 (the latest) compiled and running on a
Dell 333mhz optiplex GX1. It was compiled using egcs v1.1.2 with
libc6 v2.0.7. Now that USB support is being added, I'm trying to get
it working on this UMSDOS kernel version. 

	Here is a list of the problems I'm encountering/seen so
far with this kernel version. ITEMS A-D.



A). Problem with the "%d" in usb-serial. Note: I don't have
    any devices connected to any USB port, but the controllers
    are detected and powered on based on syslog. My kernel is compiled
    without the USB disconnect plug-n-play option set - meaning I can't
    remove USB devices on the fly.

   Here is my /dev/usb/tts    subdirectory stuff for my two USB ports
                              based on the /proc/tty/drivers listing
              		      below which I setup based on the dir path
			      listed.

crw-r--r--   1 root     root     188,   1 Oct 12 21:22 1
crw-r--r--   1 root     root     188,   0 Oct 12 21:22 0

   However /usr/src/linux/Documentation/devices.txt states that
   the usb ports for device 188 is /dev/ttyUSB0 and /dev/ttyUSB1

   Here is my /dev/ttyUSB0 and 1 listing which I also setup too!

crw-r--r--   1 root     root     188,   3 Oct 12 21:14 ttyUSB3
crw-r--r--   1 root     root     188,   2 Oct 12 21:14 ttyUSB2
crw-r--r--   1 root     root     188,   1 Oct 12 21:14 ttyUSB1
crw-r--r--   1 root     root     188,   0 Oct 12 21:13 ttyUSB0


   Here is my /proc listing of the "tty" sub-directory showing
   that the kernel thinks a /dev/usb/tts directoy should exist.
   
   In addition, if the subdirectory "tts" is valid, then I'd
   expect a /proc/tts/drivers file then.

   As a side note, why is my console stuff below listed as "unkown"?

cat /proc/tty/drivers

usb-serial           /dev/usb/tts/%d 188   0-254 serial
pty_slave            /dev/pts      136   0-255 pty:slave
pty_master           /dev/ptm      128   0-255 pty:master
pty_slave            /dev/ttyp       3   0-255 pty:slave
pty_master           /dev/pty        2   0-255 pty:master
serial               /dev/cua        5   64-67 serial:callout
serial               /dev/ttyS       4   64-67 serial
/dev/tty0            /dev/tty0       4       0 system:vtmaster
/dev/ptmx            /dev/ptmx       5       2 system
/dev/console         /dev/console    5       1 system:console
/dev/tty             /dev/tty        5       0 system:/dev/tty
unknown              /dev/tty        4    1-63 console


	Here is my "lsmod" listing.

Module                  Size  Used by
usb-storage            22040   0  (unused)
usbserial              17512   0  (unused)
usb-uhci               19996   0  (unused)
usbcore                48072   0  [usb-storage usbserial usb-uhci]
loop                    7648   0  (unused)
dummy                    720   0  (unused)
3c59x                  20808   1 
opl3                   11208   0  (unused)
cs4232                  2408   0  (unused)
uart401                 6032   0  [cs4232]
ad1848                 16144   0  [cs4232]
sound                  58988   0  [opl3 cs4232 uart401 ad1848]
soundcore               2756   5  [sound]
ppp_deflate            40652   0  (unused)
bsd_comp                3656   0  (unused)
ppp                    20748   0  [ppp_deflate bsd_comp]
slip                    7316   0  (unused)
slhc                    4352   0  [ppp slip]
parport_pc              7284   0 
parport                 7648   0  [parport_pc]


B). Need to update the devices.txt document in the Documentation
    sub-directory. I checked the maintainers site and it is the same
    one as delivered with this kernel version. However, it is out-of-date
    since there are quite a few devices missing, i.e. cpuid  major #
    203  and others.  I've emailed the author of the document around 
    October 2000, but haven't seen this document updated for the
    linux v2.2.x kernels. I assume the v2.4 devices.txt document is
    the same. If so, then the document would need to clarify what
    what devices are valid for each kernel (2.0, 2.2, 2.4)
    so that devices that don't exist in these older kernel versions
    aren't created. 

    Moreover, the same applies to device name changes, or if they are
    put in a different subdir location.


 C).  Problem cat'g the proc pci bus files.

cat /proc/bus/pci/00/00.0

Get non-printable characters

The same occurs for any file in this sub-directory or in sub-dir "01".



D).  Problem not being able to poweroff on the Dell Workstation.
      I've tried "shutdown", "halt -p" and even "poweroff" and I'll
      get the message "powering off", but nothing happens. I must then
      manually turn off the PC. This last worked in linux 2.2.16.
      Shortly after this, changes were made to the poweroff logic to
      handle powering off with SMP support and since then it has not
      worked.

      Things I've tried.

       a). Compile in SMP although I have a single processor system.
       b). Don't compile in SMP support.
       c). Compile in PCI BIOS or the "Any" kernel config option.

       Other things that are setup or may be special about Dell's.


       a). In this machines BIOS the ACPI power option is enabled.
           When enabled, and I manually hit the power switch, it's
           supposed to go in standby and when the power switch is
           hit again, it powers off. Perhaps the "halt -p" must
           do a two step process instead of one? Perhaps poweroff
	    must send two commands instead of just one similar to
	   this two step process.

	   When the ACPI option is disabled, then hitting the 
           power switch will turn the PC off without going into 
           standby.
	
	b). The BIOS option to power-on the PC via the LAN is disabled
            in the PC setup screens.




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
