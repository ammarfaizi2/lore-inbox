Return-Path: <linux-kernel-owner+w=401wt.eu-S964946AbWL1G2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWL1G2P (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 01:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWL1G2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 01:28:15 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:2413
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S964946AbWL1G2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 01:28:14 -0500
Date: Wed, 27 Dec 2006 22:27:48 -0800 (PST)
Message-Id: <20061227.222748.74746488.davem@davemloft.net>
To: kenneth.w.chen@intel.com
Cc: torvalds@osdl.org, ranma@tdiedrich.de, gordonfarquharson@gmail.com,
       tbm@cyrius.com, a.p.zijlstra@chello.nl, andrei.popa@i-neo.ro,
       akpm@osdl.org, hugh@veritas.com, nickpiggin@yahoo.com.au,
       arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix page_mkclean_one
From: David Miller <davem@davemloft.net>
In-Reply-To: <000101c72a46$ee2296b0$bc84030a@amr.corp.intel.com>
References: <000001c72a44$c3da12e0$bc84030a@amr.corp.intel.com>
	<000101c72a46$ee2296b0$bc84030a@amr.corp.intel.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Date: Wed, 27 Dec 2006 22:10:52 -0800

> Chen, Kenneth wrote on Wednesday, December 27, 2006 9:55 PM
> > Linus Torvalds wrote on Wednesday, December 27, 2006 7:05 PM
> > > On Wed, 27 Dec 2006, David Miller wrote:
> > > > > 
> > > > > I still don't see _why_, though. But maybe smarter people than me can see 
> > > > > it..
> > > > 
> > > > FWIW this program definitely triggers the bug for me.
> > > 
> > > Ok, now that I have something simple to do repeatable stuff with, I can 
> > > say what the pattern is.. It's not all that surprising, but it's still 
> > > worth just stating for the record.
> > 
> > 
> > Running the test code, git bisect points its finger at this commit. Reverting
> > this commit on top of 2.6.20-rc2 doesn't trigger the bug from the test code.
> > 
> > edc79b2a46ed854595e40edcf3f8b37f9f14aa3f is first bad commit
> > commit edc79b2a46ed854595e40edcf3f8b37f9f14aa3f
> > Author: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > Date:   Mon Sep 25 23:30:58 2006 -0700
> > 
> >     [PATCH] mm: balance dirty pages
> > 
> >     Now that we can detect writers of shared mappings, throttle them.  Avoids OOM
> >     by surprise.
> 
> 
> Oh, never mind :-(  I just didn't create enough write out pressure when
> test this. I just saw bug got triggered on a kernel I previously thought
> was OK.

Besides, I'm pretty sure that from the Debian bug entry it's been
established that the dirty-page tracking changes from a few releases
ago introduced this problem.
