Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbTJYWzz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 18:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263110AbTJYWzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 18:55:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:52451 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262865AbTJYWzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 18:55:54 -0400
Date: Sat, 25 Oct 2003 15:56:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Phillips <phillim2@comcast.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, jgarzik@pobox.com,
       shemminger@osdl.org, netdev@oss.sgi.com
Subject: Re: [PATCH] ibmtr_cs/ibmtr on 2.6.0-test9 - get working again
Message-Id: <20031025155649.148bad99.akpm@osdl.org>
In-Reply-To: <20031025221435.GA18782@siasl.dyndns.org>
References: <20031025221435.GA18782@siasl.dyndns.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Phillips <phillim2@comcast.net> wrote:
>
> -    dev = alloc_trdev(sizeof(*info));
>  +    info = kmalloc(sizeof(*info), GFP_KERNEL); 
>  +    if (!info) return NULL;
>  +    memset(info,0,sizeof(*info));
>  +    dev = alloc_trdev(sizeof(struct tok_info));
>       if (!dev)
>   	    return NULL;

This return leaks the memory at `info'.
