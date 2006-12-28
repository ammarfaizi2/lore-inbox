Return-Path: <linux-kernel-owner+w=401wt.eu-S964924AbWL1GKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWL1GKz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 01:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWL1GKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 01:10:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:27817 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964924AbWL1GKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 01:10:54 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,214,1165219200"; 
   d="scan'208"; a="182341216:sNHT22382885"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>,
       "David Miller" <davem@davemloft.net>
Cc: <ranma@tdiedrich.de>, <gordonfarquharson@gmail.com>, <tbm@cyrius.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>, <andrei.popa@i-neo.ro>,
       "Andrew Morton" <akpm@osdl.org>, <hugh@veritas.com>,
       <nickpiggin@yahoo.com.au>, <arjan@infradead.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm: fix page_mkclean_one
Date: Wed, 27 Dec 2006 22:10:52 -0800
Message-ID: <000101c72a46$ee2296b0$bc84030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccqLS9Kqo4sjztNSZqePKJs01fm0gAFnoNAAACayxA=
In-Reply-To: <000001c72a44$c3da12e0$bc84030a@amr.corp.intel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth wrote on Wednesday, December 27, 2006 9:55 PM
> Linus Torvalds wrote on Wednesday, December 27, 2006 7:05 PM
> > On Wed, 27 Dec 2006, David Miller wrote:
> > > > 
> > > > I still don't see _why_, though. But maybe smarter people than me can see 
> > > > it..
> > > 
> > > FWIW this program definitely triggers the bug for me.
> > 
> > Ok, now that I have something simple to do repeatable stuff with, I can 
> > say what the pattern is.. It's not all that surprising, but it's still 
> > worth just stating for the record.
> 
> 
> Running the test code, git bisect points its finger at this commit. Reverting
> this commit on top of 2.6.20-rc2 doesn't trigger the bug from the test code.
> 
> edc79b2a46ed854595e40edcf3f8b37f9f14aa3f is first bad commit
> commit edc79b2a46ed854595e40edcf3f8b37f9f14aa3f
> Author: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Date:   Mon Sep 25 23:30:58 2006 -0700
> 
>     [PATCH] mm: balance dirty pages
> 
>     Now that we can detect writers of shared mappings, throttle them.  Avoids OOM
>     by surprise.


Oh, never mind :-(  I just didn't create enough write out pressure when
test this. I just saw bug got triggered on a kernel I previously thought
was OK.
