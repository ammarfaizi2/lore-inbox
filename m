Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWDYSCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWDYSCV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWDYSCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:02:21 -0400
Received: from witte.sonytel.be ([80.88.33.193]:37353 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932101AbWDYSCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:02:21 -0400
Date: Tue, 25 Apr 2006 20:02:15 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
In-Reply-To: <20060425001617.0a536488@werewolf.auna.net>
Message-ID: <Pine.LNX.4.62.0604252001120.19752@pademelon.sonytel.be>
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>
 <mj+md-20060424.201044.18351.atrey@ucw.cz> <444D44F2.8090300@wolfmountaingroup.com>
 <1145915533.1635.60.camel@localhost.localdomain> <20060425001617.0a536488@werewolf.auna.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2006, J.A. Magallon wrote:
> On Mon, 24 Apr 2006 22:52:12 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > This is one area of concern. Just as big a problem for the OS case is
> > that the hidden constructors/destructors may fail.
> 
> Tell me what is the difference between:
> 
> 
>     sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
>     if (!sbi)
>         return -ENOMEM;
>     sb->s_fs_info = sbi;
>     memset(sbi, 0, sizeof(*sbi));
>     sbi->s_mount_opt = 0;
>     sbi->s_resuid = EXT3_DEF_RESUID;
>     sbi->s_resgid = EXT3_DEF_RESGID;
> 
> and
> 
>     SuperBlock() : s_mount_opt(0), s_resuid(EXT3_DEF_RESUID), s_resgid(EXT3_DEF_RESGID)
>     {}
> 
>     ...
>     sbi = new SuperBlock;

You forgot the `nothrow'.

>     if (!sbi)
>         return -ENOMEM;
> 
> apart that you don't get members initalized twice and get a shorter code :).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
