Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVBWRhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVBWRhV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 12:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVBWRhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 12:37:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11149 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261507AbVBWRhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 12:37:14 -0500
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
From: Arjan van de Ven <arjan@infradead.org>
To: Olof Johansson <olof@austin.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Joe Korty <joe.korty@ccur.com>,
       Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
In-Reply-To: <20050223171015.GD10256@austin.ibm.com>
References: <20050222190646.GA7079@austin.ibm.com>
	 <20050222115503.729cd17b.akpm@osdl.org>
	 <20050222210752.GG22555@mail.shareable.org>
	 <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org>
	 <20050223144940.GA880@tsunami.ccur.com>
	 <Pine.LNX.4.58.0502230751140.2378@ppc970.osdl.org>
	 <20050223171015.GD10256@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 18:37:01 +0100
Message-Id: <1109180222.6290.89.camel@laptopd505.fenrus.org>
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

On Wed, 2005-02-23 at 11:10 -0600, Olof Johansson wrote:
> On Wed, Feb 23, 2005 at 07:54:06AM -0800, Linus Torvalds wrote:
> 
> > > Otherwise, a preempt attempt in get_user would not be seen
> > > until some future preempt_enable was executed.
> > 
> > True. I guess we should have a "preempt_check_resched()" there too. That's 
> > what "kunmap_atomic()" does too (which is what we rely on in the other 
> > case we do this..)
> 
> Ok, this is getting complex enough to warrant get_user_inatomic(),
> which means adding it to every arch's uaccess.h.
> 
> Below patch does so. Unfortunately I don't have a Viro setup with cross
> compilers for nearly every arch, so I can't make sure it doesn't break
> anything. But since I pasted the same code everywhere it shouldn't.

I hate to do this to you, but get_user is a bit horrible in that it is
an untyped interface. Fixing it is hard (ugh) but when adding new
variants should/could we consider to please make it a typed (eg inline
and not a define) interface please ?


