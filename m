Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWDLRSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWDLRSq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWDLRSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:18:46 -0400
Received: from smtp.cce.hp.com ([161.114.21.22]:863 "EHLO
	ccerelrim01.cce.hp.com") by vger.kernel.org with ESMTP
	id S932257AbWDLRSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:18:46 -0400
From: "Bob Picco" <bob.picco@hp.com>
Date: Wed, 12 Apr 2006 13:18:42 -0400
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Mel Gorman <mel@skynet.ie>, linuxppc-dev@ozlabs.org,
       davej@codemonkey.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de,
       bob.picco@hp.com
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture independent manner
Message-ID: <20060412171842.GG23742@localhost>
References: <20060411103946.18153.83059.sendpatchset@skynet> <20060411222029.GA7743@agluck-lia64.sc.intel.com> <Pine.LNX.4.64.0604112352230.6624@skynet.skynet.ie> <20060412000500.GA8532@agluck-lia64.sc.intel.com> <Pine.LNX.4.64.0604121001590.24819@skynet.skynet.ie> <20060412154633.GA10589@agluck-lia64.sc.intel.com> <Pine.LNX.4.64.0604121657380.24819@skynet.skynet.ie> <20060412170726.GA11143@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060412170726.GA11143@agluck-lia64.sc.intel.com>
User-Agent: Mutt/1.5.11
X-PMX-Version: 5.1.2.240295, Antispam-Engine: 2.3.0.1, Antispam-Data: 2006.4.12.95109
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

luck wrote:	[Wed Apr 12 2006, 01:07:26PM EDT]
> On Wed, Apr 12, 2006 at 05:00:32PM +0100, Mel Gorman wrote:
> > Patch is attached as 105-ia64_use_init_nodes.patch until I beat sense into 
> > my mail setup. I've added Bob Picco to the cc list as he will hit the same 
> > issue with whitespace corruption.
> 
> Next I tried building a "generic" kernel (using arch/ia64/defconfig). This
> has NUMA=y and DISCONTIG=y).  This crashes with the following console log.
> 
> 
> -Tony
[snip]
Yes. I see the same. It's because with granules we have intersecting
regions which add_active_range doesn't handle. At least that's what
appears to be the reason. I modified add_active_range to combine an
added intersecting region and it boots. However, present pages in zones is
enormous which probably means hole calculation is wrong. That's what I'm
pursuing now.

bob
