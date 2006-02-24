Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWBXOpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWBXOpl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 09:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWBXOpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 09:45:41 -0500
Received: from kanga.kvack.org ([66.96.29.28]:28320 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932191AbWBXOpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 09:45:40 -0500
Date: Fri, 24 Feb 2006 09:40:28 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid calling down_read and down_write during startup
Message-ID: <20060224144028.GB7101@kvack.org>
References: <20060223161631.6f8fa41d.akpm@osdl.org> <Pine.LNX.4.44L0.0602232211260.19776-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0602232211260.19776-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 10:18:18PM -0500, Alan Stern wrote:
> Ben, earlier you expressed concern about the extra overhead due to 
> cache-line contention (on SMP) in the down_read() call added to 
> blocking_notifier_call_chain.  I don't remember which notifier chain in 
> particular you were worried about; something to do with networking.
> 
> Does this still bother you?  I can see a couple of ways around it.

Yes it's a problem.  Any read lock is going to act as a memory barrier, 
and we need fewer of those in hot paths, not more to slow things down.  

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
