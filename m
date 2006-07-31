Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWGaSL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWGaSL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 14:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbWGaSL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 14:11:26 -0400
Received: from mail.gmx.de ([213.165.64.21]:64479 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030288AbWGaSLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 14:11:25 -0400
X-Authenticated: #428038
Date: Mon, 31 Jul 2006 20:11:20 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       Matthias Andree <matthias.andree@gmx.de>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060731181120.GA9667@merlin.emma.line.org>
Mail-Followup-To: Rudy Zijlstra <rudy@edsons.demon.nl>,
	Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
	ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
	jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
References: <1153760245.5735.47.camel@ipso.snappymail.ca> <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl> <20060731125846.aafa9c7c.reiser4@blinkenlights.ch> <20060731144736.GA1389@merlin.emma.line.org> <20060731175958.1626513b.reiser4@blinkenlights.ch> <20060731162224.GJ31121@lug-owl.de> <Pine.LNX.4.64.0607311842120.13492@nedra.edsons.demon.nl> <20060731173239.GO31121@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731173239.GO31121@lug-owl.de>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw schrieb am 2006-07-31:

> On Mon, 2006-07-31 18:44:33 +0200, Rudy Zijlstra <rudy@edsons.demon.nl> wrote:
> > On Mon, 31 Jul 2006, Jan-Benedict Glaw wrote:
> > > On Mon, 2006-07-31 17:59:58 +0200, Adrian Ulrich 
> > > <reiser4@blinkenlights.ch> wrote:
> > > > A colleague of mine happened to create a ~300gb filesystem and started
> > > > to migrate Mailboxes (Maildir-style format = many small files (1-3kb))
> > > > to the new LUN. At about 70% the filesystem ran out of inodes; Not a
> > >
> > > So preparation work wasn't done.
> > 
> > Of course you are right. Preparation work was not fully done. And using 
> > ext1 would also have been possible. I suspect you are still using ext1, 
> > cause with proper preparation it is perfectly usable.
> 
> Oh, and before people start laughing at me, here are some personal or
> friend's experiences with different filesystems:
> 
>   * reiser3: A HDD containing a reiser3 filesystem was tried to be
>     booted on a machine that fucked up DMA writes. Fortunately, it
>     crashed really soon (right after going for read-write.)  After
>     rebooting the HDD on a sane PeeCee, it refused to boot. Starting
>     off some rescue system showed an _empty_ root filesystem.

Massive hardware problems don't count. ext2/ext3 doesn't look much better in
such cases. I had a machine with RAM gone bad (no ECC - I wonder what
idiot ordered a machine without ECC for a server, but anyways) and it
fucked up every 64th bit - only in a certain region. Guess what happened
to the fs when it went into e2fsck after a reboot. Boom. Same with a
dead DPTA that lost every 16th block or so, the rescue in the first case
was swapping the RAM and "amrecover" and in the second swapping the
drive and "dsmc restore". OTOH, kernel panics on bad blocks are a no-no
of course.

>   * A friend's XFS data partition (portable USB/FireWire HDD) once
>     crashed due to being hot-unplugged off the USB.  The in-kernel XFS
>     driver refused to mount that thing again, and the tools also
>     refused to fix any errors. (Don't ask, no details at my hands...)

Don't use write caches then. (Though I've seen NUL-filled blocks in new
files or appended to files after in 2001 or 2002.)

>   * JFS just always worked for me. Though I've never ever had a broken
>     HDD where it (or it's tools) could have shown how well-done they
>     were, so from a crash-recovery point of view, it's untested.

SUSE removed JFS support from their installation tool for "technical
reasons" they didn't specify in the release notes. Whatever.

> ext3 always worked well for me, so why should I abandon it?

Plus, it and its tools are maintained.

-- 
Matthias Andree
