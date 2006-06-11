Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161080AbWFKEkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbWFKEkJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 00:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWFKEkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 00:40:08 -0400
Received: from ns2.suse.de ([195.135.220.15]:10954 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161078AbWFKEkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 00:40:06 -0400
From: Neil Brown <neilb@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Date: Sun, 11 Jun 2006 14:39:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17547.40585.982575.7069@cse.unsw.edu.au>
Cc: Theodore Tso <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Chase Venters <chase.venters@clientec.com>,
       Alex Tomas <alex@clusterfs.com>, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Stable/devel policy - was Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: message from Jeff Garzik on Saturday June 10
References: <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
	<20060609181020.GB5964@schatzie.adilger.int>
	<Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
	<m31wty9o77.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse>
	<4489C580.7080001@garzik.org>
	<17D07BC0-4B41-4981-80F5-7AAEC0BB6CC8@mac.com>
	<Pine.LNX.4.64.0606101238110.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606101248030.5498@g5.osdl.org>
	<20060610212624.GD6641@thunk.org>
	<448B45ED.1040209@garzik.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday June 10, jeff@garzik.org wrote:
> Theodore Tso wrote:
> > 	So you you would be in OK of a model where we copy fs/ext3 to
> > "fs/ext4", and do development there which would merged rapidly into
> > mainline so that people who want to participate in testing can use
> > ext3dev, while people who want stability can use ext3 --- and at some
> > point, we remove the old ext3 entirely and let fs/ext4 register itself
> > as both the ext3 and ext4 filesystem, and at some point in the future,
> > remove the ext3 name entirely?
> 
> Yep, and in addition I would argue that you can take the opportunity to 
> make ext4 default to extents-enabled, and some similar behavior changes 
> (dir_index default?).  The existence of both ext3 and ext4 means you can 
> be more aggressive in turning on stuff, IMO.
> 
> 	Jeff

I'm wondering what all this has to say about general principles of
sub-project development with the Linux kernel.

There is a strong tradition of software projects having a 'stable'
branch and a 'development' branch, and having both available and both
receiving bug fixes (at least) so that users can choose what best
suits their needs.

Due to the (quite appropriate) lack of a stable API for kernel
modules, it isn't really practical (and definitely isn't encouraged)
to distribute kernel-modules separately.  This seems to suggest that
if we want a 'stable' and a 'devel' branch of a project, both branches
need to be distributed as part of the same kernel tree.

Apart from ext2/3 - and maybe reiserfs - there doesn't seem to be much
evidence of this happening.  Why is that?

 - is -mm enough?  It seems to be enough for small updates, but
   doesn't seem to be enough for more major projects.  How long
   have the ext3 patches been in -mm?? (I cannot actually seem
   to find them there at all)

 - is there lots of -devel code slipping in to the 'stable' tree, thus
   resulting in a kernel.org tree that is permanently unstable (in
   which case there should be no objection to the new ext3 code -
   leave it to distros to keep it out until it is stable).

 - are we just not innovating as much as we could be and so don't
   need a -devel? Is ext3 the only site of major innovation?
   Seems unlikely.

It seems a bit rough to insist that the ext-fs fork every so-often,
but not impose similar requirements on other sections of code.

So: what would you (collectively) suggest should be the policy for
managing substantial innovation within Linux subsystems?  And how
broadly should it be applied?

NeilBrown
