Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbUAOO0x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 09:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbUAOO0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 09:26:52 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:32784 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262746AbUAOO0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 09:26:49 -0500
Date: Thu, 15 Jan 2004 15:26:02 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Gerd Knorr <kraxel@bytesex.org>
cc: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l-05 add infrared remote support
In-Reply-To: <20040115115611.GA16266@bytesex.org>
Message-ID: <Pine.LNX.4.58.0401151502320.27223@serv>
References: <20040115115611.GA16266@bytesex.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Jan 2004, Gerd Knorr wrote:

> diff -u linux-2.6.1/drivers/media/Kconfig linux/drivers/media/Kconfig
> --- linux-2.6.1/drivers/media/Kconfig	2004-01-14 15:05:10.000000000 +0100
> +++ linux/drivers/media/Kconfig	2004-01-14 15:09:35.000000000 +0100
> @@ -49,5 +49,11 @@
>  	default VIDEO_BT848
>  	depends on VIDEO_DEV
>
> +config VIDEO_IR
> +	tristate
> +	default y if VIDEO_BT848=y || VIDEO_SAA7134=y
> +	default m if VIDEO_BT848=m || VIDEO_SAA7134=m
> +	depends on VIDEO_DEV
> +
>  endmenu
>

This can also be written as:

config VIDEO_IR
	def_tristate VIDEO_BT848 || VIDEO_SAA7134

def_tristate is the same as tristate & default ...
The dependency is redundant as the other options already depend on it.

Another possibility is to use select:

# selected as needed
config VIDEO_IR
	tristate

config VIDEO_BT848
	...
	select VIDEO_IR

This has the advantage that adding/removing drivers only requires changes
at a single place.

bye, Roman
