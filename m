Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbTJMA2L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 20:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbTJMA2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 20:28:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:57500 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261271AbTJMA2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 20:28:10 -0400
Date: Sun, 12 Oct 2003 17:31:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: support@comtrol.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] release_region in RocketPort char driver
Message-Id: <20031012173117.35bd221c.akpm@osdl.org>
In-Reply-To: <3F81769B.1060508@terra.com.br>
References: <3F81769B.1060508@terra.com.br>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe W Damasio <felipewd@terra.com.br> wrote:
>
> --- linux-2.6.0-test6/drivers/char/rocket.c.orig	2003-10-06 10:57:29.000000000 -0300
>  +++ linux-2.6.0-test6/drivers/char/rocket.c	2003-10-06 11:00:29.000000000 -0300
>  @@ -2468,6 +2468,7 @@
>   	if (retval < 0) {
>   		printk(KERN_INFO "Couldn't install tty RocketPort driver (error %d)\n", -retval);
>   		put_tty_driver(rocket_driver);
>  +		release_region(controller, 4);
>   		return -1;
>   	}

a) If variable `controller' is zero then we never allocated this region,
   so we should not free it.

b) There is an error exit path further on which also needs to release
   this region (if controller != 0).


