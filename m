Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285077AbRLFJkP>; Thu, 6 Dec 2001 04:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285074AbRLFJkF>; Thu, 6 Dec 2001 04:40:05 -0500
Received: from ulima.unil.ch ([130.223.144.143]:2692 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S285077AbRLFJjx>;
	Thu, 6 Dec 2001 04:39:53 -0500
Date: Thu, 6 Dec 2001 10:39:51 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: cooker@linux-mandrake.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.17-pre4->ld: bvmlinux: Not enough room for program headers (allocated 2, need 3)
Message-ID: <20011206103951.B4245@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I don't know if that compilation problem is with 2.4.17-pre4 or with the
latest Mandrake cooker tools, so I cross post to both mailing list:

ld -m elf_i386 -Ttext 0x0 -s --oformat binary -e begtext -o bsetup bsetup.o
make[2]: Entering directory `/usr/src/linux-2.4/arch/i386/boot/compressed'
tmppiggy=_tmp_$$piggy; \
rm -f $tmppiggy $tmppiggy.gz $tmppiggy.lnk; \
objcopy -O binary -R .note -R .comment -S /usr/src/linux-2.4/vmlinux $tmppiggy; \
gzip -f -9 < $tmppiggy > $tmppiggy.gz; \
echo "SECTIONS { .data : { input_len = .; LONG(input_data_end - input_data) input_data = .; *(.data) input_data_end = .; }}" > $tmppiggy.lnk; \
ld -m elf_i386 -r -o piggy.o -b binary $tmppiggy.gz -b elf32-i386 -T $tmppiggy.lnk; \
rm -f $tmppiggy $tmppiggy.gz $tmppiggy.lnk
gcc -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux-2.4/include -traditional -c head.S
gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -c misc.c
ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o piggy.o
ld: bvmlinux: Not enough room for program headers (allocated 2, need 3)
ld: final link failed: Bad value
make[2]: *** [bvmlinux] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4/arch/i386/boot/compressed'
make[1]: *** [compressed/bvmlinux] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4/arch/i386/boot'
make: *** [bzImage] Error 2

In case needed my config is: http://ulima.unil.ch/greg/linux/2417-pre4
I have gcc-2.96 from Mandrake, and all latest one...

Thanks you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
