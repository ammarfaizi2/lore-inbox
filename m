Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279902AbRKRRKu>; Sun, 18 Nov 2001 12:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279904AbRKRRKk>; Sun, 18 Nov 2001 12:10:40 -0500
Received: from schwerin.p4.net ([195.98.200.5]:13914 "EHLO schwerin.p4.net")
	by vger.kernel.org with ESMTP id <S279902AbRKRRKX>;
	Sun, 18 Nov 2001 12:10:23 -0500
Message-ID: <3BF7EBBE.8080006@p4all.de>
Date: Sun, 18 Nov 2001 18:11:26 +0100
From: Michael Dunsky <michael.dunsky@p4all.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andreas Vogt <a_vogt@gaia.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Compilation problem 2.4.14
In-Reply-To: <8D6bPntFarB@a_vogt.gaia.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Vogt wrote:

> Hi,
> 
> I can't compile actual kernel
> 2.4.14
> with gcc 2.95.3 and ld 2.11.90.0.29 (GNU)
> 
> Compilation ends with follwing messages:
> 
> make dep clean
> works fine.
> 
> Next step
> make bzImage
> 
> outputs the following:
> 
> 
> 
> . scripts/mkversion > .tmpversion
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.14/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -DUTS_MACHINE='"i386"' -c -o init/version.o init/version.c
> make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.14/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 " -C  kernel
> ...
> ...
> make all_targets
> make[2]: Entering directory `/usr/src/linux-2.4.14/arch/i386/lib'
> make[2]: Nothing to be done for `all_targets'.
> make[2]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
> make[1]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
> ld -m elf_i386 -T /usr/src/linux-2.4.14/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
> 	--start-group \
> 	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
> 	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o drivers/net/fc/fc.o drivers/net/appletalk/appletalk.o drivers/net/wan/wan.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/net/pcmcia/pcmcia_net.o drivers/video/video.o drivers/md/mddev.o \
> 	net/network.o \
> 	/usr/src/linux-2.4.14/arch/i386/lib/lib.a /usr/src/linux-2.4.14/lib/lib.a /usr/src/linux-2.4.14/arch/i386/lib/lib.a \
> 	--end-group \
> 	-o vmlinux
> drivers/block/block.o: In function `lo_send':
> drivers/block/block.o(.text+0xa2ef): undefined reference to `deactivate_page'
> drivers/block/block.o(.text+0xa339): undefined reference to `deactivate_page'
> make: *** [vmlinux] Error 1
> 
> 
> So what's wrong?
> I didn't patch the kernel. It's original from ftp.kernel.org, downloaded  
> yesterday.
> What can I do? Do you need more information about .config?
> 
> I also noticed a problem with kernel 2.4.12 concerning ieee1284_ops.c
> (IEEE1284_PH_DIR_UNKNOWN should be IEEE1284_PH_ECP_DIR_UNKNOWN)
> This seems to be fixed now (2.4.14).
> 
> There was also a warning about not to use 2.4.11
> 
> Aren't there enough people to test new kernels? Are you releasing too  
> often?
> 
> Thank's for any helping answers.
> 
> Bye
> Andreas Vogt
> 
>


Known problem with 2.4.14... apply this patch:


--- linux-2.4.14/drivers/block/loop.c	Thu Oct 25 13:58:34 2001
+++ linux-2.4.14-loop/drivers/block/loop.c	Mon Nov  5 17:06:08 2001
@@ -207,7 +207,6 @@
 		index++;
 		pos += size;
 		UnlockPage(page);
-		deactivate_page(page);
 		page_cache_release(page);
 	}
 	return 0;
@@ -218,7 +217,6 @@
 	kunmap(page);
 unlock:
 	UnlockPage(page);
-	deactivate_page(page);
 	page_cache_release(page);
 fail:
 	return -1;



ciao

Michael

