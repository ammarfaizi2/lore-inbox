Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTIWUi2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 16:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbTIWUi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 16:38:28 -0400
Received: from palrel10.hp.com ([156.153.255.245]:52198 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262193AbTIWUiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 16:38:13 -0400
Date: Tue, 23 Sep 2003 13:38:19 -0700
From: Grant Grundler <iod00d@hp.com>
To: "David S. Miller" <davem@redhat.com>
Cc: bcrl@kvack.org, tony.luck@intel.com, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au, ak@suse.de,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030923203819.GB8477@cup.hp.com>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com> <20030923142925.A16490@kvack.org> <20030923185104.GA8477@cup.hp.com> <20030923115122.41b7178f.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923115122.41b7178f.davem@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 11:51:22AM -0700, David S. Miller wrote:
> > Even x86 pays at least a one cycle penalty for every misaligned access.
> 
> Yes, one cycle, and it's completely lost in the noise when it happens.

Depends on the app - for the networking stack, I agree.

To revisit Ben's comment: if we know something is likely to be misaligned,
a RISC processor can efficiently load both parts and merge them (one cycle
penalty vs a regular aligned load). Given misaligned accesses are infrequent
enough to affect performance, it makes sense to do this in SW because
it reduces cost of the HW design/test/mfg cycles.

...
> It is an unavoidable axoim in the kernel networking.  Unaligned accesses
> will happen, and they aren't a bug and therefore not worthy of mention
> in the kernel logs any more than "page was freed" :-)

Ok. If the kernel networking stack used get_unaligned() in the one place
Peter originally found, x86/sparc64?/et al wouldn't see a difference.
It would avoid traps on ia64 and parisc.  Bad idea?
Any other arches it might help/hurt on?

grant
