Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290095AbSAKU3C>; Fri, 11 Jan 2002 15:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290097AbSAKU2y>; Fri, 11 Jan 2002 15:28:54 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3200 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290095AbSAKU2k>; Fri, 11 Jan 2002 15:28:40 -0500
Date: Fri, 11 Jan 2002 15:28:44 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Unable to boot 2.4.17 via initrd
Message-ID: <Pine.LNX.3.95.1020111152032.811A-101000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-734312198-1010780924=:811"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-734312198-1010780924=:811
Content-Type: TEXT/PLAIN; charset=US-ASCII



I have tried for several days to boot 2.4.17 (The last "stable"
kernel) off initrd.

/linuxrc never executes, therefore I am not able to load modules
to start SCSI disks, etc.

I have appended /linux-2.4.17/.config for review. The required SCSI
modules are made and the kernel has, or was configured to have,
initrd support.

This is the tail-end of my existing 'make_initrd' boot script.
I have snipped off all the stuff necessary to make the ram-disk,
etc. This works and has been working before pivot-root changes
were made in the kernel.

#
lilo -C - <<EOF
#
#  Lilo boot-configuration script.
#
boot = /dev/sda
message = /boot/message
compact
delay = 15	# optional, for systems that boot very quickly
vga = normal	# force sane state

image = /boot/vmlinuz-${VER}
  initrd = /boot/initrd-${VER}
  root  = current
  label = new 
  append = "nmi_watchdog=0"

image = /vmlinuz
 root = current
 label = linux

image = /boot/vmlinuz-${VER}
  initrd = /boot/initrd-${VER}
  root  = /dev/sdc3 
  label = maint 

image = /boot/vmlinuz-${VER}
  initrd = /boot/initrd-${VER}
  root  = /dev/sdc1 
  label = maint-su
  append="init=/bin/bash" 

image = /vmlinuz.old
  root = current
  label = linux_old

other = /dev/sda1
  table = /dev/sda
  label = dos
EOF


>From the documentation in linux-2.4.17/Documentation/initrd.txt, I
have deduced that all I have to do is add/change "append="
New stuff..... 


#
lilo -C - <<EOF
#
#  Lilo boot-configuration script.
#
boot = /dev/sda
message = /boot/message
compact
delay = 15	# optional, for systems that boot very quickly
vga = normal	# force sane state

image = /boot/vmlinuz-${VER}
  initrd = /boot/initrd-${VER}
  root  = current
  label = new 
  append = "root=/dev/ram0 init=/linuxrc rw"


[REST SNIPPED]

EOF


The boot messages show:
RAMDISK driver initialized: (with some numbers)

However, I never see the usual,
"RAMDISK: Compressed image found at block 0"

-- nor do I see anything that would have been executed from /linuxrc


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


--1678434306-734312198-1010780924=:811
Content-Type: APPLICATION/octet-stream; name="config.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.95.1020111152844.811B@chaos.analogic.com>
Content-Description: 

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

--1678434306-734312198-1010780924=:811--
