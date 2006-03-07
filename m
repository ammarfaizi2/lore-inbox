Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWCGHo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWCGHo5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 02:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWCGHo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 02:44:57 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:11175 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932444AbWCGHo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 02:44:56 -0500
Date: Tue, 7 Mar 2006 10:44:39 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ingo Oeser <netdev@axxeo.de>
Cc: "David S. Miller" <davem@davemloft.net>, jengelh@linux01.gwdg.de,
       christopher.leech@intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 0/8] Intel I/O Acceleration Technology (I/OAT)
Message-ID: <20060307074438.GA22672@2ka.mipt.ru>
References: <20060303214036.11908.10499.stgit@gitlost.site> <20060304.134144.122314124.davem@davemloft.net> <20060305014324.GA20026@2ka.mipt.ru> <200603061844.07439.netdev@axxeo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603061844.07439.netdev@axxeo.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 07 Mar 2006 10:44:40 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 06:44:07PM +0100, Ingo Oeser (netdev@axxeo.de) wrote:
> Evgeniy Polyakov wrote:
> > On Sat, Mar 04, 2006 at 01:41:44PM -0800, David S. Miller (davem@davemloft.net) wrote:
> > > From: Jan Engelhardt <jengelh@linux01.gwdg.de>
> > > Date: Sat, 4 Mar 2006 19:46:22 +0100 (MET)
> > > 
> > > > Does this buy the normal standard desktop user anything?
> > > 
> > > Absolutely, it optimizes end-node performance.
> > 
> > It really depends on how it is used.
> > According to investigation made for kevent based FS AIO reading,
> > get_user_pages() performange graph looks like sqrt() function
> 
> Hmm, so I should resurrect my user page table walker abstraction?
> 
> There I would hand each page to a "recording" function, which
> can drop the page from the collection or coalesce it in the collector
> if your scatter gather implementation allows it.

It depends on where performance growth is stopped.
>From the first glance it does not look like find_extend_vma(),
probably follow_page() fault and thus __handle_mm_fault().
I can not say actually, but if it is true and performance growth is
stopped due to increased number of faults and it's processing, 
your approach will hit this problem too, doesn't it?

> Regards
> 
> Ingo Oeser

-- 
	Evgeniy Polyakov
