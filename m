Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281519AbRKPT2M>; Fri, 16 Nov 2001 14:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281503AbRKPT2D>; Fri, 16 Nov 2001 14:28:03 -0500
Received: from mout1.freenet.de ([194.97.50.132]:22479 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S281504AbRKPT1o>;
	Fri, 16 Nov 2001 14:27:44 -0500
Subject: problems with memory allocation
From: Garfycx <garfycx@garfycx.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 16 Nov 2001 20:28:08 +0100
Message-Id: <1005938890.23493.2.camel@-f>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Help!

I have some trouble with seg faults when allocating memory, and am too
confused by that to find the right culprit...

I created a linked list (with a FOR loop and same conditions for each
element) and got a seg fault at 10th element. May happen, but now
happens since days and always at the same 10th element. I tried around a
bit to find out what could be the problem and stranded with an
experiment:

I wrote a loop from 0 to 100 and allocated memory with calloc to a char
pointer each loop (at same place in code to keep it comparable):

for (i = 0; i <= 100; i++){
	char pointer = (cast) calloc(1,bytes);
	printf("hier (means 'here' in german)\n");
}

I got seg faults till up to 100 bytes per allocation at always the same
overall allocated memory size (bytes * loops) (malloc, instead, works
fine but using the faulty memory leads to seg fault too). When
allocating 1000 bytes each loop I got no error. To me this means that
there are some small faulty rests in memory that were overjumped when
allocating more memory at once. But because I can overfill my memory
with applications without any seg fault, and the error is always
strictly the same (even after boot and with different amount of products
running), I can't believe that it is my hardware. At least, other
products don't step into this problem. May it be the vm?

I use glibc 2.2.4 and gcc 2.95.3 on linux 2.4.13. I tried to compile
2.4.14 but got an installation error:

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
	 drivers/parport/driver.o drivers/char/char.o drivers/block/block.o
drivers/misc/misc.o drivers/net/net.o drivers/media/media.o
drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/atm/atm.o
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o
drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o
drivers/input/inputdrv.o drivers/message/i2o/i2o.o drivers/i2c/i2c.o \
	net/network.o \
	/usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0xa853): undefined reference to
`deactivate_page'
drivers/block/block.o(.text+0xa895): undefined reference to
`deactivate_page'
make: *** [vmlinux] Error 1


The patch nr.5 for 2.4.15pre gives another compilation error:

setup.c: In function `c_start':
setup.c:2791: subscripted value is neither array nor pointer
setup.c:2792: warning: control reaches end of non-void function
make[1]: *** [setup.o] Error 1
make[1]: Leaving directory `/usr/src/linux/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2





