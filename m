Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbUDBBiC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbUDBBiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:38:01 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45972
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263523AbUDBBfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:35:48 -0500
Date: Fri, 2 Apr 2004 03:35:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040402013547.GM18585@dualathlon.random>
References: <20040401135920.GF18585@dualathlon.random> <20040401170705.Y22989@build.pdx.osdl.net> <20040402011804.GL18585@dualathlon.random> <20040401173014.Z22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401173014.Z22989@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 05:30:14PM -0800, Chris Wright wrote:
> * Andrea Arcangeli (andrea@suse.de) wrote:
> > please elaborate how can you account for shmget(SHM_HUGETLB) with the
> > rlimit. The rlimit is just about the _address_space_ mlocked, there's no
> > way to account for something _outside_ the address space with the rlimit,
> > period. If you attempt doing that, _that_ will be THE true hack(tm) ;).
> 
> Heh ;-)  OK, here's the patch.  When you setup the vmas for the huge pages
> account for them, when you tear them down, account for that as well.
> It's very possible that I've missed the obvious, but it at least pasts

what you missed is that after you locked_vm -= you don't free anything,
you only unmap them from the address space which means nothing in terms
of amount if pinned ram.

so patch is broken and insecure as far as I can tell.
