Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVCFFnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVCFFnv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 00:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVCFFnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 00:43:50 -0500
Received: from fmr21.intel.com ([143.183.121.13]:12777 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261316AbVCFFns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 00:43:48 -0500
Date: Sat, 5 Mar 2005 21:43:37 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] remove aggressive idle balancing
Message-ID: <20050305214336.A9085@unix-os.sc.intel.com>
References: <1109229491.5177.71.camel@npiggin-nld.site> <1109229542.5177.73.camel@npiggin-nld.site> <1109229650.5177.78.camel@npiggin-nld.site> <1109229700.5177.79.camel@npiggin-nld.site> <1109229760.5177.81.camel@npiggin-nld.site> <1109229867.5177.84.camel@npiggin-nld.site> <1109229935.5177.85.camel@npiggin-nld.site> <1109230031.5177.87.camel@npiggin-nld.site> <20050224084118.GB10023@elte.hu> <421DC4DA.7000102@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <421DC4DA.7000102@yahoo.com.au>; from nickpiggin@yahoo.com.au on Thu, Feb 24, 2005 at 11:13:14PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 11:13:14PM +1100, Nick Piggin wrote:
> Ingo Molnar wrote:
> > * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > 
> > 
> >> [PATCH 6/13] no aggressive idle balancing
> >>
> >> [PATCH 8/13] generalised CPU load averaging
> >> [PATCH 9/13] less affine wakups
> >> [PATCH 10/13] remove aggressive idle balancing
> > 
> > 
> > they look fine, but these are the really scary ones :-) Maybe we could
> > do #8 and #9 first, then #6+#10. But it's probably pointless to look at
> > these in isolation.
> > 
> 
> Oh yes, they are very scary and I guarantee they'll cause
> problems :P

By code inspection, I see an issue with this patch
	[PATCH 10/13] remove aggressive idle balancing

Why are we removing cpu_and_siblings_are_idle check from active_load_balance?
In case of SMT, we  want to give prioritization to an idle package while
doing active_load_balance(infact, active_load_balance will be kicked
mainly because there is an idle package) 

Just the re-addition of cpu_and_siblings_are_idle check to 
active_load_balance might not be enough. We somehow need to communicate 
this to move_tasks, otherwise can_migrate_task will fail and we will 
never be able to do active_load_balance.

thanks,
suresh
