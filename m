Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWGHDXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWGHDXw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 23:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWGHDXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 23:23:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:36327 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932500AbWGHDXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 23:23:51 -0400
Date: Sat, 8 Jul 2006 05:23:17 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Matthew Wilcox <matthew@wil.cx>
cc: Sam Ravnborg <sam@ravnborg.org>, wookey@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support DOS line endings
In-Reply-To: <20060707173458.GB1605@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0607080513280.17704@scrub.home>
References: <20060707173458.GB1605@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 7 Jul 2006, Matthew Wilcox wrote:

> Kconfig doesn't currently handle config files with DOS line endings.
> While these are, of course, an abomination, etc, etc, it can be handy
> to not have to convert them first.  It's also a tiny patch and even adds
> support for lines ending in just \r or even \n\r.

Did you try the latter? Unless you told fgets() about it I don't see how 
it should work.

>  			if (p2)
>  				*p2 = 0;
> +			p2 = strchr(p, '\r');
> +			if (p2)
> +				*p2 = 0;

I think something like this would be simpler:

	if (p2[-1] == '\r')
		p2[-1] = 0;

bye, Roman
