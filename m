Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbSI0TUa>; Fri, 27 Sep 2002 15:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261726AbSI0TUa>; Fri, 27 Sep 2002 15:20:30 -0400
Received: from packet.digeo.com ([12.110.80.53]:64645 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261600AbSI0TUa>;
	Fri, 27 Sep 2002 15:20:30 -0400
Message-ID: <3D94B0BE.991E770@digeo.com>
Date: Fri, 27 Sep 2002 12:25:50 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] 'virtual => physical page mappingcache',vcache-2.5.38-B8
References: <3D94A4D9.D458D453@digeo.com> <1033154186.16726.17.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2002 19:25:43.0682 (UTC) FILETIME=[AC322620:01C2665B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Fri, 2002-09-27 at 19:35, Andrew Morton wrote:
> > O_DIRECT writes operate under i_sem, which provides exclusion
> > from trucate.  Do you know something which I don't??
> 
> So it does, hidden away in generic_file_write rather than the lower
> layers.

Well that's sort of the same level at which truncate takes it.
It's a pretty big lock.

> Interesting. So now I have a new question to resolve, which is
> why doing O_DIRECT and truncate together corrupted my disk when I tried
> it trying to break stuff

Interesting indeed.  Possibly invalidate_inode_pages2() accidentally
left some dirty buffers detached from the mapping.  Hard to see how
it could do that.

What kernel were you testing?
