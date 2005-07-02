Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVGBIRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVGBIRT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 04:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVGBIRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 04:17:19 -0400
Received: from colo.lackof.org ([198.49.126.79]:40429 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261438AbVGBIRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 04:17:14 -0400
Date: Sat, 2 Jul 2005 02:21:29 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: Re: [PATCH 7/13]: PCI Err: Symbios SCSI  driver recovery
Message-ID: <20050702082129.GD14091@colo.lackof.org>
References: <20050628235919.GA6415@austin.ibm.com> <20050629030237.GB71992@muc.de> <20050629163408.GI28499@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629163408.GI28499@austin.ibm.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 11:34:08AM -0500, Linas Vepstas wrote:
...
> requests get replayed, in a fashion similar to what would be needed
> after a host reset.  In particular, there shouldn't be and (permanent)
> file system corruption because any inconsistent state on the disk 
> would get over-written when the queued reqeusts get re-issued.

FS's that require some ordering (journal) should be handling
this sort of stuff already. I have the same expectations as
Linas does WRT design. FS's that don't, will have the same sort
of problems that they would have as if the OS crashed.

> FWIW, yes, I have heard of devices that "cheat", and report back that a
> transaction is complete, even though it is still pending in firmware
> somewhere, either  on the host or the disk.  Those devices get screwed.

See "Write Cache Enabled" (aka WCE or in HPUX speak "Immediate Reporting").
WCE must be disabled if data corruption can not be tolerated.
"Desktop" (ie unix workstations) systems typically have WCE enabled
so they look good on (stupid) performance benchmarks.

The only devices that lie about WCE have battery backed RAM buffers.
(e.g. SCSI RAID *devices* - multi-LUN, dual controller beasts)

> No doubt, this will happen to some giant banking customer,

It won't happen because of WCE. None of the major HW vendors will
sell or support HW with WCE enabled. Exactly for the reasons you
point out.

grant
