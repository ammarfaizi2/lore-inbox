Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132300AbRAFQwO>; Sat, 6 Jan 2001 11:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131973AbRAFQwD>; Sat, 6 Jan 2001 11:52:03 -0500
Received: from [156.46.206.66] ([156.46.206.66]:41991 "EHLO eagle.netwrx1.com")
	by vger.kernel.org with ESMTP id <S131597AbRAFQvy>;
	Sat, 6 Jan 2001 11:51:54 -0500
From: "George R. Kasica" <georgek@netwrx1.com>
To: linux-kernel@vger.kernel.org
Cc: Keith Owens <kaos@ocs.com.au>
Subject: Re: 2.4.0 Module compile error 
Date: Sat, 06 Jan 2001 10:51:53 -0600
Organization: Netwrx Consulting Inc.
Reply-To: georgek@netwrx1.com
Message-ID: <f8je5tcv8fudipcjcfib41lacger7it6dv@4ax.com>
In-Reply-To: <ek0c5t404dfib22jc6je0dldkj57e07k7d@4ax.com> <17981.978766533@ocs3.ocs-net>
In-Reply-To: <17981.978766533@ocs3.ocs-net>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>You have a broken modules.conf that tells depmod to scan _all_ of
>/lib/modules or you have an old version of modules or you have some
>weird symlinks in /lib/modules.  It looks like you have some dangling
>symlinks, although I cannot be certain about that.

Keith:

Here it is....what do I need to fix on it:

>[root@eagle 2.4.0]# cd /etc
>[root@eagle /etc]# more modules.conf
>keep
>
>path[usb]=/lib/modules/`uname -r`/`uname -v`
>path[usb]=/lib/modules/`uname -r`
>path[usb]=/lib/modules/
>path[usb]=/lib/modules/default
>
>alias usb-0000.0000.01.00.00  audio.o
>alias usb-0000.0000.03.01.00  mouse.o
>
>alias parport_lowlevel  parport_pc
>alias char-major-107    3dfx
>alias char-major-89     i2c-dev
>
># consider disabling this if you have less than 32MB of memory
>options sound dmabuf=1

/lib/modules looks like:

>[root@eagle /etc]# ls -la /lib/modules
>total 4
>drwxr-xr-x   3 root     root         1024 Jan  6 10:14 .
>drwxr-xr-x   6 root     users        2048 Jul 25 14:19 ..
>drwxr-xr-x   3 root     root         1024 Jan  6 10:28 2.4.0
>[root@eagle /etc]# ls -la /lib/modules/*
>total 8
>drwxr-xr-x   3 root     root         1024 Jan  6 10:28 .
>drwxr-xr-x   3 root     root         1024 Jan  6 10:14 ..
>lrwxrwxrwx   1 root     root           20 Jan  6 10:22 build -> /usr/src/linux-2
>.4.0
>drwxr-xr-x   2 root     root         1024 Jan  6 10:22 kernel
>-rw-r--r--   1 root     root            0 Jan  6 10:22 modules.dep
>-rw-r--r--   1 root     root           31 Jan  6 10:22 modules.generic_string
>-rw-r--r--   1 root     root           81 Jan  6 10:22 modules.isapnpmap
>-rw-r--r--   1 root     root           29 Jan  6 10:22 modules.parportmap
>-rw-r--r--   1 root     root           99 Jan  6 10:22 modules.pcimap
>-rw-r--r--   1 root     root          177 Jan  6 10:22 modules.usbmap

I did a fresh install from linux-2.4.0.tar here and used the following
sequence:

>make mrproper
>cp ../.config-2.2.18
>make oldconfig
>make dep
>make bzImage
>make modules
>make modules_install
 
*** Stopped here due to errors***

>cp /vmlinuz /vmlinuz.old
>cp /usr/src/linux/arch/i386/boot/bzImage /vmlinuz
>/sbin/lilo
>
Here is the errors on the latest clean install attempt(almost looks
like a type here with the two // rather than /) :

make[1]: Leaving directory `/usr/src/linux-2.4.0/arch/i386/lib'
cd /lib/modules/2.4.0; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.0; fi
depmod: error reading ELF header /lib/modules//2.4.0/modules.dep: No
such file o
r directory
depmod: error reading ELF header
/lib/modules//2.4.0/modules.generic_string: No
such file or directory
depmod: /lib/modules//2.4.0/modules.isapnpmap is not an ELF file
depmod: error reading ELF header
/lib/modules//2.4.0/modules.parportmap: No such
 file or directory
depmod: /lib/modules//2.4.0/modules.pcimap is not an ELF file
depmod: /lib/modules//2.4.0/modules.usbmap is not an ELF file

George, MR. Tibbs & The Beast Kasica
Waukesha, WI USA
georgek@netwrx1.com
http://www.netwrx1.com
ICQ #12862186

      Zz
       zZ
    |\ z    _,,,---,,_
    /,`.-'`'    _   ;-;;,_
   |,4-  ) )-,_..;\ (  `'_'
  '---''(_/--'  `-'\_)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
