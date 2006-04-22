Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWDVTz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWDVTz4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWDVTz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:55:56 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:16069 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751109AbWDVTzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:55:55 -0400
Date: Fri, 21 Apr 2006 21:16:55 -0700
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Tilman Schmidt <tilman@imap.cc>, linux-kernel@vger.kernel.org,
       hjlipp@web.de
Subject: Re: [PATCH 2.6.17-rc2 1/2] return class device pointer from tty_register_device()
Message-ID: <20060422041655.GA15892@suse.de>
References: <44497FFE.6050508@imap.cc> <20060421181429.5ea9d777.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421181429.5ea9d777.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 06:14:29PM -0700, Andrew Morton wrote:
> Tilman Schmidt <tilman@imap.cc> wrote:
> >
> >  + * Returns a pointer to the class device (or NULL on error).
> >  + *
> >    * This call is required to be made to register an individual tty device if
> >    * the tty driver's flags have the TTY_DRIVER_NO_DEVFS bit set.  If that
> >    * bit is not set, this function should not be called.
> >    */
> >  -void tty_register_device(struct tty_driver *driver, unsigned index,
> >  -			 struct device *device)
> >  +struct class_device *tty_register_device(struct tty_driver *driver,
> >  +					 unsigned index, struct device *device)
> >   {
> 
> It would be better to make this return ERR_PTR(-Efoo) on error, rather than
> NULL.
> 
> That way, tty_register_device() ends with
> 
> -       class_device_create(tty_class, NULL, dev, device, "%s", name);
> +       return class_device_create(tty_class, NULL, dev, device, "%s", name);
>  }
> 
> which is neat.

I agree, that would be nicer.

thanks,

greg k-h
