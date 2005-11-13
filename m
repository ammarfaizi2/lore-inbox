Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVKMWMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVKMWMn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 17:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVKMWMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 17:12:43 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:46736 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1750762AbVKMWMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 17:12:42 -0500
Date: Sun, 13 Nov 2005 23:12:43 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Neil Brown <neilb@suse.de>
Cc: "J.A. Magallon" <jamagallon@able.es>, "H. Peter Anvin" <hpa@zytor.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: x86 building altivec for raid ?
Message-ID: <20051113221243.GA7638@mars.ravnborg.org>
References: <20051113220213.55fc6fae@werewolf.auna.net> <17271.44949.625740.612801@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17271.44949.625740.612801@cse.unsw.edu.au>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> diff ./drivers/md/Makefile~current~ ./drivers/md/Makefile
> --- ./drivers/md/Makefile~current~	2005-11-14 08:13:43.000000000 +1100
> +++ ./drivers/md/Makefile	2005-11-14 08:23:29.000000000 +1100
> @@ -8,12 +8,15 @@ dm-multipath-objs := dm-hw-handler.o dm-
>  dm-snapshot-objs := dm-snap.o dm-exception-store.o
>  dm-mirror-objs	:= dm-log.o dm-raid1.o
>  md-mod-objs     := md.o bitmap.o
> +raid6-$(CONFIG_ALTIVEC) :=  \
> +		   raid6altivec1.o raid6altivec2.o raid6altivec4.o \
> +		   raid6altivec8.o
> +raid6-$(CONFIG_X86) :=  raid6mmx.o raid6sse1.o
> +raid6-$(CONFIG_X86_64) := raid6sse2.o
>  raid6-objs	:= raid6main.o raid6algos.o raid6recov.o raid6tables.o \
Change the above line to:
>  raid6-y	+= raid6main.o raid6algos.o raid6recov.o raid6tables.o \

>  		   raid6int1.o raid6int2.o raid6int4.o \
>  		   raid6int8.o raid6int16.o raid6int32.o \
> -		   raid6altivec1.o raid6altivec2.o raid6altivec4.o \
> -		   raid6altivec8.o \
> -		   raid6mmx.o raid6sse1.o raid6sse2.o
> +		   $(raid6-y)
And then you do not need to add the above line.

The Makefile deserve a small comment why you overwrite
the first assigned vaule of raid6-y - otherwise it may confuse when
reading through the file.

	Sam
