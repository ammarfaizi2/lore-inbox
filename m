Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317498AbSIEN5i>; Thu, 5 Sep 2002 09:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317602AbSIEN5i>; Thu, 5 Sep 2002 09:57:38 -0400
Received: from 216-42-72-141.ppp.netsville.net ([216.42.72.141]:42657 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S317498AbSIEN5h>;
	Thu, 5 Sep 2002 09:57:37 -0400
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
From: Chris Mason <mason@suse.com>
To: Oleg Drokin <green@namesys.com>
Cc: "David S. Miller" <davem@redhat.com>, szepe@pinerecords.com,
       reiser@namesys.com, shaggy@austin.ibm.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       linuxjfs@us.ibm.com
In-Reply-To: <20020905174902.A32687@namesys.com>
References: <3D76A6FF.509@namesys.com> <1031186951.1684.205.camel@tiny>
	<20020905054008.GH24323@louise.pinerecords.com>
	<20020904.223651.79770866.davem@redhat.com>
	<20020905135442.A19682@namesys.com>  <20020905174902.A32687@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Sep 2002 10:03:44 -0400
Message-Id: <1031234624.1726.224.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-05 at 09:49, Oleg Drokin wrote:
> Hello!
> 
> On Thu, Sep 05, 2002 at 01:54:42PM +0400, Oleg Drokin wrote:
> 
> > Ok, since I really like this approach, below is the patch (for 2.4) that
> > demonstrates my solution.
> > Also it correctly calculates maximal number given type may hold ( does not work
> > with unsigned long long, though) with my own way ;)
> 
> Version that actually works is now here ;)
> Also I have added checks to reiserfs_mkdir and reiserfs_rename to not
> overflow the counter. Still reiserfs only version of the patch.
> Actually I think this very approach can be used for a lot of other filesystems
> including ext2, where max nlink is defined to be 32000 only (I am not sure
> how much space is there reserved on disk, though).
> 
> Chris, can you please take a look at it?

read the -noleaf description on the find man page to see why we need to
set the directory link count to 1 when we are lying to userspace about
the actual link count on directories. 

find isn't the only program that makes this assumption (it's just the
only one I can think of ;-)

Other than that the patch (the second one diffed against the correct
tree) looks sane.

-chris


