Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWFVAVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWFVAVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 20:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWFVAVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 20:21:08 -0400
Received: from mga05.intel.com ([192.55.52.89]:47688 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932128AbWFVAVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 20:21:07 -0400
X-IronPort-AV: i="4.06,163,1149490800"; 
   d="scan'208"; a="56504098:sNHT42397852"
Date: Wed, 21 Jun 2006 17:15:36 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Rajesh Shah <rajesh.shah@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, Brice Goglin <brice@myri.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] PCI extended conf space when MMCONFIG disabled because of e820
Message-ID: <20060621171536.A17560@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <44907A8E.1080308@myri.com> <4491029D.4060002@linux.intel.com> <20060621151942.A17228@unix-os.sc.intel.com> <200606220032.19388.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200606220032.19388.ak@suse.de>; from ak@suse.de on Thu, Jun 22, 2006 at 12:32:19AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 12:32:19AM +0200, Andi Kleen wrote:
> On Thursday 22 June 2006 00:19, Rajesh Shah wrote:
> > On Wed, Jun 14, 2006 at 11:47:57PM -0700, Arjan van de Ven wrote:
> > > 
> > > > We need to improve this "mmconfig disabled" anyhow. Having the extended
> > > > config space unavailable on lots of machines is also far from a viable
> > > > solution :)
> > > 
> > > it's unlikely to be many machines though.
> > > 
> > I just noticed today - this check killed PCI Express on 3 of the 4
> > machines I normally use for testing.
> 
> What do you mean with killed PCI Express? PCI Express should
> work even without extended config space, except error handling.
> 
Yes, I meant it killed extended config space. Note that we are
about to send out code that enables PCI Express error handling,
so this will become more visible now.

> You're saying that you have lots of machines where the mmconfig
> aperture is not fully reserved in e820?
> 
Yes, I saw this in 3 out of 4 systems I checked. I'll go check
some more systems too.

> Is it partially reserved (not for all busses) or not at all?
> 
The MMCFG resources are not listed at all in the BIOS provided
memory map.

> 
> If someone does a patch to double check it against the ACPI name space
> I'm not opposed to let it overrule the e820 heuristic.
> 
> The point of this code is to pragmatically detect BIOS with obviously 
> broken setups. It's not about standards lawyering.
> 
Oh I agree with you that booting is more important. My point with
the spec statement was that most BIOS developers may not even know
they are doing something "wrong" by not listing these resources in
the int15 E820 table, since the document they normally refer to
doesn't say so. I suspect there are many more systems out there
which do the same thing and will fail the check, but we never notice
since most users don't try to ever access the extended space today.

Rajesh
