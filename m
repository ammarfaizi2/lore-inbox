Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbTGLFf7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 01:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267706AbTGLFf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 01:35:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5305 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S267705AbTGLFf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 01:35:58 -0400
Date: Fri, 11 Jul 2003 22:41:42 -0700
From: "David S. Miller" <davem@redhat.com>
To: James Morris <jmorris@intercode.com.au>
Cc: jkenisto@us.ibm.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       akpm@osdl.org, jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk,
       rddunlap@osdl.org, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH - RFC] [1/2] 2.6 must-fix list - kernel error reporting
Message-Id: <20030711224142.557b5b5e.davem@redhat.com>
In-Reply-To: <Mutt.LNX.4.44.0307120135120.21806-100000@excalibur.intercode.com.au>
References: <3F0DB9A5.23723BE1@us.ibm.com>
	<Mutt.LNX.4.44.0307120135120.21806-100000@excalibur.intercode.com.au>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jul 2003 01:37:44 +1000 (EST)
James Morris <jmorris@intercode.com.au> wrote:

> Indeed, the kernel socket buffer fills up.
> 
> I think this needs to be addressed in the netlink code, per the patch 
> below.
...
> +	/* Don't bother queuing skb if kernel socket has no input function */
> +        if (nlk->pid == 0 && !nlk->data_ready)
> +        	goto no_dst;
> +

Oops, turns out this doesn't work.  data_ready is never NULL, look at
how netlink_kernel_create() works.

Also, the broadcast case probably needs to be handled
too?

As an aside, to be honest what's so wrong with the socket receive
buffer filling up?  The damage is limited to the receive buffer size
of the kernel netlink socket, but that's it.
