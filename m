Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318751AbSICKzf>; Tue, 3 Sep 2002 06:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318752AbSICKzf>; Tue, 3 Sep 2002 06:55:35 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:43979 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S318751AbSICKze>; Tue, 3 Sep 2002 06:55:34 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 3 Sep 2002 12:08:33 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.33: modular ide breaks lilo ...
Message-ID: <20020903100833.GA4371@bytesex.org>
References: <20020902162707.GA22182@bytesex.org> <20020902173748.GA9328@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020902173748.GA9328@win.tue.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 07:37:48PM +0200, Andries Brouwer wrote:
> On Mon, Sep 02, 2002 at 06:27:07PM +0200, Gerd Knorr wrote:
> 
> > I've tried building the ide driver modular and insmod it using an
> > initrd.  The kernel boots just fine, but lilo complains:
> > 
> > bogomips root ~# lilo
> > Device 0x0300: Invalid partition table, 2nd entry
> >   3D address:     1/0/262 (264096)
> >   Linear address: 1/10/4175 (4209030)
> 
> What LILO version?

22.1

> For many versions it will suffice to give LILO the linear or lba32 option.

There already is a lba32 option in lilo.conf ...

> > Disk /dev/hda: 16 heads, 63 sectors, 79780 cylinders
> > Units = cylinders of 1008 * 512 bytes

> > Disk /dev/hda: 255 heads, 63 sectors, 5005 cylinders
> > Units = cylinders of 16065 * 512 bytes
> 
> What fdisk version? Make sure you have a recent one.

2.11n

> Clearly, the rest of the fdisk output is a consequence of the different
> geometries. The kernel boot messages will probably tell what happened.

modular:
[ ... ]
hda: IBM-DTLA-305040, ATA DISK drive
[ ... ]
hda: host protected area => 1
hda: 80418240 sectors (41174 MB) w/380KiB Cache, CHS=79780/16/63, UDMA(33)
 hda: hda1 hda2 < hda5 hda6 hda7 > hda4
 hda4: <bsd: hda8 hda9 hda10 hda11 >
[ ... ]

builtin:
[ ... ]
hda: IBM-DTLA-305040, ATA DISK drive
[ ... ]
hda: host protected area => 1
hda: 80418240 sectors (41174 MB) w/380KiB Cache, CHS=5005/255/63, UDMA(33)
 hda: hda1 hda2 < hda5 hda6 hda7 > hda4
 hda4: <bsd: hda8 hda9 hda10 hda11 >
[ ... ]

The boot messages and the CHS geometry displayed by fdisk match ...

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
