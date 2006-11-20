Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966193AbWKTUfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966193AbWKTUfF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966654AbWKTUfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:35:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:15070 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S966193AbWKTUfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:35:03 -0500
Date: Mon, 20 Nov 2006 12:34:40 -0800
From: Greg KH <gregkh@suse.de>
To: Akinobu Mita <akinobu.mita@gmail.com>, Jiri Slaby <jirislaby@gmail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: delete virtual directory on class_unregister()
Message-ID: <20061120203440.GA5458@suse.de>
References: <4561E290.7060100@gmail.com> <20061120182312.GA16006@APFDCB5C> <4561FA6F.4030400@gmail.com> <20061120195318.GB18077@APFDCB5C>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120195318.GB18077@APFDCB5C>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 04:53:18AM +0900, Akinobu Mita wrote:
> Class virtual directory is created as the need arises.
> But it is not deleted when the class is unregistered.
> 
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
> ---
>  drivers/base/class.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: work-fault-inject/drivers/base/class.c
> ===================================================================
> --- work-fault-inject.orig/drivers/base/class.c
> +++ work-fault-inject/drivers/base/class.c
> @@ -163,6 +163,8 @@ int class_register(struct class * cls)
>  void class_unregister(struct class * cls)
>  {
>  	pr_debug("device class '%s': unregistering\n", cls->name);
> +	if (cls->virtual_dir)
> +		kobject_unregister(cls->virtual_dir);
>  	remove_class_attrs(cls);
>  	subsystem_unregister(&cls->subsys);
>  }

Hm, why is this not reproducable for me then without this patch?

Very strange, I'll dig into it some more this evening, gotta go do
family stuff for the rest of the day...

thanks,

greg k-h
