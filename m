Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTFTE4K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 00:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTFTEz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 00:55:56 -0400
Received: from dp.samba.org ([66.70.73.150]:5094 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261365AbTFTEzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 00:55:49 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Thiago Rondon <thiago@nl.linux.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
Subject: Re: [2.5 patch] 2.5.72: moxa.c doesn't compile 
In-reply-to: Your message of "Thu, 19 Jun 2003 15:53:53 -0300."
             <20030619185352.GB421@ananke.com.br> 
Date: Fri, 20 Jun 2003 14:28:13 +1000
Message-Id: <20030620050950.46DDC2C150@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030619185352.GB421@ananke.com.br> you write:
> @@ -654,7 +658,7 @@
>  	if (ch == NULL)
>  		return (0);
>  	port = ch->port;
> -	save_flags(flags);
> +	local_save_flags(flags);
>  	if (from_user) {
>  		if (count > PAGE_SIZE)
>  			count = PAGE_SIZE;
> @@ -662,17 +666,17 @@
>  		if (copy_from_user(moxaXmitBuff, buf, count)) {
>  			len = -EFAULT;
>  		} else {
> -			cli();
> +			spin_lock_irqsave(&moxa_lock, flags);

Just drop the local_save_flags() altogether; it's redundant.

>  	/*********************************************
> @@ -751,11 +755,11 @@
>  	if (ch == NULL)
>  		return;
>  	port = ch->port;
> -	save_flags(flags);
> -	cli();
> +	local_save_flags(flags);
> +	spin_lock_irqsave(&moxa_lock, flags);

Here too...

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
