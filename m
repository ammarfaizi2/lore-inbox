Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262569AbRENXS5>; Mon, 14 May 2001 19:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262570AbRENXSs>; Mon, 14 May 2001 19:18:48 -0400
Received: from baltazar.tecnoera.com ([200.29.128.1]:42766 "EHLO
	baltazar.tecnoera.com") by vger.kernel.org with ESMTP
	id <S262569AbRENXSa>; Mon, 14 May 2001 19:18:30 -0400
Date: Mon, 14 May 2001 19:17:25 -0400 (CLT)
From: Juan Pablo Abuyeres <jpabuyer@tecnoera.com>
To: Josh Logan <josh@wcug.wwu.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec RAID SCSI 2100S
In-Reply-To: <Pine.BSO.4.21.0105141536430.10091-100000@sloth.wcug.wwu.edu>
Message-ID: <Pine.LNX.4.33.0105141912590.11610-100000@baltazar.tecnoera.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before merging both hard disks I saw each of them as a separate SCSI
device, at boot time and when the system booted up. After building the
RAID1, when the system boots I only see one RAID device recognized, and so
do I when linux recognizes it.

[root@lala log]# cat /proc/scsi/dpt_i2o/0
Vendor: DPT Model: 2100S            Rev: 320P, scsi 0:

DPT I2O Driver Version: 1.14/1.14:

        cmd_per_lun = 210, max_id = 15, max_lun = 7, max_channel = 0
        sg_tablesize = 39, irq = 11, OutstandingMsgs = 0
        maxfromiopmsgs = 64, maxtoiopmsgs = 210

    Devices:
        Channel = 0, Target = 1, Lun = 0
[root@lala log]#

[root@lala log]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: ADAPTEC  Model: RAID-1           Rev: 320P
  Type:   Direct-Access                    ANSI SCSI revision: 02
[root@lala log]#

If I want to see each device separately I have to go to the controller's
software by pressing ctrl-a at boot time.

					Juan Pablo Abuyeres


On Mon, 14 May 2001, Josh Logan wrote:

>
> What makes you think /dev/sda is the raid?  For me cat /proc/scsi/scsi
> lists all 4 drives which, to me, implies that it is raw.
>
> fdisk could not partition the raid by default.  I needed to use sfdisk the
> first time.  After that fdisk worked fine.
>
> If I have both modules loaded I can mount /dev/i2o/hd/dics0/part1 but not
> /dev/sda1 (no filesystem).
>
> I was hoping i2o_scsi would make it appear as a "normal" scsi device, but
> I don't think that is happening with the current driver.
>
> If you are having a different scsi setup I would be interested in trying
> to set my system up the same way.  Thanks!
>
> 							Later, JOSH
>
>
> On Mon, 14 May 2001, Juan Pablo Abuyeres wrote:
>
> > > > Then When I tried to fdisk /dev/sda (/dev/sda is a RAID1 of two
> > > > Quantum disks) syslog shows this:
> > >
> > > is /dev/sda the raid or the disks raw ?
> >
> > /dev/sda is the RAID1
> >
> > > > So, I don't know if I'm doing something wrong or what, but I haven't been
> > > > able to get it working on 2.4.4 yet... please help.
> > >
> > > Ok I need to put mroe disks and newer firmware on my card when I have some
> > > time
> >
> > my /dev/dsa is a RAID1 made of two quantum atlas 10K II 18.xGb.
> > Unfortunately I have to get this RAID running this week (maybe on
> > wednesday) and after that I won't be able to do tests... so.. maybe
> > I would have to use 2.2.19 instead of 2.4.4  :-(...
> >
> > Juan Pablo Abuyeres
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>

