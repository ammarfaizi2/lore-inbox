Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262828AbVBZBTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbVBZBTQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 20:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVBZBRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 20:17:40 -0500
Received: from gate.crashing.org ([63.228.1.57]:54169 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261174AbVBZBOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 20:14:21 -0500
Subject: Re: 2.6.11-rc5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <20050226004137.GA25539@suse.de>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
	 <20050224145049.GA21313@suse.de>  <20050226004137.GA25539@suse.de>
Content-Type: text/plain
Date: Sat, 26 Feb 2005 12:13:09 +1100
Message-Id: <1109380389.15026.112.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-26 at 01:41 +0100, Olaf Hering wrote:

> 
> modedb can not be __init because fb_find_mode() may get db == NULL.
> fb_find_mode() is called from modules.

Ahhh, good catch ! I though that was fixed long ago, looks like I was
wrong.

Ben.

> Signed-off-by: Olaf Hering <eolh@suse.de>
> 
> diff -purNx tags linux-2.6.11-rc5.orig/drivers/video/modedb.c linux-2.6.11-rc5/drivers/video/modedb.c
> --- linux-2.6.11-rc5.orig/drivers/video/modedb.c	2005-02-24 17:40:24.000000000 +0100
> +++ linux-2.6.11-rc5/drivers/video/modedb.c	2005-02-26 01:37:43.138003474 +0100
> @@ -37,7 +37,7 @@ const char *global_mode_option;
>  
>  #define DEFAULT_MODEDB_INDEX	0
>  
> -static const __init struct fb_videomode modedb[] = {
> +static const struct fb_videomode modedb[] = {
>      {
>  	/* 640x400 @ 70 Hz, 31.5 kHz hsync */
>  	NULL, 70, 640, 400, 39721, 40, 24, 39, 9, 96, 2,
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

