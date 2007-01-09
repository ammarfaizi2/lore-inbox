Return-Path: <linux-kernel-owner+w=401wt.eu-S932299AbXAISeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbXAISeI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 13:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbXAISeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 13:34:08 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59841 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932299AbXAISeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 13:34:07 -0500
Date: Tue, 9 Jan 2007 10:30:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: =?ISO-8859-1?Q?Malte_Schr=F6der?= <MalteSch@gmx.de>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       reiserfs-dev@namesys.com
Subject: Re: 2.6.20-rc4: known unfixed regressions (v2)
In-Reply-To: <200701091908.44576.MalteSch@gmx.de>
Message-ID: <Pine.LNX.4.64.0701091022180.3594@woody.osdl.org>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
 <20070109052510.GG25007@stusta.de> <Pine.LNX.4.64.0701090944070.3594@woody.osdl.org>
 <200701091908.44576.MalteSch@gmx.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-1780670073-1168367443=:3594"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-1780670073-1168367443=:3594
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 9 Jan 2007, Malte Schröder wrote:
> 
> > So something interesting is definitely going on, but I don't know exactly
> > what it is. Why does reiserfs do the truncate as part of a close, if the
> > same inode is actually mapped somewhere else? And if it's a race with two
> > different CPU's (one doing a "munmap()" and the other doing a "close()",
> > then the unmap should _still_ have actually unmapped the pages before it
> > actually did _its_ "release()" call.
> 
> This was on a single core. But with CONFIG_PREEMPT_VOLUNTARY=y.
> It didn't happen again since then. 

Yeah, PREEMPT would be able to show most races like this too. In fact, 
some races show up much better with preemption than they do with real SMP.

But I haven't looked at what exactly reiserfs does. I did check that the 
VM layer definitely does the remove_vma() stuff (that actually closes the 
files) _after_ it has unmapped everything. It would have surprised me if 
we had had that kind of bug, but still..

		Linus
---1463790079-1780670073-1168367443=:3594--
