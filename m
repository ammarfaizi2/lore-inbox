Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262638AbTCNVpA>; Fri, 14 Mar 2003 16:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263515AbTCNVpA>; Fri, 14 Mar 2003 16:45:00 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:39042 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262638AbTCNVo7>; Fri, 14 Mar 2003 16:44:59 -0500
Subject: Re: [Ext2-devel] Filesystem write priorities, (Was: Re: [RFC]
	Improved inode number allocation for HTree)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: John Bradford <john@grabjohn.com>
Cc: Andreas Schwab <schwab@suse.de>, phillips@arcor.de,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger@clusterfs.com>,
       chrisl@vmware.com, bzzz@tmi.comex.ru, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <200303102150.h2ALoVME001043@81-2-122-30.bradfords.org.uk>
References: <200303102150.h2ALoVME001043@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047678942.2566.613.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 14 Mar 2003 21:55:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2003-03-10 at 21:50, John Bradford wrote:

> Well, yes, I use noatime by default, but I was thinking that there
> might be users who wanted to gain most of the performance that using
> noatime would, who still wanted access times available generally, but
> who were not bothered about loosing them on an unclean shutdown.

I've got new inode-flushing code which somewhat does that already.  The
code in 

http://people.redhat.com/sct/patches/ext3-2.4/dev-20030314/40-iflush-sct/

allows us to defer inode writes, primarily to eliminate redundant
copy-to-buffer-cache operations in mark_inode_dirty; but it has the
side-effect of allowing us to defer atime updates quite safely.

I'm currently integrating all the latest bits and pieces of orlov and
htree work into that set of patches to provide a stable base, and the
next order of business is to get ACL and O_DIRECT diffs in for 2.4
too.   But beyond that, I need to get down to some serious performance
work with ext3, and the inode flush code is a major part of that.

--Stephen

