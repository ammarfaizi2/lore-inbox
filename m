Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265374AbSJXTTP>; Thu, 24 Oct 2002 15:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbSJXTTO>; Thu, 24 Oct 2002 15:19:14 -0400
Received: from packet.digeo.com ([12.110.80.53]:65422 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265374AbSJXTTO>;
	Thu, 24 Oct 2002 15:19:14 -0400
Message-ID: <3DB84920.46166E73@digeo.com>
Date: Thu, 24 Oct 2002 12:25:20 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Andrea Arcangeli <andrea@suse.de>, chrisl@vmware.com,
       linux-kernel@vger.kernel.org, chrisl@gnuchina.org
Subject: Re: writepage return value check in vmscan.c
References: <20021024184005.GT3354@dualathlon.random> <Pine.LNX.4.44L.0210241713100.1648-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2002 19:25:20.0560 (UTC) FILETIME=[17914300:01C27B93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Thu, 24 Oct 2002, Andrea Arcangeli wrote:
> 
> > unfortunately I see no way around it and patching the kernel to loop
> > forever on dirty pages that may never be possible to write doesn't look
> > safe. You could check the free space on the fs and bug the user if it
> > has less than 2G free (still it's not 100% reliable, it's a racy check,
> > but you could also add a 100% reliable option that slowdown the startup
> > of the vm but that guarantees no corruption can happen).
> 
> We need space allocation.  Not just for this (probably rare) case,
> but also for the more generic optimisation of delayed allocation.
> 

Well that's certainly the other option.  Dig out the old
a_ops->reservepage stuff.

It _was_ Halloween 2003, wasn't it??

It would only work for filesystems which implement reservation
though, and iirc there were nasty problems doing delayed
allocation in, for example, ext3.  I guess ext3 would have to
reserve journal space as well as disk space.   ext2 delayed
allocation was pretty straightforward though, and most of
the infrastructure which it needed is there now.  The replacement
of buffer-based writeback with page-based, mainly.
