Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269400AbTHKP4N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269423AbTHKP4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:56:13 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:38650 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S269400AbTHKP4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:56:07 -0400
Date: Mon, 11 Aug 2003 09:55:18 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] file extents for EXT3
Message-ID: <20030811095518.T7752@schatzie.adilger.int>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <m3ptjcabey.fsf@bzzz.home.net> <3F3791C8.4090903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F3791C8.4090903@pobox.com>; from jgarzik@pobox.com on Mon, Aug 11, 2003 at 08:53:28AM -0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 11, 2003  08:53 -0400, Jeff Garzik wrote:
> Changing the underlying disk format without bumping the filesystem 
> revision is a hugely bad idea.  I disagreed with merging htree (even 
> though its backward compat) without bumping the filesystem version, too.
> 
> Vendors, distributors, OEMs, etc. all test against existing on-disk 
> formats, when they release their products.  When the filesystem format 
> for an existing filesystem, in production, changes underneath them, they 
> tend to get worried and annoyed.  So, to all ext developers,
> 
> Please add <it> to ext4 not ext3!

Ext2/3 uses feature flags instead of version numbers to indicate such
changes.  Version numbers are a poor way of indicating whether a change
is compatible or not compared to feature flags.  For example, if you bump
the minor number to indicate a "compatible" change it means that any
code that pretends to support version x.y features also needs to support
all features <= y and all features <= x.

If you really want to have a feature number to be happy, just think of

	s.feature_incompat.s_feature_ro_compat.s_feature_compat

as something like a version number and you will nearly be happy.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

