Return-Path: <linux-kernel-owner+w=401wt.eu-S1753684AbWL1TqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbWL1TqA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 14:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753685AbWL1Tp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 14:45:59 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54431 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753683AbWL1Tp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 14:45:59 -0500
Date: Thu, 28 Dec 2006 11:45:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Guillaume Chazarain <guichaz@yahoo.fr>, David Miller <davem@davemloft.net>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com, tbm@cyrius.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       hugh@veritas.com, nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chen Kenneth W <kenneth.w.chen@intel.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one
Message-Id: <20061228114517.3315aee7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
References: <20061226.205518.63739038.davem@davemloft.net>
	<Pine.LNX.4.64.0612271601430.4473@woody.osdl.org>
	<Pine.LNX.4.64.0612271636540.4473@woody.osdl.org>
	<20061227.165246.112622837.davem@davemloft.net>
	<Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
	<4593DE31.4070401@yahoo.fr>
	<459418D2.2000702@yahoo.fr>
	<Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006 11:28:52 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Thu, 28 Dec 2006, Guillaume Chazarain wrote:
> > 
> > The attached patch fixes the corruption for me.
> 
> Well, that's a good hint, but it's really just a symptom. You effectively 
> just made the test-program not even try to flush the data to disk, so the 
> page cache would stay in memory, and you'd not see the corruption as well.
> 
> So you basically disabled the code that tried to trigger the bug more 
> easily.
> 
> But the reason I say it's interesting is that "WB_SYNC_NONE" is very much 
> implicated in mm/page-writeback.c, and if there is a bug triggered by 
> WB_SYNC_NONE writebacks, then that would explain why page-writeback.c also 
> fails..
> 

It would be interesting to convert your app to do fsync() before
FADV_DONTNEED.  That would take WB_SYNC_NONE out of the picture as well
(apart from pdflush activity).

