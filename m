Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbUEQVJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUEQVJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 17:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUEQVJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 17:09:24 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:50269 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262020AbUEQVJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 17:09:22 -0400
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
	s->tree' failed: The saga continues.)
From: Steven Cole <elenstev@mesatop.com>
To: Chris Mason <mason@suse.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>, hugh@veritas.com,
       adi@bitmover.com, support@bitmover.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1084825489.20437.390.camel@watt.suse.com>
References: <200405132232.01484.elenstev@mesatop.com>
	 <20040517022816.GA14939@work.bitmover.com>
	 <Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org>
	 <200405162136.24441.elenstev@mesatop.com>
	 <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org>
	 <20040517141427.GD29054@work.bitmover.com>
	 <Pine.LNX.4.58.0405170717080.25502@ppc970.osdl.org>
	 <20040517145217.GA30695@work.bitmover.com>
	 <Pine.LNX.4.58.0405170758260.25502@ppc970.osdl.org>
	 <1084807424.20437.60.camel@watt.suse.com>
	 <1084825489.20437.390.camel@watt.suse.com>
Content-Type: text/plain
Message-Id: <1084828124.26340.22.camel@spc0.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-4mdk 
Date: Mon, 17 May 2004 15:08:44 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-17 at 14:24, Chris Mason wrote:
> On Mon, 2004-05-17 at 11:23, Chris Mason wrote:
> 
> > You've described it correctly for reiserfs though, we unlock the page
> > too soon.  I'll fix the page locking for reiserfs_file_write.  Steven,
> > we need to figure out why you're seeing this on ext3.  
> 
> Steven, could you give this a try as well?  It is against 2.6.6-mm3, but
> should work against vanilla too:
> 
> reiserfs_file_write unlocks the pages it operated on before updating
> i_size.  This can lead to races with writepage, who checks i_size when
> deciding how much of the file to zero out.
> 
> This patch also replaces SetPageReferenced with mark_page_accessed() in
> reiserfs_file_write
> 
> Index: linux.mm/fs/reiserfs/file.c

OK, my plan is to do this:

1) Apply your patch to 2.6.6-current, build with PREEMPT
2) Test bk pull via ppp on reiserfs until and if it breaks.
3) Test bk pull via ppp on ext3 and take a look at the s.ChangeSet file
if/when the failure occurs.
4) Apply akpm's patch here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108478018304305&w=2
5) Repeat 2,3

Here I'm defining 2.6.6-current as what was current at around midnight
last night.  I'll keep that source tree as a constant.

I'll post the results either late tonight or tomorrow.

Steven

