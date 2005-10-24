Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbVJXSQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVJXSQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 14:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVJXSQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 14:16:13 -0400
Received: from tim.rpsys.net ([194.106.48.114]:46061 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751228AbVJXSQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 14:16:12 -0400
Subject: Re: sharp zaurus c-3000: fix compile failure without CONFIG_FB_PXA
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20051024172639.GA30960@elf.ucw.cz>
References: <20051024172639.GA30960@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 19:16:01 +0100
Message-Id: <1130177761.8345.144.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 19:26 +0200, Pavel Machek wrote:
> This fixes compile problem when CONFIG_FB_PXA is not set.
> 
>   LD      .tmp_vmlinux1
> arch/arm/mach-pxa/built-in.o(.text+0x1d74): In function
> `spitz_get_hsync_len':
> : undefined reference to `pxafb_get_hsync_time'
> make: *** [.tmp_vmlinux1] Error 1
> 3.46user 0.46system 5.10 (0m5.106s) elapsed 77.01%CPU
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
> 
> diff --git a/arch/arm/mach-pxa/corgi_lcd.c b/arch/arm/mach-pxa/corgi_lcd.c
> --- a/arch/arm/mach-pxa/corgi_lcd.c
> +++ b/arch/arm/mach-pxa/corgi_lcd.c
> @@ -488,6 +488,7 @@ static int is_pxafb_device(struct device
>  
>  unsigned long spitz_get_hsync_len(void)
>  {
> +#ifdef CONFIG_FB_PXA
>  	if (!spitz_pxafb_dev) {
>  		spitz_pxafb_dev = bus_find_device(&platform_bus_type, NULL, NULL, is_pxafb_device);
>  		if (!spitz_pxafb_dev)
> @@ -496,6 +497,7 @@ unsigned long spitz_get_hsync_len(void)
>  	if (!get_hsync_time)
>  		get_hsync_time = symbol_get(pxafb_get_hsync_time);
>  	if (!get_hsync_time)
> +#endif
>  		return 0;
>  
>  	return pxafb_get_hsync_time(spitz_pxafb_dev);
> 
> 

