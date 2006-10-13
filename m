Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751791AbWJMSLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWJMSLS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWJMSLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:11:18 -0400
Received: from mailhost.somanetworks.com ([216.126.67.42]:40837 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id S1751775AbWJMSK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:10:56 -0400
Date: Fri, 13 Oct 2006 14:10:54 -0400 (EDT)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Akinobu Mita <akinobu.mita@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH] cpcihp_generic: prevent loading without "bridge" parameter
In-Reply-To: <20061013180730.GE29079@localhost>
Message-ID: <Pine.LNX.4.58.0610131409300.25755@rancor.yyz.somanetworks.com>
References: <20061013180730.GE29079@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2006, Akinobu Mita wrote:

> cpcihp_generic module requires configured "bridge" module parameter.
> But it can be loaded successfully without that parameter.
> Because module init call ends up returning positive value.
> 
> This patch prevents from loading without setting "bridge" module parameter.
> 
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Scott Murray <scottm@somanetworks.com>
> Signed-off-by: Akinbou Mita <akinobu.mita@gmail.com>

Signed-off-by: Scott Murray <scottm@somanetworks.com>

> Index: work-fault-inject/drivers/pci/hotplug/cpcihp_generic.c
> ===================================================================
> --- work-fault-inject.orig/drivers/pci/hotplug/cpcihp_generic.c
> +++ work-fault-inject/drivers/pci/hotplug/cpcihp_generic.c
> @@ -84,7 +84,7 @@ static int __init validate_parameters(vo
>  
>  	if(!bridge) {
>  		info("not configured, disabling.");
> -		return 1;
> +		return -EINVAL;
>  	}
>  	str = bridge;
>  	if(!*str)
> @@ -147,7 +147,7 @@ static int __init cpcihp_generic_init(vo
>  
>  	info(DRIVER_DESC " version: " DRIVER_VERSION);
>  	status = validate_parameters();
> -	if(status != 0)
> +	if (status)
>  		return status;
>  
>  	r = request_region(port, 1, "#ENUM hotswap signal register");

-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com
