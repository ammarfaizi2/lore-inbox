Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVCNWy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVCNWy1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVCNWT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:19:59 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:23455 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262034AbVCNWR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:17:58 -0500
Subject: Re: [Ext2-devel] Re: inode cache, dentry cache, buffer heads usage
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050314141128.7da95c34.akpm@osdl.org>
References: <1110394558.24286.203.camel@dyn318077bld.beaverton.ibm.com>
	 <20050310174751.522c5420.akpm@osdl.org>
	 <1110835692.24286.288.camel@dyn318077bld.beaverton.ibm.com>
	 <20050314141128.7da95c34.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1110838395.24286.297.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Mar 2005 14:13:15 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 14:11, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > On Thu, 2005-03-10 at 17:47, Andrew Morton wrote:
> > > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > > >
> > > > So, why is these slab cache are not getting purged/shrinked even
> > > >  under memory pressure ? (I have seen lowmem as low as 6MB). What
> > > >  can I do to keep the machine healthy ?
> > > 
> > > Tried increasing /proc/sys/vm/vfs_cache_pressure?  (That might not be in
> > > 2.6.8 though).
> > > 
> > > 
> > 
> > Yep. This helped shrink the slabs, but we end up eating up lots of
> > the lowmem in Buffers. Is there a way to shrink buffers ?
> 
> It would require some patchwork.  Why is it a problem?  That memory is
> reclaimable.
> 

Well, machine pauses for 5-30 seconds for each vi,cscope, write() etc.
There is 7.5 GB of highmem free, but only 6MB of lowmem.

Just trying to free "lowmem" as much as possible.

> > $ cat /proc/meminfo
> > MemTotal:     16377076 kB
> > MemFree:       7495824 kB
> > Buffers:       1081708 kB
> > Cached:        4162492 kB
> > SwapCached:          0 kB
> > Active:        3660756 kB
> > Inactive:      4473476 kB
> > HighTotal:    14548952 kB
> > HighFree:      7489600 kB
> > LowTotal:      1828124 kB
> > LowFree:          6224 kB
> > 
> 
> How'd you get 1.8gig of lowmem?

2:2 split

- Badari

