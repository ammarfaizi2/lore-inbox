Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUBVPIN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 10:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbUBVPIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 10:08:13 -0500
Received: from mail.shareable.org ([81.29.64.88]:64641 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261519AbUBVPIK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 10:08:10 -0500
Date: Sun, 22 Feb 2004 15:07:53 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Christer Weinigel <christer@weinigel.se>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040222150753.GB25664@mail.shareable.org>
References: <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <m3vfm1trj8.fsf@zoo.weinigel.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3vfm1trj8.fsf@zoo.weinigel.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel wrote:
> > 	long sys_mark_dir_clean(dirfd);
> > 
> > the syscall returns whether the directory was valid/clean already.
> 
> Isn't this rather bad, it's only possible to have one process that
> does this magic clean bit thing.  Other applications such as Wine or
> a DOS emulator might want to get the same speedups.

No.  The magic clean bit is associated with dirfd - different file
descriptors have separate magic clean bits.

> Add a new create syscall with the same idea as your one bit syscall,
> which checks that the generation number matches.  If the generation
> number doesn't match the create call fails.
> 
>     int create_synchronized(name, mode, generation);

Hmm.  That's an interesting idea.

-- Jamie
