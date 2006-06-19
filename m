Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWFSRGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWFSRGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWFSRGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:06:31 -0400
Received: from thunk.org ([69.25.196.29]:4813 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964804AbWFSRGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:06:31 -0400
Date: Mon, 19 Jun 2006 13:06:27 -0400
From: Theodore Tso <tytso@mit.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 5/8] inode-diet: Eliminate i_blksize and use a per-superblock default
Message-ID: <20060619170627.GC15216@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <20060619153109.817554000@candygram.thunk.org> <20060619160146.GQ29684@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619160146.GQ29684@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 09:01:46AM -0700, Joel Becker wrote:
> 
> 	I assume you meant sb->s_blksize.  osb is a private structure
> hanging off of sb->s_fs_info.

Yep, mea culpa.

> 	I have to say, having sb->s_blocksize and sb->s_blksize might be
> a little confusing.

How strongly do you feel about reporting stat.st_blksize out to be the
clustersize?  Keeping in mind that if you report a value which is too
big, /bin/cp will start coredumping....

If I take Christoph's suggestion of simply removing sb->s_blksize
altogether, and forcing filesystems that want to return a non-default
value for stat.st_blksize to supply their own filesystem-specific
getattr, will you mind terribly?

						- Ted
