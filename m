Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWDUP6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWDUP6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWDUP6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:58:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24480 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932367AbWDUP6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:58:37 -0400
Subject: GFS2 patches for review
From: Steven Whitehouse <swhiteho@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 21 Apr 2006 17:07:14 +0100
Message-Id: <1145635634.3856.91.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please find in the following patches a new release of the GFS2 code. We
believe that we've addressed all the points which were brought up on
the list after the previous posting for review. If you think we've
missed something, please let us know :-)

This is a request for GFS2 to be considered for inclusion in -mm.

The latest GFS2 patches can be found in out git tree which is located at
(or see the following emails):
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=summary

Here is a summary of whats new since the last posting:

 - Various stylistic changes as per requests from our last posting

 - Cleaned up directory code (see patch 7/17 for more details)

 - ioctl() now changed so that its compatible with the ext2/3 ioctl.
   Also this introduces a new header file linux/iflags.h which is
   designed as a place to register the flags in a fs independant way.
   Assuming that this is considered the way to move forward, then
   I'll come up with some patches to redefine the flags for the other
   fs which use this interface in terms of the ones in iflags.h. See
   patch 5/17 for the details.

 - Various bugs now fixed (see the git tree at kernel.org for a full
   list)

 - The .gfs2_admin directory is no more. Its been replaced by a gfs2meta
   filesystem. Currently you can only mount the fs normally or mount the
   meta filesystem (not both at the same time). This will change in time
   but shouldn't be a big problem as you shouldn't need to access the
   gfs2meta filesystem in normal use anyway.

Still on our "todo before submission to Linus" list:

 - Some cleanups in the glock code, and to make it return AOP_TRUNCATED_PAGE
   at the right times. We've already introduced a flag GL_AOP which is used
   to signal to the glock code that the fs is holding a page lock when a
   glock is requested.

 - Selinux support

 - More testing :-)


Steve.


