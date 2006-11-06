Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753606AbWKFW6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbWKFW6L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753905AbWKFW6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:58:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41859 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753606AbWKFW6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:58:09 -0500
Date: Mon, 6 Nov 2006 14:57:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, acme@conectiva.com.br
Subject: Re: + net-uninline-skb_put.patch added to -mm tree
Message-Id: <20061106145757.8f59caa8.akpm@osdl.org>
In-Reply-To: <20061106.144233.23011532.davem@davemloft.net>
References: <200611032218.kA3MITih003548@shell0.pdx.osdl.net>
	<20061106.144233.23011532.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2006 14:42:33 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: akpm@osdl.org
> Date: Fri, 03 Nov 2006 14:18:29 -0800
> 
> > Subject: net: uninline skb_put()
> > From: Andrew Morton <akpm@osdl.org>
> > 
> > It has 34 callsites for a total of 2650 bytes.
> > 
> > Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> 
> A more accurate figure would probably be:
> 
> davem@sunset:~/src/GIT/net-2.6$ git grep skb_put | grep -v __skb_put | wc -l
> 1167
> 
> :-)

True.  I'm not sure what .config Arnaldo was using..

> Half of the cost of this interface are the assertions, which while
> useful are obviously over the top for such an oft-used routine in
> packet processing.
> 
> Without the assertion checks it's merely:
> 
> 	unsigned char *tmp = skb->tail;
> 	skb->tail += len;
> 	skb->len  += len;
> 	return tmp;
> 
> And even with 1167 call sites that is definitely something which
> should be inlined.

Yes.

Tricky.  I guess one suitable approach would be to create a standalone
skb-debugging config option.  There's quite a lot of debug stuff in there
which could be made conditional on that option.

But otoh, skb-debugging finds bugs.
