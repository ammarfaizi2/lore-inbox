Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbWFJV0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWFJV0o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 17:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbWFJV0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 17:26:44 -0400
Received: from thunk.org ([69.25.196.29]:49347 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1161019AbWFJV0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 17:26:42 -0400
Date: Sat, 10 Jun 2006 17:26:25 -0400
From: Theodore Tso <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Jeff Garzik <jeff@garzik.org>,
       Chase Venters <chase.venters@clientec.com>,
       Alex Tomas <alex@clusterfs.com>, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610212624.GD6641@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	Kyle Moffett <mrmacman_g4@mac.com>, Jeff Garzik <jeff@garzik.org>,
	Chase Venters <chase.venters@clientec.com>,
	Alex Tomas <alex@clusterfs.com>,
	Andreas Dilger <adilger@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org
References: <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org> <20060609181020.GB5964@schatzie.adilger.int> <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org> <m31wty9o77.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org> <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse> <4489C580.7080001@garzik.org> <17D07BC0-4B41-4981-80F5-7AAEC0BB6CC8@mac.com> <Pine.LNX.4.64.0606101238110.5498@g5.osdl.org> <Pine.LNX.4.64.0606101248030.5498@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606101248030.5498@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 01:02:26PM -0700, Linus Torvalds wrote:
> Starting from scratch - even if you literally start from the same 
> code-base - and allowing the old functionality to remain undisturbed is 
> just a very nice model. Yeah, yeah, it has some diskspace cost (although 
> at least from a git perspective, even that isn't really true), but we've 
> seen both in drivers and in filesystems how splitting things up has been a 
> great thing to do.
> 
> Sometimes it's a great thing just because five years later, it turns out 
> that nobody even uses the legacy thing, and you decide to at that point 
> just remove the driver (or filesystem, but so far it's never been the 
> case for filesystems even if smbfs is a potential victim of this in the 
> not _too_ distant future), because the new version simply does everything 
> better.

	So you you would be in OK of a model where we copy fs/ext3 to
"fs/ext4", and do development there which would merged rapidly into
mainline so that people who want to participate in testing can use
ext3dev, while people who want stability can use ext3 --- and at some
point, we remove the old ext3 entirely and let fs/ext4 register itself
as both the ext3 and ext4 filesystem, and at some point in the future,
remove the ext3 name entirely?

	If that allows us to make forward progress and stop the
flamewar, I'm willing to go along with it --- although e2fsprogs will
continue to support ext2/3/4, and ext4 will have backwards
compatibility support for ext3 formats (we can look at better ways of
refactoring code to make it cleaner, if people don't like the current
conditions).  There are some real advantages to the system, especially
if we can get changed merged into mainline for ext4 more quickly while
it is under development and declared to be unstable (we can put it
under CONFIG_EXPERIMENTAL if people really want).  

	As far as people who want to use ext3 as the beginning point
to do something that is has no forwards- compatibility, there's
nothing stopping them from creating a jgarzikfs if they want.  But I
think I can speak for most of the ext3 development community that we
feel that one of the strengths of ext2/3 is its ability to do smooth
upgrades (and in many cases, downgrades as well, when people need to
migrate a filesystem so it can be mounted on older kernels), and that
it's one of the reasons why ext3 has been more succesful, than say,
JFS. 

	I do think there is plenty of room for competition, and I'm
certainly looking forward to the brainstorming at next week's
filesystem workshop.  But ext2/3 has been pretty successful for over
ten years given a certain development model and philosophy, and I for
one am interested how much farther we can take it.  Remember when
academics were saying that Linux was an obsolete design and
Microkernels was where it's at?  If we had given up 15 years ago when
Prof. Tennenbaum had said it, where would we be?

						- Ted
