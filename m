Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWCWVVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWCWVVn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWCWVVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:21:43 -0500
Received: from quark.didntduck.org ([69.55.226.66]:25495 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1750860AbWCWVVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:21:42 -0500
Message-ID: <44231179.100@didntduck.org>
Date: Thu, 23 Mar 2006 16:22:01 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Dont build altivec raid on x86
References: <20060323014046.2ca1d9df.akpm@osdl.org>	<20060323220711.28fcb82f@werewolf.auna.net> <20060323221525.52346ef7@werewolf.auna.net>
In-Reply-To: <20060323221525.52346ef7@werewolf.auna.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> On Thu, 23 Mar 2006 22:07:11 +0100, "J.A. Magallon" <jamagallon@able.es> wrote:
> 
> 
>>On Thu, 23 Mar 2006 01:40:46 -0800, Andrew Morton <akpm@osdl.org> wrote:
>>
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/
>>>
>>
> 
> gcc just compiles files emptied with #ifdefs, but it looks incorrect
> anyways
> 
> --- linux/drivers/md/Makefile.orig	2005-11-13 23:14:48.000000000 +0100
> +++ linux/drivers/md/Makefile	2005-11-13 23:28:05.000000000 +0100
> @@ -8,12 +8,21 @@
>  dm-snapshot-objs := dm-snap.o dm-exception-store.o
>  dm-mirror-objs	:= dm-log.o dm-raid1.o
>  md-mod-objs     := md.o bitmap.o
> +
> +
> +ifeq ($(CONFIG_ALTIVEC),y)
> +raid6-vec-objs := \
> +		   raid6altivec1.o raid6altivec2.o \
> +		   raid6altivec4.o raid6altivec8.o
> +endif
> +ifeq ($(CONFIG_X86),y)
> +raid6-vec-objs := \
> +		   raid6mmx.o raid6sse1.o raid6sse2.o
> +endif
>  raid6-objs	:= raid6main.o raid6algos.o raid6recov.o raid6tables.o \
>  		   raid6int1.o raid6int2.o raid6int4.o \
>  		   raid6int8.o raid6int16.o raid6int32.o \
> -		   raid6altivec1.o raid6altivec2.o raid6altivec4.o \
> -		   raid6altivec8.o \
> -		   raid6mmx.o raid6sse1.o raid6sse2.o
> +		   $(raid6-vec-objs)
>  hostprogs-y	:= mktables
>  
>  # Note: link order is important.  All raid personalities
> 

Use raid6-$(CONFIG_FOO) instead.

--
				Brian Gerst
