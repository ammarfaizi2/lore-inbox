Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbTJJWLr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 18:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbTJJWLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 18:11:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:22407 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263122AbTJJWLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 18:11:45 -0400
Subject: Re: 2.6.0-test6-mm4 - oops in __aio_run_iocbs()
From: Daniel McNeil <daniel@osdl.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20031010114821.GA4357@in.ibm.com>
References: <20031005013326.3c103538.akpm@osdl.org>
	 <1065655095.1842.34.camel@ibm-c.pdx.osdl.net>
	 <20031009111624.GA11549@in.ibm.com>
	 <1065721121.1821.16.camel@ibm-c.pdx.osdl.net>
	 <20031010083401.GA3983@in.ibm.com>  <20031010114821.GA4357@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1065823898.1839.21.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Oct 2003 15:11:38 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-10 at 04:48, Suparna Bhattacharya wrote:

> Could you try applying the following hack and see if it makes a 
> difference ?
> 
> I was able to recreate an oops running aiocp with the same arguments
> that you mentioned on 2.6.0-test6-mm4; and that didn't seem to
> occur when I applied this patch.
> 
> Note: This is not a complete fix though and probably room for doing this 
> in a cleaner way. If what I suspect is going on, we'll need more work to get 
> there - like thinking through the case where a request spans an allocated
> region followed by a hole.
> 
> Regards
> Suparna

good news, I tried the patch and the oops no longer occurs.

I also added code to aiocp to check if the AIO reads are completing out
of order, which would cause the AIO writes to out of order.  The reads
are completing in order.  However, I added code to check if the AIO
writes are completing out of order, and, if fact, they do.  Not very
often, but I got 8 i/o where an i/o farther in file completes before
an earlier i/o.

Daniel

