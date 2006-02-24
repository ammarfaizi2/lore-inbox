Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWBXQtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWBXQtT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWBXQtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:49:19 -0500
Received: from kanga.kvack.org ([66.96.29.28]:12963 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932292AbWBXQtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:49:17 -0500
Date: Fri, 24 Feb 2006 11:44:15 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid calling down_read and down_write during startup
Message-ID: <20060224164415.GA7999@kvack.org>
References: <20060224151510.GC7101@kvack.org> <Pine.LNX.4.44L0.0602241135450.5177-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0602241135450.5177-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 11:44:23AM -0500, Alan Stern wrote:
> In that case you should be worried not about acquiring and releasing the 
> rwsem at the beginning and end of blocking_notifier_call_chain; you should 
> be worried about all the RCU serialization in the core 
> notifier_call_chain routine.

RCU doesn't synchronize readers.

> The atomic chains are a different matter.  The ones that don't run in NMI 
> context could use an rw-spinlock for protection, allowing them also to 
> avoid memory barriers while going through the list.  The notifier chains 
> that do run in NMI don't have this luxury.  Fortunately I don't think 
> there are very many of them.

A read lock is a memory barrier.  That's why I'm opposed to using non-rcu 
style locking for them.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
