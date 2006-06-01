Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWFAKhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWFAKhT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWFAKhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:37:19 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:52943 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750702AbWFAKhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:37:18 -0400
Date: Thu, 1 Jun 2006 12:36:48 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Martin Bligh <mbligh@google.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <20060531225013.GA7125@elte.hu>
Message-ID: <Pine.LNX.4.64.0606011222230.17704@scrub.home>
References: <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org>
 <20060531213340.GA3535@elte.hu> <447E0DEC.60203@mbligh.org>
 <20060531215315.GB4059@elte.hu> <447E11B5.7030203@mbligh.org>
 <20060531221242.GA5269@elte.hu> <447E16E6.7020804@google.com>
 <20060531223243.GC5269@elte.hu> <447E1A7B.2000200@google.com>
 <20060531225013.GA7125@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Jun 2006, Ingo Molnar wrote:

Ingo, it would be nice to get any kind of feedback, this is already the 
third and you continue to produce more Kconfig mess, instead of fixing the 
stuff I already pointed out. :(

> Index: linux/lib/Kconfig.debug
> ===================================================================
> --- linux.orig/lib/Kconfig.debug
> +++ linux/lib/Kconfig.debug
> @@ -54,6 +54,15 @@ config DEBUG_KERNEL
>  	  Say Y here if you are developing drivers or trying to debug and
>  	  identify kernel problems.
>  
> +config DEBUG_KERNEL_OVERHEAD
> +	bool "Enable new debug options by default"
> +	default y
> +	help
> +	  Say Y here if you want to have new debugging options
> +	  enabled by default even if they cause runtime overhead.
> +	  (you can still disable/enable them manually, independently
> +	   of this switch)
> +
>  config LOG_BUF_SHIFT
>  	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
>  	range 12 21
> @@ -113,7 +122,7 @@ config DEBUG_SLAB
>  config DEBUG_SLAB_LEAK
>  	bool "Slab memory leak debugging"
>  	depends on DEBUG_SLAB
> -	default y
> +	default y if DEBUG_KERNEL_OVERHEAD
>  	help
>  	  Enable /proc/slab_allocators - provides detailed information about
>  	  which parts of the kernel are using slab objects.  May be used for

This is nonsense.
If you do this do it at least correctly, e.g. something like:

config DEBUG_RUNTIME_CHECKS
	bool "Enable runtime debug checks"

config DEBUG_RUNTIME_CHECKS_ALL
	bool "Enable all runtime debug checks"
	depends on DEBUG_RUNTIME_CHECKS

config DEBUG_KERNEL
	bool "Kernel debugging"

...

config DEBUG_FOO
	bool "foo" if DEBUG_KERNEL
	default DEBUG_RUNTIME_CHECKS

Your current defaults are definitively NACKed for mainline, keep them 
separate!

bye, Roman
