Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262055AbTCLWnl>; Wed, 12 Mar 2003 17:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262080AbTCLWnl>; Wed, 12 Mar 2003 17:43:41 -0500
Received: from ms-smtp-01.southeast.rr.com ([24.93.67.82]:46231 "EHLO
	ms-smtp-01.southeast.rr.com") by vger.kernel.org with ESMTP
	id <S262055AbTCLWnj>; Wed, 12 Mar 2003 17:43:39 -0500
Message-ID: <002801c2e8ea$46aadfb0$6401a8c0@jeremy>
From: "Jeremy Booker" <JerMe@nc.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: initrd / pivot_root + boot problems
Date: Wed, 12 Mar 2003 17:54:02 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While looking for support on the egigma-list@redhat.com list, someone
recommended that I ask here.

Here's the deal...

After forgetting my root password and trying to boot into single user mode
under Red Hat 7.2 Pro (boxed retail set) I have run into a kernel panic. In
grub I edited the boot commands to include "kernel /boot/.... single".
Immediately after doing this the system failed to boot with the error
message "kernel panic: no init found. Try passing init= to kernel".
(Previously the machine had run just fine and had been up for over 150
days). After the first failure I tried adding any combination of "single",
"-single", "s", and "-s" I could think of, and changed their position in the
command (first/last parameter, appended "single" to other commands including
initrd line). Nothing could get me into single user mode, I never got past
the kernel panic. I also tried passing init= as a kernel argument with the
path listed on the "initrd" command. I eventually booted to rescue mode from
a RH 7.2 install disk and got my password changed. However, I am still
unable to boot from the hard drives. (In a software RAID 1 config)

My grub.conf file contains the following:
root (hd0,0)
kernel /boot/vmlinuz-2.4.7-10 ro root=/dev/sda1
initrd /boot/initrd-2.4.7-10.img

( I set the file back to exactly how it looked when I started, any changes I
made were always lost after having to reboot)

Also of interest is an error that occurred just before the kernel panic. It
read "pivotroot: pivot_root(/sysroot, /sysroot/initd) failed:2". Does anyone
know what the "2" error code indicates? I cannot find this anywhere in any
documentation of pivot_root. It seems to be a rather obscure function in the
first place. Maybe if someone could shed some light on this?

The machine in question is a single CPU (Intel PIII 800mhz) with 2 SCSI
drives in RAID 1 (mirroring). I'm guessing from the 'kernel' line that my
kernel version is "vmlinuz-2.4.7-10". It is the one that came with RH 7.2
Pro retail box. I haven't upgraded or modified anything.

I'm not entirely sure of my file system layout. (I'm a relative newbie,
unsure about devices and file systems still) I'm using RAID 1 on two SCSI
drives. It was setup by the installer during the install process and I
assume it uses all the defaults. I don't know the layout of fstab. The
machine is remote (co-located in a data center), and I have no way of
copying/pasting or saving that information from the server.

I also took a look in /var/log/boot and all the recent files were blank.
Nothing ever got written to them.

>From research I have done online, I have found other posts mentioning this
exact problem. However, none of them have any solutions. It was suggested
that this may be due to file system corruption. I doubt this is the case as
I can mount my software RAID 1 drives from rescue mode and read/write all
the files just fine. Everything seems to be intact. I have not run fsck but
I will do that ASAP.

I have gotten my hands on the latest RH 8.0 ISOs. Could upgrading from 7.2
to 8.0 cure my woes? Would this just preserve the hardware/device
misconfiguration?

My problem looks to described in more detail in this post:
https://listman.redhat.com/pipermail/valhalla-list/2003-January/thread.html#
23350
and here: http://lists.ethernal.org/cantlug-0208/msg00472.html
and here:
http://archive.linuxfromscratch.org/mail-archives/lfs-support/2003/02/0018.h
tml
and here: http://www.gollatz.net/troubleshooting

Any help or ideas would be greatly appreciated.

Regards,
        Jeremy

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeremy Booker - Owner / Webmaster
JTech Web Systems
www.JTechWebSystems.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"Therefore do not worry about tomorrow, for tomorrow will worry about
itself. Each day has enough trouble of its own." -Mathew 5:34

