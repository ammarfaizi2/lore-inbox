Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbVCKMjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbVCKMjH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 07:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVCKMjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 07:39:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23748 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262687AbVCKMip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 07:38:45 -0500
Subject: Re: inappropriate use of in_atomic()
From: Arjan van de Ven <arjan@infradead.org>
To: Roland Dreier <roland@topspin.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <52k6oe9412.fsf@topspin.com>
References: <20050310204006.48286d17.akpm@osdl.org>
	 <52k6oe9412.fsf@topspin.com>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 13:38:39 +0100
Message-Id: <1110544720.9917.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 20:53 -0800, Roland Dreier wrote:
>     > Consequently the use of in_atomic() in the below files is probably
>     > deadlocky if CONFIG_PREEMPT=n:
>     ...
>     > 	drivers/infiniband/core/mad.c
> 
> Thanks for pointing this out.  I'll get you a patch in the next day or
> two.  As you can probably tell, the code is just trying to decide
> whether to use GFP_ATOMIC or GFP_KERNEL to allocate a couple of
> things, depending on what context we're being called from.  So at
> worst we can just change to GFP_ATOMIC unconditionally.

normally you are supposed to know what context your allocating function
is called in... if you don't know that often is a sign of a misdesign...

