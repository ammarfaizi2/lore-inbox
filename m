Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVHQAYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVHQAYw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 20:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVHQAYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 20:24:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16286 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750775AbVHQAYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 20:24:52 -0400
Date: Tue, 16 Aug 2005 17:24:37 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, zach@vmware.com, akpm@osdl.org,
       chrisl@vmware.com, hpa@zytor.com, Keir.Fraser@cl.cam.ac.uk,
       linux-kernel@vger.kernel.org, m+Ian.Pratt@cl.cam.ac.uk,
       mbligh@mbligh.org, pratap@vmware.com, virtualization@lists.osdl.org,
       zwane@arm.linux.org.uk
Subject: Re: [PATCH 8/14] i386 / Add a per cpu gdt accessor
Message-ID: <20050817002437.GX7762@shell0.pdx.osdl.net>
References: <200508110456.j7B4ue56019587@zach-dev.vmware.com> <20050816234725.GI27628@wotan.suse.de> <20050817000736.GU7762@shell0.pdx.osdl.net> <20050817001635.GC3996@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050817001635.GC3996@wotan.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Tue, Aug 16, 2005 at 05:07:36PM -0700, Chris Wright wrote:
> > * Andi Kleen (ak@suse.de) wrote:
> > > On Wed, Aug 10, 2005 at 09:56:40PM -0700, zach@vmware.com wrote:
> > > > Add an accessor function for getting the per-CPU gdt.  Callee must already
> > > > have the CPU.
> > > 
> > > What is the accessor good for? 
> > > 
> > > It looks just like code obfuscation to me.
> > 
> > Xen handles gdt differently (one page per cpu instead of per_cpu data).
> > So this is for handling that access cleanly.
> 
> It would be much cleaner to use a per_cpu pointer then and just allocate
> it differently.

OK, that's easily done, but it will add extra indirection.  This currently
changes nothing for common case.  The cpu_gdt_descr effectively has that
address cached already (just not as per_cpu).
