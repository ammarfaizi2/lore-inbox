Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVDRQQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVDRQQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 12:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVDRQQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 12:16:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60375 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261401AbVDRQQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 12:16:23 -0400
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
From: Arjan van de Ven <arjan@infradead.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Roland Dreier <roland@topspin.com>, Troy Benjegerdes <hozer@hozed.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <4263DBBF.9040801@ammasso.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	 <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>
	 <4263DBBF.9040801@ammasso.com>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 18:16:12 +0200
Message-Id: <1113840973.6274.84.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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

On Mon, 2005-04-18 at 11:09 -0500, Timur Tabi wrote:
> Roland Dreier wrote:
> >     Troy> How is memory pinning handled? (I haven't had time to read
> >     Troy> all the code, so please excuse my ignorance of something
> >     Troy> obvious).
> > 
> > The userspace library calls mlock() and then the kernel does
> > get_user_pages().
> 
> Why do you call mlock() and get_user_pages()?  In our code, we only call mlock(), and the 
> memory is pinned. 

this is a myth; linux is free to move the page about in physical memory
even if it's mlock()ed!!

And even then, the user can munlock the memory from another thread etc
etc. Not a good idea.

get_user_pages() is used from AIO and other parts of the kernel for
similar purposes and in fact is designed for it, so it better work. If
it has bugs those should be fixed, not worked around!


