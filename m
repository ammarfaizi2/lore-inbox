Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319268AbSIGQnh>; Sat, 7 Sep 2002 12:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319311AbSIGQnh>; Sat, 7 Sep 2002 12:43:37 -0400
Received: from packet.digeo.com ([12.110.80.53]:20106 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319268AbSIGQng>;
	Sat, 7 Sep 2002 12:43:36 -0400
Message-ID: <3D7A3118.2DEC6174@digeo.com>
Date: Sat, 07 Sep 2002 10:02:16 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>, trond.myklebust@fys.uio.no,
       Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <3D77D879.7F7A3385@zip.com.au> <15735.64356.246705.392224@charged.uio.no> <3D780027.13A5B3B@zip.com.au> <E17nb5V-0006OJ-00@starship> <3D7A24D2.DF572685@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Sep 2002 16:48:10.0352 (UTC) FILETIME=[594F7700:01C2568E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> XFS has a ->releasepage.

And it looks like it wants to be able to sleep.

I lied about ->releasepage being nonblocking.  try_to_free_buffers()
is nonblocking, and for a while, ->releasepage had to be nonblocking.
But we can relax that now.  I'll put the gfp_flags back into
page reclaim's call to try_to_release_page().  That might help XFS
to play nice with the VM.
