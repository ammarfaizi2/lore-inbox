Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280961AbRKCOsr>; Sat, 3 Nov 2001 09:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280962AbRKCOsg>; Sat, 3 Nov 2001 09:48:36 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:30925 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S280961AbRKCOs2>; Sat, 3 Nov 2001 09:48:28 -0500
Disclaimer: this mail was relayed by an official relay of the linux-society.
From: Andreas Achtzehn <linux-kernel@achtzehn.2y.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13: unresolved symbols with modules_install
Date: Sat, 3 Nov 2001 15:48:18 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01110315481802.06645@paris>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list readers,

I have severe problems compiling a 2.4.13 kernel on a LFS based system. (gcc 
2.95.2, glibc 2.2.4)
For those who have not yet used a LFS system: I have a fully running 
linux-system on a partition. I do the following before compiling the kernel

mount -t proc proc /mnt2/proc
chroot /mnt2 /usr/bin/env -i HOME=/root TERM=$TERM /bin/bash --login

I follow this way to compile a kernel for my system:

tar xvfz linux-2.4.13.tar.gz
cd linux
cp ../config.aktuell ./.config # this is a config I created before
make menuconfig # no changes, just exit (otherwise no autoconfig.h)
make dep 
make clean
make bzImage # works quite well up to here
cp System.map /boot
make modules
make modules_install 

The modules_install ends with 

mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.13; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.4.13/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode
achtzehn:/usr/src/linux#       

Is it possible that this is due to the proc-system and its unusual mounting?

Regards,
Andreas Achtzehn
