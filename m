Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTHVWhU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 18:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbTHVWhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 18:37:20 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:22206 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263258AbTHVWhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 18:37:14 -0400
Date: Sat, 23 Aug 2003 00:31:49 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Christoph Hellwig <hch@suse.cz>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix the -test3 input config damages
Message-ID: <20030822223149.GA28312@ucw.cz>
References: <20030822163800.GA7568@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822163800.GA7568@lst.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 06:38:00PM +0200, Christoph Hellwig wrote:

> There's really no point in forcing in support for all kinds of
> optional input devices unless CONFIG_EMBEDDED.  Also some of the
> selections really broke configs that worked fine before as indicated
> by the reports on lkml.  Instead select CONFIG_INPUT if CONFIG_VT
> is selected so people upgrading from 2.4 using make oldconfig have
> a chance to see it if they didn't need CONFIG_INPUT before.
> 
> Btw, could we please get a consensus on what CONFIG_EMBEDDED is
> supposed to mean?  It was introduced to allow compiling code out
> for special cases that normal userspace should be able to rely
> on like epoll and futexes but people seem to use it as an Aunt Tillie
> guard these days..

I think this is the way to go. I'm merging this into my tree now.

> --- 1.15/drivers/char/Kconfig	Wed Jul 16 13:39:32 2003
> +++ edited/drivers/char/Kconfig	Sun Aug 10 11:17:02 2003
> @@ -5,8 +5,8 @@
>  menu "Character devices"
>  
>  config VT
> -	bool "Virtual terminal" if EMBEDDED
> -	requires INPUT=y
> +	bool "Virtual terminal"
> +	select INPUT
>  	default y
>  	---help---
>  	  If you say Y here, you will get support for terminal devices with
> @@ -36,7 +36,7 @@
>  	  shiny Linux system :-)
>  
>  config VT_CONSOLE
> -	bool "Support for console on virtual terminal" if EMBEDDED
> +	bool "Support for console on virtual terminal"
>  	depends on VT
>  	default y
>  	---help---

[snip]

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
