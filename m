Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbVHYJbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbVHYJbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 05:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVHYJbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 05:31:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42966 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964904AbVHYJbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 05:31:08 -0400
Subject: Re: [PATCH] removes filp_count_lock and changes nr_files type to
	atomic_t
From: Arjan van de Ven <arjan@infradead.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <430D8D76.6040907@cosmosbay.com>
References: <20050824214610.GA3675@localhost.localdomain>
	 <1124956563.3222.8.camel@laptopd505.fenrus.org>
	 <430D8518.8020502@cosmosbay.com>
	 <1124960744.3222.11.camel@laptopd505.fenrus.org>
	 <430D8D76.6040907@cosmosbay.com>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 11:31:02 +0200
Message-Id: <1124962263.3222.14.camel@laptopd505.fenrus.org>
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

> > 
> > this patch adds atomic ops where there were none before
> 
> nope... a spinlock/spinunlock contains atomic ops.

unlock usually doesn't but ok

> 
> > for those architectures that need atomics for read (parisc? arm?)
> 
> not today. No atomic needed for read.
> 
> > 
> > however.. wouldn't it be better to make this a per cpu variable for
> > write, and for read iterate or do something smart otherwise?
> 
> So on a machine with 256 CPUS, you want to iterate 256 counters ?

you can be smart about this, similar to what ext3 and others do for
similar counters


