Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbRAEI64>; Fri, 5 Jan 2001 03:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130375AbRAEI6r>; Fri, 5 Jan 2001 03:58:47 -0500
Received: from mail.inconnect.com ([209.140.64.7]:2241 "HELO
	mail.inconnect.com") by vger.kernel.org with SMTP
	id <S129523AbRAEI6f>; Fri, 5 Jan 2001 03:58:35 -0500
Date: Fri, 5 Jan 2001 01:58:33 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
To: Andreas Bombe <andreas.bombe@munich.netsurf.de>
cc: <linux-kernel@vger.kernel.org>
Subject: IEEE1394 2.4.0 (final) compile problems
In-Reply-To: <20010102213916.B2103@storm.local>
Message-ID: <Pine.SOL.4.30.0101050155330.20242-100000@ultra1.inconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=y
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=y
CONFIG_IEEE1394_VIDEO1394=y
CONFIG_IEEE1394_RAWIO=y
# CONFIG_IEEE1394_VERBOSEDEBUG is not set

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c
ieee1394_syms.c
ld -m elf_i386 -r -o ieee1394.o ieee1394_core.o ieee1394_transactions.o
hosts.o highlevel.o csr.o guid.o ieee1394_syms.o
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686    -c -o ohci1394.o ohci1394.c
ohci1394.c:152: warning: `ohci1394_pci_tbl' defined but not used
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-f
rame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
-march=i686
    -c -o video1394.o video1394.c
video1394.c:1229: warning: `video1394_fops' defined but not used
video1394.c:1239: warning: `video1394_init' defined but not used
video1394.c:1277: warning: `remove_card' defined but not used
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-f
rame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
-march=i686
    -c -o raw1394.o raw1394.c
rm -f ieee1394drv.o
ld -m elf_i386  -r -o ieee1394drv.o ieee1394.o ohci1394.o video1394.o
raw1394.o
video1394.o(.data+0x0): multiple definition of `ohci_csr_rom'
ohci1394.o(.data+0x0): first defined here
make[3]: *** [ieee1394drv.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/ieee1394'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/ieee1394'
make[1]: *** [_subdir_ieee1394] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2
[root@thud linux]#

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
