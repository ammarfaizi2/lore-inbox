Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262165AbTCLXIw>; Wed, 12 Mar 2003 18:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262170AbTCLXIw>; Wed, 12 Mar 2003 18:08:52 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:22011 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S262165AbTCLXIs>; Wed, 12 Mar 2003 18:08:48 -0500
Date: Wed, 12 Mar 2003 16:18:13 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Larry McVoy <lm@work.bitmover.com>,
       David Lang <david.lang@digitalinsight.com>,
       Larry McVoy <lm@bitmover.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312161813.S12806@schatzie.adilger.int>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Lang <david.lang@digitalinsight.com>,
	Larry McVoy <lm@bitmover.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
References: <20030312220156.GE30788@work.bitmover.com> <Pine.LNX.4.44.0303121409300.11045-100000@dlang.diginsite.com> <20030312223013.GH7275@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030312223013.GH7275@work.bitmover.com>; from lm@bitmover.com on Wed, Mar 12, 2003 at 02:30:13PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 12, 2003  14:30 -0800, Larry McVoy wrote:
> On Wed, Mar 12, 2003 at 02:21:49PM -0800, David Lang wrote:
> > and if you did real-time updates but once a month or so redid the
> > 'longest-path' thing that would change the CVS version info, correct?
> 
> Exactly.  So if we redo it then anyone who has active CVS workspaces will
> get the wrong thing when they update if the revs have moved around and
> they will.
> 
> I suspect the right answer is that we do the real time updates, see how it
> goes, if it starts to suck we'll periodically toss the CVS tree and start
> over.  

What you could do is have a CVS "realtime" branch which is forked from the
trunk, say once a week, or whenever Linux makes a point release.  On this
branch you do incremental updates as they are merged into CVS.  When it is
time to create a new branch (say for 2.5.99-pre12), you re-do the export from
the branch base tag (at 2.5.99-pre11) to the current BK head in an "optimal"
way, and retag the "realtime" branch off of the new base tag.

We do this in our current CVS development, and CVS is smart enough to keep
local changes over the update and/or generate conflicts.  That way, most
people can have a simple-but-good trunk to follow, but people who want
up-to-the-second updates can have it too, and you don't end up renumbering
the CVS revisions for times in the past.  It also avoids the need to re-crunch
the entire BK repository to get an optimal path (which is only going to get
slower as time goes on, and I'm not sure whether Linux development is ahead
of or behind Moore's law).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

