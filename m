Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUD1ArL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUD1ArL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 20:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbUD1ArL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 20:47:11 -0400
Received: from web12824.mail.yahoo.com ([216.136.174.205]:20319 "HELO
	web12824.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264531AbUD1ArJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 20:47:09 -0400
Message-ID: <20040428004707.89142.qmail@web12824.mail.yahoo.com>
Date: Tue, 27 Apr 2004 17:47:07 -0700 (PDT)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page writeback
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>
Cc: sgoel01@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <1083080207.2616.31.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew/Trond,

Any consensus as to what the right approach is here?

One cheap though perhaps hack'ish solution would be to
introduce yet another special error code like
WRITEPAGE_ACTIVATE which instead of moving the page to
the head of the active list instead moves it to the
head of the inactive list.  In this case, would it
also make sense for balance_pgdat() to
wakeup_bdflush() before blk_congestion_wait()? 
Otherwise, kswapd() would keep looping over the same
pages at least until kupdate kicks in or a process
stalls in try_to_free_pages()?

Thanks,
Shantanu



	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
