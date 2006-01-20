Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030406AbWATGqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbWATGqV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 01:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbWATGqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 01:46:21 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:64953 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030406AbWATGqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 01:46:21 -0500
Message-ID: <43D0873C.7010300@namesys.com>
Date: Thu, 19 Jan 2006 22:46:20 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>, vitaly@thebsh.namesys.com
Subject: [PATCH] someone broke reiserfs V3 mount options, this fixes it
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040609040507040604010202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040609040507040604010202
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

questions to vitaly.....

--------------040609040507040604010202
Content-Type: message/rfc822;
 name="Re: reiserfs tails and disk space"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: reiserfs tails and disk space"

Return-Path: <vitaly@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 16334 invoked by uid 85); 18 Jan 2006 18:37:24 -0000
Received: from vitaly@namesys.com by thebsh.namesys.com by uid 82 with qmail-scanner-1.15 
 (spamassassin: 2.43-cvs.  Clear:SA:0(0.0/2.0 tests=none autolearn=no version=2.60):. 
 Processed in 1.108234 secs); 18 Jan 2006 18:37:24 -0000
Received: from relay.wplus.net (195.131.52.142)
  by thebsh.namesys.com with SMTP; 18 Jan 2006 18:37:23 -0000
Received: from ip64.124.adsl.wplus.ru (ip64.124.adsl.wplus.ru [195.131.124.64])
	by relay.wplus.net (8.13.1/8.13.1/RELAY-DVD) with ESMTP id k0IIb4vJ057303;
	Wed, 18 Jan 2006 21:37:08 +0300 (MSK)
From: Vitaly Fertman <vitaly@namesys.com>
To: Bruce Guenter <lists-reiserfs-list@bruce-guenter.dyndns.org>
Subject: Re: reiserfs tails and disk space
Date: Wed, 18 Jan 2006 21:34:49 +0300
User-Agent: KMail/1.7.1
Cc: Hans Reiser <reiser@namesys.com>, reiserfs-list@namesys.com
References: <20060117181548.GB11010@untroubled.org> <43CD3E45.6080304@namesys.com>
In-Reply-To: <43CD3E45.6080304@namesys.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JpozD1gHRiJ8MHw"
Message-Id: <200601182134.49888.vitaly@namesys.com>
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	thebsh.namesys.com
X-Spam-DCC: : 
X-Spam-Status: No, hits=0.0 required=2.0 tests=none autolearn=no version=2.60

--Boundary-00=_JpozD1gHRiJ8MHw
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 17 January 2006 21:58, Hans Reiser wrote:
> The result is not expected, Vitaly please look into it.
> 
> Hans
> 
> Bruce Guenter wrote:
> 
> >Hi.
> >
> >I've been running a few tests with reiserfs and tails, and have been
> >unable to create a setup where the use (or lack) of tails results in a
> >significant difference in the amount of disk space used.

thank you for the report, the attached patch should fix 
the broken mount options. please try it.

> >Here's what I've done:
> >
> >1. Create a fresh 1GB filesystem (in a file on loopback), using reiserfs
> >with no options.
> >
> >2. Mount the filesystem with either no options, "notail", "tails=off",
> >"tails=on", or "tails=small".
> >
> >3. Unpack a sources tarball onto the filesystem, consisting of two fully
> >compiled versions of the linux kernel.  The tarball contains 47996 files
> >and 3321 directories totalling about 660MB of space.
> >
> >4. Measure the free disk space using df.
> >
> >5. Use dd to fill up the free disk space and count how many 1kB blocks
> >it could write.
> >
> >In all of the tests, the result was within 12kB of each other.  In fact,
> >the tests with "notail" or "tails=off" options had more usable disk
> >space than when using tails.
> >
> >Results:
> >
> >Options    1K-blocks    Used Available
> >default      1023964  645988  377976
> >notail       1023964  645988  377976
> >tails=off    1023964  645996  377968
> >tails=on     1023964  646000  377964
> >tails=small  1023964  645996  377968
> >
> >default      377600+0 records out
> >notail       377600+0 records out
> >tails=off    377592+0 records out
> >tails=on     377588+0 records out
> >tails=small  377592+0 records out
> >
> >I've put the log files and scripts up for review at
> >	http://untroubled.org/reiserfsdf/
> >I'm using Gentoo Linux, kernel 2.6.14-gentoo-r5
> >
> >Am I missing something, is this an expected result, or is something
> >broken?
> >
> >Thanks.
> >  
> >
> 
> 
> 

-- 
Vitaly

--Boundary-00=_JpozD1gHRiJ8MHw
Content-Type: text/x-diff;
  charset="koi8-r";
  name="linux-2.6.14-reiserfs-mount-options-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.14-reiserfs-mount-options-fix.patch"

--- linux-2.6.15-rc5-mm3-clean/fs/reiserfs/super.c	2005-12-21 23:57:54.000000000 +0300
+++ linux-2.6.15-rc5-mm3/fs/reiserfs/super.c	2006-01-18 21:28:25.206460792 +0300
@@ -1131,7 +1131,7 @@
 			REISERFS_SB(s)->s_mount_opt &= ~(1 << REISERFS_ATTRS);
 		}
 	} else if (le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared) {
-		REISERFS_SB(s)->s_mount_opt |= REISERFS_ATTRS;
+		REISERFS_SB(s)->s_mount_opt |= (1 << REISERFS_ATTRS);
 	}
 }
 

--Boundary-00=_JpozD1gHRiJ8MHw--



--------------040609040507040604010202--
