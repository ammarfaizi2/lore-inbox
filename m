Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263537AbRFAOgY>; Fri, 1 Jun 2001 10:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263539AbRFAOgE>; Fri, 1 Jun 2001 10:36:04 -0400
Received: from fe020.world-online.no ([213.142.64.152]:58561 "HELO
	mail.world-online.no") by vger.kernel.org with SMTP
	id <S263537AbRFAOf7>; Fri, 1 Jun 2001 10:35:59 -0400
Subject: Strange bug (?) in 2.4.5
From: Ole =?ISO-8859-1?Q?Andr=E9?= Vadla =?ISO-8859-1?Q?Ravn=E5s?= 
	<zole@jblinux.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution/0.10 (Preview Release)
Date: 01 Jun 2001 16:39:45 -0100
Message-Id: <991417186.1429.0.camel@zole.home.jblinux.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I suspect that I've found a bug in 2.4.5. I use isolinux (1.62) for
CD-booting, and its configuration file is like this:

default linux
display some.msg
label linux
  kernel linux
  append ramdisk_start=0 ramdisk_size=12288 root=/dev/rd/0
load_ramdisk=1 initrd=initrd

The kernel has devfs enabled and is configured to automatically mount
/dev on boot.

This is what happens:
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 3682 k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
VFS: Mounted root (ext2 filesystem).
change_root: old root has d_count=5
Mounted devfs on /dev
Trying to unmount old root ... okay
Freeing unused kernel memory: 96 k freed
Kernel panic: No init found. Try passing init= option to kernel.

Okay, this is strange, because I haven't touched the initrd image since
the last time it worked. :-) So, what I tried next was replacing the
kernel with the 2.4.4 that I had used before (identical kernel
configuration), wrote another CD-R, and voila, it worked (I've even
repeated this twice (2.4.4 and 2.4.5), same result each time). So,
something is definitely wrong.

On the other hand, 2.4.5 works fine when booting from floppies (using
syslinux) and this configuration:
default linux
display some.msg
label linux
  kernel linux
  append ramdisk_start=0 load_ramdisk=1 prompt_ramdisk=1
ramdisk_size=12288 root=/dev/fd/0


Thanks,
Ole André Vadla Ravnås


