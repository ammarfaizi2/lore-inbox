Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbUBZNxg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 08:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUBZNxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 08:53:36 -0500
Received: from unthought.net ([212.97.129.88]:32979 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262790AbUBZNxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 08:53:34 -0500
Date: Thu, 26 Feb 2004 14:53:33 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.25 - large inode_cache
Message-ID: <20040226135333.GQ29776@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20040226013313.GN29776@unthought.net> <20040226111912.GB4554@core.home> <Pine.LNX.4.58L.0402261004310.5003@logos.cnet> <20040226130344.GP29776@unthought.net> <Pine.LNX.4.58L.0402261109190.5003@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0402261109190.5003@logos.cnet>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 11:23:46AM -0300, Marcelo Tosatti wrote:
...
> > Will a heap of busy knfsd processes doing reads or writes exert
> > pressure?   Or is it only local userspace that can pressurize the VM (by
> > either anonymously backed memory or file I/O).
> 
> Any allocator will cause VM pressure.

And I suppose that a busy knfsd qualifies as an "allocator"   :)

...
> > Any enlightenment or suggestions are greatly appreciated :)
> 
> What you can try is to increase the VM tunable vm_vfs_scan_ratio. This is
> the proportion of VFS unused d/i caches that will try to be in one VM
> freeing pass. The default is 6. Try 4 or 3.
> 
> /proc/sys/vm/vm_vfs_scan_ratio

Done!  Set to 3 now - I will let the box run with this setting until
tomorrow, and report back how things look.

> You can also play with
> 
> /proc/sys/vm/vm_cache_scan_ratio (which is the percentage of cache which
> will be scanned in one go).

I'm leaving this one be for now (one variable at a time). But let's see
what tomorrow brings. 

Judging from the code, it seems that it's the vm_vfs_scan_ratio that
directly affects the icache/dcache and dquot - but I'm sure that there
are subtle interactions far beyond what I can possibly hope to
comprehend ;)

Thanks a lot for your suggestions Marcelo!

 / jakob


