Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262598AbTDAPPp>; Tue, 1 Apr 2003 10:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262599AbTDAPPp>; Tue, 1 Apr 2003 10:15:45 -0500
Received: from havoc.daloft.com ([64.213.145.173]:2961 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S262598AbTDAPPo>;
	Tue, 1 Apr 2003 10:15:44 -0500
Date: Tue, 1 Apr 2003 10:27:03 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>, colpatch@us.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (2.5.66-mm2) War on warnings
Message-ID: <20030401152703.GA21986@gtf.org>
References: <19200000.1049210557@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19200000.1049210557@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 07:22:37AM -0800, Martin J. Bligh wrote:
> drivers/base/node.c: In function `register_node_type':
> drivers/base/node.c:96: warning: suggest parentheses around assignment used as truth value
> drivers/base/memblk.c: In function `register_memblk_type':
> drivers/base/memblk.c:54: warning: suggest parentheses around assignment used as truth value
> 
> Bah.
> 
> --- linux-2.5.66-mm2/drivers/base/node.c	2003-04-01 06:40:02.000000000 -0800
> +++ 2.5.66-mm2/drivers/base/node.c	2003-04-01 06:37:32.000000000 -0800
> @@ -93,7 +93,7 @@ int __init register_node_type(void)
>  {
>  	int error;
>  	if (!(error = devclass_register(&node_devclass)))
> -		if (error = driver_register(&node_driver))
> +		if ((error = driver_register(&node_driver)))
>  			devclass_unregister(&node_devclass);

Personally, I feel statements like these are prone to continual error
and confusion.  I would prefer to break each test like this out into
separate assignment and test statements.  Combining them decreases
readability, while saving a paltry few extra bytes of source code.

Sure, the gcc warning is silly, but the code is a bit obtuse too.

	Jeff



