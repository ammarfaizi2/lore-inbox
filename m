Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbTDUTFX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 15:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbTDUTFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 15:05:22 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:55744 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262665AbTDUTFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 15:05:20 -0400
Date: Mon, 21 Apr 2003 21:16:50 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       "David S. Miller" <davem@redhat.com>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] new system call mknod64
Message-ID: <20030421191650.GA7990@wohnheim.fh-wedel.de>
References: <20030421182734.GN10374@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0304211132130.3101-100000@home.transmeta.com> <20030421185424.GO10374@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030421185424.GO10374@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 April 2003 19:54:24 +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, Apr 21, 2003 at 11:35:31AM -0700, Linus Torvalds wrote:
> > 
> > Since they are always in canonical format, there is no way for them to 
> > have the aliasing issue. However, even then they _should_ be careful, 
> > since it would be very confusing (and bad) if they consider
> > 
> > 	0x00010100 	(major 1, minor 256)
> > 
> > to be fundamentally different from
> > 
> > 	0x01ff		(major 1, minor 255)
> > 
> > and cause problems that way.
> > 
> > In other words, if I'm a device driver, and I say that I want "range 
> > 0-0xfff" for "major 2", then I had better get _all_ of it.
> 
> Sure.  However, note that right now there is only one driver that
> wants a range bigger than 256 (and has to split it).  UNIX 98 ptys.

Once this whole matter has settled down a little, mtdchar might want
more than 256 as well. The good news though, is that the old range
should stay unchanged for compatibility and the more-than-256 range
can remain unsplit.

Jörn

-- 
Simplicity is prerequisite for reliability.
-- Edsger W. Dijkstra
