Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313118AbSDYNCo>; Thu, 25 Apr 2002 09:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313120AbSDYNCn>; Thu, 25 Apr 2002 09:02:43 -0400
Received: from pool-151-204-76-125.delv.east.verizon.net ([151.204.76.125]:17162
	"EHLO trianna.2y.net") by vger.kernel.org with ESMTP
	id <S313118AbSDYNCn>; Thu, 25 Apr 2002 09:02:43 -0400
Date: Thu, 25 Apr 2002 09:03:18 -0400
From: Malcolm Mallardi <magamo@ranka.2y.net>
To: Andrey Panin <pazke@orbita1.ru>, linux-kernel@vger.kernel.org
Subject: [PATCH] arch/mips/kernel/signal.c, still more errors, though.
Message-ID: <20020425090318.A31172@trianna.upcommand.net>
In-Reply-To: <20020424145825.A21701@trianna.upcommand.net> <20020425062859.GA2418@pazke.ipt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2002 at 10:28:59AM +0400, Andrey Panin wrote:
> Hi Malcolm,
> 
> for the second problem did you try to add #include <linux/personality.h> 
> line in signal.c ?
> 


That did indeed fix that build error, so here is the patch for said
fix.

--- linux/arch/mips/kernel/signal.c.orig        Thu Apr 25 08:09:15
2002
+++ linux/arch/mips/kernel/signal.c     Thu Apr 25 08:02:33 2002
@@ -18,6 +18,7 @@
 #include <linux/wait.h>
 #include <linux/ptrace.h>
 #include <linux/unistd.h>
+#include <linux/personality.h>
 
 #include <asm/asm.h>
 #include <asm/bitops.h>


Though I am left with yet another build error during the final linking:

ld -G 0 -static -T arch/mips/ld.script arch/mips/kernel/head.o
arch/mips/kernel/init_task.o init/main.o init/version.o
init/do_mounts.o \
        --start-group \
        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o
arch/mips/sgi-ip22/ip22-kern.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/scsi/scsidrv.o
drivers/cdrom/driver.o drivers/sgi/sgi.a drivers/video/video.o \
        net/network.o \
        arch/mips/lib/lib.a /usr/src/linux-2.4.19-pre7/lib/lib.a
arch/mips/arc/arclib.a \
        --end-group \
        -o vmlinux
drivers/sgi/sgi.a(sgichar.o): In function `register_serial':
sgichar.o(.text+0x6e14): multiple definition of `register_serial'
drivers/char/char.o(.text+0x1ba70): first defined here
drivers/sgi/sgi.a(sgichar.o): In function `unregister_serial':
sgichar.o(.text+0x6e1c): multiple definition of `unregister_serial'
drivers/char/char.o(.text+0x1bac8): first defined here
arch/mips/kernel/kernel.o: In function `irix_waitsys':
arch/mips/kernel/kernel.o(.text+0xaa90): undefined reference to
`release_task'
make: *** [vmlinux] Error 1

The first part of that error was likely a config snafu (I defined both
standard serial and SGI serial) The second looks like a problem with
Irix binary compatibility, I'm disabling that as well.

Disabling those two things has left me with a compiled kernel.

--
Malcolm D. Mallardi - Dark Freak At Large
"Captain, we are receiving two-hundred eighty-five THOUSAND hails."
AOL: Nuark  UIN: 11084092 Y!: Magamo Jabber: Nuark@jabber.com
http://ranka.2y.net:8008/~magamo/index.htm
