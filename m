Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUEJSmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUEJSmc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 14:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUEJSmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 14:42:32 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:38574 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261231AbUEJSmb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 14:42:31 -0400
Date: Tue, 11 May 2004 00:09:25 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, wli@holomorphy.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: dentry bloat.
Message-ID: <20040510183925.GB4813@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org> <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org> <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org> <20040508204239.GB6383@in.ibm.com> <409DDDAE.3090700@colorfullife.com> <20040509153316.GE4007@in.ibm.com> <20040509221712.GA17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040509221712.GA17014@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2004 at 11:17:12PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Sun, May 09, 2004 at 09:03:16PM +0530, Dipankar Sarma wrote:
>  
> > Actually, what may happen is that since the dentries are added
> > in the front, a double move like that would result in hash chain
> > traversal looping. Timing dependent and unlikely, but d_move_count
> > avoided that theoritical possibility. It is not about skipping
> > dentries which is safe because a miss would result in a real_lookup()
> 
> Not really.  A miss could result in getting another dentry allocated
> for the same e.g. directory, which is *NOT* harmless at all.

AFAICS, a miss in __d_lookup would result in a repeat lookup
under dcache_lock in which case we are safe or real_lookup()
which in turn does another lookup with dcache_lock. Is there
a path that I am missing here ?

Thanks
Dipankar
