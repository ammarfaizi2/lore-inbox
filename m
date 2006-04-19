Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWDSDpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWDSDpZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 23:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWDSDpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 23:45:25 -0400
Received: from fmr18.intel.com ([134.134.136.17]:20380 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750731AbWDSDpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 23:45:25 -0400
Subject: Re: [PATCH 2/3] swsusp i386 mark special saveable/unsaveable pages
From: Shaohua Li <shaohua.li@intel.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200604191259.57951.ncunningham@cyclades.com>
References: <1144809501.2865.40.camel@sli10-desk.sh.intel.com>
	 <200604191208.49386.ncunningham@cyclades.com>
	 <1145415212.19994.15.camel@sli10-desk.sh.intel.com>
	 <200604191259.57951.ncunningham@cyclades.com>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 11:28:54 +0800
Message-Id: <1145417334.19994.24.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 12:59 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Wednesday 19 April 2006 12:53, Shaohua Li wrote:
> > On Wed, 2006-04-19 at 12:08 +1000, Nigel Cunningham wrote:
> > > Hi.
> > >
> > > On Wednesday 19 April 2006 11:51, Shaohua Li wrote:
> > > > On Wed, 2006-04-19 at 11:41 +1000, Nigel Cunningham wrote:
> > > > > Oh, and while we're on the topic, if only part of a page is NVS,
> > > > > what's the right behaviour? My e820 table has:
> > > > >
> > > > > BIOS-e820: 000000003dff0000 - 000000003dffffc0 (ACPI data)
> > > > > BIOS-e820: 000000003dffffc0 - 000000003e000000 (ACPI NVS)
> > > >
> > > > If only part of a page is NVS, my patch will save the whole page. Any
> > > > other idea?
> > >
> > > A device model driver that handles saving just the part of the page,
> > > using preallocated buffers to avoid the potential allocation problems?
> > > (The whole page could then safely be Nosave).
> >
> > The allocation might not be a problem, this just needs one or two extra
> > pages. A problem is if just part of the page is NVS, could we touch
> > other part (save/restore) the page.
> 
> Yes, so I was thinking of treating it with a pseudo driver that could save and 
> restore just that portion of the page.
Sounds like a good idea. If NVS is already aligned to page size, do you
still use the pseudo driver to save/restore the pages? In my system, the
NVS memory is 512k. 
In the other way, we could let the 'swsusp_add_arch_pages' accept
address instead of a pfn and let snapshot.c handle the partial page
issue.

> Regarding the allocation, I was originally thinking of that other ACPI 
> allocation while atomic issue, and trying to avoid another one. I guess this 
> is simpler though because we know ahead of time how much is needed (am I 
> right in thinking that in the other case, the amount of memory needed isn't 
> known ahead of time?).
Yes, we can get the amount of memory needed ahead per the e820 map.

Thanks,
Shaohua

