Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbULOA2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbULOA2J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbULOAVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:21:39 -0500
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:40079 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261729AbULOAKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:10:15 -0500
Subject: Re: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0412142304160.11826-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0412142304160.11826-100000@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 15 Dec 2004 11:10:10 +1100
Message-Id: <1103069410.5420.40.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 23:26 +0000, Hugh Dickins wrote:
> On Tue, 14 Dec 2004, Greg KH wrote:
> > 
> > So I finally try to get dri working on my laptop and I get the following
> > kernel bug when killing X (the program gish was running at the time):
> > 
> > kernel BUG at mm/rmap.c:480!
> > EIP is at page_remove_rmap+0x32/0x40
> > Process gish (pid: 10864, threadinfo=c8aea000 task=c7c2c040)
> >  [<c0141495>] zap_pte_range+0x135/0x290
> >...
> >  [<c0145f41>] exit_mmap+0x71/0x140
> >  [<c01163c4>] mmput+0x24/0x80
> >  [<c011a756>] do_exit+0x146/0x370
> >...
> 
> It's my BUG_ON(page_mapcount(page) < 0).
> 
> We've had about one report per month, over the last six months.
> But this is the first citing "gish"; sometimes it's been "cc1".
> 
> I've given it a lot of thought, but I'm still mystified.  The last
> report turned out to be attributable to bad memory; but this BUG_ON
> is too persistent and specific to be put down to that in all cases.
> 
> One case that's easy to explain: if it was preceded (perhaps hours
> earlier) by a "Bad page state" message and stacktrace, referring to
> the same page (in ecx, edx, ebp in your dump), which showed non-zero
> mapcount, then this is an after-effect of bad_page resetting mapcount.
> And the real problem was probably a double free, which bad_page noted,
> but carried on regardless.  Worth checking your logs for, let us know,
> but there have been several reports where that's definitely not so.
> 


"EIP:    0060:[<c0147d72>]    Not tainted VLI"
                              ^^^^^^^^^^^

Just FYI, that kernel should be tainting on bad_page...


