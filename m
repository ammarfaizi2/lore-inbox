Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261485AbTCGKBG>; Fri, 7 Mar 2003 05:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbTCGKBG>; Fri, 7 Mar 2003 05:01:06 -0500
Received: from packet.digeo.com ([12.110.80.53]:62087 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261485AbTCGKBF>;
	Fri, 7 Mar 2003 05:01:05 -0500
Date: Fri, 7 Mar 2003 02:11:39 -0800
From: Andrew Morton <akpm@digeo.com>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5] double free in ext2?
Message-Id: <20030307021139.5268cc44.akpm@digeo.com>
In-Reply-To: <20030307130655.A17819@namesys.com>
References: <20030307130655.A17819@namesys.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 10:11:33.0963 (UTC) FILETIME=[EE5369B0:01C2E491]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@namesys.com> wrote:
>
> Hello!
> 
>    I am playing with smatch and while testing my improved version of
>    unfree.pl, I seems to have found a double free condition in ext2:
> 
>    fs/ext2/super.c::ext2_fill_super()  (I am looking at yesterday's 2.5 snapshot)
> 
>    in line 784 we do kfree(sbi->s_group_desc); (then print "EXT2-fs: unable to read group descriptors\n")
>    and go to failed_mount_group_desc, which reads (from line 821):
> failed_mount_group_desc:
>         kfree(sbi->s_group_desc);
> 

yes, bug.  Thanks.
