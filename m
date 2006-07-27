Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751825AbWG0ACJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbWG0ACJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 20:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWG0ACJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 20:02:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:40167 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751825AbWG0ACI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 20:02:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Greg KH <gregkh@suse.de>
Subject: Re: [RFC PATCH] Multi-threaded device probing
Date: Thu, 27 Jul 2006 02:02:00 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
References: <20060725203028.GA1270@kroah.com>
In-Reply-To: <20060725203028.GA1270@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607270202.00854.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 July 2006 22:30, Greg KH wrote:
> --- gregkh-2.6.orig/include/linux/device.h
> +++ gregkh-2.6/include/linux/device.h
> @@ -105,6 +105,8 @@ struct device_driver {
>         void    (*shutdown)     (struct device * dev);
>         int     (*suspend)      (struct device * dev, pm_message_t state);
>         int     (*resume)       (struct device * dev);
> +
> +       unsigned int multithread_probe:1;
>  };
>  

Why use a bit field here? It ends up consuming sizeof(long) anyway
and causes more complex code, with no obvious benefit.

	Arnd <><
