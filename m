Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273483AbRIYUHd>; Tue, 25 Sep 2001 16:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273484AbRIYUHX>; Tue, 25 Sep 2001 16:07:23 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:16392 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273483AbRIYUHO>; Tue, 25 Sep 2001 16:07:14 -0400
Date: Tue, 25 Sep 2001 15:43:41 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: GFP_FAIL?
In-Reply-To: <20010924210951.A165@bug.ucw.cz>
Message-ID: <Pine.LNX.4.21.0109251526190.2193-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Sep 2001, Pavel Machek wrote:

> Hi!
> 
> I need to alloc as much memory as possible, *but not more*. I do not
> want to OOM-kill anything. How do I do this? Tried GFP_KERNEL, will
> oom-kill. GFP_USER will OOM-kill, too.

Currently, you can't. 

I've added a GFP_FAIL flag at 2.4.5-ac1 to be used by the bounce buffering
allocation code to avoid highmem deadlocks, but it was removed due to no
more need.
(http://oss.sgi.com/projects/xfs/mail_archive/0103/msg00110.html is a
similar patch which I proposed to the XFS people)

The only problem by of a GFP_FAIL flag for some users is that it cannot
fail _too_ easily. Think about the SCSI layer trying to allocate big
memory chunks to do more effective (bigger) scatter-gather transfers.

If we use GFP_FAIL to mean "get memory without any efforts", the
scatter-gather big tables are never going to happen, thus we'll have
crappy performance. For _those_ kind of allocations, we want to try a bit
more instead failing so easily. See?

Thats why I think Linus will not like such a flag with no exact meaning.

Well, ask him. :) 

