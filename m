Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbTJTSBZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 14:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTJTSBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 14:01:25 -0400
Received: from 66.Red-80-38-104.pooles.rima-tde.net ([80.38.104.66]:23194 "HELO
	fulanito.nisupu.com") by vger.kernel.org with SMTP id S262712AbTJTSBT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 14:01:19 -0400
Message-ID: <001901c39734$8a2c2bb0$0514a8c0@HUSH>
From: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
To: "Svetoslav Slavtchev" <svetljo@gmx.de>,
       "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Cc: <linux-kernel@vger.kernel.org>
References: <45855.194.237.142.24.1066637022.squirrel@ncircle.nullnet.fi> <14985.1066640611@www51.gmx.net>
Subject: Re: HighPoint 374
Date: Mon, 20 Oct 2003 19:02:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, isn't m0 supposed to reduce perfomance?

[root@fulanito wd1200jb]# time dd if=/dev/zero of=filling count=20000
bs=65536
20000+0 records in
20000+0 records out

real    0m33.763s
user    0m0.200s
sys     0m10.920s
[root@fulanito wd1200jb]# hdparm -m4 /dev/hdk

/dev/hdk:
 setting multcount to 4
 multcount    =  4 (on)
[root@fulanito wd1200jb]# time dd if=/dev/zero of=filling count=20000
bs=65536
20000+0 records in
20000+0 records out

real    0m30.321s
user    0m0.150s
sys     0m10.630s
[root@fulanito wd1200jb]# hdparm -m0 /dev/hdk

/dev/hdk:
 setting multcount to 0
 multcount    =  0 (off)
[root@fulanito wd1200jb]# time dd if=/dev/zero of=filling count=20000
bs=65536
20000+0 records in
20000+0 records out

real    0m30.749s
user    0m0.130s
sys     0m10.900s
[root@fulanito wd1200jb]#

----- Original Message ----- 
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, October 20, 2003 11:03
Subject: Re: HighPoint 374


> >
> >
> > >> Are you capable of trying if the hdparm -m0 trick
> > >> works for you ?
> > >
> > > you mean the fs corruption on soft raid or the interupts problem ?
> > > i dumped the raid setup as i couldn't find a way to debug it
> > > and my drives are pretty full again, but i'll try to free some space
> >
> > I meant the interrupt problem, because if that problem exists
> > there doesn't seem to be a reasonable way to figure out what
> > is the reason for the filesystem corruption.
> >
> > > for the interupts
> > > with test7-bk8  , acpi=off pci=noacpi &
> > > hdparm  -m0 -d1 -X69  /dev/hd[a,e,g]
> > > hdparm  -m16 -d1 -X69  /dev/hd[a,e,g]
> > > i don't see timeouts
> > > if i omit -m i do see them sometimes
> >
> > Ok, so if I understood you correctly, the interrupt problem
> > persists _only_ if you leave the multiple sector setting on
> > its default setting ? If you explicitly disable it, or set
> > it to maximum it works fine ? Does it work with any value ?
>
> -m4 & -m8 seems to work OK
> each time 3 runs of the dd test
> 1 to hda
> 2 to hde
>
> TCQ  not activated
>
>
> -- 
> NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
> Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService
>
> Jetzt kostenlos anmelden unter http://www.gmx.net
>
> +++ GMX - die erste Adresse für Mail, Message, More! +++
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

