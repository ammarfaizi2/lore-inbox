Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261571AbTCKU00>; Tue, 11 Mar 2003 15:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261590AbTCKU00>; Tue, 11 Mar 2003 15:26:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:63875 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261571AbTCKU0X>; Tue, 11 Mar 2003 15:26:23 -0500
Date: Tue, 11 Mar 2003 15:39:59 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ben Collins <bcollins@debian.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire on Linux-2.4.20
In-Reply-To: <20030311200311.GB379@phunnypharm.org>
Message-ID: <Pine.LNX.3.95.1030311152746.8672A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Mar 2003, Ben Collins wrote:

> On Tue, Mar 11, 2003 at 02:29:39PM -0500, Richard B. Johnson wrote:
> > 
> > Hello FIREWIRE gurus!
> > 
> > I am trying to get Linux-2.4.20 running!  I need the
> > IEEE1394 PCILYNX module working. The configuration has
> > strangely changed since linux-2.4.18 so the required
> > object file becomes an 8-byte text file!
> 
> I'd much rather see the output of this:
> 
> # rm drivers/ieee1394/pcilynx.o
> # make SUBDIRS=drivers/ieee1394
> 
> 
> Mainly, I want to see the command line and output from the kernel
> command line. The pcilynx.o you shows seems to be an attempted AR
> archive, which is really weird.
> 

Here it is....
Script started on Tue Mar 11 15:25:13 2003
# sh -v xxx.xxx


rm drivers/ieee1394/*.o
make SUBDIRS=drivers/ieee1394
. scripts/mkversion > .tmpversion
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe   -DUTS_MACHINE='"i386"' -DKBUILD_BASENAME=version -c -o init/version.o init/version.c
make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  " -C  drivers/ieee1394
make[1]: Entering directory `/usr/src/linux-2.4.20/drivers/ieee1394'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.4.20/drivers/ieee1394'
rm -f ieee1394drv.o
ar rcs ieee1394drv.o
make[2]: Leaving directory `/usr/src/linux-2.4.20/drivers/ieee1394'
make[1]: Leaving directory `/usr/src/linux-2.4.20/drivers/ieee1394'
ld -m elf_i386 -T /usr/src/linux-2.4.20/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o \
	net/network.o \
	/usr/src/linux-2.4.20/arch/i386/lib/lib.a /usr/src/linux-2.4.20/lib/lib.a /usr/src/linux-2.4.20/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw] \)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map

# cd drivers/ieee*
# ls *.o
ieee1394drv.o
# strings *.o
!<arch>
# cat *.o
!<arch>
# exit
exit

Script done on Tue Mar 11 15:26:29 2003


Here's another hack at it:

Script started on Tue Mar 11 15:30:02 2003
# sh -v xxx.xxx

rm drivers/ieee1394/*.o
make SUBDIRS=drivers/ieee1394 modules
make -C  drivers/ieee1394 CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -DMODULE" MAKING_MODULES=1 modules
make[1]: Entering directory `/usr/src/linux-2.4.20/drivers/ieee1394'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=ieee1394_core  -DEXPORT_SYMTAB -c ieee139
4_core.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=ieee1394_transactions  -c -o ieee1394_tra
nsactions.o ieee1394_transactions.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=hosts  -c -o hosts.o hosts.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=highlevel  -c -o highlevel.o highlevel.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=csr  -c -o csr.o csr.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=nodemgr  -c -o nodemgr.o nodemgr.c
ld -m elf_i386 -e stext -r -o ieee1394.o ieee1394_core.o ieee1394_transactions.o hosts.o highlevel.o csr.o nodemgr.o
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=pcilynx  -c -o pcilynx.o pcilynx.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=ohci1394  -DEXPORT_SYMTAB -c ohci1394.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=raw1394  -c -o raw1394.o raw1394.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=sbp2  -c -o sbp2.o sbp2.c
make[1]: Leaving directory `/usr/src/linux-2.4.20/drivers/ieee1394'


# cd drivers/ieee*
# ls *.o
csr.o	     hosts.o	 ieee1394_core.o	  nodemgr.o   pcilynx.o  sbp2.o
highlevel.o  ieee1394.o  ieee1394_transactions.o  ohci1394.o  raw1394.o
# ls -la pcilynx.o
-rw-r--r--   1 root     root        16432 Mar 11 15:30 pcilynx.o
# depmod pcilynx.o
depmod: *** Unresolved symbols in pcilynx.o
pcilynx.o:

# module             vendor     device     subvendor  subdevice  class      class_mask driver_data
pcilynx.o            0x0000104c 0x00008000 0xffffffff 0xffffffff 0x00000000 0x00000000 0x00000000
# insmod pcilynx.o
pcilynx.o: unresolved symbol i2c_transfer
pcilynx.o: unresolved symbol i2c_bit_del_bus
pcilynx.o: unresolved symbol i2c_bit_add_bus
# exit
exit

Script done on Tue Mar 11 15:32:17 2003

This shows some unresolved symbols because the newer pcilynx.o requires
i2c support (some shared bit-banger) and, even though it was configured,
no i2c stuff got built!

Script started on Tue Mar 11 15:35:35 2003
# pwd
/usr/src/linux-2.4.20/drivers/i2c
# ls 
Config.in	i2c-algo-pcf.c	i2c-ite.h	   i2c-proc.c
Makefile	i2c-core.c	i2c-keywest.c	   i2c-velleman.c
i2c-adap-ite.c	i2c-dev.c	i2c-keywest.h
i2c-algo-bit.c	i2c-elektor.c	i2c-pcf8584.h
i2c-algo-ite.c	i2c-elv.c	i2c-philips-par.c
# exit
exit

Script done on Tue Mar 11 15:35:53 2003


FYI, this is an un-patched kernel right "out-of-the-box",
 linux-2.4.20.tar.gz

I just did:

cd /usr/src/linux-2.4.20.tar.gz
cp ../linux-2.4.18/.config .
make oldconfig  # Answered a few new questions
make dep
make bzImage
make modules
make modules_install


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


