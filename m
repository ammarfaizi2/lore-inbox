Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWHaNXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWHaNXH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 09:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWHaNXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 09:23:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4481 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932238AbWHaNXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 09:23:05 -0400
Subject: [PATCHSET] The GFS2 filesystem (for review)
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Russell Cattelan <cattelan@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       David Teigland <teigland@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 31 Aug 2006 14:26:55 +0100
Message-Id: <1157030815.3384.782.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following on from this message are the 16 patches of GFS2 which we are
again posting for review. Since the last posting we have, I hope,
addressed all the issues raised as well as fixing a number of bugs. In
particular, we have now only one new exported symbol (see patch 16 of
the series).

It is now possible to mount the gfs2meta filesystem for a particular
gfs2 filesystem at the same time as the gfs2 filesystem is mounted. In
fact we enforce that rule at least for the time being due to
dependencies in mounting the two filesystems.

Christoph requested that we find a different way to deal with the
problem of the VFS checking the file size in the direct i/o read path
before handing control to GFS2 (in other words at a point when the size
may change). We have done this with a two line patch to filemap.c (also
in patch 16 of the series) so that its logic is now very similar to that
followed in the direct i/o write path. This has eliminated the need for
us to duplicate parts of the core VFS code inside GFS2.

As usual the git tree is at:

git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6.git

It is based off a fairly recent pull from Linus' tree and includes the
DLM which is not included in the patch set being posted here.

Steve.


