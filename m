Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263950AbUD0Loj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263950AbUD0Loj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 07:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbUD0Loj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 07:44:39 -0400
Received: from web12824.mail.yahoo.com ([216.136.174.205]:5508 "HELO
	web12824.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263950AbUD0Loi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 07:44:38 -0400
Message-ID: <20040427114437.66819.qmail@web12824.mail.yahoo.com>
Date: Tue, 27 Apr 2004 04:44:37 -0700 (PDT)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page writeback
To: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: sgoel01@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040426225834.7035d2c1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Andrew Morton <akpm@osdl.org> wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> >
> > 
> > Err... Anything that currently ends up calling
> writepage() and returning
> > WRITEPAGE_ACTIVATE. This is a problem that you
> believe you are seeing
> > the effects of, right? 
> 
> I didn't report the problem - Shantanu is reporting
> problems where all the
> NFS pages are stuck on the active list and the VM
> has nothing to reclaim on
> the inactive list.
> 

Yup, what happens is the NFS writepage() returns
WRITEPAGE_ACTIVATE causing the scanner to place the
page at the head of the active list.  Now the page
won't be reclaimed until the scanner has run through
the entire active list.  I do not see such behaviour
with ext3 for instance.



	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
