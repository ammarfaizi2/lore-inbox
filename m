Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285113AbRLFLQo>; Thu, 6 Dec 2001 06:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285114AbRLFLQe>; Thu, 6 Dec 2001 06:16:34 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:779 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S285113AbRLFLQX>; Thu, 6 Dec 2001 06:16:23 -0500
Date: Thu, 6 Dec 2001 12:16:16 +0100
From: Jan Kara <jack@suse.cz>
To: Craig Christophel <merlin@transgeek.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: shrink_caches inconsistancy
Message-ID: <20011206121615.A21816@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011205180526.DCB78C7382@smtp.transgeek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011205180526.DCB78C7382@smtp.transgeek.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> 	This patch makes the comments match for icache,dcache,dqcache   shrink 
> functions.  Initially the comment stated that a priority of 0 could be used, 
> but after looking into mm/vmscan.c::shrink_caches this cannot be true.  So 
> the comment now states that 1 is the highest priority.  This appears __really 
> true as at priority 1 all of the cache possible is removed.
> 
> 	Also shrink_dqcache_memory now uses the count variable like everyone else.
> 	
> 	Possibly incorrect __GFP_FS check added to the dqcache function.  but again 
> consistancy is my goal.  
  This check really isn't needed for shrink_dqcache() function. This function can
never recurse into fs so there's no need to have __GFP_FS set.

> 	Another dqcache issue in that the dqcache was being shrunk at priority+1 
> rather than at priority, this looked suspect, and with no comment around the 
> code, it to has been remanded to consistancy.
  OK :). If I remeber well I saw 'priority' could be 0 somewhere in the comment
and so I added +1 to avoid division by zero. But you're right that code in vmscan.c
actually never calls the functions with priority == 0.

								Honza
