Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268417AbTGIQuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 12:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268415AbTGIQuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 12:50:06 -0400
Received: from dnsc6804027.pnl.gov ([198.128.64.39]:65157 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S268432AbTGIQtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 12:49:08 -0400
Date: Wed, 9 Jul 2003 10:03:36 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Christoph Hellwig <hch@infradead.org>, marcelo@connectiva.com.br,
       trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: ->direct_IO API change in current 2.4 BK
Message-ID: <20030709100336.H4482@schatzie.adilger.int>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	marcelo@connectiva.com.br, trond.myklebust@fys.uio.no,
	linux-kernel@vger.kernel.org
References: <20030709133109.A23587@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030709133109.A23587@infradead.org>; from hch@infradead.org on Wed, Jul 09, 2003 at 01:31:09PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 09, 2003  13:31 +0100, Christoph Hellwig wrote:
> I just got a nice XFS oops due to the direct_IO API change in
> 2.4.  Guys, this is a STABLE series and APIs are supposed to be exactly
> that, _STABLE_.  If you really think O_DIRECT on NFS is soo important
> please add a ->direct_IO2 for NFS like the reiserfs read_inode2 hack.

I would have to agree with that sentiment - we shouldn't change the
API in an "almost compatible" way, although I would have hoped that
compile warnings and/or module symbol versioning would have avoided
a crash.

> But what's the use of it anyway?  AFAIK it's mostly for whoracle setups
> that have their data on netapps but that needs a certified vendor kernel
> not mainline..

Actually, it is useful for Lustre to do this, because it allows us to have
a file handle (which, naturally, holds per-file data) at the time the IO is
sent over the wire, instead of the "anonymous" writes that happen now.
This helps us with readahead on the server and other minor improvements.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

