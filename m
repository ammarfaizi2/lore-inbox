Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWEBUmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWEBUmX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWEBUmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:42:23 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:36508 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964775AbWEBUmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:42:23 -0400
Date: Tue, 2 May 2006 16:42:16 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, kamezawa.hiroyu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH] catch valid mem range at onlining memory
Message-ID: <20060502204216.GB6566@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060428114732.e889ad2d.kamezawa.hiroyu@jp.fujitsu.com> <20060428163409.389e895e.akpm@osdl.org> <20060428234410.GA7598@kroah.com> <20060428170519.1194b077.akpm@osdl.org> <20060429071818.GA939@kroah.com> <20060429232615.GA18723@in.ibm.com> <20060429164043.4cf4a861.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060429164043.4cf4a861.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2006 at 04:40:43PM -0700, Andrew Morton wrote:
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> >
> > > > All the code bloat's a bit sad though.  It would have been nice to have
> > > > made the type of resource.start and .end Kconfigurable.  What happened
> > > > to that?
> > > 
> > > Hm, I didn't remember anything about that.  Vivek, any thoughts?
> > >
> > 
> > Having resource size configurable is nice but it brings added complexity
> > with it. The question would be if code bloat is significant enough to 
> > go for other option. Last time I had posted few compilation results on
> > i386. I am summarizing these again.
> > 
> > allmodconfig (CONFIG_DEBUG_INFO=n)
> > -----------
> > 
> > vmlinux bloat:4096 bytes
> > 
> > allyesconfig  (CONFIG_DEBUG_INFO=n)
> > -----------
> >                                                                                 
> > vmlinux size bloat: 52K
> > 
> > So even with allyesconfig total bloat is 52K and I am assuming the
> > systems where memory is at premium are going to use a very limited set
> > of modules and effectively will see much lesser code bloat than 52K.
> > 
> > For Kconfigurable resource size, probably dma_addr_t is not the very 
> > appropriate as at lots of places size also needs to be 64 bit and 
> > using dma_addr_t is not good. This will then boil down to introducing
> > a new type like dma_addr_t whose size is Kconfigurable.
> 
> Yes, it would need to to be a new type - resource_addr_t, perhaps.
> 

How about "res_sz_t". "resource_addr_t" probably is not a very appropriate
keyword as at lots of places we also need to represent size and alignment
with this typedef.

Thanks
Vivek
