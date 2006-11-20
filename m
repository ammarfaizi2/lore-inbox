Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934069AbWKTLzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934069AbWKTLzm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 06:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934071AbWKTLzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 06:55:42 -0500
Received: from mx10.go2.pl ([193.17.41.74]:50850 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S934069AbWKTLzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 06:55:41 -0500
Date: Mon, 20 Nov 2006 13:01:59 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: jmalicki@metacarta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AF_UNIX recv/shutdown race
Message-ID: <20061120120159.GC1001@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>, jmalicki@metacarta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51488.68.160.147.35.1163979646.squirrel@webmail.metacarta.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-2006 00:40, jmalicki@metacarta.com wrote:
...
> @@ -650,7 +651,7 @@ static int unix_autobind(struct socket *
>  	struct unix_address * addr;
>  	int err;
> 
> -	mutex_lock(&u->readlock);
> +	unix_state_rlock(sk);

Here follows:
        err = 0;
        if (u->addr)
                goto out;

        err = -ENOMEM;
        addr = kzalloc(sizeof(*addr) + sizeof(short) + 16, GFP_KERNEL);
        if (!addr)
                goto out;

Are you sure you can use spin_lock here? 

Jarek P.
