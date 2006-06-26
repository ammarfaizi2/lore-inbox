Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWFZLxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWFZLxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 07:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWFZLxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 07:53:22 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:57320 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750994AbWFZLxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 07:53:21 -0400
Date: Mon, 26 Jun 2006 13:52:54 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jeff Dike <jdike@addtoit.com>
cc: Andrew Morton <akpm@osdl.org>, Theodore Tso <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1: UML failing w/o SKAS enabled
In-Reply-To: <20060623142829.GA4333@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.64.0606261347370.12900@scrub.home>
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060622213443.GA22303@thunk.org>
 <20060622145743.2accfeaf.akpm@osdl.org> <20060623025418.GC8316@ccure.user-mode-linux.org>
 <Pine.LNX.4.64.0606231209000.17704@scrub.home> <20060623142829.GA4333@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 23 Jun 2006, Jeff Dike wrote:

> Index: linux-2.6.17/arch/um/Kconfig
> ===================================================================
> --- linux-2.6.17.orig/arch/um/Kconfig	2006-06-20 17:24:29.000000000 -0400
> +++ linux-2.6.17/arch/um/Kconfig	2006-06-23 10:20:27.000000000 -0400
> @@ -1,3 +1,8 @@
> +config DEFCONFIG_LIST
> +	string
> +	option defconfig_list
> +	default "arch/um/defconfig"
> +
>  # UML uses the generic IRQ sugsystem
>  config GENERIC_HARDIRQS
>  	bool

That would work too, but what I had in mind was to customize the entry in 
init/Kconfig, e.g.

config DEFCONFIG_LIST
	string
	option defconfig_list
	default "/lib/modules/$UNAME_RELEASE/.config"
	default "/etc/kernel-config"
	default "/boot/config-$UNAME_RELEASE"
	depends on !UML

config DEFCONFIG_LIST
	default "arch/$ARCH/defconfig"

This way the last entry is always the same for all archs and the rest can 
be customized.

bye, Roman
