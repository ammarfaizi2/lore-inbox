Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289307AbSAVVKJ>; Tue, 22 Jan 2002 16:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289316AbSAVVKA>; Tue, 22 Jan 2002 16:10:00 -0500
Received: from 216-42-72-169.ppp.netsville.net ([216.42.72.169]:47320 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S289307AbSAVVJt>; Tue, 22 Jan 2002 16:09:49 -0500
Date: Tue, 22 Jan 2002 16:08:28 -0500
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Andreas Dilger <adilger@turbolabs.com>, Shawn Starr <spstarr@sh0n.net>,
        linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: Possible Idea with filesystem buffering.
Message-ID: <2116720000.1011733708@tiny>
In-Reply-To: <3C4DCC49.1080202@namesys.com>
In-Reply-To: <Pine.LNX.4.33L.0201221234470.32617-100000@imladris.surriel.com>
 <3C4DB36F.4090306@namesys.com> <2080500000.1011727185@tiny>
 <3C4DCC49.1080202@namesys.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, January 22, 2002 11:32:09 PM +0300 Hans Reiser
<reiser@namesys.com> wrote:

>> Its not about the cost of a function call, it's what the FS does to make
>> that call useful.  Pretend for a second the VM tells the FS everything it
>> needs to know to age a page (whatever scheme the FS wants to use).
>> 
>> Then pretend the VM decides there's memory pressure, and tells the FS
>> subcache to start freeing ram.  So, the FS goes through its list of pages
>> and finds the most suitable one for flushing, but it has no idea how
>> suitable that page is in comparison with the pages that don't belong to
>> that FS (or even other pages from different mount points of the same FS
>> flavor).
>> 
> 
> Why does it need to know how suitable it is compared to the other
> subcaches?  It just ages X pages, and depends on the VM to determine how
> large X is.  The VM pressures subcaches in proportion to their size, it
> doesn't need to know  how suitable one page is compared to another, it
> just has a notion of push on everyone in proportion to their size.

If subcache A has 1000 pages that are very very active, and subcache B has
500 pages that never ever get used, should A get twice as much memory
pressure?  That's what we want to avoid, and I don't see how subcaches
allow it.

-chris


