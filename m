Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVH2D1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVH2D1s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 23:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVH2D1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 23:27:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16600 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750734AbVH2D1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 23:27:47 -0400
Date: Sun, 28 Aug 2005 20:27:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jerome Pinot <ngc891@gmail.com>
cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.13
In-Reply-To: <88ee31b705082819341961949e@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0508282017250.3243@g5.osdl.org>
References: <88ee31b705082819341961949e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Aug 2005, Jerome Pinot wrote:
> 
> Using git in the linus tree:
> $ git-whatchanged v2.6.12..v2.6.13 --pretty=full

It's really much nicer to just do

	git log --no-merges v2.6.12..v2.6.13

which gives you a much more readable result.

git-whatchanged is useful if you also want to see the files that got
changed (especially with the "-p" flag to see the whole diff), or if you
want to limit it to a specific subsystem ("git-whatchanged drivers/usb"),
but if you just want the log, use "git log".

That "--pretty=full" this gives you committer information (and you can do
it for "git log" too), but most people probably don't care. In fact, you'd
more often find yourself using "--pretty=short", which only shows the
first line ("head-line" - the subject line of an email patch) of the
commit message.

Additionally, you can pipe the output of "git log" to "git-shortlog", and
you'll get the shortlog format (ie head-line only, and sorted by author).  

Sadly, some commits ended up missing out on the author field (hey, people
were getting started with git), so you have two commits like this:

	commit af25e94d4dcfb9608846242fabdd4e6014e5c9f0
	Author:  <>
	Commit: Tony Luck <tony.luck@intel.com>
	
	    [IA64] Make ia64 die() preempt safe
	
	    Signed-off-by: Keith Owens <kaos@sgi.com>
	    Signed-off-by: Tony Luck <tony.luck@intel.com>

	commit af2c80e926ad5335d00a8d507928aff4e8ff1877
	Author: ? <?>
	Commit: Thomas Gleixner <tglx@mtd.linutronix.de>
	
	    [MTD] ms02-nv: Fix 64bit operation
	
	    Replace KSEG1ADDR() with CKSEG1ADDR() as the former does not work for
	    64-bit configurations anymore.
	
	    Signed-off-by: Maciej W. Rozycki <macro@infradead.org>
	    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

where the author does show up thanks to the sign-off lines, but the git
author information was left empty, so the git-shortlog thing has two 
unattributed changes ;^p

			Linus
