Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSGAL2I>; Mon, 1 Jul 2002 07:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315479AbSGAL2H>; Mon, 1 Jul 2002 07:28:07 -0400
Received: from [62.70.58.70] ([62.70.58.70]:55174 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S315472AbSGAL2G> convert rfc822-to-8bit;
	Mon, 1 Jul 2002 07:28:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Subject: Re: Can't boot from /dev/md0 (RAID-1)
Date: Mon, 1 Jul 2002 13:30:18 +0200
User-Agent: KMail/1.4.1
Cc: linux-raid@vger.rutgers.edu,
       Kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206301152150.1582-100000@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.44.0206301152150.1582-100000@twinlark.arctic.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207011330.18973.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

trying this:
--
boot=/dev/md0
map=/boot/map
install=/boot/boot.b.hda
backup=/boot/boot.b.rs.hda
prompt
timeout=50
lba32
raid-extra-boot=/dev/hda,/dev/hdb
...

with lilo-21.4-4 (standard with rh73) it won't accept the raid-extra-boot 
option

and

with lilo-22.3.1, it won't accept (i beleive boot=/dev/md0)

[root@jumbo lilo-22.3.1]# lilo
Warning: using BIOS device code 0x80 for RAID boot blocks
Fatal: Filesystem would be destroyed by LILO boot sector: /dev/md0

thanks 

roy

On Sunday 30 June 2002 20:57, dean gaudet wrote:
> my system has 4 disks, but /dev/md0 is a RAID1 for /boot.  (/dev/md1 is a
> RAID5 and LVM is on top of it...)  anyhow, this is what works for me.
> i've even pulled out a disk and it still boots.
>
> btw, you really don't want to put two drives on an IDE controller.  not
> just for performance reasons -- if a master drive fails it can easily
> prevent access to the slave... so you'll have a two disk failure on your
> hands.  or maybe this is just urban legend and i'm spreading it further ;)
>
> -dean
>
> lba32
> boot=/dev/md0
> root=/dev/arctic/root
> install=/boot/boot-text.b
> map=/boot/map
> prompt
> timeout=150
> raid-extra-boot=/dev/hde,/dev/hdg,/dev/hdi,/dev/hdk
>
> password=XXXXXXXX
>
> serial=0,38400n8
> append="console=tty0 console=ttyS0,38400n8"
>
> default=linux
>
> image=/boot/vmlinuz
>         initrd=/boot/initrd-lvm-2.4.19-pre3-ac1.gz
>         label=linux
>         restricted
>         read-only
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

