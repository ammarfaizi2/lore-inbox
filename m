Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264894AbUD2RJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbUD2RJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 13:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUD2RJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 13:09:27 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:50920 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S264894AbUD2RJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 13:09:25 -0400
Date: Thu, 29 Apr 2004 11:09:22 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: David =?iso-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>
Cc: sct@redhat.com, akpm@digeo.com, linux-kernel@vger.kernel.org,
       ext3-users@redhat.com
Subject: Re: Ext3 problems (aborting journal).
Message-ID: <20040429170922.GN1521@schnapps.adilger.int>
Mail-Followup-To: David =?iso-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>,
	sct@redhat.com, akpm@digeo.com, linux-kernel@vger.kernel.org,
	ext3-users@redhat.com
References: <200404291415.46949.ender@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200404291415.46949.ender@debian.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 29, 2004  14:15 +0200, David Martínez Moreno wrote:
> Hello all. I'm writing to all the people in charge of ext3 fs
> 
> Apr 29 12:21:21 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1071716394, count = 1

You need to run "e2fsck -f /dev/sda7" on the unmounted filesystem.  There
is some sort of corruption there.

> Apr 23 20:35:41 arsinoe kernel: EXT3-fs error (device sda7): ext3_free_blocks: Freeing blocks not in datazone - block = 1075532092, count = 1

This earlier error should have forced a full fsck - did that run?

> Apr 23 20:38:47 arsinoe kernel: i91u: Reset SCSI Bus ...
> Apr 23 20:38:47 arsinoe kernel: ERROR: SCSI host `INI9100U' has no error handling
> Apr 23 20:38:47 arsinoe kernel: ERROR: This is not a safe way to run your SCSI host
> Apr 23 20:38:47 arsinoe kernel: ERROR: The error handling must be added to this driver

This seems a bit ominous, not sure how bad it really is.

> 	I forced to fsck all the ext3 drives (/dev/sda{1,6,7}) and installed 2.6.6-rc2.
> It fsck'ed one of the partitions, then wanted to reboot, then fsck'ed the three

Hmm, so it did run.  It seems you are getting corruption on the disk for
some reason.

> 	A tune2fs from the affected partition:
> 
> arsinoe:/usr/src/dev# tune2fs -l /dev/sda7
> tune2fs 1.35-WIP (07-Dec-2003)
> Filesystem volume name:   <none>
> Last mounted on:          <not available>
> Filesystem UUID:          6b9d38e7-7487-444b-b8e4-68404673964f
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      has_journal filetype needs_recovery sparse_super
> Default mount options:    (none)
> Filesystem state:         clean with errors

Was this after the e2fsck was run?  It shouldn't be marked "with errors".

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

