Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282924AbRLFPNP>; Thu, 6 Dec 2001 10:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282242AbRLFPM1>; Thu, 6 Dec 2001 10:12:27 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:27349 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S282941AbRLFPMF>; Thu, 6 Dec 2001 10:12:05 -0500
Date: Thu, 6 Dec 2001 16:11:59 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Kai Germaschewski <kai.germaschewski@gmx.de>,
        Karsten Keil <keil@isdn4linux.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: ISDN compile broken since 2.4.17-pre3
Message-ID: <Pine.NEB.4.43.0112061603240.3735-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.17-pre3 adds the files hisax_isac.{c,h}. The problem is that they
define a function isac_interrupt that is different from the one already
present in isac.{c,h}. This produces the following error when you use a
.config that tries to compile both files into the kernel:

...
ld -m elf_i386  -r -o vmlinux-obj.o hisax.o sedlbauer_cs.o elsa_cs.o
hisax_st5481.o hisax_isac.o hisax_fcpcipnp.o
hisax_isac.o: In function `isac_interrupt':
hisax_isac.o(.text+0x630): multiple definition of `isac_interrupt'
hisax.o(.text+0x497b8): first defined here
ld: Warning: size of symbol `isac_interrupt' changed from 3038 to 1373 in
hisax_isac.o
make[4]: *** [vmlinux-obj.o] Error 1
make[4]: Leaving directory `/mnt/kernel/linux/drivers/isdn/hisax'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/mnt/kernel/linux/drivers/isdn/hisax'
make[2]: *** [_subdir_hisax] Error 2
make[2]: Leaving directory `/mnt/kernel/linux/drivers/isdn'
make[1]: *** [_subdir_isdn] Error 2
make[1]: Leaving directory `/mnt/kernel/linux/drivers'
make: *** [_dir_drivers] Error 2


cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400


