Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262471AbTCMR33>; Thu, 13 Mar 2003 12:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbTCMR32>; Thu, 13 Mar 2003 12:29:28 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:18422 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S262471AbTCMR32>; Thu, 13 Mar 2003 12:29:28 -0500
Date: Thu, 13 Mar 2003 10:39:48 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [Ext2-devel] [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <20030313103948.Z12806@schatzie.adilger.int>
Mail-Followup-To: Alex Tomas <bzzz@tmi.comex.ru>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
References: <m3el5bmyrf.fsf@lexa.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3el5bmyrf.fsf@lexa.home.net>; from bzzz@tmi.comex.ru on Thu, Mar 13, 2003 at 11:55:32AM +0300
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 13, 2003  11:55 +0300, Alex Tomas wrote:
> as Andrew said, concurrent balloc for ext3 is useless because of BKL.
> and I saw it in benchmarks. but it may be useful for ext2.

Sadly, we are constantly diverging the ext2/ext3 codebases.  Lots of
features are going into ext3, but lots of fixes/improvements are only
going into ext2.  Is ext3 holding BKL for doing journal_start() still?

Looking at ext3_prepare_write() we grab the BKL for doing journal_start()
and for journal_stop(), but I don't _think_ we need BKL for journal_stop()
do we?  We may or may not need it for the journal_data case, but that is
not even working right now I think.

It also seems we are getting BKL in ext3_truncate(), which likely isn't
needed past journal_start(), although we do need to have superblock-only
lock for ext3_orphan_add/del.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

