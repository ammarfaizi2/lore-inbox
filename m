Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWHIOEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWHIOEL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 10:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWHIOEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 10:04:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:50223 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750854AbWHIOEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 10:04:08 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.07,225,1151910000"; 
   d="scan'208"; a="105582002:sNHT18508861"
Date: Wed, 9 Aug 2006 07:03:49 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Akkana Peck <akkana@shallowsky.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Jesse Barnes <jesse.barnes@intel.com>, Chris Wedgwood <cw@f00f.org>,
       jsipek@cs.sunysb.edu, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] [PATCH] Relative lazy atime
Message-ID: <20060809140349.GE13474@goober>
References: <20060803063622.GB8631@goober> <20060805122537.GA23239@lst.de> <44D49BAA.6050501@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D49BAA.6050501@linux.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 06:22:50AM -0700, Arjan van de Ven wrote:
> Christoph Hellwig wrote:
> >Another idea, similar to how atime updates work in xfs currently might
> >be interesting:  Always update atime in core, but don't start a
> >transaction just for it - instead only flush it when you'd do it anyway,
> >that is another transaction or evicting the inode.
> 
> this is sort of having a "dirty" and "dirty atime" split for the inode I 
> suppose..
> shouldn't be impossible to do with a bit of vfs support..

This is certainly another possibility.  There may be other uses for
the idea of a half-dirty inode.

However, one thing I want to avoid is an event that would cause the
build-up and subsequent write-out of a big list of half-dirty inodes -
think about the worst case: grep -r of the entire file system,
followed by some kind of memory pressure or an unmount.  Would we then
flush out a write to every inode in the file system?  Ew. (This is
worse than having atime on because with full atime, the writes would
be spread out during the execution of the grep -r command.)

-VAL
