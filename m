Return-Path: <linux-kernel-owner+w=401wt.eu-S964929AbWL1FzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWL1FzZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 00:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWL1FzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 00:55:25 -0500
Received: from mga03.intel.com ([143.182.124.21]:20609 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964929AbWL1FzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 00:55:24 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,214,1165219200"; 
   d="scan'208"; a="163039431:sNHT27267009"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>,
       "David Miller" <davem@davemloft.net>
Cc: <ranma@tdiedrich.de>, <gordonfarquharson@gmail.com>, <tbm@cyrius.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>, <andrei.popa@i-neo.ro>,
       "Andrew Morton" <akpm@osdl.org>, <hugh@veritas.com>,
       <nickpiggin@yahoo.com.au>, <arjan@infradead.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm: fix page_mkclean_one
Date: Wed, 27 Dec 2006 21:55:21 -0800
Message-ID: <000001c72a44$c3da12e0$bc84030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccqLS9Kqo4sjztNSZqePKJs01fm0gAFnoNA
In-Reply-To: <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote on Wednesday, December 27, 2006 7:05 PM
> On Wed, 27 Dec 2006, David Miller wrote:
> > > 
> > > I still don't see _why_, though. But maybe smarter people than me can see 
> > > it..
> > 
> > FWIW this program definitely triggers the bug for me.
> 
> Ok, now that I have something simple to do repeatable stuff with, I can 
> say what the pattern is.. It's not all that surprising, but it's still 
> worth just stating for the record.


Running the test code, git bisect points its finger at this commit. Reverting
this commit on top of 2.6.20-rc2 doesn't trigger the bug from the test code.


edc79b2a46ed854595e40edcf3f8b37f9f14aa3f is first bad commit
commit edc79b2a46ed854595e40edcf3f8b37f9f14aa3f
Author: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date:   Mon Sep 25 23:30:58 2006 -0700

    [PATCH] mm: balance dirty pages

    Now that we can detect writers of shared mappings, throttle them.  Avoids OOM
    by surprise.

    Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
    Cc: Hugh Dickins <hugh@veritas.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>
