Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315468AbSEBXnI>; Thu, 2 May 2002 19:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315469AbSEBXnH>; Thu, 2 May 2002 19:43:07 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:34467 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315468AbSEBXnG>;
	Thu, 2 May 2002 19:43:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Fri, 3 May 2002 01:42:56 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020502153402.A11414@dualathlon.random> <E172wFc-00024h-00@starship> <20020502180632.I11414@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E173QDx-0002C4-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 18:06, Andrea Arcangeli wrote:
> On Wed, May 01, 2002 at 05:42:40PM +0200, Daniel Phillips wrote:
> > On Thursday 02 May 2002 17:35, Andrea Arcangeli wrote:
> > > On Thu, May 02, 2002 at 08:18:33AM -0700, Martin J. Bligh wrote:
> > > > At the moment I use the contig memory model (so we only use discontig for
> > > > NUMA support) but I may need to change that in the future.
> > > 
> > > I wasn't thinking at numa-q, but regardless numa-Q fits perfectly into
> > > the current discontigmem-numa model too as far I can see.
> > 
> > No it doesn't.  The config_discontigmem model forces all zone_normal memory
> > to be on node zero, so all the remaining nodes can only have highmem locally.
> 
> You can trivially map the phys mem between 1G and 1G+256M to be in a
> direct mapping between 3G+256M and 3G+512M, then you can put such 256M
> at offset 1G into the ZONE_NORMAL of node-id 1 with discontigmem too.

Andrea, I'm re-reading this and I'm guilty of misreading your 3G+512M, what
you meant is PAGE_OFFSET+512M.  Yes, in fact this is exactly what
config_nonlinear does.  Config_discontigmem does not do this, not without
your 'trivial map', and that's all config_nonlinear is: a trivial map done
in an organized way.  This same trivial mapping is capable of replacing all
known non-numa uses of config_discontigmem.

-- 
Daniel
