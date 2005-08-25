Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbVHYGQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVHYGQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 02:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbVHYGQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 02:16:29 -0400
Received: from smtp101.biz.mail.mud.yahoo.com ([68.142.200.236]:10633 "HELO
	smtp101.biz.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751214AbVHYGQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 02:16:28 -0400
Subject: Re: [PATCH 2/3] exterminate strtok - drivers/video/au1100fb.c
From: Pete Popov <ppopov@mvista.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200508242108.32885.jesper.juhl@gmail.com>
References: <200508242108.32885.jesper.juhl@gmail.com>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 23:16:21 -0700
Message-Id: <1124950581.14435.978.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I see the patch, or an equivalent, has been applied already.

Pete

On Wed, 2005-08-24 at 21:08 +0200, Jesper Juhl wrote:
> Since strtok() died in 2002 let's not use it - use strsep() instead which
> is the replacement function.
> 
> Note: I've not been able to test this patch since I lack both hardware and 
> a cross compiler, so if someone else could please check it and sign off on 
> it before I send it to Andrew for inclusion in -mm I'd appreciate it.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
>  au1100fb.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> --- linux-2.6.13-rc6-mm2-orig/drivers/video/au1100fb.c	2005-08-17 21:51:59.000000000 +0200
> +++ linux-2.6.13-rc6-mm2/drivers/video/au1100fb.c	2005-08-24 18:58:18.000000000 +0200
> @@ -614,7 +614,7 @@ void au1100fb_cleanup(struct fb_info *in
>  
>  void au1100fb_setup(char *options, int *ints)
>  {
> -	char* this_opt;
> +	char *this_opt;
>  	int i;
>  	int num_panels = sizeof(panels)/sizeof(struct known_lcd_panels);
>  
> @@ -622,8 +622,9 @@ void au1100fb_setup(char *options, int *
>  	if (!options || !*options)
>  		return;
>  
> -	for(this_opt=strtok(options, ","); this_opt;
> -	    this_opt=strtok(NULL, ",")) {
> +	while ((this_opt = strsep(&options, ","))) {
> +		if (!*this_opt)
> +			continue;
>  		if (!strncmp(this_opt, "panel:", 6)) {
>  #if defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_DB1100)
>  			/* Read Pb1100 Switch S10 ? */
> 
> 

