Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWIXOUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWIXOUO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 10:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWIXOUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 10:20:14 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:15890 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750865AbWIXOUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 10:20:12 -0400
Date: Sun, 24 Sep 2006 15:20:06 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Petr Baudis <pasky@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm1
Message-ID: <20060924142005.GF25666@flint.arm.linux.org.uk>
Mail-Followup-To: Petr Baudis <pasky@ucw.cz>, linux-kernel@vger.kernel.org
References: <20060924040215.8e6e7f1a.akpm@osdl.org> <20060924124647.GB25666@flint.arm.linux.org.uk> <20060924132213.GE11916@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924132213.GE11916@pasky.or.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 03:22:13PM +0200, Petr Baudis wrote:
> Dear diary, on Sun, Sep 24, 2006 at 02:46:47PM CEST, I got a letter
> where Russell King <rmk+lkml@arm.linux.org.uk> said that...
> > On Sun, Sep 24, 2006 at 04:02:15AM -0700, Andrew Morton wrote:
> > >  git-arm.patch
> > 
> > It's worth pointing out that something has gone horribly wrong in the
> > devel branch of this tree, resulting in a load of files being deleted
> > which shouldn't have been.
> > 
> > Absolutely no idea how that happened, but it's a commit buried behind
> > lots of other commits and has taken some 4 days to be spotted.  At a
> > guess, a perl bug where a new associative array somehow manages to pick
> > up on old values and forget values from previous assignments.
> > 
> > Oddly, running the script in debug mode (where the only things which
> > don't happen is the git commands get called) appears to give correct
> > behaviour.
> > 
> > So I'm in the situation where I need to rebuild 4 days work in the ARM
> > devel tree. ;(
> 
> If I understand correctly, you just need to get rid of that bad commit?

I'm now told that the resulting tree after all the commits is correct.
The problem is that all the files which were supposed to be deleted by
previous patches ended up actually being deleted by the final patch in
the series.

So the resulting tree is fine, it's just that the history is rather
broken.

I think a solution to this might be to use git-apply, but there's one
draw back - I currently have the facility to unpatch at a later date,
but git-apply doesn't support -R.  I'd have to fall back to the patch
+ git add + git rm + git commit method, but that's been shown to be
fundamentally broken.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
