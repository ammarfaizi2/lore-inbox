Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269050AbUIHJ1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269050AbUIHJ1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269045AbUIHJY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:24:56 -0400
Received: from cantor.suse.de ([195.135.220.2]:54442 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269065AbUIHJYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:24:22 -0400
Date: Wed, 8 Sep 2004 11:23:14 +0200
From: Jens Axboe <axboe@suse.de>
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 2/3] uml-ubd-any-elevator
Message-ID: <20040908092314.GE2258@suse.de>
References: <20040906174449.8CAAEBB1A@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040906174449.8CAAEBB1A@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06 2004, blaisorblade_spam@yahoo.it wrote:
> diff -puN arch/um/drivers/ubd_kern.c~uml-ubd-any-elevator arch/um/drivers/ubd_kern.c
> --- uml-linux-2.6.8.1/arch/um/drivers/ubd_kern.c~uml-ubd-any-elevator	2004-08-29 14:40:53.731043416 +0200
> +++ uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c	2004-08-29 14:40:53.733043112 +0200
> @@ -749,8 +749,6 @@ int ubd_init(void)
>  		return -1;
>  	}
>  		
> -	elevator_init(ubd_queue, &elevator_noop);
> -
>  	if (fake_major != MAJOR_NR) {
>  		char name[sizeof("ubd_nnn\0")];

if this is not applied, at least the file needs an elevator_exit(q);
before calling elevator_init() for the new elevator. otherwise the
original elevator data is leaked.

-- 
Jens Axboe

