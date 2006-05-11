Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbWEKB2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbWEKB2Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 21:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbWEKB2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 21:28:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39366 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965101AbWEKB2Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 21:28:24 -0400
Date: Thu, 11 May 2006 02:28:18 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: davem@davemloft.net, dwalker@mvista.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Message-ID: <20060511012818.GL27946@ftp.linux.org.uk>
References: <20060510162106.GC27946@ftp.linux.org.uk> <20060510150321.11262b24.akpm@osdl.org> <20060510221024.GH27946@ftp.linux.org.uk> <20060510.153129.122741274.davem@davemloft.net> <20060510224549.GI27946@ftp.linux.org.uk> <20060510160548.36e92daf.akpm@osdl.org> <20060510232042.GJ27946@ftp.linux.org.uk> <20060510164554.27a13ca9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510164554.27a13ca9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 04:45:54PM -0700, Andrew Morton wrote:
> Al Viro <viro@ftp.linux.org.uk> wrote:
> > Sorry, no - it shuts up too much.  Look, there are two kinds of warnings
> > here.  "May be used" and "is used".  This stuff shuts both.  And unlike
> > "may be used", "is used" has fairly high S/N ratio.
> > 
> > Moreover, once you do that, you lose all future "is used" warnings on
> > that variable.  So your ability to catch future bugs is decreased, not
> > increased.
> 
> Only for certain gcc versions.  Other people use other versions, so it'll
> be noticed.  If/when gcc gets fixed, more and more people will see the real
> warnings.
> 
> Look, of course it has problems.  But the current build has problems too. 
> It's a question of which problem is worse..

FWIW, I've got mostly finished pile of scripts (still needs to be
consolidated, with merge into git for some parts) that does that following:
take two trees and build log for the first one; generate remapped log
with all lines of form <filename>:<line number>:<text> modified.  If line
in question survives in the new tree, turn it into
N:<new filename>:<new line number>:<text>
with new filename and line giving its new location, otherwise turn it into
O:<filename>:<line number>:<text>

That reduces the size of diff between build logs a _lot_ - basically,
all noise from changed line numbers is gone and we are left with real
changes.  It works better with git (we catch renames that way), but
even starting with diff between the trees works fairly well.

IME, it makes watching for regressions quite simple, even when dealing with
something like 2.6.16-rc2 and current, with shitloads of changes in between.
And yes, I _do_ watch ia64 tree, with all its noise.  Moreover, I watch
CHECK_ENDIAN sparse builds, aka thousands of warnings all over the tree...

I'll get that stuff into sane form and post it; IMO it solves the noise
problem just fine.
