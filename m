Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSK0Orh>; Wed, 27 Nov 2002 09:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSK0Orh>; Wed, 27 Nov 2002 09:47:37 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:51942 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP
	id <S262808AbSK0Org>; Wed, 27 Nov 2002 09:47:36 -0500
Date: Wed, 27 Nov 2002 08:25:56 -0700
From: Matt Porter <porter@cox.net>
To: "David S. Miller" <davem@redhat.com>
Cc: Matt Porter <porter@cox.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4] update ref counts on all allocated pages
Message-ID: <20021127082556.A26524@home.com>
References: <20021126170723.A23962@home.com> <1038393091.14825.0.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1038393091.14825.0.camel@rth.ninka.net>; from davem@redhat.com on Wed, Nov 27, 2002 at 02:31:31AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 02:31:31AM -0800, David S. Miller wrote:
> On Tue, 2002-11-26 at 16:07, Matt Porter wrote:
> > The following patch sets the ref count on all pages of an
> > allocation.  This allows an allocation with order>0 to be freed
> > via individual __free_page() calls within vfree().
> 
> If your pci_alloc_consistent implementation is doing something
> strang, _it_ should be doing the per-page reference counts.
> 
> Don't make every caller eat this overhead.

I'm surprised that's the recommended solution.  It seems pretty
dangerous to have allocated pages in the system where the per-page
ref counts are bogus.

To clarify then, on an order>0 allocation, it is only valid/defined
to free the same order of pages.  Is that a true statement?  If so,
I'll submit a docs patch and adjust our our local implementation.

Thanks,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
