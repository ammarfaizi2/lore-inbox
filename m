Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTKYXM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 18:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTKYXM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 18:12:58 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:43243 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S263299AbTKYXM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 18:12:57 -0500
Date: Tue, 25 Nov 2003 17:11:08 -0600
From: Jack Steiner <steiner@sgi.com>
To: Anton Blanchard <anton@samba.org>
Cc: Jes Sorensen <jes@trained-monkey.org>, Alexander Viro <viro@math.psu.edu>,
       Andrew Morton <akpm@osdl.org>,
       "William Lee Irwin, III" <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, jbarnes@sgi.com
Subject: Re: hash table sizes
Message-ID: <20031125231108.GA5675@sgi.com>
References: <16323.23221.835676.999857@gargle.gargle.HOWL> <20031125204814.GA19397@sgi.com> <20031125211611.GE26811@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125211611.GE26811@krispykreme>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 08:16:11AM +1100, Anton Blanchard wrote:
>  
> Hi,
> 
> > Some architectures (IA64, for example) dont have severe limitations on
> > usage of vmalloc space. Would it make sense to use vmalloc on these
> > architectures. Even if the max size of the structures being allocated
> > is limited to an acceptible size, it still concentrates the memory on
> > a single node. 
> 
> The kernel region on many architectures is mapped with large pages, we
> would lose that by going to vmalloc.
> 
> Anton


That was a concern to me too. However, on IA64, all page structs are
in the vmalloc region (it isnt allocated by vmalloc but is in the
same region as vmalloc'ed pages. They are mapped with 16k pages instead of the 64MB 
pages used for memory allocated by kmalloc).

Before switching to 16K pages for the page structs, we made numerous performance
measurements. As far as we could tell, there was no performce degradation
caused by the smaller pages. It seems to me that if page structs are ok 
being mapped by 16k pages, the hash tables would be ok too. 



-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


