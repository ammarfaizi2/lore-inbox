Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272675AbTHBBEM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 21:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272676AbTHBBEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 21:04:12 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:4230 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S272675AbTHBBEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 21:04:08 -0400
Message-ID: <3F2B0E06.9000907@cn.stir.ac.uk>
Date: Sat, 02 Aug 2003 02:04:06 +0100
From: Bernd Porr <Bernd.Porr@cn.stir.ac.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, comedi@comedi.org
Subject: compiling external kernel modules (comedi.org)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Aug 2003 01:04:06.0472 (UTC) FILETIME=[F8D50C80:01C35891]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to compile comedi on 2.6-test2. The very naive way (with 
configure) does not work (as expected). However, comedi conforms 
(mainly) to the kernel makefile convention. So I tried this:

make -C /usr/src/linux-2.6.0-test2 
SUBDIRS=/home/bp1/c/usb/2.6/comedi/comedi/ V=1

make -f scripts/Makefile.build 
obj=/home/bp1/c/usb/2.6/comedi/comedi//drivers
scripts/Makefile.build:27: kbuild: 
/home/bp1/c/usb/2.6/comedi/comedi//drivers/Makefile - Usage of 
export-objs is obsolete in 2.5. Please fix!
make -f scripts/Makefile.build 
obj=/home/bp1/c/usb/2.6/comedi/comedi//kcomedilib
scripts/Makefile.build:27: kbuild: 
/home/bp1/c/usb/2.6/comedi/comedi//kcomedilib/Makefile - Usage of 
export-objs is obsolete in 2.5. Please fix!
make -f scripts/Makefile.build obj=arch/i386/boot arch/i386/boot/bzImage
make -f scripts/Makefile.build obj=arch/i386/boot/compressed \
                                IMAGE_OFFSET=0x100000 
arch/i386/boot/compressed/
vmlinux
Kernel: arch/i386/boot/bzImage is ready
  Building modules, stage 2.
make -rR -f scripts/Makefile.modpost
  scripts/modpost vmlinux drivers/net/pcmcia/3c574_cs.o 
drivers/net/pcmcia/3c589
_cs.o drivers/net/8139cp.o drivers/net/8139too.o drivers/net/8390.o 
drivers/char
/agp/agpgart.o drivers/net/wireless/airo.o 
drivers/net/wireless/airo_cs.o driver
s/net/wireless/arlan-proc.o drivers/net/wireless/arlan.o 
drivers/net/wireless/at
mel.o drivers/net/wireless/atmel_cs.o drivers/usb/class/audio.o 
drivers/net/pcmc

Looks like as if the kernel itself has been compiled and not comedi.

In comparison: kernel 2.4.x makes it (nearly) right:

make -C /usr/src/linux SUBDIRS=/home/bp1/c/usb/2.6/comedi/comedi/

make: Entering directory `/usr/src/linux-2.4.21'
. scripts/mkversion > .tmpversion
gcc -D__KERNEL__ -I/usr/src/linux-2.4.21/include -Wall 
-Wstrict-prototypes -Wno-
trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-pipe -mpref
erred-stack-boundary=2 -march=athlon  -DUTS_MACHINE='"i386"' 
-DKBUILD_BASENAME=v
ersion -c -o init/version.o init/version.c
make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.21/include -Wall 
-Wstrict-prototy
pes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pi
pe -mpreferred-stack-boundary=2 -march=athlon " -C  
/home/bp1/c/usb/2.6/comedi/c
omedi
make[1]: Entering directory `/home/bp1/c/usb/2.6/comedi/comedi'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.21/include -Wall 
-Wstrict-prototypes -Wno-
trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-pipe -mpref
erred-stack-boundary=2 -march=athlon  -D__KERNEL__ 
-I/usr/src/linux-2.4.21/inclu
de  -c -o comedi_fops.o comedi_fops.c
make[1]: Leaving directory `/home/bp1/c/usb/2.6/comedi/comedi'
make: Leaving directory `/usr/src/linux-2.4.21'

Is it a kernel2.6 issue or is it a comedi issue? Actually the comedi 
configuration is a hack and does not completely comply with the kernel 
makefile conventions. Probably because it has to run on either 2.x.x 
kernel. Who can help? Is the way to compile exernal modules from the 
2.4.x kernel deprecated? Is there another (more elegant) way? Would be 
nice to use as much as possible from the 2.6 stuff. Just now comdi does 
most of the stuff by a "configure" by itself. This leads to another 
problem where comedi is not able to obtain the compiler flags etc from 
the 2-6 kernel. However, this is a hack and has to be chnanged anyway.

Therefore my questions: What is the best way to compile external modules?
What has changed from 2.4 to 2.6? I noticed that .htdepend is no longer 
there and that there is no rules file.

/Bernd

-- 
http://www.cn.stir.ac.uk/~bp1/
mailto:bp1@cn.stir.ac.uk



