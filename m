Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267796AbUIAW0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267796AbUIAW0r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 18:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267758AbUIAVgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:36:45 -0400
Received: from research.rutgers.edu ([128.6.25.145]:45818 "EHLO
	research.rutgers.edu") by vger.kernel.org with ESMTP
	id S267935AbUIAVcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:32:31 -0400
Date: Wed, 1 Sep 2004 17:32:25 -0400 (EDT)
From: Suresh Gopalakrishnan <gsuresh@cs.rutgers.edu>
To: linux-kernel@vger.kernel.org
Subject: NFS returns EBADCOOKIE (523) to user space
Message-ID: <Pine.GSO.4.21.0409011713360.28492-100000@research.rutgers.edu>
Return-Rcpt-To: gsuresh@rutgers.edu
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When a process is doing a readdir in a directory and another process is
deleting objects in the same directory, sometimes EBADCOOKIE seems to be
returned to the first process.

The following messages were seen when nfs tracing was turned on.
kernel: NFS: find_dirent() returns -523
kernel: NFS: find_dirent_page() returns -523
kernel: NFS: readdir_search_pagecache() returned -523 

Here is the analysis: In nfs_readdir, when readdir_search_pagecache()
returns -EBADCOOKIE, uncached_readdir() is called. This sets desc->error
to -EBADCOOKIE, and status to -EIO. In nfs_readdir(), the status (res) is
reset to 0. Then desc->error is returned as is to user space.

--suresh

