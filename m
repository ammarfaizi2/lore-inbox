Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbSLFT0y>; Fri, 6 Dec 2002 14:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265713AbSLFT0y>; Fri, 6 Dec 2002 14:26:54 -0500
Received: from 216-42-72-140.ppp.netsville.net ([216.42.72.140]:8073 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S265711AbSLFT0x>;
	Fri, 6 Dec 2002 14:26:53 -0500
Subject: Re: [patch] fix the ext3 data=journal unmount bug
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "ext3-users@redhat.com" <ext3-users@redhat.com>
In-Reply-To: <3DF0F69E.FF0E513A@digeo.com>
References: <3DF03B35.AA5858DC@digeo.com> <1039197769.7939.46.camel@tiny> 
	<3DF0F69E.FF0E513A@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Dec 2002 14:34:47 -0500
Message-Id: <1039203287.9244.97.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 14:12, Andrew Morton wrote:
> 
> It won't.  There isn't really a sane way of doing this properly unless
> we do something like:
> 
> 1) Add a new flag to the superblock
> 2) Set that flag against all r/w superblocks before starting the sync
> 3) Use that flag inside the superblock walk.
> 
> That would provide a reasonable solution, but I don't believe we
> need to go to those lengths in 2.4, do you?

Grin, I'm partial to changing sync_supers to allow the FS to leave
s_dirt set in its write_super call.

I see what ext3 gains from your current patch in the unmount case, but
the sync case is really unchanged because of interaction with kupdate. 

Other filesystems trying to use the sync_fs() call might think adding
one is enough to always get called on sync, and I think that will lead
to unreliable sync implementations.

-chris


