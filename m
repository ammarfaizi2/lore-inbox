Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWFTIUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWFTIUl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWFTIUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:20:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:6898 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964988AbWFTIUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:20:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kcCPTRumnA6y6EaGyaEoZtz77fRHNi35FLMKvEAaywgGt5GypYWnynQYzJ+GlPKkGQyJftlP6IigAgoX8xCPCu++SeIxAd916n1cAKoxRJSasYLO7ylB1MdJHTd4wrgaaPDeGLGwYQJQ55KltRPDKFiAo1Nq0s0GlvplnfQkRKA=
Message-ID: <3aa654a40606200120v5baf0304ka205f1ad8f136ad9@mail.gmail.com>
Date: Tue, 20 Jun 2006 01:20:39 -0700
From: "Avuton Olrich" <avuton@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: XFS crashed twice, once in 2.6.16.20, next in 2.6.17, reproducable
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
In-Reply-To: <20060620165209.C1080488@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3aa654a40606190044q43dca571qdc06ee13d82d979@mail.gmail.com>
	 <20060620161006.C1079661@wobbly.melbourne.sgi.com>
	 <3aa654a40606192338v751150fp5645d1d2943316ea@mail.gmail.com>
	 <20060620164338.A1080488@wobbly.melbourne.sgi.com>
	 <3aa654a40606192350w5c469670t466dfc1344e23a4@mail.gmail.com>
	 <20060620165209.C1080488@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/06, Nathan Scott <nathans@sgi.com> wrote:
> On Mon, Jun 19, 2006 at 11:50:37PM -0700, Avuton Olrich wrote:
> > On 6/19/06, Nathan Scott <nathans@sgi.com> wrote:
> > > Oh - thats a kernel patch, not a repair patch, I was more interested
> > > in whether the initial corruption could be reproduced.  Which version
> > > of xfs_repair are you running?  (xfs_repair -V)  xfsprogs-2.7.18 will
> > > resolve your problem, I suspect.
> >
> > OK, I'm running Gentoo's latest: 2.7.11, I can't find 2.7.18
> > _anywhere_ although 2.7.13 is in the pre directory on the ftp, is that
> > the one you're referring to?
>
> No - its in CVS (for a long time); I'll go get the ftp area updated,
> looks like thats been forgotten about again.

OK, just compiled from CVS HEAD (xfs_repair 2.8.2) and it still fails:

If this fix is not yet in the 2.8.x I will wait for 2.7.18 to get on the ftp.

Phase 1 - find and verify superblock...
Phase 2 - using internal log
        - zero log...
        - scan filesystem freespace and inode maps...
        - found root inode chunk
Phase 3 - for each AG...
        - scan and clear agi unlinked lists...
        - process known inodes and perform inode discovery...
        - agno = 0
entry "/ost+found" at block 0 offset 448 in directory inode 128
references invalid inode 18374686479671623679
        clearing inode number in entry at offset 448...
entry at block 0 offset 448 in directory inode 128 has illegal name
"/ost+found": imap claims a free inode 859505 is in use, correcting
imap and clearing inode
        - agno = 1
        - agno = 2
        - agno = 3
        - agno = 4
        - agno = 5
        - agno = 6
        - agno = 7
        - agno = 8
        - agno = 9
        - agno = 10
        - agno = 11
        - agno = 12
        - agno = 13
        - agno = 14
        - agno = 15
        - process newly discovered inodes...
Phase 4 - check for duplicate blocks...
        - setting up duplicate extent list...
        - clear lost+found (if it exists) ...
        - check for inodes claiming duplicate blocks...
        - agno = 0
        - agno = 1
        - agno = 2
        - agno = 3
        - agno = 4
        - agno = 5
        - agno = 6
        - agno = 7
        - agno = 8
        - agno = 9
        - agno = 10
        - agno = 11
        - agno = 12
        - agno = 13
        - agno = 14
        - agno = 15
Phase 5 - rebuild AG headers and trees...
        - reset superblock...
Phase 6 - check inode connectivity...
        - resetting contents of realtime bitmap and summary inodes
        - ensuring existence of lost+found directory
        - traversing filesystem starting at / ...
rebuilding directory inode 128

fatal error -- can't read block 16777216 for directory inode
1507133580

-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
