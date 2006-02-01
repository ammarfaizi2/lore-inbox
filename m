Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWBAAEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWBAAEZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 19:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWBAAEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 19:04:25 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:48279 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751105AbWBAAEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 19:04:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=RNcjAsONMvQHyBQqAHI3croF6ErNn9OK2Y3PxOoh6s5ex2Eqqf1Rx5+Hs9IQdXco29q5sjkG6PBAbec4eksh+MFukhkwJGnwvaksooWDqOapQwMz8/RlA2MNmsMHJOU4DkkvD8GBXOtnZU+AM+miaiVLGEJlHdSf4TMwyD+07QA=
Date: Wed, 1 Feb 2006 03:22:33 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Shaun Jackman <sjackman@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Liyitec PS/2 touch panel driver [PATCH]
Message-ID: <20060201002233.GA14212@mipter.zuzino.mipt.ru>
References: <7f45d9390601311459o45de3c34sd4d25fc7990c728d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f45d9390601311459o45de3c34sd4d25fc7990c728d@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 03:59:20PM -0700, Shaun Jackman wrote:
> I've written an input driver for the Liyitec PS/2 touch panel. The
> patch follows. As this is my first input driver, I'd appreciate any
> feedback.

> 2006-01-31  Shaun Jackman  <sjackman@gmail.com>
>
> 	* drivers/input/touchscreen/Kconfig (TOUCHSCREEN_LIYITEC): New item.
> 	* drivers/input/touchscreen/Makefile: Add liyitec driver.
> 	* drivers/input/touchscreen/liyitec.c: New file.
> 	* include/linux/serio.h (SERIO_LIYITEC): New constant.

This is not ChangeLog style Linux is using.

> +static void liyitec_disconnect(struct serio *serio)
> +{
> +	struct liyitec *liyitec = serio_get_drvdata(serio);
> +
> +	input_get_device(liyitec->dev);

What do you want to do with return value?

> +	input_unregister_device(liyitec->dev);
> +	serio_close(serio);
> +	serio_set_drvdata(serio, NULL);
> +	input_put_device(liyitec->dev);
> +	kfree(liyitec);
> +}

> +static void __exit liyitec_exit(void)
> +{
> +	printk(KERN_INFO "liyitec: %s\n", __func__);

I suggest to drop this line.

> +	serio_unregister_driver(&liyitec_drv);
> +}

