Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSHMK5d>; Tue, 13 Aug 2002 06:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSHMK5d>; Tue, 13 Aug 2002 06:57:33 -0400
Received: from 212.68.254.82.brutele.be ([212.68.254.82]:44675 "EHLO stargate")
	by vger.kernel.org with ESMTP id <S314938AbSHMK5c>;
	Tue, 13 Aug 2002 06:57:32 -0400
Date: Tue, 13 Aug 2002 13:01:38 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre2 compile error
Message-ID: <20020813110138.GF31522@stargate.lan>
References: <20020813103024.GD31522@stargate.lan> <Pine.NEB.4.44.0208131236140.14606-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.NEB.4.44.0208131236140.14606-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

are you sure that the "int number" is employed only by devfs?

On mar, 13 aoû 2002, Adrian Bunk wrote:
> On Tue, 13 Aug 2002, Stephane Wirtel wrote:
> 
> > are you sure about the patch ?
> 
> It seems to be correct and I can verify both the compile error and that
> this patch fixes it. What do you consider to be wrong?
> 
> > best regards
> 
> cu
> Adrian
> 
> > On mar, 13 aoû 2002, Adrian Bunk wrote:
> > > On Tue, 13 Aug 2002, Chad Young wrote:
> > >
> > > > any idea what causes these errors?
> > > >
> > > > make[3]: Entering directory
> > > > `/home/skidley/kernel/linux-2.4.20-pre2/fs/partitions'
> > > > gcc -D__KERNEL__ -I/home/skidley/kernel/linux-2.4.20-pre2/include -Wall
> > > > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > > > -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
> > > > -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
> > > > -DKBUILD_BASENAME=check  -DEXPORT_SYMTAB -c check.c
> > > > check.c: In function `devfs_register_disc':
> > > > check.c:328: structure has no member named `number'
> > > > check.c:329: structure has no member named `number'
> > > > check.c: In function `devfs_register_partitions':
> > > > check.c:361: structure has no member named `number'
> > > >...
> > >
> > > The following patch made by Christoph Hellwig fixes it:
> > >
> > >
> > > --- linux-2.4.20-bk-20020810/include/linux/genhd.h	Sat Aug 10 14:37:16 2002
> > > +++ linux/include/linux/genhd.h	Mon Aug 12 23:40:37 2002
> > > @@ -62,7 +62,9 @@ struct hd_struct {
> > >  	unsigned long start_sect;
> > >  	unsigned long nr_sects;
> > >  	devfs_handle_t de;              /* primary (master) devfs entry  */
> > > -
> > > +#ifdef CONFIG_DEVFS_FS
> > > +	int number;
> > > +#endif /* CONFIG_DEVFS_FS */
> > >  #ifdef CONFIG_BLK_STATS
> > >  	/* Performance stats: */
> > >  	unsigned int ios_in_flight;
> > >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
Web : www.linux-mons.be	 "Linux Is Not UniX !!!"
