Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbUK3Dir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUK3Dir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 22:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbUK3Dir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 22:38:47 -0500
Received: from holomorphy.com ([207.189.100.168]:47510 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261965AbUK3Dip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 22:38:45 -0500
Date: Mon, 29 Nov 2004 19:38:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, "David S. Miller" <davem@redhat.com>
Subject: Re: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for CONFIG_XEN
Message-ID: <20041130033826.GF2714@holomorphy.com>
References: <E1CVHzW-0004XC-00@mta1.cl.cam.ac.uk> <E1CVI5c-0004bf-00@mta1.cl.cam.ac.uk> <20041130030812.GN4365@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041130030812.GN4365@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 11:22:51PM +0000, Ian Pratt wrote:
>> This patch modifies /dev/mem to call io_remap_page_range rather than
>> remap_pfn_range under CONFIG_XEN.  This is required because in arch

On Tue, Nov 30, 2004 at 04:08:12AM +0100, Andrea Arcangeli wrote:
> Why don't we change /dev/mem to use io_remap_page_range unconditionally
> for ranges above high_memory? Clearly io_remap_page_range can map device
> space, and I guess that's what io_remap_page_range is there for. sparc
> and sparc64 are the only two ones implementing io_remap_page_range, so
> maybe Dave or Wli can tell us if there's any penalty in using
> io_remap_page_range in mmap(/dev/mmap) for phys ranges above
> high_memory. I don't know the sparc architectural details of mk_pte_io
> invoked by io_remap_page_range of the sparc arch.
> There's also an issue with io_remap_page_range where sparc has 6 args
> while everyone else has 5 args. It's perfectly fine that sparc will be
> the only one parsing the last value, but we should pass that last value
> to all archs, so that people can avoid writing code like the below
> (drivers/char/drm):

On sparc32, all IO memory is above the 32-bit boundary. So it's
generally okay for that. The general ongoing work in the
io_remap_page_range() area to unify the sparc32/sparc64 case with other
architectures is based in part on the remap_pfn_range() work (as noted
by davem in another followup).

Unfortunately the effort to debug the effects of pending changes in
2.6.10-rc2-mm3 is blocking the io_remap_page_range() work.


-- wli
