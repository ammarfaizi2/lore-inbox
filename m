Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWFSWO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWFSWO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWFSWO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:14:26 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:43384 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S964940AbWFSWOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:14:25 -0400
Date: Mon, 19 Jun 2006 15:14:21 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Theodore Tso <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 5/8] inode-diet: Eliminate i_blksize and use a per-superblock default
Message-ID: <20060619221420.GJ3082@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060619152003.830437000@candygram.thunk.org> <20060619153109.817554000@candygram.thunk.org> <20060619160146.GQ29684@ca-server1.us.oracle.com> <20060619170627.GC15216@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619170627.GC15216@thunk.org>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 01:06:27PM -0400, Theodore Tso wrote:
> How strongly do you feel about reporting stat.st_blksize out to be the
> clustersize?  Keeping in mind that if you report a value which is too
> big, /bin/cp will start coredumping....
Any idea on what constitutes "too big"? We could always cap things at some
reasonable maximum. AFAIR, the reason it's set to clustersize these days is
because it actually made a performance impact on large file operations -
backing up a data base file, for example.

> If I take Christoph's suggestion of simply removing sb->s_blksize
> altogether, and forcing filesystems that want to return a non-default
> value for stat.st_blksize to supply their own filesystem-specific
> getattr, will you mind terribly?
No, I don't mind really - it's a minor bit of code and it'll save us all
some space on the super block structure. I assume we can just continue to
follow Christoph's suggestion in ocfs2_getattr().
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
