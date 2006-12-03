Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756952AbWLCQdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756952AbWLCQdy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 11:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756958AbWLCQdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 11:33:54 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19389 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1756935AbWLCQdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 11:33:54 -0500
Date: Sun, 3 Dec 2006 16:41:09 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: Convert kmalloc()+memset() combo to kzalloc().
Message-ID: <20061203164109.4c260592@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0612031120110.4371@localhost.localdomain>
References: <Pine.LNX.4.64.0612031120110.4371@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  	if (!p) {
> -		p = kmalloc(sizeof(*p), GFP_KERNEL);
> +		p = kzalloc(sizeof(*p), GFP_KERNEL);
>  		if (!p)
>  			return -ENOMEM;
>  		file->private_data = p;
>  	}
> -	memset(p, 0, sizeof(*p));
>  	mutex_init(&p->lock);
>  	p->op = op;


NAK

If p was already set (ie private data existed) the old code zeroed it,
your code does not, but only zeroes the new stuff.

Alan
