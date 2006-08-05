Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWHEQ6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWHEQ6u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 12:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWHEQ6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 12:58:50 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:25223 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030228AbWHEQ6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 12:58:49 -0400
Subject: Re: [RFC] [PATCH] Relative lazy atime
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Valerie Henson <val_henson@linux.intel.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Akkana Peck <akkana@shallowsky.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Jesse Barnes <jesse.barnes@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, Chris Wedgwood <cw@f00f.org>,
       jsipek@cs.sunysb.edu, Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: <20060805122537.GA23239@lst.de>
References: <20060803063622.GB8631@goober>  <20060805122537.GA23239@lst.de>
Content-Type: text/plain
Date: Sat, 05 Aug 2006 11:58:43 -0500
Message-Id: <1154797123.12108.6.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-05 at 14:25 +0200, Christoph Hellwig wrote:
> On Wed, Aug 02, 2006 at 11:36:22PM -0700, Valerie Henson wrote:
> > (Corrected Chris Wedgwood's name and email.)
> > 
> > My friend Akkana followed my advice to use noatime on one of her
> > machines, but discovered that mutt was unusable because it always
> > thought that new messages had arrived since the last time it had
> > checked a folder (mbox format).  I thought this was a bummer, so I
> > wrote a "relative lazy atime" patch which only updates the atime if
> > the old atime was less than the ctime or mtime.  This is not the same
> > as the lazy atime patch of yore[1], which maintained a list of inodes
> > with dirty atimes and wrote them out on unmount.
> 
> Another idea, similar to how atime updates work in xfs currently might
> be interesting:  Always update atime in core, but don't start a
> transaction just for it - instead only flush it when you'd do it anyway,
> that is another transaction or evicting the inode.

Hmm.  That adds a cost to evicting what the vfs considers a clean inode.
It seems wrong, but if that's what xfs does, it must not be a problem.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

