Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUFBHhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUFBHhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 03:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265122AbUFBHhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 03:37:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:23753 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264960AbUFBHhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 03:37:07 -0400
Date: Wed, 2 Jun 2004 00:36:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, bilotta78@hotpop.com,
       danlee@informatik.uni-freiburg.de, vojtech@suse.cz, tuukkat@ee.oulu.fi
Subject: Re: [RFC/RFT] Raw access to serio ports (1/2)
Message-Id: <20040602003626.4d754944.akpm@osdl.org>
In-Reply-To: <200406020218.42979.dtor_core@ameritech.net>
References: <200406020218.42979.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> Hi,
> 
> Below is an implementation of rawdev driver.

Yes, it does appear that we need the feature, thanks.

> Comments?

They're the thingies inside /* and */.  Your patch is refreshingly free of
them ;)

> +static ssize_t rawdev_write(struct file *file, const char *buffer, size_t count, loff_t *ppos)
> +{
> +	struct rawdev_list *list = file->private_data;
> +	ssize_t written = 0;
> +	int retval;
> +	unsigned char c;
> +
> +	retval = down_interruptible(&rawdev_sem);
> +	if (retval)
> +		return retval;
> +
> +	if (!list->rawdev->serio) {
> +		retval = -ENODEV;
> +		goto out;
> +	}

The return values here are mucked up - this function returns `written'.

> +	if (count > 32)
> +		count = 32;

Why?  (Don't tell me - add a comment!)

