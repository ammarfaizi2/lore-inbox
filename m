Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132348AbRALUDE>; Fri, 12 Jan 2001 15:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132768AbRALUCz>; Fri, 12 Jan 2001 15:02:55 -0500
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:37003 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S132348AbRALUCs>; Fri, 12 Jan 2001 15:02:48 -0500
Message-ID: <3A5F62C6.FF3EE6B1@Home.net>
Date: Fri, 12 Jan 2001 15:02:15 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [CONT PROBLEM] 2.4.1-pre3 - Undefined symbol `__buggy_fxsr_alignment'
In-Reply-To: <3A5E4B1D.5EF1B0EB@Home.net> <3A5E7DB2.A7126A68@Home.net> <3A5E7EC4.39CC7298@Home.net>
Content-Type: multipart/alternative;
 boundary="------------EBAE702E4AB8A4F5C6FB0033"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------EBAE702E4AB8A4F5C6FB0033
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit



Nope, its not ;/

Im on a Intel Pentium 200Mhz PC, 64MB RAM,

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
 --start-group \
 arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o
ipc/ipc.o \
 drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/net/net.o
drivers/media/media.o  drivers/parport/driver.o drivers/ide/idedriver.o
drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o
drivers/pnp/pnp.o drivers/video/video.o drivers/input/inputdrv.o \
 net/network.o \
 /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
 --end-group \
 -o vmlinux
init/main.o: In function `check_fpu':
init/main.o(.text.init+0x53): undefined reference to `__buggy_fxsr_alignment'
make: *** [vmlinux] Error 1

same fatal error. Where is this function defined in the i386 asm header?

If so, I could fix this and submit a patch.

[root@coredump linux]# grep -r "__buggy_fxsr_alignment" *
include/asm-i386/bugs.h:  extern void __buggy_fxsr_alignment(void);
include/asm-i386/bugs.h:  __buggy_fxsr_alignment();
include/asm/bugs.h:  extern void __buggy_fxsr_alignment(void);
include/asm/bugs.h:  __buggy_fxsr_alignment();

/* Enable FXSR and company _before_ testing for FP problems. */
        /*
         * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
         */
        if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
                extern void __buggy_fxsr_alignment(void);
                __buggy_fxsr_alignment();

Where is this function? Where is it defined? When i grep the whole dir i dont see
this function anywhere?

Shawn.

Shawn Starr wrote:

> errrr i think it was just fixed in pre3 ;-)
>
> +       if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
> +               extern void __buggy_fxsr_alignment(void);
> +               __buggy_fxsr_alignment();
> +       }
>
> > GCC 2.95.2 -> PGCC 2.95.2(3?) patched. 2.4.0 compiles fine
> >
> > init/main.o: In function `check_fpu':
> > init/main.o(.text.init+0x53): undefined reference to `__buggy_fxsr_alignment'
> >
> > make: *** [vmlinux] Error 1
> >
> > On compiling (and recompiling) i get this fatal error. This function
> > does not exist anymore?
> >
> > Anyone else having this problem?
> >
> > Shawn Starr.
> >

--------------EBAE702E4AB8A4F5C6FB0033
Content-Type: text/html; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
&nbsp;
<pre>

Nope, its not ;/

Im on a Intel Pentium 200Mhz PC, 64MB RAM,</pre>
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o
arch/i386/kernel/init_task.o init/main.o init/version.o \
<br>&nbsp;--start-group \
<br>&nbsp;arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
<br>&nbsp;drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o&nbsp; drivers/parport/driver.o
drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o
drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o drivers/input/inputdrv.o
\
<br>&nbsp;net/network.o \
<br>&nbsp;/usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a
\
<br>&nbsp;--end-group \
<br>&nbsp;-o vmlinux
<br>init/main.o: In function `check_fpu':
<br>init/main.o(.text.init+0x53): undefined reference to `__buggy_fxsr_alignment'
<br>make: *** [vmlinux] Error 1
<p>same fatal error. Where is this function defined in the i386 asm header?
<p>If so, I could fix this and submit a patch.
<p>[root@coredump linux]# grep -r "__buggy_fxsr_alignment" *
<br>include/asm-i386/bugs.h:&nbsp; extern void __buggy_fxsr_alignment(void);
<br>include/asm-i386/bugs.h:&nbsp; __buggy_fxsr_alignment();
<br>include/asm/bugs.h:&nbsp; extern void __buggy_fxsr_alignment(void);
<br>include/asm/bugs.h:&nbsp; __buggy_fxsr_alignment();
<p>/* Enable FXSR and company _before_ testing for FP problems. */
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Verify that the
FXSAVE/FXRSTOR data will be 16-byte aligned.
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (offsetof(struct task_struct,
thread.i387.fxsave) &amp; 15) {
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
extern void __buggy_fxsr_alignment(void);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
__buggy_fxsr_alignment();
<p>Where is this function?&nbsp;Where is it defined?&nbsp;When i grep the
whole dir i dont see this function anywhere?
<p>Shawn.
<p>Shawn Starr wrote:
<blockquote TYPE=CITE>errrr i think it was just fixed in pre3 ;-)
<p>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (offsetof(struct task_struct,
thread.i387.fxsave) &amp; 15) {
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
extern void __buggy_fxsr_alignment(void);
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
__buggy_fxsr_alignment();
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
<p>> GCC 2.95.2 -> PGCC 2.95.2(3?) patched. 2.4.0 compiles fine
<br>>
<br>> init/main.o: In function `check_fpu':
<br>> init/main.o(.text.init+0x53): undefined reference to `__buggy_fxsr_alignment'
<br>>
<br>> make: *** [vmlinux] Error 1
<br>>
<br>> On compiling (and recompiling) i get this fatal error. This function
<br>> does not exist anymore?
<br>>
<br>> Anyone else having this problem?
<br>>
<br>> Shawn Starr.
<br>></blockquote>
</html>

--------------EBAE702E4AB8A4F5C6FB0033--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
