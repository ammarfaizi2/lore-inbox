Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbUKXQiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbUKXQiJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 11:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbUKXQfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 11:35:42 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:33677 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262687AbUKXQez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 11:34:55 -0500
Date: Wed, 24 Nov 2004 17:34:18 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nigel Cunningham <ncunningham@linuxmail.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 26/51: Kconfig and makefile.
In-Reply-To: <1101296580.5805.292.camel@desktop.cunninghams>
Message-ID: <Pine.LNX.4.61.0411241718400.1284@scrub.home>
References: <1101292194.5805.180.camel@desktop.cunninghams>
 <1101296580.5805.292.camel@desktop.cunninghams>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 24 Nov 2004, Nigel Cunningham wrote:

> +menu "Software Suspend 2"
> +
> +config SOFTWARE_SUSPEND2_CORE
> +	tristate "Software Suspend 2"
> +	depends on PM
> +	select SOFTWARE_SUSPEND2
> +	---help---
> +	  Software Suspend 2 is the 'new and improved' suspend support. You
> +	  can now build it as modules, but be aware that this requires
> +	  initrd support (the modules you use in saving the image have to
> +	  be loaded in order for you to be able to resume!)
> +	  
> +	  See the Software Suspend home page (softwaresuspend.berlios.de)
> +	  for FAQs, HOWTOs and other documentation.
> +
> +	config SOFTWARE_SUSPEND2
> +	bool
> +
> +	if SOFTWARE_SUSPEND2
> +		config SOFTWARE_SUSPEND2_WRITER
> +		bool
> +

Please don't use such indentations.
There is no need to use to select here either. If you really want to make 
it modular (and you can convince Christoph), you want to do something like 
this:

config SOFTWARE_SUSPEND2
	tristate "Software Suspend 2"
	depends on PM

config SOFTWARE_SUSPEND2_BUILTIN
	def_bool SOFTWARE_SUSPEND2

and let everything else depend on SOFTWARE_SUSPEND2.

> +		config SOFTWARE_SUSPEND_SWAPWRITER
> +			tristate '   Swap Writer'
> +			depends on SWAP && SOFTWARE_SUSPEND2_CORE
> +			select SOFTWARE_SUSPEND2_WRITER

This select is also bogus.

> +
> +ifeq ($(CONFIG_SOFTWARE_SUSPEND2),y)
> +obj-y	+= suspend_builtin.o proc.o
> +endif

Use SOFTWARE_SUSPEND2_BUILTIN here without the ifeq.

bye, Roman
