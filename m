Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263053AbSJBLnh>; Wed, 2 Oct 2002 07:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263054AbSJBLnh>; Wed, 2 Oct 2002 07:43:37 -0400
Received: from [212.3.242.3] ([212.3.242.3]:52210 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S263053AbSJBLng>;
	Wed, 2 Oct 2002 07:43:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.4.50 - 8250_cs does NOT work
Date: Wed, 2 Oct 2002 13:48:58 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200210021257.43121.devilkin-lkml@blindguardian.org> <20021002120540.D24770@flint.arm.linux.org.uk>
In-Reply-To: <20021002120540.D24770@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210021348.58582.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 October 2002 13:05, Russell King wrote:
> On Wed, Oct 02, 2002 at 12:57:42PM +0200, DevilKin wrote:
> > If i load the 8250_cs module, I get _nothing_ at all. No text in system
> > logs, nothing. Modem doesn't respond under the old /dev/ttyS1, I've tried
> > all other /dev/ttySx's to see if it hasn't been remapped. Unfortunately,
> > no.
> >
> > Is there anything else I can try? I really need my modem back...
>
> Known problem.  I've sent a fix to someone else for it but iirc they
> never came back.  The following patch is completely untested - I'm
> still trying to get 2.5.40 to build at present.
>
Had to manually apply it (for some weird reason it didn't work with patch),

compiled it and got this compilation error:

make[3]: Entering directory `/usr/src/linux-2.5/drivers/serial'
  gcc -Wp,-MD,./.core.o.d -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -I/usr/src/linux-2.5/arch/i386/mach-generic -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=core -DEXPORT_SYMTAB  -c -o core.o 
core.c
  gcc -Wp,-MD,./.8250.o.d -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -I/usr/src/linux-2.5/arch/i386/mach-generic -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=8250 -DEXPORT_SYMTAB  -c -o 8250.o 
8250.c
drivers/serial/8250.c: In function `serial8250_set_mctrl':
drivers/serial/8250.c:1061: `ALPHA_KLUDGE_MCR' undeclared (first use in this 
function)
drivers/serial/8250.c:1061: (Each undeclared identifier is reported only once
drivers/serial/8250.c:1061: for each function it appears in.)
drivers/serial/8250.c: In function `serial8250_isa_init_ports':
drivers/serial/8250.c:1701: structure has no member named `io_type'
  gcc -Wp,-MD,./.8250_pci.o.d -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -I/usr/src/linux-2.5/arch/i386/mach-generic -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=8250_pci   -c -o 8250_pci.o 
8250_pci.c
   ld -m elf_i386  -r -o built-in.o core.o 8250.o 8250_pci.o
ld: cannot open 8250.o: No such file or directory
make[3]: *** [built-in.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5/drivers/serial'
make[2]: *** [serial] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5/drivers'
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5'
make: *** [bzImage] Error 2

So i guess it doesn't work...

DK
-- 
"... one of the main causes of the fall of the Roman Empire was that,
lacking zero, they had no way to indicate successful termination of
their C programs."
		-- Robert Firth

