Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbTJTVUs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 17:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbTJTVUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 17:20:48 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20185 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262774AbTJTVUl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 17:20:41 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Svetoslav Slavtchev" <svetljo@gmx.de>,
       "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
Subject: Re: HighPoint 374
Date: Mon, 20 Oct 2003 23:25:05 +0200
User-Agent: KMail/1.5.4
Cc: Tomi.Orava@ncircle.nullnet.fi, linux-kernel@vger.kernel.org
References: <001901c39734$8a2c2bb0$0514a8c0@HUSH> <31727.1066684060@www30.gmx.net>
In-Reply-To: <31727.1066684060@www30.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310202325.05384.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


multicount affects PIO transfers performance only...

On Monday 20 of October 2003 23:07, Svetoslav Slavtchev wrote:
> > BTW, isn't m0 supposed to reduce perfomance?
>
> hm here it also doesn't seem to change much,
> may be it's ignored if UDMA is used
>
> mem is 1024Mb
>
> [root@svetljo kernel]#  hdparm -m0 /dev/hde
>
> /dev/hde:
>  setting multcount to 0
>  multcount    =  0 (off)
>
> [root@svetljo 1]# time dd if=/dev/zero of=10Gb.zeros count=20000 bs=512k
> 20000+0 records in
> 20000+0 records out
> 0.09user 29.38system 5:44.49elapsed 8%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (149major+40minor)pagefaults 0swaps
> [root@svetljo 1]#  hdparm -m8 /dev/hde
>
> /dev/hde:
>  setting multcount to 8
>  multcount    =  8 (on)
> [root@svetljo 1]# time dd if=/dev/zero of=10Gb.zeros count=20000 bs=512k
> 20000+0 records in
> 20000+0 records out
> 0.10user 28.99system 5:50.44elapsed 8%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (150major+41minor)pagefaults 0swaps
>
> root@svetljo 1]#  hdparm -m16 /dev/hde
>
> /dev/hde:
>  setting multcount to 16
>  multcount    = 16 (on)
> [root@svetljo 1]# time dd if=/dev/zero of=10Gb.zeros count=20000 bs=512k
> 20000+0 records in
> 20000+0 records out
> 0.09user 28.83system 5:53.57elapsed 8%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (165major+40minor)pagefaults 0swaps
> [root@svetljo 1]#
>
> > [root@fulanito wd1200jb]# time dd if=/dev/zero of=filling count=20000
> > bs=65536
> > 20000+0 records in
> > 20000+0 records out
> >
> > real    0m33.763s
> > user    0m0.200s
> > sys     0m10.920s
> > [root@fulanito wd1200jb]# hdparm -m4 /dev/hdk
> >
> > /dev/hdk:
> >  setting multcount to 4
> >  multcount    =  4 (on)
> > [root@fulanito wd1200jb]# time dd if=/dev/zero of=filling count=20000
> > bs=65536
> > 20000+0 records in
> > 20000+0 records out
> >
> > real    0m30.321s
> > user    0m0.150s
> > sys     0m10.630s
> > [root@fulanito wd1200jb]# hdparm -m0 /dev/hdk
> >
> > /dev/hdk:
> >  setting multcount to 0
> >  multcount    =  0 (off)
> > [root@fulanito wd1200jb]# time dd if=/dev/zero of=filling count=20000
> > bs=65536
> > 20000+0 records in
> > 20000+0 records out
> >
> > real    0m30.749s
> > user    0m0.130s
> > sys     0m10.900s
> > [root@fulanito wd1200jb]#

