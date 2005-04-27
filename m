Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVD0AlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVD0AlN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 20:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVD0AlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 20:41:13 -0400
Received: from fmr22.intel.com ([143.183.121.14]:13283 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261864AbVD0AlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 20:41:08 -0400
Date: Tue, 26 Apr 2005 17:40:42 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rohit Seth <rohit.seth@intel.com>, mark.gross@intel.com
Subject: Re: [PATCH] Increase number of e820 entries hard limit from 32 to 128
Message-ID: <20050426174042.A17750@unix-os.sc.intel.com>
References: <20050422181441.A18205@unix-os.sc.intel.com> <Pine.LNX.4.58.0504221851140.2344@ppc970.osdl.org> <20050422193250.A18512@unix-os.sc.intel.com> <20050423151048.GE7715@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050423151048.GE7715@wotan.suse.de>; from ak@suse.de on Sat, Apr 23, 2005 at 05:10:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2005 at 05:10:48PM +0200, Andi Kleen wrote:
> On Fri, Apr 22, 2005 at 07:32:50PM -0700, Venkatesh Pallipadi wrote:
> > On Fri, Apr 22, 2005 at 06:51:59PM -0700, Linus Torvalds wrote:
> > > On Fri, 22 Apr 2005, Venkatesh Pallipadi wrote:
> > > > The specifications that talk about E820 map doesn't have an upper limit
> > > > on the number of E820 entries. But, today's kernel has a hard limit of 32.
> > > > With increase in memory size, we are seeing the number of E820 entries
> > > > reaching close to 32. Patch below bumps the number upto 128. 
> > > 
> > > Hmm. Anything that changes setup.S tends to have bootloader dependencies. 
> > > I worry whether this one does too..
> > > 
> > 
> > The setup.S change in this patch should be OK. As it is adding to the 
> > existing zero-page and keeping it within one page. I tested it on systems 
> > with grub, adding some dummy E820 entries and it worked fine.
> 
> The last time I tried to extend the zero page (with a longer command line)
> it broke lilo on systems with EDID support and CONFIG_EDID enabled.
> Make sure you test that case.
> 

Tested this patch with some more configuration and I did not see any breakage.
- LILO with EDID enabled
- pxeboot

And in the current zero-page, EDID info is at a lower address (before E820MAP).
So, there should not be any issues with EDID info. Only field (other than E820) 
that is changing in zero page is EDDBUF (that comes after E820MAP). 
The patch changes the reference to EDDBUF inside kernel to new position in 
zero page. And I don't see EDDBUF being used by boot loader anywhere. So, we 
should be OK with that change.

Thanks,
Venki

