Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSDJTKJ>; Wed, 10 Apr 2002 15:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313544AbSDJTKI>; Wed, 10 Apr 2002 15:10:08 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:11959 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S313537AbSDJTKI>; Wed, 10 Apr 2002 15:10:08 -0400
Message-ID: <3CB48DF2.10900@antefacto.com>
Date: Wed, 10 Apr 2002 20:09:38 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Amol Kumar Lad <amolk@ishoni.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Reducing root filesystem
In-Reply-To: <7CFD7CA8510CD6118F950002A519EA3001067D06@leonoid.in.ishoni.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amol Kumar Lad wrote:
> Hi,
>   I am porting Linux to an embedded system. Currently my rootfilesystem is
> around 2.5 MB (after keeping it to minimal and adding tools like busybox). I
> want to furthur reduce it to say maximum of 1.5 MB. 
> Please suggest some link/references where I can find the details to optimise
> my root filesystem
> 
> thanks
> Amol
> 
> please CC me

Obviously it depends what logic you want in your root partition,
but without too much effort we've created the following minimal
system that can do web downloads and write flash cards, and is
generally very configurable with shell scripting etc.
Note we used dietlibc for our binary. Note also when we did
this buysbox was not compatible with dietlibc.

       5 /boot/message
      10 /etc/hosts.allow
      12 /etc/host.conf
      24 /lib/modules/2.4.16-9afo/modules.pnpbiosmap
      29 /lib/modules/2.4.16-9afo/modules.parportmap
      31 /lib/modules/2.4.16-9afo/modules.generic_string
      51 /bin/runlcdd
      73 /lib/modules/2.4.16-9afo/modules.ieee1394map
      81 /lib/modules/2.4.16-9afo/modules.isapnpmap
      81 /etc/sysconfig/network-scripts/ifcfg-eth1
      99 /lib/modules/2.4.16-9afo/modules.pcimap
     101 /etc/fstab
     103 /etc/passwd
     108 /etc/group
     120 /etc/issue
     125 /etc/sysconfig/network-scripts/ifcfg-lo
     127 /etc/hosts
     134 /etc/shells
     189 /lib/modules/2.4.16-9afo/modules.usbmap
     192 /etc/suauth
     238 /etc/nsswitch.conf
     281 /bin/rescue.ash
     396 /etc/inittab
     538 /etc/profile
     595 /etc/protocols
     976 /etc/init.d/rc
    6008 /boot/boot-text.b
   16406 /bin/afrescue
   20480 /boot/map
  102273 /lib/modules/e100.o
  674931 /boot/bzImage
  717992 /bin/busybox
--------
1542809
========

So to get this even smaller:

1. Get busybox working with dietlibc/uclibc (this probably already done)
2. use something like UPX to "transparently" compress executables.
3. use e2compr to transparently compress the whole filesystem
    (gzip/bzip2 available). dri@sxb.bsf.alcatel.fr has a patch for this.

Padraig.

