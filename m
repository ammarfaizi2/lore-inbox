Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbTLWL10 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 06:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbTLWL1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 06:27:25 -0500
Received: from camus.xss.co.at ([194.152.162.19]:36370 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S265100AbTLWL1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 06:27:22 -0500
Message-ID: <3FE8268E.40605@xss.co.at>
Date: Tue, 23 Dec 2003 12:27:10 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Build problems (Re: Linux 2.4.24-pre2)
References: <Pine.LNX.4.58L.0312221753140.1384@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0312221753140.1384@logos.cnet>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Marcelo Tosatti wrote:
> Hi,
>
> Here goes 2.4.24-pre2. It contains MIPS/PPC64/SPARC updates, ACPI
> bugfixes, USB update, XFS fixes, amongst others.
>
I noticed some build problems.

Compiler: gcc-2.95.3
Compilation on x86 machine with CONFIG_M586TSC=y
Trying to enable and compile as much drivers as modules
as possible.

1.) cciss.c
    (parse error already reported by Eyal Lebedinsky)

2.) drivers/char/ds1742.c
    Can be selected, but does not compile on x86 architecture

3.) qlogic PCMCIA SCSI
[...]
gcc -D__KERNEL__ -I/usr/src/linux-2.4.24-pre2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.24-pre2/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=qlogicfas -DPCMCIA -D__NO_VERSION__ -c -o qlogicfas.o ../qlogicfas.c
../qlogicfas.c: In function `qlogicfas_detect':
../qlogicfas.c:650: warning: passing arg 1 of `scsi_unregister_Rsmp_532576d5' from incompatible pointer type
ld -m elf_i386 -r -o qlogic_cs.o qlogic_stub.o qlogicfas.o
qlogicfas.o: In function `init_module':
qlogicfas.o(.text+0xe78): multiple definition of `init_module'
qlogic_stub.o(.text+0x76c): first defined here
ld: Warning: size of symbol `init_module' changed from 81 to 59 in qlogicfas.o
qlogicfas.o: In function `cleanup_module':
qlogicfas.o(.text+0xeb4): multiple definition of `cleanup_module'
qlogic_stub.o(.text+0x7c0): first defined here
ld: Warning: size of symbol `cleanup_module' changed from 40 to 16 in qlogicfas.o
make[3]: *** [qlogic_cs.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.24-pre2/drivers/scsi/pcmcia'
make[2]: *** [_modsubdir_pcmcia] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.24-pre2/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.24-pre2/drivers'
make: *** [_mod_drivers] Error 2
[...]

4.) fdomain PCMCIA SCSI
[...]
gcc -D__KERNEL__ -I/usr/src/linux-2.4.24-pre2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.24-pre2/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=fdomain -DPCMCIA -D__NO_VERSION__ -c -o fdomain.o ../fdomain.c
../fdomain.c:565: warning: `fdomain_setup' defined but not used
ld -m elf_i386 -r -o fdomain_cs.o fdomain_stub.o fdomain.o
fdomain.o: In function `init_module':
fdomain.o(.text+0x1a0c): multiple definition of `init_module'
fdomain_stub.o(.text+0x698): first defined here
ld: Warning: size of symbol `init_module' changed from 75 to 58 in fdomain.o
fdomain.o: In function `cleanup_module':
fdomain.o(.text+0x1a48): multiple definition of `cleanup_module'
fdomain_stub.o(.text+0x6e4): first defined here
ld: Warning: size of symbol `cleanup_module' changed from 36 to 16 in fdomain.o
make[3]: *** [fdomain_cs.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.24-pre2/drivers/scsi/pcmcia'
make[2]: *** [_modsubdir_pcmcia] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.24-pre2/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.24-pre2/drivers'
make: *** [_mod_drivers] Error 2
[...]

5.) aha152x PCMCIA SCSI
[...]
gcc -D__KERNEL__ -I/usr/src/linux-2.4.24-pre2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.24-pre2/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=aha152x -DPCMCIA -D__NO_VERSION__ -DAHA152X_STAT -c -o aha152x.o ../aha152x.c
../aha152x.c:853: warning: `do_setup' defined but not used
ld -m elf_i386 -r -o aha152x_cs.o aha152x_stub.o aha152x.o
aha152x.o: In function `init_module':
aha152x.o(.text+0x5328): multiple definition of `init_module'
aha152x_stub.o(.text+0x72c): first defined here
ld: Warning: size of symbol `init_module' changed from 81 to 59 in aha152x.o
aha152x.o: In function `cleanup_module':
aha152x.o(.text+0x5364): multiple definition of `cleanup_module'
aha152x_stub.o(.text+0x780): first defined here
ld: Warning: size of symbol `cleanup_module' changed from 40 to 16 in aha152x.o
make[3]: *** [aha152x_cs.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.24-pre2/drivers/scsi/pcmcia'
make[2]: *** [_modsubdir_pcmcia] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.24-pre2/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.24-pre2/drivers'
make: *** [_mod_drivers] Error 2
[...]

HTH

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/6CaMxJmyeGcXPhERAt9FAJ9TFLFhQroocWgGDLcVyvr0zB8yQwCgrkzg
xFFdByHrmHsdCv1+1l9e3IU=
=Ff/x
-----END PGP SIGNATURE-----

