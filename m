Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315783AbSGAQNH>; Mon, 1 Jul 2002 12:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315779AbSGAQNG>; Mon, 1 Jul 2002 12:13:06 -0400
Received: from [62.70.58.70] ([62.70.58.70]:14471 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S315762AbSGAQNE> convert rfc822-to-8bit;
	Mon, 1 Jul 2002 12:13:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: lilo/raid?
Date: Mon, 1 Jul 2002 18:15:36 +0200
User-Agent: KMail/1.4.1
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200207011604.58253.roy@karlsbakk.net> <20020701155910.GA21471@win.tue.nl>
In-Reply-To: <20020701155910.GA21471@win.tue.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207011815.36602.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, it looks like (1) you can use the -F flag and lilo will go ahead
> anyway, (2) lilo thinks it recognizes XFS or NTFS or swap space on the boot
> sector of your device.

Thanks
I added some debug output in part_nowrite(), and - you're right - it thinks 
it's NTFS. More info below

fstab:
LABEL=/                 /                       ext3    defaults        1 1
/dev/md2                /tmp                    ext3    defaults        1 2
/dev/md3                /var                    jfs     defaults        1 2
/dev/md4                /data                   jfs     defaults        1 2
/dev/md1                swap                    swap    defaults        0 0
none                    /dev/pts                devpts  gid=5,mode=620  0 0
none                    /proc                   proc    defaults        0 0
none                    /dev/shm                tmpfs   defaults        0 0
/dev/fd0                /mnt/floppy             auto    noauto,owner,kudzu 0 0

/proc/partitions:
   9     0    4096448 md0 0 0 0 0 0 0 0 0 0 0 0
   9     1    2048128 md1 0 0 0 0 0 0 0 0 0 0 0
   9     2    2048192 md2 0 0 0 0 0 0 0 0 0 0 0
   9     3   40958720 md3 0 0 0 0 0 0 0 0 0 0 0
   9     4 1631383040 md4 0 0 0 0 0 0 0 0 0 0 0
  89     0  120627360 hdo 52 144 632 400 524 106 4368 130 -2 534050 41882082
  89     1    4095976 hdo1 40 35 360 230 517 6 4136 80 0 260 310
  89     2  116531352 hdo2 11 106 264 160 7 100 232 50 0 110 210
  89    64  120627360 hdp 7 3 56 100 2 0 16 0 -2 534050 41881682
  89    65    4095976 hdp1 3 0 24 40 1 0 8 0 0 40 40
  89    66  116531352 hdp2 3 0 24 50 1 0 8 0 0 50 50
  88     0  120627360 hdm 23 10 192 230 259 0 2072 80 -2 534060 41881822
  88     1    4096543 hdm1 16 0 128 160 257 0 2056 80 0 220 240
  88     2  116527477 hdm2 6 7 56 60 2 0 16 0 0 60 60
  88    64  120627360 hdn 22 10 184 140 13 0 104 10 -2 534070 41881682
  88    65    4096543 hdn1 18 7 152 110 12 0 96 10 0 120 120
  88    66  116527477 hdn2 3 0 24 30 1 0 8 0 0 30 30
  57     0  120627360 hdk 44 53 488 400 342 29 2824 180 -2 534070 41882072
  57     1    4095976 hdk1 36 31 392 330 341 29 2816 180 0 420 510
  57     2  116531352 hdk2 7 19 88 60 1 0 8 0 0 60 60
  57    64  120627360 hdl 25 159 488 260 177 155 1696 110 -2 534040 41881862
  57    65    4095976 hdl1 19 62 264 170 174 61 1496 90 0 240 260
  57    66  116531352 hdl2 5 94 216 90 3 94 200 20 0 80 110
  56     0  120627360 hdi 32 14 296 240 129 12 1080 70 -2 534080 41881772
  56     1    4095976 hdi1 28 11 264 200 128 12 1072 70 0 240 270
  56     2  116531352 hdi2 3 0 24 40 1 0 8 0 0 40 40
  56    64  120627360 hdj 39 68 424 270 324 62 2704 230 -2 534030 41881972
  56    65    4095976 hdj1 32 62 368 210 323 62 2696 230 0 350 440
  56    66  116531352 hdj2 6 3 48 50 1 0 8 0 0 50 50
  34     0  120627360 hdg 37 7 328 360 392 2 3152 130 -2 534110 41881922
  34     1    4095976 hdg1 32 4 288 300 390 2 3136 130 0 350 430
  34     2  116531352 hdg2 4 0 32 60 2 0 16 0 0 60 60
  34    64  120627360 hdh 26 5 224 260 330 2 2656 160 -2 534060 41881872
  34    65    4095976 hdh1 22 2 192 190 329 2 2648 160 0 300 350
  34    66  116531352 hdh2 3 0 24 60 1 0 8 0 0 60 60
  33     0  120627360 hde 36 33 312 400 15 7 128 30 -2 534130 41881842
  33     1    4095976 hde1 32 30 280 350 14 7 120 30 0 140 380
  33     2  116531352 hde2 3 0 24 40 1 0 8 0 0 40 40
  33    64  120627360 hdf 39 11 376 350 863 5 6944 480 -2 534090 41882252
  33    65    4095976 hdf1 35 8 344 280 862 5 6936 480 0 630 760
  33    66  116531352 hdf2 3 0 24 60 1 0 8 0 0 60 60
  22     0  120627360 hdc 20 12 154 100 20 27 360 10 -2 534140 41881502
  22     1    2048224 hdc1 4 0 32 0 1 0 8 0 0 0 0
  22     2    2048256 hdc2 12 9 90 50 18 27 344 10 0 60 60
  22     3  116530848 hdc3 3 0 24 50 1 0 8 0 0 50 50
  22    64  120627360 hdd 22 68 264 150 20 27 360 10 -2 534140 41881552
  22    65    2048224 hdd1 5 0 40 20 1 0 8 0 0 20 20
  22    66    2048256 hdd2 13 65 192 70 18 27 344 10 0 80 80
  22    67  116530848 hdd3 3 0 24 50 1 0 8 0 0 50 50
   3     0  120627360 hda 972 1726 21338 3630 502 1142 13192 1210 -2 533970 
41886202
   3     1    4096543 hda1 953 1694 21170 3540 497 1136 13152 1210 0 3550 4750
   3     2  116527477 hda2 18 29 160 90 5 6 40 0 0 90 90
   3    64  120627360 hdb 844 1990 22648 3410 498 1136 13160 2740 -2 533950 
41887522
   3    65    4096543 hdb1 840 1987 22616 3350 497 1136 13152 2740 0 3340 6090
   3    66  116527477 hdb2 3 0 24 50 1 0 8 0 0 50 50


-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

