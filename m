Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267697AbTBUUpc>; Fri, 21 Feb 2003 15:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267699AbTBUUpc>; Fri, 21 Feb 2003 15:45:32 -0500
Received: from packet.digeo.com ([12.110.80.53]:45549 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267697AbTBUUpb>;
	Fri, 21 Feb 2003 15:45:31 -0500
Date: Fri, 21 Feb 2003 12:52:59 -0800
From: Andrew Morton <akpm@digeo.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: andrea@suse.de, m.c.p@wolk-project.de, t.baetzler@bringe.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: xdr nfs highmem deadlock fix [Re: filesystem access slowing
 system to a crawl]
Message-Id: <20030221125259.5d22a42f.akpm@digeo.com>
In-Reply-To: <shs1y22zhm9.fsf@charged.uio.no>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR>
	<200302191742.02275.m.c.p@wolk-project.de>
	<20030219174940.GJ14633@x30.suse.de>
	<200302201629.51374.m.c.p@wolk-project.de>
	<20030220103543.7c2d250c.akpm@digeo.com>
	<20030220215457.GV31480@x30.school.suse.de>
	<shs1y22zhm9.fsf@charged.uio.no>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 20:55:30.0098 (UTC) FILETIME=[91794120:01C2D9EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> >>>>> " " == Andrea Arcangeli <andrea@suse.de> writes:
> 
>      > 2.5.62 has the very same deadlock condition in xdr triggered by
>      >        nfs too.
>      > Andrew, if you're forward porting it yourself like with the
>      > filebacked vma merging feature just let me know so we make sure
>      > not to duplicate effort.
> 
> For 2.5.x we should rather fix MSG_MORE so that it actually works
> instead of messing with hacks to kmap().

Is the fixing of MSG_MORE likely to actually happen?

> For 2.4.x, Hirokazu Takahashi had a patch which allowed for a safe
> kmap of > 1 page in one call. Appended here as an attachment FYI
> (Marcelo do *not* apply!).

Andrea's patch is quite simple.  Although I wonder if this, in
xdr_kmap():

+		} else {
+			iov->iov_base = kmap_nonblock(*ppage);
+			if (!iov->iov_base)
+				goto out;
+		}

should be skipping the map_tail thing?
