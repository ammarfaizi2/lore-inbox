Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756723AbWKTLLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723AbWKTLLL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 06:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756721AbWKTLLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 06:11:10 -0500
Received: from mail-gw3.sa.ew.hu ([212.108.200.82]:54692 "EHLO
	mail-gw3.sa.ew.hu") by vger.kernel.org with ESMTP id S1755919AbWKTLLJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 06:11:09 -0500
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Quadratic behavior of shrink_dcache_parent()
Message-Id: <E1Gm731-0003Br-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 20 Nov 2006 12:10:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The shrink_dcache_parent() can take a very long time for deep
directory trees: minutes for depth of 100,000, probably hours for
depth of 1,000,000.

The reason is that after dropping a leaf, it starts again from the
root.

Filesystems affected include FUSE, NFS, CIFS.  Others I haven't
checked.  NFS and to a lesser extent CIFS don't seem to efficiently
handle lookups within such a deep hierarchy, so they're sort of
immune.

But with FUSE it's pretty easy to DoS the system.

Limiting the depth to some sane value could work around this problem,
but that would mean having to traverse subtrees in rename().

Any better ideas?

Thanks,
Miklos
