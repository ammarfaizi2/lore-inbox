Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbUDEITq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 04:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbUDEITq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 04:19:46 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:48539 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263162AbUDEITn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 04:19:43 -0400
Date: Mon, 5 Apr 2004 10:19:26 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Pavel Machek <pavel@ucw.cz>, Chris Friesen <cfriesen@nortelnetworks.com>,
       mj@ucw.cz, jack@ucw.cz,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040405081925.GC28924@wohnheim.fh-wedel.de>
References: <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz> <406DE280.6050109@nortelnetworks.com> <20040403004947.GI653@mail.shareable.org> <20040403082303.GA1316@elf.ucw.cz> <20040403131539.GA4706@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040403131539.GA4706@mail.shareable.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 April 2004 14:15:39 +0100, Jamie Lokier wrote:
> Pavel Machek wrote:
> > > > Could you not change it back to a normal inode when refcount becomes 1? 
> > > 
> > > You can only do that if the cowid object has a pointer to the last
> > > remaining reference to it.  That's possible, but more complicated and
> > > would incur a little more I/O per cow operation.
> > 
> > You'd have to have pointers to all references to it... because you
> > can't tell in advance which one will be the last to go away.
> 
> Exactly.  Each of the cow pointers would need to be linked in a doubly
> linked list containing them all.

I don't like the list idea.  Having the extra cowid (I prefer inode)
indirection costs a few bytes and one lookup, not much.  The list is
way too much overhead to get rid of so little in a few cases.

If you really want to, create a new syscall foldfile() that will
remove the indirection for one file, if possible.  Then userspace can
do the ugly work of scanning for single-linked cowids (or just leave
it).

Jörn

-- 
The competent programmer is fully aware of the strictly limited size of
his own skull; therefore he approaches the programming task in full
humility, and among other things he avoids clever tricks like the plague. 
-- Edsger W. Dijkstra
