Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbSLFRy4>; Fri, 6 Dec 2002 12:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbSLFRy4>; Fri, 6 Dec 2002 12:54:56 -0500
Received: from 216-42-72-140.ppp.netsville.net ([216.42.72.140]:20872 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S265270AbSLFRyz>;
	Fri, 6 Dec 2002 12:54:55 -0500
Subject: Re: [patch] fix the ext3 data=journal unmount bug
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "ext3-users@redhat.com" <ext3-users@redhat.com>
In-Reply-To: <3DF03B35.AA5858DC@digeo.com>
References: <3DF03B35.AA5858DC@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Dec 2002 13:02:49 -0500
Message-Id: <1039197769.7939.46.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 00:52, Andrew Morton wrote:
> 
> 
> This patch fixes the data loss which can occur when unmounting a
> data=journal ext3 filesystem.
> 
> The core problem is that the VFS doesn't tell the filesystem enough
> about what is happening.  ext3 _needs_ to know the difference between
> regular memory-cleansing writeback and sync-for-data-integrity
> purposes.
> 

What happens when the user does a sync() immediately after kupdate
trigger a write_super?

Since ext3_write_super just clears s_dirt, I don't see how sync_fs()
will get called.

-chris
 

