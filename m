Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUJHSnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUJHSnY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUJHSmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:42:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:7603 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264098AbUJHShB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:37:01 -0400
Date: Fri, 8 Oct 2004 11:35:49 -0700
From: Greg KH <greg@kroah.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, linus@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] protect against buggy drivers
Message-ID: <20041008183549.GB4842@kroah.com>
References: <1097254421.16787.27.camel@localhost.localdomain> <20041008171414.GA28001@kroah.com> <Pine.LNX.4.61.0410081322110.4031@chaos.analogic.com> <20041008175058.GA2232@kroah.com> <Pine.LNX.4.61.0410081430490.7079@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410081430490.7079@chaos.analogic.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 02:31:27PM -0400, Richard B. Johnson wrote:
> 
> In the meantime, can we do something like:
> 
> --- linux-2.6.8/fs/char_dev.c.orig	2004-10-08 14:24:03.838389344 -0400
> +++ linux-2.6.8/fs/char_dev.c	2004-10-08 14:26:51.059967800 -0400
> @@ -206,7 +206,7 @@
> 
>  	cdev->owner = fops->owner;
>  	cdev->ops = fops;
> -	strcpy(cdev->kobj.name, name);
> +	strncpy(cdev->kobj.name, name, KOBJ_NAME_LEN-1);
>  	for (s = strchr(cdev->kobj.name, '/'); s; s = strchr(s, '/'))
>  		*s = '!';

No, that's still wrong.  Use Stephen's other patch instead.

thanks,

greg k-h
