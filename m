Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161610AbWJDQ5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161610AbWJDQ5B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161607AbWJDQ5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:57:00 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:190 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1161260AbWJDQ47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:56:59 -0400
Date: Wed, 4 Oct 2006 10:56:56 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
       linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Directories > 2GB
Message-ID: <20061004165655.GD22010@schatzie.adilger.int>
Mail-Followup-To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	xfs@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For ext4 we are exploring the possibility of directories being larger
than 2GB in size.  For ext3/ext4 the 2GB limit is about 50M files, and
the 2-level htree limit is about 25M files (this is a kernel code and not
disk format limit).

Amusingly (or not) some users of very large filesystems hit this limit
with their HPC batch jobs because they have 10,000 or 128,000 processes
creating files in a directory on an hourly basis (job restart files,
data dumps for visualization, etc) and it is not always easy to change
the apps.

My question (esp. for XFS folks) is if anyone has looked at this problem
before, and what kind of problems they might have hit in userspace and in
the kernel due to "large" directory sizes (i.e. > 2GB).  It appears at
first glance that 64-bit systems will do OK because off_t is a long
(for telldir output), but that 32-bit systems would need to use O_LARGEFILE
when opening the file in order to be able to read the full directory
contents.  It might also be possible to return -EFBIG only in the case
that telldir is used beyond 2GB (the LFS spec doesn't really talk about
large directories at all).

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

