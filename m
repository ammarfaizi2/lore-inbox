Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbVINQF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbVINQF5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbVINQF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:05:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:19896 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030217AbVINQF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:05:57 -0400
Date: Wed, 14 Sep 2005 09:05:27 -0700
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@novell.com>
Cc: Mr Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] hdaps driver update.
Message-ID: <20050914160527.GA22352@kroah.com>
References: <1126713453.5738.7.camel@molly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126713453.5738.7.camel@molly>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 11:57:33AM -0400, Robert Love wrote:
> +/* dummy release function -- everything is static, nothing to free */
> +static void hdaps_dummy_release(struct device *dev) { }

Woah, no, this is not ok.  Please see my objections to this the zillion
other times people have tried to do this...

Why is this static?  Shouldn't it be dynamic and then your release would
be able to free the memory?

>  static struct device_driver hdaps_driver = {
>  	.name = "hdaps",
>  	.bus = &platform_bus_type,
> -	.owner = THIS_MODULE,
>  	.probe = hdaps_probe,
>  	.resume = hdaps_resume
>  };

Why delete that?  You just lost your symlink in sysfs then :(

thanks,

greg k-h
