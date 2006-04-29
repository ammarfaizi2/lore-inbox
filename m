Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWD2X03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWD2X03 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 19:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWD2X03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 19:26:29 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:5317 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750826AbWD2X02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 19:26:28 -0400
Date: Sat, 29 Apr 2006 19:26:15 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, kamezawa.hiroyu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH] catch valid mem range at onlining memory
Message-ID: <20060429232615.GA18723@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060428114732.e889ad2d.kamezawa.hiroyu@jp.fujitsu.com> <20060428163409.389e895e.akpm@osdl.org> <20060428234410.GA7598@kroah.com> <20060428170519.1194b077.akpm@osdl.org> <20060429071818.GA939@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060429071818.GA939@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2006 at 12:18:18AM -0700, Greg KH wrote:
> On Fri, Apr 28, 2006 at 05:05:19PM -0700, Andrew Morton wrote:
> > Greg KH <greg@kroah.com> wrote:
> > >
> > > > This all looks fairly (but trivially) dependent upon the 64-bit-resource
> > > > patches in Greg's tree.  Greg, were you planning on merging them in the
> > > > post-2.6.17 flood?
> > > 
> > > Yes, I was,
> > 
> > OK, thanks.
> > 
> > > unless there are any objections to me doing this?
> > 
> > I'd consider the patches as they stand to be ready to roll.
> > 
> > All the code bloat's a bit sad though.  It would have been nice to have
> > made the type of resource.start and .end Kconfigurable.  What happened
> > to that?
> 
> Hm, I didn't remember anything about that.  Vivek, any thoughts?
>

Having resource size configurable is nice but it brings added complexity
with it. The question would be if code bloat is significant enough to 
go for other option. Last time I had posted few compilation results on
i386. I am summarizing these again.

allmodconfig (CONFIG_DEBUG_INFO=n)
-----------

vmlinux bloat:4096 bytes

allyesconfig  (CONFIG_DEBUG_INFO=n)
-----------
                                                                                
vmlinux size bloat: 52K

So even with allyesconfig total bloat is 52K and I am assuming the
systems where memory is at premium are going to use a very limited set
of modules and effectively will see much lesser code bloat than 52K.

For Kconfigurable resource size, probably dma_addr_t is not the very 
appropriate as at lots of places size also needs to be 64 bit and 
using dma_addr_t is not good. This will then boil down to introducing
a new type like dma_addr_t whose size is Kconfigurable.

Even if it is done, it will not get rid of code bloat completely as lots
of code bloat comes from printk() statemets where we explicitly typecast
the resource to (unsigned long long) to avoid compilation warnings across
the platforms. This typecasting will continue to be there even with
Kconfigurable resources.

Personally I would tend to think that we can live with this code bloat.

Thanks
Vivek

