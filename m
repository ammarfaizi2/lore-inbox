Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSIEAnD>; Wed, 4 Sep 2002 20:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316569AbSIEAnD>; Wed, 4 Sep 2002 20:43:03 -0400
Received: from 216-42-72-141.ppp.netsville.net ([216.42.72.141]:58268 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S316437AbSIEAnB>;
	Wed, 4 Sep 2002 20:43:01 -0400
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: "David S. Miller" <davem@redhat.com>, shaggy@austin.ibm.com,
       szepe@pinerecords.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, aurora-sparc-devel@linuxpower.org,
       reiserfs-dev@namesys.com, linuxjfs@us.ibm.com, green@namesys.com
In-Reply-To: <3D76A6FF.509@namesys.com>
References: <200209042018.g84KI6612079@shaggy.austin.ibm.com>	<3D766DA8.9030207@namesys.
	 com> <20020904.163515.82835380.davem@redhat.com> 
	<3D76A6FF.509@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Sep 2002 20:49:11 -0400
Message-Id: <1031186951.1684.205.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-04 at 20:36, Hans Reiser wrote:
> David S. Miller wrote:
> 
> >   From: Hans Reiser <reiser@namesys.com>
> >   Date: Thu, 05 Sep 2002 00:31:36 +0400
> >
> >   The proper fix should be to make the result of the limit
> >   computation be accurately architecture specific.
> >
> >And then each and every Reiserfs partition is platform specific
> >and cannot be mounted onto another Linux platform.
> >
> >Creating such a restriction is a grave error.
> >
> >
> >  
> >
> And you would cripple the 99% usage to aid those users who move disk 
> drives physically over to a sparc box AND have more than 31k links to a 
> file?

31k links to a file isn't really an issue, I really doubt anyone out
there is doing something like that.

31k links on a directory is a bigger problem, since each subdir is a
link.  The good news is that reiserfs already works around this by
setting the link count to 1 and doing other checks to make sure a
directory really is empty.

My point isn't that we should not change the link max, it is that
changing the link max is not sufficient.  Portability to sparc doesn't
matter one bit if it means breaking existing i386 users.  Our disk
format has link counts > 32k, so any reiserfs fixes for this need to
expect those larger values on disk and play nicely with them.

-chris


