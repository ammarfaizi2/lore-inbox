Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317142AbSHAV6r>; Thu, 1 Aug 2002 17:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317182AbSHAV6r>; Thu, 1 Aug 2002 17:58:47 -0400
Received: from [195.63.194.11] ([195.63.194.11]:3342 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S317142AbSHAV6q>;
	Thu, 1 Aug 2002 17:58:46 -0400
Message-ID: <3D49AEB7.9060900@evision.ag>
Date: Thu, 01 Aug 2002 23:57:11 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: martin@dalecki.de, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] 2.5.29 IDE 110
References: <CDEF453FCB@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Petr Vandrovec napisa?:
> On  1 Aug 02 at 23:16, Marcin Dalecki wrote:
> 
>>Lets not forgett that the code removed would allow to read behind the
>>partion in question and was broken therefore. However the real world
>>example from Petr worries me and makes me thinking that the partition
>>scanning time solution could turn out to be most adequate -> we have the
>>FAT partition ID there at hand and could adjust the partition
>>parameters in question properly with ease. Both of them: offset *and* size.
>>
>>Petr would you mind dumping the dd=/dev/hdx count=10 of the
>>disk in question at me? Or do you preferr to go after this blotch
>>yourself?
> 
> 
> First sector contains valid partition table, but all partitions are
> set to type 0x55, EZDrive. AFAIK EZDrive synchronizes this inivisble
> partition with one from sector 2 on each reboot. Second sector contains 
> 'real' partition table, with types set to Linux, Linux swap, VFAT and
> so on. I do not have extended partition on the drive, so I do not know
> whether this record will have 0x55 or correct type in the sector 1.
> 
> Problem only occurs when you'll run LILO (if you have installed it
> in /dev/hdx instead of in /dev/hdx#), or install-mbr - it will overwrite
> ezdrive, and you have to find diskette and reinstall EZDrive to make
> disk bootable in this obsolete system (btw, it is PentiumII).
> 
> So only problem is that we do not have special /dev/hdx-mbr device
> for accessing MBR, all code expects that it is in first sector of the 
> /dev/hdx, while with 0_to_1 remap it is in second one.
>                                             Petr Vandrovec

Thank you for saving me a bit of time. I was right now scanning Phoenix
site for the precise docu. Now I don'thave too. Well all the above
sounds like a defficiency in:

1. LILO.

2. fdisk.

3. Partition scanning code which should look at both sectors.

Hmm...

2. Isn't that critical becouse it only affects disk creation time.

3. Can be fixed easy at the proper place. Namely parition/xxx.cc

1. Is actually interresting for installing a new kernel
and the most mind boggling offender.

