Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVHRBFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVHRBFe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 21:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbVHRBFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 21:05:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:12984 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932070AbVHRBFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 21:05:33 -0400
Date: Thu, 18 Aug 2005 03:05:25 +0200
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, Benjamin LaHaise <bcrl@linux.intel.com>,
       "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct file cleanup : the very large file_ra_state is now allocated only on demand.
Message-ID: <20050818010524.GW3996@wotan.suse.de>
References: <20050810164655.GB4162@linux.intel.com> <20050810.135306.79296985.davem@davemloft.net> <20050810211737.GA21581@linux.intel.com> <430391F1.9080900@cosmosbay.com> <20050817211829.GK27628@wotan.suse.de> <4303AEC4.3060901@cosmosbay.com> <20050817215357.GU3996@wotan.suse.de> <4303D90E.2030103@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4303D90E.2030103@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 02:40:46AM +0200, Eric Dumazet wrote:
> Andi Kleen a ?crit :
> 
> >
> >>(because of the insane struct file_ra_state f_ra. I wish this structure 
> >>were dynamically allocated only for files that really use it)
> >
> >
> >How about you submit a patch for that instead? 
> >
> >-Andi
> 
> OK, could you please comment this patch ?

I would just set the ra pointer to a single global structure if the allocation
fails. Then you can avoid all the other checks. It will slow down
things and trash some state, but not fail and nobody should expect good 
performance after out of memory anyways. The only check still
needed would be on freeing.

-Andi
