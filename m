Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbVAPT6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbVAPT6J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 14:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVAPT6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 14:58:08 -0500
Received: from fire.osdl.org ([65.172.181.4]:10459 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262594AbVAPTx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 14:53:27 -0500
Message-ID: <41EAC45D.30207@osdl.org>
Date: Sun, 16 Jan 2005 11:45:33 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: conglomerate objects in reference*.pl
References: <14049.1105852931@ocs3.ocs.com.au>
In-Reply-To: <14049.1105852931@ocs3.ocs.com.au>
Content-Type: multipart/mixed;
 boundary="------------000502060909000103060708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000502060909000103060708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Keith Owens wrote:
> On Sat, 15 Jan 2005 20:49:33 -0800, 
> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> 
>>Hi Keith,
>>
>>I'm seeing some drivers/*/built-in.o that should be ignored AFAIK,
>>but they are not ignored.  Any ideas?
>>
>>This is 2.6.11-rc1-bk3 on i386 with allmodconfig
>>(except DEBUG_INFO=n) and gcc 3.3.3.
>>
>>Error: ./drivers/ide/built-in.o .text refers to 00000939 R_386_PC32 
>>     .init.text
>>Error: ./drivers/ide/legacy/built-in.o .text refers to 00000939 
>>R_386_PC32        .init.text
>>Error: ./drivers/ide/legacy/hd.o .text refers to 00000939 R_386_PC32 
>>      .init.text
> 
> 
> Output from these commands please.
> 
> rm drivers/ide/built-in.o drivers/ide/legacy/built-in.o
> make SUBDIRS=drivers/ide V=1
> objdump -s -j .comment drivers/ide/built-in.o | head -n15

objdump says:

drivers/ide/built-in.o:     file format elf32-i386

Contents of section .comment:
  0000 00474343 3a202847 4e552920 332e332e  .GCC: (GNU) 3.3.
  0010 33202853 75534520 4c696e75 782900    3 (SuSE Linux).


make output is attached.

Thanks,
-- 
~Randy

--------------000502060909000103060708
Content-Type: text/plain;
 name="build_ide.out"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="build_ide.out"

mkdir -p drivers/ide/.tmp_versions
make -f scripts/Makefile.build obj=3Ddrivers/ide
make -f scripts/Makefile.build obj=3Ddrivers/ide/arm
   rm -f drivers/ide/arm/built-in.o; ar rcs drivers/ide/arm/built-in.o
make -f scripts/Makefile.build obj=3Ddrivers/ide/legacy
  gcc -Wp,-MD,drivers/ide/legacy/.hd.o.d -nostdinc -isystem /usr/lib/gcc-=
lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-=
prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding=
 -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bou=
ndary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-i=
386/mach-default  -Idrivers/ide   -DKBUILD_BASENAME=3Dhd -DKBUILD_MODNAME=
=3Dhd -c -o drivers/ide/legacy/.tmp_hd.o drivers/ide/legacy/hd.c
   ld -m elf_i386  -r -o drivers/ide/legacy/built-in.o drivers/ide/legacy=
/hd.o
  gcc -Wp,-MD,drivers/ide/legacy/.ali14xx.o.d -nostdinc -isystem /usr/lib=
/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wst=
rict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreesta=
nding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stac=
k-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/=
asm-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dali14x=
x -DKBUILD_MODNAME=3Dali14xx -c -o drivers/ide/legacy/.tmp_ali14xx.o driv=
ers/ide/legacy/ali14xx.c
  gcc -Wp,-MD,drivers/ide/legacy/.dtc2278.o.d -nostdinc -isystem /usr/lib=
/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wst=
rict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreesta=
nding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stac=
k-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/=
asm-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Ddtc227=
8 -DKBUILD_MODNAME=3Ddtc2278 -c -o drivers/ide/legacy/.tmp_dtc2278.o driv=
ers/ide/legacy/dtc2278.c
  gcc -Wp,-MD,drivers/ide/legacy/.ht6560b.o.d -nostdinc -isystem /usr/lib=
/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wst=
rict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreesta=
nding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stac=
k-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/=
asm-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dht6560=
b -DKBUILD_MODNAME=3Dht6560b -c -o drivers/ide/legacy/.tmp_ht6560b.o driv=
ers/ide/legacy/ht6560b.c
  gcc -Wp,-MD,drivers/ide/legacy/.qd65xx.o.d -nostdinc -isystem /usr/lib/=
gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstr=
ict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestan=
ding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack=
-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/a=
sm-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dqd65xx =
-DKBUILD_MODNAME=3Dqd65xx -c -o drivers/ide/legacy/.tmp_qd65xx.o drivers/=
ide/legacy/qd65xx.c
  gcc -Wp,-MD,drivers/ide/legacy/.umc8672.o.d -nostdinc -isystem /usr/lib=
/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wst=
rict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreesta=
nding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stac=
k-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/=
asm-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dumc867=
2 -DKBUILD_MODNAME=3Dumc8672 -c -o drivers/ide/legacy/.tmp_umc8672.o driv=
ers/ide/legacy/umc8672.c
  gcc -Wp,-MD,drivers/ide/legacy/.ide-cs.o.d -nostdinc -isystem /usr/lib/=
gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstr=
ict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestan=
ding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack=
-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/a=
sm-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dide_cs =
-DKBUILD_MODNAME=3Dide_cs -c -o drivers/ide/legacy/.tmp_ide-cs.o drivers/=
ide/legacy/ide-cs.c
make -f scripts/Makefile.build obj=3Ddrivers/ide/pci
   rm -f drivers/ide/pci/built-in.o; ar rcs drivers/ide/pci/built-in.o
  gcc -Wp,-MD,drivers/ide/pci/.aec62xx.o.d -nostdinc -isystem /usr/lib/gc=
c-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstric=
t-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandi=
ng -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-b=
oundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm=
-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Daec62xx -=
DKBUILD_MODNAME=3Daec62xx -c -o drivers/ide/pci/.tmp_aec62xx.o drivers/id=
e/pci/aec62xx.c
  gcc -Wp,-MD,drivers/ide/pci/.alim15x3.o.d -nostdinc -isystem /usr/lib/g=
cc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstri=
ct-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestand=
ing -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-=
boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/as=
m-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dalim15x3=
 -DKBUILD_MODNAME=3Dalim15x3 -c -o drivers/ide/pci/.tmp_alim15x3.o driver=
s/ide/pci/alim15x3.c
  gcc -Wp,-MD,drivers/ide/pci/.amd74xx.o.d -nostdinc -isystem /usr/lib/gc=
c-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstric=
t-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandi=
ng -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-b=
oundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm=
-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Damd74xx -=
DKBUILD_MODNAME=3Damd74xx -c -o drivers/ide/pci/.tmp_amd74xx.o drivers/id=
e/pci/amd74xx.c
  gcc -Wp,-MD,drivers/ide/pci/.atiixp.o.d -nostdinc -isystem /usr/lib/gcc=
-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict=
-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandin=
g -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bo=
undary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-=
i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Datiixp -DK=
BUILD_MODNAME=3Datiixp -c -o drivers/ide/pci/.tmp_atiixp.o drivers/ide/pc=
i/atiixp.c
  gcc -Wp,-MD,drivers/ide/pci/.cmd64x.o.d -nostdinc -isystem /usr/lib/gcc=
-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict=
-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandin=
g -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bo=
undary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-=
i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dcmd64x -DK=
BUILD_MODNAME=3Dcmd64x -c -o drivers/ide/pci/.tmp_cmd64x.o drivers/ide/pc=
i/cmd64x.c
  gcc -Wp,-MD,drivers/ide/pci/.cs5520.o.d -nostdinc -isystem /usr/lib/gcc=
-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict=
-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandin=
g -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bo=
undary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-=
i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dcs5520 -DK=
BUILD_MODNAME=3Dcs5520 -c -o drivers/ide/pci/.tmp_cs5520.o drivers/ide/pc=
i/cs5520.c
  gcc -Wp,-MD,drivers/ide/pci/.cs5530.o.d -nostdinc -isystem /usr/lib/gcc=
-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict=
-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandin=
g -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bo=
undary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-=
i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dcs5530 -DK=
BUILD_MODNAME=3Dcs5530 -c -o drivers/ide/pci/.tmp_cs5530.o drivers/ide/pc=
i/cs5530.c
  gcc -Wp,-MD,drivers/ide/pci/.sc1200.o.d -nostdinc -isystem /usr/lib/gcc=
-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict=
-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandin=
g -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bo=
undary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-=
i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dsc1200 -DK=
BUILD_MODNAME=3Dsc1200 -c -o drivers/ide/pci/.tmp_sc1200.o drivers/ide/pc=
i/sc1200.c
  gcc -Wp,-MD,drivers/ide/pci/.cy82c693.o.d -nostdinc -isystem /usr/lib/g=
cc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstri=
ct-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestand=
ing -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-=
boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/as=
m-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dcy82c693=
 -DKBUILD_MODNAME=3Dcy82c693 -c -o drivers/ide/pci/.tmp_cy82c693.o driver=
s/ide/pci/cy82c693.c
  gcc -Wp,-MD,drivers/ide/pci/.hpt34x.o.d -nostdinc -isystem /usr/lib/gcc=
-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict=
-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandin=
g -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bo=
undary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-=
i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dhpt34x -DK=
BUILD_MODNAME=3Dhpt34x -c -o drivers/ide/pci/.tmp_hpt34x.o drivers/ide/pc=
i/hpt34x.c
  gcc -Wp,-MD,drivers/ide/pci/.hpt366.o.d -nostdinc -isystem /usr/lib/gcc=
-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict=
-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandin=
g -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bo=
undary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-=
i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dhpt366 -DK=
BUILD_MODNAME=3Dhpt366 -c -o drivers/ide/pci/.tmp_hpt366.o drivers/ide/pc=
i/hpt366.c
  gcc -Wp,-MD,drivers/ide/pci/.ns87415.o.d -nostdinc -isystem /usr/lib/gc=
c-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstric=
t-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandi=
ng -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-b=
oundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm=
-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dns87415 -=
DKBUILD_MODNAME=3Dns87415 -c -o drivers/ide/pci/.tmp_ns87415.o drivers/id=
e/pci/ns87415.c
  gcc -Wp,-MD,drivers/ide/pci/.opti621.o.d -nostdinc -isystem /usr/lib/gc=
c-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstric=
t-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandi=
ng -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-b=
oundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm=
-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dopti621 -=
DKBUILD_MODNAME=3Dopti621 -c -o drivers/ide/pci/.tmp_opti621.o drivers/id=
e/pci/opti621.c
  gcc -Wp,-MD,drivers/ide/pci/.pdc202xx_old.o.d -nostdinc -isystem /usr/l=
ib/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -W=
strict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffrees=
tanding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-st=
ack-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclud=
e/asm-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dpdc2=
02xx_old -DKBUILD_MODNAME=3Dpdc202xx_old -c -o drivers/ide/pci/.tmp_pdc20=
2xx_old.o drivers/ide/pci/pdc202xx_old.c
  gcc -Wp,-MD,drivers/ide/pci/.pdc202xx_new.o.d -nostdinc -isystem /usr/l=
ib/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -W=
strict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffrees=
tanding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-st=
ack-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclud=
e/asm-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dpdc2=
02xx_new -DKBUILD_MODNAME=3Dpdc202xx_new -c -o drivers/ide/pci/.tmp_pdc20=
2xx_new.o drivers/ide/pci/pdc202xx_new.c
  gcc -Wp,-MD,drivers/ide/pci/.piix.o.d -nostdinc -isystem /usr/lib/gcc-l=
ib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-p=
rototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding =
-Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-boun=
dary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-i3=
86/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dpiix -DKBUIL=
D_MODNAME=3Dpiix -c -o drivers/ide/pci/.tmp_piix.o drivers/ide/pci/piix.c=

  gcc -Wp,-MD,drivers/ide/pci/.rz1000.o.d -nostdinc -isystem /usr/lib/gcc=
-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict=
-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandin=
g -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bo=
undary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-=
i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Drz1000 -DK=
BUILD_MODNAME=3Drz1000 -c -o drivers/ide/pci/.tmp_rz1000.o drivers/ide/pc=
i/rz1000.c
  gcc -Wp,-MD,drivers/ide/pci/.serverworks.o.d -nostdinc -isystem /usr/li=
b/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Ws=
trict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreest=
anding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-sta=
ck-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude=
/asm-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dserve=
rworks -DKBUILD_MODNAME=3Dserverworks -c -o drivers/ide/pci/.tmp_serverwo=
rks.o drivers/ide/pci/serverworks.c
  gcc -Wp,-MD,drivers/ide/pci/.siimage.o.d -nostdinc -isystem /usr/lib/gc=
c-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstric=
t-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandi=
ng -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-b=
oundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm=
-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dsiimage -=
DKBUILD_MODNAME=3Dsiimage -c -o drivers/ide/pci/.tmp_siimage.o drivers/id=
e/pci/siimage.c
  gcc -Wp,-MD,drivers/ide/pci/.sis5513.o.d -nostdinc -isystem /usr/lib/gc=
c-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstric=
t-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandi=
ng -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-b=
oundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm=
-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dsis5513 -=
DKBUILD_MODNAME=3Dsis5513 -c -o drivers/ide/pci/.tmp_sis5513.o drivers/id=
e/pci/sis5513.c
  gcc -Wp,-MD,drivers/ide/pci/.slc90e66.o.d -nostdinc -isystem /usr/lib/g=
cc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstri=
ct-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestand=
ing -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-=
boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/as=
m-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dslc90e66=
 -DKBUILD_MODNAME=3Dslc90e66 -c -o drivers/ide/pci/.tmp_slc90e66.o driver=
s/ide/pci/slc90e66.c
  gcc -Wp,-MD,drivers/ide/pci/.triflex.o.d -nostdinc -isystem /usr/lib/gc=
c-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstric=
t-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandi=
ng -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-b=
oundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm=
-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dtriflex -=
DKBUILD_MODNAME=3Dtriflex -c -o drivers/ide/pci/.tmp_triflex.o drivers/id=
e/pci/triflex.c
  gcc -Wp,-MD,drivers/ide/pci/.trm290.o.d -nostdinc -isystem /usr/lib/gcc=
-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict=
-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandin=
g -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bo=
undary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-=
i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dtrm290 -DK=
BUILD_MODNAME=3Dtrm290 -c -o drivers/ide/pci/.tmp_trm290.o drivers/ide/pc=
i/trm290.c
  gcc -Wp,-MD,drivers/ide/pci/.via82cxxx.o.d -nostdinc -isystem /usr/lib/=
gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstr=
ict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestan=
ding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack=
-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/a=
sm-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dvia82cx=
xx -DKBUILD_MODNAME=3Dvia82cxxx -c -o drivers/ide/pci/.tmp_via82cxxx.o dr=
ivers/ide/pci/via82cxxx.c
  gcc -Wp,-MD,drivers/ide/pci/.generic.o.d -nostdinc -isystem /usr/lib/gc=
c-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstric=
t-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandi=
ng -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-b=
oundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm=
-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dgeneric -=
DKBUILD_MODNAME=3Dgeneric -c -o drivers/ide/pci/.tmp_generic.o drivers/id=
e/pci/generic.c
   ld -m elf_i386  -r -o drivers/ide/built-in.o drivers/ide/legacy/built-=
in.o
  gcc -Wp,-MD,drivers/ide/.ide.o.d -nostdinc -isystem /usr/lib/gcc-lib/i5=
86-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-protot=
ypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -Os  =
   -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-boundary=3D=
2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-i386/mach=
-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dide -DKBUILD_MODNAM=
E=3Dide_core -c -o drivers/ide/.tmp_ide.o drivers/ide/ide.c
  gcc -Wp,-MD,drivers/ide/.ide-default.o.d -nostdinc -isystem /usr/lib/gc=
c-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstric=
t-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandi=
ng -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-b=
oundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm=
-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dide_defau=
lt -DKBUILD_MODNAME=3Dide_core -c -o drivers/ide/.tmp_ide-default.o drive=
rs/ide/ide-default.c
  gcc -Wp,-MD,drivers/ide/.ide-io.o.d -nostdinc -isystem /usr/lib/gcc-lib=
/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-pro=
totypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -O=
s     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bounda=
ry=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-i386=
/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dide_io -DKBUIL=
D_MODNAME=3Dide_core -c -o drivers/ide/.tmp_ide-io.o drivers/ide/ide-io.c=

  gcc -Wp,-MD,drivers/ide/.ide-iops.o.d -nostdinc -isystem /usr/lib/gcc-l=
ib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-p=
rototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding =
-Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-boun=
dary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-i3=
86/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dide_iops -DK=
BUILD_MODNAME=3Dide_core -c -o drivers/ide/.tmp_ide-iops.o drivers/ide/id=
e-iops.c
  gcc -Wp,-MD,drivers/ide/.ide-lib.o.d -nostdinc -isystem /usr/lib/gcc-li=
b/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-pr=
ototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -=
Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bound=
ary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-i38=
6/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dide_lib -DKBU=
ILD_MODNAME=3Dide_core -c -o drivers/ide/.tmp_ide-lib.o drivers/ide/ide-l=
ib.c
  gcc -Wp,-MD,drivers/ide/.ide-probe.o.d -nostdinc -isystem /usr/lib/gcc-=
lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-=
prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding=
 -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bou=
ndary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-i=
386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dide_probe -=
DKBUILD_MODNAME=3Dide_core -c -o drivers/ide/.tmp_ide-probe.o drivers/ide=
/ide-probe.c
  gcc -Wp,-MD,drivers/ide/.ide-taskfile.o.d -nostdinc -isystem /usr/lib/g=
cc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstri=
ct-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestand=
ing -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-=
boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/as=
m-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dide_task=
file -DKBUILD_MODNAME=3Dide_core -c -o drivers/ide/.tmp_ide-taskfile.o dr=
ivers/ide/ide-taskfile.c
  gcc -Wp,-MD,drivers/ide/pci/.cmd640.o.d -nostdinc -isystem /usr/lib/gcc=
-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict=
-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandin=
g -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bo=
undary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-=
i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dcmd640 -DK=
BUILD_MODNAME=3Dide_core -c -o drivers/ide/pci/.tmp_cmd640.o drivers/ide/=
pci/cmd640.c
  gcc -Wp,-MD,drivers/ide/.setup-pci.o.d -nostdinc -isystem /usr/lib/gcc-=
lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-=
prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding=
 -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bou=
ndary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-i=
386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dsetup_pci -=
DKBUILD_MODNAME=3Dide_core -c -o drivers/ide/.tmp_setup-pci.o drivers/ide=
/setup-pci.c
  gcc -Wp,-MD,drivers/ide/.ide-dma.o.d -nostdinc -isystem /usr/lib/gcc-li=
b/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-pr=
ototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -=
Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bound=
ary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-i38=
6/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dide_dma -DKBU=
ILD_MODNAME=3Dide_core -c -o drivers/ide/.tmp_ide-dma.o drivers/ide/ide-d=
ma.c
  gcc -Wp,-MD,drivers/ide/.ide-proc.o.d -nostdinc -isystem /usr/lib/gcc-l=
ib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-p=
rototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding =
-Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-boun=
dary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-i3=
86/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dide_proc -DK=
BUILD_MODNAME=3Dide_core -c -o drivers/ide/.tmp_ide-proc.o drivers/ide/id=
e-proc.c
  gcc -Wp,-MD,drivers/ide/.ide-pnp.o.d -nostdinc -isystem /usr/lib/gcc-li=
b/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-pr=
ototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -=
Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bound=
ary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-i38=
6/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dide_pnp -DKBU=
ILD_MODNAME=3Dide_core -c -o drivers/ide/.tmp_ide-pnp.o drivers/ide/ide-p=
np.c
  ld -m elf_i386  -r -o drivers/ide/ide-core.o drivers/ide/ide.o drivers/=
ide/ide-default.o drivers/ide/ide-io.o drivers/ide/ide-iops.o drivers/ide=
/ide-lib.o drivers/ide/ide-probe.o drivers/ide/ide-taskfile.o drivers/ide=
/pci/cmd640.o drivers/ide/setup-pci.o drivers/ide/ide-dma.o drivers/ide/i=
de-proc.o drivers/ide/ide-pnp.o
  gcc -Wp,-MD,drivers/ide/.ide-generic.o.d -nostdinc -isystem /usr/lib/gc=
c-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstric=
t-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandi=
ng -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-b=
oundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm=
-i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dide_gener=
ic -DKBUILD_MODNAME=3Dide_generic -c -o drivers/ide/.tmp_ide-generic.o dr=
ivers/ide/ide-generic.c
  gcc -Wp,-MD,drivers/ide/.ide-disk.o.d -nostdinc -isystem /usr/lib/gcc-l=
ib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-p=
rototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding =
-Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-boun=
dary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-i3=
86/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dide_disk -DK=
BUILD_MODNAME=3Dide_disk -c -o drivers/ide/.tmp_ide-disk.o drivers/ide/id=
e-disk.c
  gcc -Wp,-MD,drivers/ide/.ide-cd.o.d -nostdinc -isystem /usr/lib/gcc-lib=
/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-pro=
totypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -O=
s     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bounda=
ry=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-i386=
/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dide_cd -DKBUIL=
D_MODNAME=3Dide_cd -c -o drivers/ide/.tmp_ide-cd.o drivers/ide/ide-cd.c
  gcc -Wp,-MD,drivers/ide/.ide-tape.o.d -nostdinc -isystem /usr/lib/gcc-l=
ib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-p=
rototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding =
-Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-boun=
dary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-i3=
86/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dide_tape -DK=
BUILD_MODNAME=3Dide_tape -c -o drivers/ide/.tmp_ide-tape.o drivers/ide/id=
e-tape.c
  gcc -Wp,-MD,drivers/ide/.ide-floppy.o.d -nostdinc -isystem /usr/lib/gcc=
-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict=
-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandin=
g -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bo=
undary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-=
i386/mach-default  -Idrivers/ide  -DMODULE -DKBUILD_BASENAME=3Dide_floppy=
 -DKBUILD_MODNAME=3Dide_floppy -c -o drivers/ide/.tmp_ide-floppy.o driver=
s/ide/ide-floppy.c
  Building modules, stage 2.
make -rR -f /mnt/box/linux-2611-rc1-bk3/scripts/Makefile.modpost
  scripts/mod/modpost -m -a -i /mnt/box/linux-2611-rc1-bk3/Module.symvers=
 vmlinux drivers/ide/ide-cd.o drivers/ide/ide-core.o drivers/ide/ide-disk=
=2Eo drivers/ide/ide-floppy.o drivers/ide/ide-generic.o drivers/ide/ide-t=
ape.o drivers/ide/legacy/ali14xx.o drivers/ide/legacy/dtc2278.o drivers/i=
de/legacy/ht6560b.o drivers/ide/legacy/ide-cs.o drivers/ide/legacy/qd65xx=
=2Eo drivers/ide/legacy/umc8672.o drivers/ide/pci/aec62xx.o drivers/ide/p=
ci/alim15x3.o drivers/ide/pci/amd74xx.o drivers/ide/pci/atiixp.o drivers/=
ide/pci/cmd64x.o drivers/ide/pci/cs5520.o drivers/ide/pci/cs5530.o driver=
s/ide/pci/cy82c693.o drivers/ide/pci/generic.o drivers/ide/pci/hpt34x.o d=
rivers/ide/pci/hpt366.o drivers/ide/pci/ns87415.o drivers/ide/pci/opti621=
=2Eo drivers/ide/pci/pdc202xx_new.o drivers/ide/pci/pdc202xx_old.o driver=
s/ide/pci/piix.o drivers/ide/pci/rz1000.o drivers/ide/pci/sc1200.o driver=
s/ide/pci/serverworks.o drivers/ide/pci/siimage.o drivers/ide/pci/sis5513=
=2Eo drivers/ide/pci/slc90e66.o drivers/ide/pci/triflex.o drivers/ide/pci=
/trm290.o drivers/ide/pci/via82cxxx.o
  gcc -Wp,-MD,drivers/ide/.ide-cd.mod.o.d -nostdinc -isystem /usr/lib/gcc=
-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstrict=
-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestandin=
g -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-bo=
undary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/asm-=
i386/mach-default     -DKBUILD_BASENAME=3Dide_cd -DKBUILD_MODNAME=3Dide_c=
d -DMODULE -c -o drivers/ide/ide-cd.mod.o drivers/ide/ide-cd.mod.c
  ld -m elf_i386 -r -o drivers/ide/ide-cd.ko drivers/ide/ide-cd.o drivers=
/ide/ide-cd.mod.o
  gcc -Wp,-MD,drivers/ide/.ide-core.mod.o.d -nostdinc -isystem /usr/lib/g=
cc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstri=
ct-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestand=
ing -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-=
boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/as=
m-i386/mach-default     -DKBUILD_BASENAME=3Dide_core -DKBUILD_MODNAME=3Di=
de_core -DMODULE -c -o drivers/ide/ide-core.mod.o drivers/ide/ide-core.mo=
d.c
  ld -m elf_i386 -r -o drivers/ide/ide-core.ko drivers/ide/ide-core.o dri=
vers/ide/ide-core.mod.o
  gcc -Wp,-MD,drivers/ide/.ide-disk.mod.o.d -nostdinc -isystem /usr/lib/g=
cc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstri=
ct-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestand=
ing -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-=
boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/as=
m-i386/mach-default     -DKBUILD_BASENAME=3Dide_disk -DKBUILD_MODNAME=3Di=
de_disk -DMODULE -c -o drivers/ide/ide-disk.mod.o drivers/ide/ide-disk.mo=
d.c
  ld -m elf_i386 -r -o drivers/ide/ide-disk.ko drivers/ide/ide-disk.o dri=
vers/ide/ide-disk.mod.o
  gcc -Wp,-MD,drivers/ide/.ide-floppy.mod.o.d -nostdinc -isystem /usr/lib=
/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wst=
rict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreesta=
nding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stac=
k-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/=
asm-i386/mach-default     -DKBUILD_BASENAME=3Dide_floppy -DKBUILD_MODNAME=
=3Dide_floppy -DMODULE -c -o drivers/ide/ide-floppy.mod.o drivers/ide/ide=
-floppy.mod.c
  ld -m elf_i386 -r -o drivers/ide/ide-floppy.ko drivers/ide/ide-floppy.o=
 drivers/ide/ide-floppy.mod.o
  gcc -Wp,-MD,drivers/ide/.ide-generic.mod.o.d -nostdinc -isystem /usr/li=
b/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Ws=
trict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreest=
anding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-sta=
ck-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude=
/asm-i386/mach-default     -DKBUILD_BASENAME=3Dide_generic -DKBUILD_MODNA=
ME=3Dide_generic -DMODULE -c -o drivers/ide/ide-generic.mod.o drivers/ide=
/ide-generic.mod.c
  ld -m elf_i386 -r -o drivers/ide/ide-generic.ko drivers/ide/ide-generic=
=2Eo drivers/ide/ide-generic.mod.o
  gcc -Wp,-MD,drivers/ide/.ide-tape.mod.o.d -nostdinc -isystem /usr/lib/g=
cc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstri=
ct-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestand=
ing -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-=
boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/as=
m-i386/mach-default     -DKBUILD_BASENAME=3Dide_tape -DKBUILD_MODNAME=3Di=
de_tape -DMODULE -c -o drivers/ide/ide-tape.mod.o drivers/ide/ide-tape.mo=
d.c
  ld -m elf_i386 -r -o drivers/ide/ide-tape.ko drivers/ide/ide-tape.o dri=
vers/ide/ide-tape.mod.o
  gcc -Wp,-MD,drivers/ide/legacy/.ali14xx.mod.o.d -nostdinc -isystem /usr=
/lib/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffre=
estanding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-=
stack-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iincl=
ude/asm-i386/mach-default     -DKBUILD_BASENAME=3Dali14xx -DKBUILD_MODNAM=
E=3Dali14xx -DMODULE -c -o drivers/ide/legacy/ali14xx.mod.o drivers/ide/l=
egacy/ali14xx.mod.c
  ld -m elf_i386 -r -o drivers/ide/legacy/ali14xx.ko drivers/ide/legacy/a=
li14xx.o drivers/ide/legacy/ali14xx.mod.o
  gcc -Wp,-MD,drivers/ide/legacy/.dtc2278.mod.o.d -nostdinc -isystem /usr=
/lib/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffre=
estanding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-=
stack-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iincl=
ude/asm-i386/mach-default     -DKBUILD_BASENAME=3Ddtc2278 -DKBUILD_MODNAM=
E=3Ddtc2278 -DMODULE -c -o drivers/ide/legacy/dtc2278.mod.o drivers/ide/l=
egacy/dtc2278.mod.c
  ld -m elf_i386 -r -o drivers/ide/legacy/dtc2278.ko drivers/ide/legacy/d=
tc2278.o drivers/ide/legacy/dtc2278.mod.o
  gcc -Wp,-MD,drivers/ide/legacy/.ht6560b.mod.o.d -nostdinc -isystem /usr=
/lib/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffre=
estanding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-=
stack-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iincl=
ude/asm-i386/mach-default     -DKBUILD_BASENAME=3Dht6560b -DKBUILD_MODNAM=
E=3Dht6560b -DMODULE -c -o drivers/ide/legacy/ht6560b.mod.o drivers/ide/l=
egacy/ht6560b.mod.c
  ld -m elf_i386 -r -o drivers/ide/legacy/ht6560b.ko drivers/ide/legacy/h=
t6560b.o drivers/ide/legacy/ht6560b.mod.o
  gcc -Wp,-MD,drivers/ide/legacy/.ide-cs.mod.o.d -nostdinc -isystem /usr/=
lib/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -=
Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffree=
standing -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-s=
tack-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclu=
de/asm-i386/mach-default     -DKBUILD_BASENAME=3Dide_cs -DKBUILD_MODNAME=3D=
ide_cs -DMODULE -c -o drivers/ide/legacy/ide-cs.mod.o drivers/ide/legacy/=
ide-cs.mod.c
  ld -m elf_i386 -r -o drivers/ide/legacy/ide-cs.ko drivers/ide/legacy/id=
e-cs.o drivers/ide/legacy/ide-cs.mod.o
  gcc -Wp,-MD,drivers/ide/legacy/.qd65xx.mod.o.d -nostdinc -isystem /usr/=
lib/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -=
Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffree=
standing -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-s=
tack-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclu=
de/asm-i386/mach-default     -DKBUILD_BASENAME=3Dqd65xx -DKBUILD_MODNAME=3D=
qd65xx -DMODULE -c -o drivers/ide/legacy/qd65xx.mod.o drivers/ide/legacy/=
qd65xx.mod.c
  ld -m elf_i386 -r -o drivers/ide/legacy/qd65xx.ko drivers/ide/legacy/qd=
65xx.o drivers/ide/legacy/qd65xx.mod.o
  gcc -Wp,-MD,drivers/ide/legacy/.umc8672.mod.o.d -nostdinc -isystem /usr=
/lib/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffre=
estanding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-=
stack-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iincl=
ude/asm-i386/mach-default     -DKBUILD_BASENAME=3Dumc8672 -DKBUILD_MODNAM=
E=3Dumc8672 -DMODULE -c -o drivers/ide/legacy/umc8672.mod.o drivers/ide/l=
egacy/umc8672.mod.c
  ld -m elf_i386 -r -o drivers/ide/legacy/umc8672.ko drivers/ide/legacy/u=
mc8672.o drivers/ide/legacy/umc8672.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.aec62xx.mod.o.d -nostdinc -isystem /usr/li=
b/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Ws=
trict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreest=
anding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-sta=
ck-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude=
/asm-i386/mach-default     -DKBUILD_BASENAME=3Daec62xx -DKBUILD_MODNAME=3D=
aec62xx -DMODULE -c -o drivers/ide/pci/aec62xx.mod.o drivers/ide/pci/aec6=
2xx.mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/aec62xx.ko drivers/ide/pci/aec62xx=
=2Eo drivers/ide/pci/aec62xx.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.alim15x3.mod.o.d -nostdinc -isystem /usr/l=
ib/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -W=
strict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffrees=
tanding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-st=
ack-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclud=
e/asm-i386/mach-default     -DKBUILD_BASENAME=3Dalim15x3 -DKBUILD_MODNAME=
=3Dalim15x3 -DMODULE -c -o drivers/ide/pci/alim15x3.mod.o drivers/ide/pci=
/alim15x3.mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/alim15x3.ko drivers/ide/pci/alim15=
x3.o drivers/ide/pci/alim15x3.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.amd74xx.mod.o.d -nostdinc -isystem /usr/li=
b/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Ws=
trict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreest=
anding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-sta=
ck-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude=
/asm-i386/mach-default     -DKBUILD_BASENAME=3Damd74xx -DKBUILD_MODNAME=3D=
amd74xx -DMODULE -c -o drivers/ide/pci/amd74xx.mod.o drivers/ide/pci/amd7=
4xx.mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/amd74xx.ko drivers/ide/pci/amd74xx=
=2Eo drivers/ide/pci/amd74xx.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.atiixp.mod.o.d -nostdinc -isystem /usr/lib=
/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wst=
rict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreesta=
nding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stac=
k-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/=
asm-i386/mach-default     -DKBUILD_BASENAME=3Datiixp -DKBUILD_MODNAME=3Da=
tiixp -DMODULE -c -o drivers/ide/pci/atiixp.mod.o drivers/ide/pci/atiixp.=
mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/atiixp.ko drivers/ide/pci/atiixp.o=
 drivers/ide/pci/atiixp.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.cmd64x.mod.o.d -nostdinc -isystem /usr/lib=
/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wst=
rict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreesta=
nding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stac=
k-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/=
asm-i386/mach-default     -DKBUILD_BASENAME=3Dcmd64x -DKBUILD_MODNAME=3Dc=
md64x -DMODULE -c -o drivers/ide/pci/cmd64x.mod.o drivers/ide/pci/cmd64x.=
mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/cmd64x.ko drivers/ide/pci/cmd64x.o=
 drivers/ide/pci/cmd64x.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.cs5520.mod.o.d -nostdinc -isystem /usr/lib=
/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wst=
rict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreesta=
nding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stac=
k-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/=
asm-i386/mach-default     -DKBUILD_BASENAME=3Dcs5520 -DKBUILD_MODNAME=3Dc=
s5520 -DMODULE -c -o drivers/ide/pci/cs5520.mod.o drivers/ide/pci/cs5520.=
mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/cs5520.ko drivers/ide/pci/cs5520.o=
 drivers/ide/pci/cs5520.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.cs5530.mod.o.d -nostdinc -isystem /usr/lib=
/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wst=
rict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreesta=
nding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stac=
k-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/=
asm-i386/mach-default     -DKBUILD_BASENAME=3Dcs5530 -DKBUILD_MODNAME=3Dc=
s5530 -DMODULE -c -o drivers/ide/pci/cs5530.mod.o drivers/ide/pci/cs5530.=
mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/cs5530.ko drivers/ide/pci/cs5530.o=
 drivers/ide/pci/cs5530.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.cy82c693.mod.o.d -nostdinc -isystem /usr/l=
ib/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -W=
strict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffrees=
tanding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-st=
ack-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclud=
e/asm-i386/mach-default     -DKBUILD_BASENAME=3Dcy82c693 -DKBUILD_MODNAME=
=3Dcy82c693 -DMODULE -c -o drivers/ide/pci/cy82c693.mod.o drivers/ide/pci=
/cy82c693.mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/cy82c693.ko drivers/ide/pci/cy82c6=
93.o drivers/ide/pci/cy82c693.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.generic.mod.o.d -nostdinc -isystem /usr/li=
b/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Ws=
trict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreest=
anding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-sta=
ck-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude=
/asm-i386/mach-default     -DKBUILD_BASENAME=3Dgeneric -DKBUILD_MODNAME=3D=
generic -DMODULE -c -o drivers/ide/pci/generic.mod.o drivers/ide/pci/gene=
ric.mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/generic.ko drivers/ide/pci/generic=
=2Eo drivers/ide/pci/generic.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.hpt34x.mod.o.d -nostdinc -isystem /usr/lib=
/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wst=
rict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreesta=
nding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stac=
k-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/=
asm-i386/mach-default     -DKBUILD_BASENAME=3Dhpt34x -DKBUILD_MODNAME=3Dh=
pt34x -DMODULE -c -o drivers/ide/pci/hpt34x.mod.o drivers/ide/pci/hpt34x.=
mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/hpt34x.ko drivers/ide/pci/hpt34x.o=
 drivers/ide/pci/hpt34x.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.hpt366.mod.o.d -nostdinc -isystem /usr/lib=
/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wst=
rict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreesta=
nding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stac=
k-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/=
asm-i386/mach-default     -DKBUILD_BASENAME=3Dhpt366 -DKBUILD_MODNAME=3Dh=
pt366 -DMODULE -c -o drivers/ide/pci/hpt366.mod.o drivers/ide/pci/hpt366.=
mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/hpt366.ko drivers/ide/pci/hpt366.o=
 drivers/ide/pci/hpt366.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.ns87415.mod.o.d -nostdinc -isystem /usr/li=
b/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Ws=
trict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreest=
anding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-sta=
ck-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude=
/asm-i386/mach-default     -DKBUILD_BASENAME=3Dns87415 -DKBUILD_MODNAME=3D=
ns87415 -DMODULE -c -o drivers/ide/pci/ns87415.mod.o drivers/ide/pci/ns87=
415.mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/ns87415.ko drivers/ide/pci/ns87415=
=2Eo drivers/ide/pci/ns87415.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.opti621.mod.o.d -nostdinc -isystem /usr/li=
b/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Ws=
trict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreest=
anding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-sta=
ck-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude=
/asm-i386/mach-default     -DKBUILD_BASENAME=3Dopti621 -DKBUILD_MODNAME=3D=
opti621 -DMODULE -c -o drivers/ide/pci/opti621.mod.o drivers/ide/pci/opti=
621.mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/opti621.ko drivers/ide/pci/opti621=
=2Eo drivers/ide/pci/opti621.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.pdc202xx_new.mod.o.d -nostdinc -isystem /u=
sr/lib/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wal=
l -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ff=
reestanding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferre=
d-stack-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iin=
clude/asm-i386/mach-default     -DKBUILD_BASENAME=3Dpdc202xx_new -DKBUILD=
_MODNAME=3Dpdc202xx_new -DMODULE -c -o drivers/ide/pci/pdc202xx_new.mod.o=
 drivers/ide/pci/pdc202xx_new.mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/pdc202xx_new.ko drivers/ide/pci/pd=
c202xx_new.o drivers/ide/pci/pdc202xx_new.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.pdc202xx_old.mod.o.d -nostdinc -isystem /u=
sr/lib/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wal=
l -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ff=
reestanding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferre=
d-stack-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iin=
clude/asm-i386/mach-default     -DKBUILD_BASENAME=3Dpdc202xx_old -DKBUILD=
_MODNAME=3Dpdc202xx_old -DMODULE -c -o drivers/ide/pci/pdc202xx_old.mod.o=
 drivers/ide/pci/pdc202xx_old.mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/pdc202xx_old.ko drivers/ide/pci/pd=
c202xx_old.o drivers/ide/pci/pdc202xx_old.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.piix.mod.o.d -nostdinc -isystem /usr/lib/g=
cc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wstri=
ct-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestand=
ing -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stack-=
boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/as=
m-i386/mach-default     -DKBUILD_BASENAME=3Dpiix -DKBUILD_MODNAME=3Dpiix =
-DMODULE -c -o drivers/ide/pci/piix.mod.o drivers/ide/pci/piix.mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/piix.ko drivers/ide/pci/piix.o dri=
vers/ide/pci/piix.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.rz1000.mod.o.d -nostdinc -isystem /usr/lib=
/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wst=
rict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreesta=
nding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stac=
k-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/=
asm-i386/mach-default     -DKBUILD_BASENAME=3Drz1000 -DKBUILD_MODNAME=3Dr=
z1000 -DMODULE -c -o drivers/ide/pci/rz1000.mod.o drivers/ide/pci/rz1000.=
mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/rz1000.ko drivers/ide/pci/rz1000.o=
 drivers/ide/pci/rz1000.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.sc1200.mod.o.d -nostdinc -isystem /usr/lib=
/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wst=
rict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreesta=
nding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stac=
k-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/=
asm-i386/mach-default     -DKBUILD_BASENAME=3Dsc1200 -DKBUILD_MODNAME=3Ds=
c1200 -DMODULE -c -o drivers/ide/pci/sc1200.mod.o drivers/ide/pci/sc1200.=
mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/sc1200.ko drivers/ide/pci/sc1200.o=
 drivers/ide/pci/sc1200.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.serverworks.mod.o.d -nostdinc -isystem /us=
r/lib/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall=
 -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffr=
eestanding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred=
-stack-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinc=
lude/asm-i386/mach-default     -DKBUILD_BASENAME=3Dserverworks -DKBUILD_M=
ODNAME=3Dserverworks -DMODULE -c -o drivers/ide/pci/serverworks.mod.o dri=
vers/ide/pci/serverworks.mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/serverworks.ko drivers/ide/pci/ser=
verworks.o drivers/ide/pci/serverworks.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.siimage.mod.o.d -nostdinc -isystem /usr/li=
b/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Ws=
trict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreest=
anding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-sta=
ck-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude=
/asm-i386/mach-default     -DKBUILD_BASENAME=3Dsiimage -DKBUILD_MODNAME=3D=
siimage -DMODULE -c -o drivers/ide/pci/siimage.mod.o drivers/ide/pci/siim=
age.mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/siimage.ko drivers/ide/pci/siimage=
=2Eo drivers/ide/pci/siimage.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.sis5513.mod.o.d -nostdinc -isystem /usr/li=
b/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Ws=
trict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreest=
anding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-sta=
ck-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude=
/asm-i386/mach-default     -DKBUILD_BASENAME=3Dsis5513 -DKBUILD_MODNAME=3D=
sis5513 -DMODULE -c -o drivers/ide/pci/sis5513.mod.o drivers/ide/pci/sis5=
513.mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/sis5513.ko drivers/ide/pci/sis5513=
=2Eo drivers/ide/pci/sis5513.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.slc90e66.mod.o.d -nostdinc -isystem /usr/l=
ib/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -W=
strict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffrees=
tanding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-st=
ack-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclud=
e/asm-i386/mach-default     -DKBUILD_BASENAME=3Dslc90e66 -DKBUILD_MODNAME=
=3Dslc90e66 -DMODULE -c -o drivers/ide/pci/slc90e66.mod.o drivers/ide/pci=
/slc90e66.mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/slc90e66.ko drivers/ide/pci/slc90e=
66.o drivers/ide/pci/slc90e66.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.triflex.mod.o.d -nostdinc -isystem /usr/li=
b/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Ws=
trict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreest=
anding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-sta=
ck-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude=
/asm-i386/mach-default     -DKBUILD_BASENAME=3Dtriflex -DKBUILD_MODNAME=3D=
triflex -DMODULE -c -o drivers/ide/pci/triflex.mod.o drivers/ide/pci/trif=
lex.mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/triflex.ko drivers/ide/pci/triflex=
=2Eo drivers/ide/pci/triflex.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.trm290.mod.o.d -nostdinc -isystem /usr/lib=
/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -Wst=
rict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreesta=
nding -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-stac=
k-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclude/=
asm-i386/mach-default     -DKBUILD_BASENAME=3Dtrm290 -DKBUILD_MODNAME=3Dt=
rm290 -DMODULE -c -o drivers/ide/pci/trm290.mod.o drivers/ide/pci/trm290.=
mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/trm290.ko drivers/ide/pci/trm290.o=
 drivers/ide/pci/trm290.mod.o
  gcc -Wp,-MD,drivers/ide/pci/.via82cxxx.mod.o.d -nostdinc -isystem /usr/=
lib/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -Wall -=
Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffree=
standing -Os     -fno-omit-frame-pointer -pipe -msoft-float -mpreferred-s=
tack-boundary=3D2 -fno-unit-at-a-time -march=3Di686 -mregparm=3D3 -Iinclu=
de/asm-i386/mach-default     -DKBUILD_BASENAME=3Dvia82cxxx -DKBUILD_MODNA=
ME=3Dvia82cxxx -DMODULE -c -o drivers/ide/pci/via82cxxx.mod.o drivers/ide=
/pci/via82cxxx.mod.c
  ld -m elf_i386 -r -o drivers/ide/pci/via82cxxx.ko drivers/ide/pci/via82=
cxxx.o drivers/ide/pci/via82cxxx.mod.o

--------------000502060909000103060708--
