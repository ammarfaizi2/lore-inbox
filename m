Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWBYIzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWBYIzs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 03:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbWBYIzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 03:55:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11027 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932364AbWBYIzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 03:55:47 -0500
Date: Sat, 25 Feb 2006 08:55:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
Message-ID: <20060225085541.GB27538@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <0.399206195@selenic.com> <4.399206195@selenic.com> <20060224221909.GD28855@flint.arm.linux.org.uk> <20060225065136.GH13116@waste.org> <20060225084955.GA27538@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225084955.GA27538@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 08:49:55AM +0000, Russell King wrote:
> On Sat, Feb 25, 2006 at 12:51:36AM -0600, Matt Mackall wrote:
> > On Fri, Feb 24, 2006 at 10:19:09PM +0000, Russell King wrote:
> > > How does this change handle the case where we run out of input data?
> > > This condition needs to be handled explicitly because the inflate
> > > functions can infinitely loop.
> > 
> > And if you look at the current users, you'll see that only two of 15
> > actually use it.
> 
> Sorry, I don't understand the relevance of your comment.
> 
> As the code stands in mainline, if we run out of input data, we are
> guaranteed to exit from inflate.
> 
> With your change in this patch set, we no longer guaranteed to exit,
> but will in some circumstances loop indefinitely.
> 
> The problem this causes is that if the ramdisk decompression runs out
> of data, the kernel will just silently hang.
> 
> Please do not back out this fix.
> 
> > > Relying on a bit pattern returned by get_byte() is how this code
> > > pre-fix used to work, and it caused several confused bug reports.
> > 
> > Just about everywhere, get_byte prints an error message and halts.
> 
> And the cases where it doesn't halt is the important case.
> 
> Sorry, but I hope that this code does not get merged as is.  It's
> backing out a fix that I was involved in getting in, and therefore
> I'm completely opposed to your code as it stands.

FYI, here's the bk delta which introduced this fix.

http://linux.bkbits.net:8080/linux-2.6/diffs/lib/inflate.c@1.6?nav=index.html|src/.|src/lib|hist/lib/inflate.c

Of course, not having per-file comments in BK means that we can't get
at the cset comments which explain _why_ it is necessary.  Maybe akpm
keeps an archive of such things?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
