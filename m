Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUDVWP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUDVWP2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 18:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUDVWP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 18:15:28 -0400
Received: from mail.kroah.org ([65.200.24.183]:424 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261951AbUDVWPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 18:15:24 -0400
Date: Thu, 22 Apr 2004 15:07:56 -0700
From: Greg KH <greg@kroah.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix dev_printk to work even in the absence of am attached driver
Message-ID: <20040422220756.GA2479@kroah.com>
References: <1082407198.1804.35.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082407198.1804.35.camel@mulgrave>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 03:39:57PM -0500, James Bottomley wrote:
>  /* debugging and troubleshooting/diagnostic helpers. */
>  #define dev_printk(level, dev, format, arg...)	\
> -	printk(level "%s %s: " format , (dev)->driver->name , (dev)->bus_id , ## arg)
> +	printk(level "%s %s: " format , (dev)->driver ? (dev)->driver->name : "(unbound)", (dev)->bus_id , ## arg)

But doesn't this cause the string "(unbound)" to be created for every
dev_printk() call in the code?  I don't think gcc can optimize that very
well.  How about making a global string just for that, otherwise the
size police will come after me for adding such a patch :)

thanks,

greg k-h
