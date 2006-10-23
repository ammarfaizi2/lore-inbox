Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWJWIuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWJWIuG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 04:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbWJWIuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 04:50:05 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:55515 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751342AbWJWIuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 04:50:04 -0400
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       ralf@linux-mips.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org>
	 <20061020.123635.95058911.davem@davemloft.net>
	 <Pine.LNX.4.64.0610201251440.3962@g5.osdl.org>
	 <20061020.125851.115909797.davem@davemloft.net>
	 <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org>
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 23 Oct 2006 10:50:00 +0200
Message-Id: <1161593400.28813.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-20 at 13:10 -0700, Linus Torvalds wrote:
> 
> On Fri, 20 Oct 2006, David Miller wrote:
> > 
> > I did some more digging, here's what I think the hardware actually
> > does:
> 
> Ok, this sounds sane.
> 
> What should we do about this? How does this patch look to people?
> 
> (Totally untested, and I'm not sure we should even do that whole 
> "oldmm->mm_users" test, but I'm throwing it out here for discussion, in 
> case it matters for performance. The second D$ flush should obviously be 
> unnecessary for the common unthreaded case, which is why none of this has 
> mattered historically, I think).
> 
> Comments? We need ARM, MIPS, sparc and S390 at the very least to sign off 
> on this, and somebody to write a nice explanation for the changelog (and 
> preferably do this through -mm too).

On s390 you never have to worry about cache flushing. It is not stated
anywhere in the principles of operation but the architecture has to be
PIPT, otherwise it couldn't possibly work. The best indication for it is
that there is no cache flush instruction. The view on data in memory is
always consistent.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


