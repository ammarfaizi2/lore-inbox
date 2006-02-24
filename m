Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWBXPUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWBXPUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 10:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWBXPUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 10:20:14 -0500
Received: from kanga.kvack.org ([66.96.29.28]:63392 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932186AbWBXPUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 10:20:13 -0500
Date: Fri, 24 Feb 2006 10:15:10 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid calling down_read and down_write during startup
Message-ID: <20060224151510.GC7101@kvack.org>
References: <20060224144028.GB7101@kvack.org> <Pine.LNX.4.44L0.0602241003450.5071-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0602241003450.5071-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 10:04:23AM -0500, Alan Stern wrote:
> What do you think of the two suggestions in my previous message?

Even if the read version of the lock only touches a cacheline local to 
the cpu, you'd still have to use the lock prefix to allow for correctness 
when a writer comes along.  It is not cacheline bouncing that worries me, 
it is serialising instructions and memory barriers as those hurt immensely 
when the data is in the cache.  I've been looking at a lot of profiles on 
P4s of late, and every single locked instruction is painful as it means 
all of the memory ordering rules come into play.  Neither suggestion 
addresses that overhead that has been introduced.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
