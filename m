Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319378AbSHQKTB>; Sat, 17 Aug 2002 06:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319379AbSHQKTB>; Sat, 17 Aug 2002 06:19:01 -0400
Received: from 212.68.254.82.brutele.be ([212.68.254.82]:33542 "EHLO debian")
	by vger.kernel.org with ESMTP id <S319378AbSHQKTA>;
	Sat, 17 Aug 2002 06:19:00 -0400
Date: Sat, 17 Aug 2002 12:22:59 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre3
Message-ID: <20020817102259.GA4174@debian>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020817045924.GC377@hendrix> <Pine.LNX.4.44.0208170117360.8089-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208170117360.8089-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
X-Operating-System: GNU/Linux
X-LUG: Linux Users Group Mons ( Linux-Mons )
X-URL: http://www.linux-mons.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

about the patch of devfs, why don't add directly this patch in the new 2.4.20-pre3
?



On Sat, Aug 17, 2002 at 01:18:17AM -0300, Marcelo Tosatti wrote:
> 
> 
> On Sat, 17 Aug 2002, Skidley wrote:
> 
> > check.c: In function `devfs_register_disc':
> > check.c:328: structure has no member named `number'
> > check.c:329: structure has no member named `number'
> > check.c: In function `devfs_register_partitions':
> > check.c:361: structure has no member named `number'
> > make[3]: *** [check.o] Error 1
> > make[3]: Leaving directory
> > `/home/skidley/kernel/linux-2.4.20-pre3/fs/partitions'
> > make[2]: *** [first_rule] Error 2
> > make[2]: Leaving directory
> > `/home/skidley/kernel/linux-2.4.20-pre3/fs/partitions'
> > make[1]: *** [_subdir_partitions] Error 2
> > make[1]: Leaving directory `/home/skidley/kernel/linux-2.4.20-pre3/fs'
> > make: *** [_dir_fs] Error 2
> 
> Yeah, I forgot to apply the fix to this one, sorry.
> 
> Here it is:
> 
> Subject: [PATCH] fix current BK tree compilation with devfs enabled
> 
> 
> Not that I care for devfs, but there was at least one report on lkml.
> 
> I tried to also put the devfs_handle_t under CONFIG_DEVFS_FS, but the
> devfs wrappers require it.  And yes, I'm seriously pissed that devfs
> puts wordsize objects everywhere even if not enabled.
> 
> 
> --- linux-2.4.20-bk-20020810/include/linux/genhd.h	Sat Aug 10 14:37:16 2002
> +++ linux/include/linux/genhd.h	Mon Aug 12 23:40:37 2002
> @@ -62,7 +62,9 @@ struct hd_struct {
>  	unsigned long start_sect;
>  	unsigned long nr_sects;
>  	devfs_handle_t de;              /* primary (master) devfs entry  */
> -
> +#ifdef CONFIG_DEVFS_FS
> +	int number;
> +#endif /* CONFIG_DEVFS_FS */
>  #ifdef CONFIG_BLK_STATS
>  	/* Performance stats: */
>  	unsigned int ios_in_flight;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
Web : www.linux-mons.be	 "Linux Is Not UniX !!!"
