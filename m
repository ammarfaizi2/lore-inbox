Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbTDKWxN (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTDKWxN (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:53:13 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:28923 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S261977AbTDKWwx (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 18:52:53 -0400
Date: Fri, 11 Apr 2003 17:03:52 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Andrew Morton <akpm@digeo.com>
Cc: cat@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: ext3 weirdness
Message-ID: <20030411170352.S26054@schatzie.adilger.int>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>, cat@zip.com.au,
	linux-kernel@vger.kernel.org
References: <20030411170655.GA10449@zip.com.au> <20030411113941.O26054@schatzie.adilger.int> <20030411154006.7b4d511c.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030411154006.7b4d511c.akpm@digeo.com>; from akpm@digeo.com on Fri, Apr 11, 2003 at 03:40:06PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 11, 2003  15:40 -0700, Andrew Morton wrote:
> Andreas Dilger <adilger@clusterfs.com> wrote:
> > Because you can't reallocate in-use blocks until the dirty bitmaps have
> > been committed to disk in a transaction.
> 
> Also, in 2.5 pdflush will take a ref on the inode while writing it out.  So
> an unlink while pdflush is writing back the inode's pages will be magically
> instantaneous, and pdflush actually does the truncate.

It should be possible to have pdflush check for i_nlink == 0 and i_count == 1
periodically, indicating it is the only one that has a reference and then
immediately iput the node (truncating the pages instead of writing them out).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

