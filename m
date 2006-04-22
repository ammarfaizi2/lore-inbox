Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWDVBPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWDVBPe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 21:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWDVBPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 21:15:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35456 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750835AbWDVBPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 21:15:33 -0400
Date: Fri, 21 Apr 2006 18:14:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de, hjlipp@web.de
Subject: Re: [PATCH 2.6.17-rc2 1/2] return class device pointer from
 tty_register_device()
Message-Id: <20060421181429.5ea9d777.akpm@osdl.org>
In-Reply-To: <44497FFE.6050508@imap.cc>
References: <44497FFE.6050508@imap.cc>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tilman Schmidt <tilman@imap.cc> wrote:
>
>  + * Returns a pointer to the class device (or NULL on error).
>  + *
>    * This call is required to be made to register an individual tty device if
>    * the tty driver's flags have the TTY_DRIVER_NO_DEVFS bit set.  If that
>    * bit is not set, this function should not be called.
>    */
>  -void tty_register_device(struct tty_driver *driver, unsigned index,
>  -			 struct device *device)
>  +struct class_device *tty_register_device(struct tty_driver *driver,
>  +					 unsigned index, struct device *device)
>   {

It would be better to make this return ERR_PTR(-Efoo) on error, rather than
NULL.

That way, tty_register_device() ends with

-       class_device_create(tty_class, NULL, dev, device, "%s", name);
+       return class_device_create(tty_class, NULL, dev, device, "%s", name);
 }

which is neat.
