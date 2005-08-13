Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVHMSSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVHMSSQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 14:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVHMSSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 14:18:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50110 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932235AbVHMSSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 14:18:16 -0400
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference
	between /dev/kmem and /dev/mem)
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508131034350.19049@g5.osdl.org>
References: <1123796188.17269.127.camel@localhost.localdomain>
	 <1123809302.17269.139.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
	 <1123951810.3187.20.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0508130955010.19049@g5.osdl.org>
	 <1123953924.3187.22.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0508131034350.19049@g5.osdl.org>
Content-Type: text/plain
Date: Sat, 13 Aug 2005 20:18:07 +0200
Message-Id: <1123957087.3187.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-13 at 10:37 -0700, Linus Torvalds wrote:
> 
> On Sat, 13 Aug 2005, Arjan van de Ven wrote:
> > 
> > attached is the same patch but now with Steven's change made as well
> 
> Actually, the more I looked at that mmap_kmem() function, the less I liked 
> it.  Let's get that sucker fixed better first. It's still not wonderful, 
> but at least now it tries to verify the whole _range_ of the mapping.

actually if that is your goal this just isn't enough... assume the
situation of a 1 page "forbidden gap", if you mmap 3 pages with the gap
in the middle.... then the code you send still doesn't cope. At which
point... it gets messy...

