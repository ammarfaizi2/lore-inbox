Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVCORyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVCORyR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVCORwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:52:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57820 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261711AbVCORu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:50:27 -0500
Date: Tue, 15 Mar 2005 17:50:24 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Mahoney <jeffm@suse.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blockdev: fix for racing mount/umount
Message-ID: <20050315175023.GQ8859@parcelfarce.linux.theplanet.co.uk>
References: <20050315141449.GA13653@locomotive.unixthugs.org> <Pine.LNX.4.58.0503150746320.6119@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503150746320.6119@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 08:00:52AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 15 Mar 2005, Jeff Mahoney wrote:
> >
> > This patch is another take at fixing the race between mount and umount
> > resetting the blocksize and causing buffer errors, infinite loops in
> > __getblk_slow, and possibly other undiscovered effects.
> 
> Ok. I had to go back and look up the original problem, and having looked 
> at this a bit more, I wonder whether the real problem is not that we do 
> that silly "set blocksize back to the original one" at umount time in the 
> first place.
> 
> (It happens very indirectly, though the "->kill_sb()" fn pointer, which 
> ends up doing kill_block_super on a regular block device).
> 
> Maybe we should just get rid of it entirely? There's really no point to 
> it.
> 
> Instead, to make things repeatable, we'd always just set the blocksize to
> its default value at the first open. We already do that anyway, don't we?

Yes, but we could explicitly change it at some point before mount.  I'm looking
through that stuff right now - been net.dead for several weeks, thanks to
fscking telco idiocy at exactly wrong time ;-/

Give me a couple of days, OK?  Three weeks of l-k is a hell of a backlog ;-/
