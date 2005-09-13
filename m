Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932676AbVIMPbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbVIMPbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbVIMPbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:31:11 -0400
Received: from colin.muc.de ([193.149.48.1]:47371 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932676AbVIMPbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:31:10 -0400
Date: 13 Sep 2005 17:31:06 +0200
Date: Tue, 13 Sep 2005 17:31:06 +0200
From: Andi Kleen <ak@muc.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 13/14] x86_64: Use common functions in cluster and physflat mode
Message-ID: <20050913153106.GB14316@muc.de>
References: <200509032135.j83LZ8gX020554@shell0.pdx.osdl.net> <20050905231628.GA16476@muc.de> <20050906161215.B19592@unix-os.sc.intel.com> <Pine.LNX.4.61.0509091003490.978@montezuma.fsmlabs.com> <20050909134503.A29351@unix-os.sc.intel.com> <Pine.LNX.4.61.0509091439110.978@montezuma.fsmlabs.com> <20050911230220.GA73228@muc.de> <20050912152308.A18649@unix-os.sc.intel.com> <20050913081054.GB37889@muc.de> <Pine.LNX.4.61.0509130749210.1684@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509130749210.1684@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 07:53:03AM -0700, Zwane Mwaikambo wrote:
> On Tue, 13 Sep 2005, Andi Kleen wrote:
> 
> > > We should probably remove the !HOTPLUG case and just use the mask version
> > > for all cases <=8 CPUS, use physflat or the cluster mode for >8cpus as 
> > > the case may be, instead of defaulting to sequence_IPI which seems
> > > a little overkill for the intended purpose.
> > 
> > Or just always use physflat and remove the logical flat case? 
> > That seems cleanest to me. Any objections? 
> 
> My objection is the number of APIC writes required to issue IPIs to a 
> group of processors, however i do understand that it would help 

local APIC accesses are cheap, they don't go over any external bus.
It's not like a PCI cycle.

> maintainability and testing coverage if we reduce the number of operating 
> modes, are you proposing physflat for _everything_ ?

On everything that's currently run by flat yes. Possibly the others
too when tested.

-Andi
