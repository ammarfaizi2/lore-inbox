Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423243AbWJSDqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423243AbWJSDqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 23:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423245AbWJSDqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 23:46:12 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:8188 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1423243AbWJSDqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 23:46:11 -0400
Date: Wed, 18 Oct 2006 20:47:36 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware/dcdbas: add size check in smi_data_write
Message-Id: <20061018204736.72755856.randy.dunlap@oracle.com>
In-Reply-To: <20061019005441.GA8850@sysman-doug.us.dell.com>
References: <20061019005441.GA8850@sysman-doug.us.dell.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 19:54:42 -0500 Doug Warzecha wrote:

> 
> This patch adds a size check in smi_data_write to prevent possible wrapping problems with large pos values when calling smi_data_buf_realloc on 32-bit.

I think that 'man 2 write' suggests EFBIG instead of EINVAL?


> ---
> 
> --- linux-2.6.19-rc2/drivers/firmware/dcdbas.c.orig	2006-10-18 18:52:43.000000000 -0500
> +++ linux-2.6.19-rc2/drivers/firmware/dcdbas.c	2006-10-18 18:55:08.000000000 -0500
> @@ -8,7 +8,7 @@
>   *
>   *  See Documentation/dcdbas.txt for more information.
>   *
> - *  Copyright (C) 1995-2005 Dell Inc.
> + *  Copyright (C) 1995-2006 Dell Inc.
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License v2.0 as published by
> @@ -40,7 +40,7 @@
>  #include "dcdbas.h"
>  
>  #define DRIVER_NAME		"dcdbas"
> -#define DRIVER_VERSION		"5.6.0-2"
> +#define DRIVER_VERSION		"5.6.0-3.2"
>  #define DRIVER_DESCRIPTION	"Dell Systems Management Base Driver"
>  
>  static struct platform_device *dcdbas_pdev;
> @@ -175,6 +175,9 @@ static ssize_t smi_data_write(struct kob
>  {
>  	ssize_t ret;
>  
> +	if ((pos + count) > MAX_SMI_DATA_BUF_SIZE)
> +		return -EINVAL;
> +
>  	mutex_lock(&smi_data_lock);
>  
>  	ret = smi_data_buf_realloc(pos + count);
> -


---
~Randy
