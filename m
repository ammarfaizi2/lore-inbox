Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbVESIP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVESIP2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 04:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVESIP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 04:15:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59532 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262457AbVESIPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 04:15:19 -0400
Subject: Re: [PATCH] prevent NULL mmap in topdown model
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20050519064657.GH23013@shell0.pdx.osdl.net>
References: <Pine.LNX.4.61.0505181556190.3645@chimarrao.boston.redhat.com>
	 <Pine.LNX.4.58.0505181535210.18337@ppc970.osdl.org>
	 <Pine.LNX.4.61.0505182224250.29123@chimarrao.boston.redhat.com>
	 <Pine.LNX.4.58.0505181946300.2322@ppc970.osdl.org>
	 <20050519064657.GH23013@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Thu, 19 May 2005 10:15:10 +0200
Message-Id: <1116490511.6027.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
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

On Wed, 2005-05-18 at 23:46 -0700, Chris Wright wrote:
> * Linus Torvalds (torvalds@osdl.org) wrote:
> > However, it would be good to have even the trivial patch tested. 
> > Especially since what it tries to fix is a total corner-case in the first 
> > place..
> 
> I gave it a quick and simple test.  Worked as expected.  Last page got
> mapped at 0x1000, leaving first page unmapped.  Of course, either with
> MAP_FIXED or w/out MAP_FIXED but proper hint (like -1) you can still
> map first page.  This isn't to say I was extra creative in testing.

sure. Making it *impossible* to mmap that page is bad. People should be
able to do that if they really want to, just doing it if they don't ask
for it is bad.

There are plenty of reasons people may want that page mmaped, one of
them being that the compiler can then do more speculative loads around
null pointer checks. Not saying it's a brilliant idea always, but making
such things impossible makes no sense.


