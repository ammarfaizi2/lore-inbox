Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315438AbSGALuG>; Mon, 1 Jul 2002 07:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSGALuF>; Mon, 1 Jul 2002 07:50:05 -0400
Received: from unthought.net ([212.97.129.24]:43742 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S315438AbSGALuE>;
	Mon, 1 Jul 2002 07:50:04 -0400
Date: Mon, 1 Jul 2002 13:52:30 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       linux-raid@vger.rutgers.edu,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Can't boot from /dev/md0 (RAID-1)
Message-ID: <20020701115230.GD18580@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	dean gaudet <dean-list-linux-kernel@arctic.org>,
	linux-raid@vger.rutgers.edu,
	Kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206301152150.1582-100000@twinlark.arctic.org> <200207011330.18973.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200207011330.18973.roy@karlsbakk.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 01:30:18PM +0200, Roy Sigurd Karlsbakk wrote:
> hi
> 
> trying this:
> --
> boot=/dev/md0
> map=/boot/map
> install=/boot/boot.b.hda
> backup=/boot/boot.b.rs.hda
> prompt
> timeout=50
> lba32
> raid-extra-boot=/dev/hda,/dev/hdb
> ...
> 
> with lilo-21.4-4 (standard with rh73) it won't accept the raid-extra-boot 
> option

Ok - I use it with LILO 22.2 here, it's on Debian, and it's the only box
where I ever needed that option.

My lilo.conf:
----------8<--------
lba32
boot=/dev/md0
raid-extra-boot=/dev/sda,/dev/sdb
root=/dev/md1

disk=/dev/sda
 bios=0x80
disk=/dev/sdb
 bios=0x81

install=/boot/boot-menu.b

delay=20
default=Linux

image=/boot/vmlinuz
  label=Linux
  read-only
----------8<--------

The following is from a standard RedHat 7.3 system with LILO 21.4.4-14:

----------8<-----8<-----
boot=/dev/md3
map=/boot/map
install=/boot/boot.b
message=/boot/message
prompt
timeout=40
linear
default=2.4.18
image=/boot/vmlinuz-2.4.18
  label=2.4.18
  read-only
  root=/dev/md2
----------8<-----8<-----

Both systems are SCSI-only though.

The following is an IDE-only RedHat 7.2 with LILO 21.4.4.14

----8<-----8<------------
boot=/dev/md0
map=/boot/map
install=/boot/boot.b
prompt
timeout=50
message=/boot/message
linear
default=linux
image=/boot/vmlinuz
  label=linux
  read-only
  root=/dev/md1
----8<-----8<------------

Perhaps you could change the lba32 option into linear ?  I'm really
shooting in the mist here - LILO tends to "just work", and ignorance is
bliss   ;)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
