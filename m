Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289363AbSAVTVK>; Tue, 22 Jan 2002 14:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289364AbSAVTVA>; Tue, 22 Jan 2002 14:21:00 -0500
Received: from 216-42-72-169.ppp.netsville.net ([216.42.72.169]:60631 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S289363AbSAVTUw>; Tue, 22 Jan 2002 14:20:52 -0500
Date: Tue, 22 Jan 2002 14:19:45 -0500
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>, Rik van Riel <riel@conectiva.com.br>
cc: Andreas Dilger <adilger@turbolabs.com>, Shawn Starr <spstarr@sh0n.net>,
        linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: Possible Idea with filesystem buffering.
Message-ID: <2080500000.1011727185@tiny>
In-Reply-To: <3C4DB36F.4090306@namesys.com>
In-Reply-To: <Pine.LNX.4.33L.0201221234470.32617-100000@imladris.surriel.com>
 <3C4DB36F.4090306@namesys.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, January 22, 2002 09:46:07 PM +0300 Hans Reiser
<reiser@namesys.com> wrote:

> Rik van Riel wrote:
>>> The FS doesn't know how long a page has been dirty, or how often it
>>> gets used,
>> In an efficient system, the FS will never get to know this, either.
> 
> I don't understand this statement.  If dereferencing a vfs op for every
> page aging is too expensive, then ask it to age more than one page at a
> time.  Or do I miss your meaning?

Its not about the cost of a function call, it's what the FS does to make
that call useful.  Pretend for a second the VM tells the FS everything it
needs to know to age a page (whatever scheme the FS wants to use).

Then pretend the VM decides there's memory pressure, and tells the FS
subcache to start freeing ram.  So, the FS goes through its list of pages
and finds the most suitable one for flushing, but it has no idea how
suitable that page is in comparison with the pages that don't belong to
that FS (or even other pages from different mount points of the same FS
flavor).

Since each subcache has its own aging scheme, you can't look at a page from
subcache A and compare it with a page from subcache B.

All the filesystem can do is flush its own pages, which might be the least
suitable pages on the entire box.  The VM has no way of knowing, and
neither does the FS, and that's why its inefficient.

Please let me know if I misunderstood the original plan ;-)

-chris

