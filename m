Return-Path: <linux-kernel-owner+w=401wt.eu-S965026AbWL1WfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWL1WfR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 17:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWL1WfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 17:35:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:46136 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965024AbWL1WfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 17:35:16 -0500
X-Authenticated: #14349625
Subject: Re: [PATCH] mm: fix page_mkclean_one
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Guillaume Chazarain <guichaz@yahoo.fr>,
       David Miller <davem@davemloft.net>, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, tbm@cyrius.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       hugh@veritas.com, nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chen Kenneth W <kenneth.w.chen@intel.com>
In-Reply-To: <20061228114517.3315aee7.akpm@osdl.org>
References: <20061226.205518.63739038.davem@davemloft.net>
	 <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org>
	 <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org>
	 <20061227.165246.112622837.davem@davemloft.net>
	 <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
	 <4593DE31.4070401@yahoo.fr> <459418D2.2000702@yahoo.fr>
	 <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
	 <20061228114517.3315aee7.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 28 Dec 2006 23:35:10 +0100
Message-Id: <1167345310.5980.27.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-28 at 11:45 -0800, Andrew Morton wrote:
> On Thu, 28 Dec 2006 11:28:52 -0800 (PST)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > 
> > 
> > On Thu, 28 Dec 2006, Guillaume Chazarain wrote:
> > > 
> > > The attached patch fixes the corruption for me.
> > 
> > Well, that's a good hint, but it's really just a symptom. You effectively 
> > just made the test-program not even try to flush the data to disk, so the 
> > page cache would stay in memory, and you'd not see the corruption as well.
> > 
> > So you basically disabled the code that tried to trigger the bug more 
> > easily.
> > 
> > But the reason I say it's interesting is that "WB_SYNC_NONE" is very much 
> > implicated in mm/page-writeback.c, and if there is a bug triggered by 
> > WB_SYNC_NONE writebacks, then that would explain why page-writeback.c also 
> > fails..
> > 
> 
> It would be interesting to convert your app to do fsync() before
> FADV_DONTNEED.  That would take WB_SYNC_NONE out of the picture as well
> (apart from pdflush activity).

I did fdatasync(), tried remapping before unmapping... nogo here.

