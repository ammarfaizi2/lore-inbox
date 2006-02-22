Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWBVWDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWBVWDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWBVWDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:03:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20909 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751479AbWBVWDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:03:07 -0500
Date: Wed, 22 Feb 2006 22:02:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Steven Whitehouse <swhiteho@redhat.com>, Chris Wedgwood <cw@f00f.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Oleg Drokin <green@linuxhacker.ru>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: FMODE_EXEC or alike?
Message-ID: <20060222220258.GA25654@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Chris Wedgwood <cw@f00f.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Oleg Drokin <green@linuxhacker.ru>
References: <20060220221948.GC5733@linuxhacker.ru> <20060221103949.GD19349@infradead.org> <20060222010347.GA27318@taniwha.stupidest.org> <1140598740.6400.610.camel@quoit.chygwyn.com> <20060222214201.GI28219@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222214201.GI28219@fieldses.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 04:42:02PM -0500, J. Bruce Fields wrote:
> On Wed, Feb 22, 2006 at 08:59:00AM +0000, Steven Whitehouse wrote:
> > Hi,
> > 
> > Also GFS2 (which we hope to be ready to submit to the kernel shortly)
> > would want to make use of this feature. Its been a long standing entry
> > on our TODO list,
> 
> So there's a question here about ordering of these sorts of patches.
> 
> At CITI we've done some work on making nfsd play nicely with cluster
> filesystems (e.g., to allow consistent locking across NFS clients
> talking to different NFS servers exporting the same cluster filesystem).
> 
> The work is partly motivated by (and so far only tested with)
> out-of-tree filesystems.  We've had some minor discussion with GFS2 and
> OCFS2 hackers but assumed there was no use asking for serious review
> until there was an in-tree filesystem that could take advantage of them.
> (So we're happy to hear GFS2 is nearly ready--OCFS2 isn't attempting
> cluster-coherent locking at all for now.)
> 
> Should we be pushing these sorts of patches earlier, at least as long as
> they're fairly low-impact?  Or should we be observing an absolute rule
> against introducing new interfaces without also introducing in-tree
> users?

That patch adds lots of unused code so far now a clear NACK.  Even after
users are in mainline such additions would need a clear justification.
Can for example some existing locking code be removed?  fs/locks.c is
a huge mess right now and adding more and more entry points doesn't
exactly help there.

Oh, and given that's it's stuff deeply interwinded with the file locking
code it should become _GPL exports.

