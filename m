Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbTLHOHq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 09:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265433AbTLHOHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 09:07:46 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:36014 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265431AbTLHOHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 09:07:39 -0500
Subject: Re: partially encrypted filesystem
From: David Woodhouse <dwmw2@infradead.org>
To: phillip@lougher.demon.co.uk
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       kbiswas@neoscale.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <E1ATLgF-0003XX-0V@anchor-post-31.mail.demon.net>
References: <E1ATLgF-0003XX-0V@anchor-post-31.mail.demon.net>
Content-Type: text/plain
Message-Id: <1070892449.31993.97.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.1) 
Date: Mon, 08 Dec 2003 14:07:33 +0000
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-08 at 13:44 +0000, phillip@lougher.demon.co.uk wrote:
> dwmw2@infradead.org wrote:
> > On Sat, 2003-12-06 at 00:50 +0000, Phillip Lougher wrote:
> > > Of course, all this is at the logical file level, and ignores the 
> > > physical blocks on disk.  All filesystems assume physical data blocks 
> > > can be updated in place.  With compression it is possible a new physical 
> > > block has to be found, especially if blocks are highly packed and not 
> > > aligned to block boundaries.  I expect this is at least partially why 
> > > JFFS2 is a log structured filesystem.
> > 
> > Not really. JFFS2 is a log structured file system because it's designed
> > to work on _flash_, not on block devices. You have an eraseblock size of
> > typically 64KiB, you can clear bits in that 'block' all you like till
> > they're all gone or you're bored, then you have to erase it back to all
> > 0xFF again and start over.
> 
> Curiously, I am aware of how flash and log structured filesystems work.

This I assumed. The explanation was more for the benefit of the peanut
gallery than yourself.

> > JFFS2 was designed to avoid that inefficient extra layer, and work
> > directly on the flash. Since overwriting stuff in-place is so difficult,
> > or requires a whole new translation layer to map 'logical' addresses to
> > physical addresses, it was decided just to ditch the idea that physical
> > locality actually means _anything_.
> 
> Maybe okay for a flash filesystem which is slow anyway, but many
> filesystem designers *are* concerned about physical locality of
> blocks, for example video filesystems.

Oh, absolutely. 

> Or maybe 'not in(to)-place' :-)

:)

>  I don't think I was saying compression is difficult, it is not
> difficult if you've designed the filesystem correctly.

My point was that it's trivial in JFFS2 not because I designed the file
system 'correctly', but mostly because of other factors which just
happened to lead to a design which, by coincidence, made compression
trivial.

-- 
dwmw2

