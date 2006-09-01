Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWIAGA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWIAGA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 02:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWIAGA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 02:00:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6377 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932373AbWIAGA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 02:00:56 -0400
Date: Thu, 31 Aug 2006 23:00:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org, matthew@wil.cx
Subject: Re: [Patch] Uninitialized variable in drivers/scsi/ncr53c8xx.c
Message-Id: <20060831230049.db26d0e6.akpm@osdl.org>
In-Reply-To: <1157066952.13948.3.camel@alice>
References: <1157066952.13948.3.camel@alice>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Sep 2006 01:29:12 +0200
Eric Sesterhenn <snakebyte@gmx.de> wrote:

> hi,
> 
> this was spotted by coverity (id #880).
> We use simple_strtoul() earlier to initialize pe,
> if the function fails, it also does not initialize it.
> Therefore we should initialize it ourselves, so the check
> in the OPT_TAGS case "if (pe && *pe == '/')" makes sense, and
> actually makes the command line parsing more robust.
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

simple_strtoul() always initialises `pe'.

> --- linux-2.6.18-rc5/drivers/scsi/ncr53c8xx.c.orig	2006-09-01 01:25:09.000000000 +0200
> +++ linux-2.6.18-rc5/drivers/scsi/ncr53c8xx.c	2006-09-01 01:25:26.000000000 +0200
> @@ -692,7 +692,7 @@ static int __init sym53c8xx__setup(char 
>  	int xi = 0;
>  
>  	while (cur != NULL && (pc = strchr(cur, ':')) != NULL) {
> -		char *pe;
> +		char *pe = NULL;
>  
>  		val = 0;
>  		pv = pc;
> 

