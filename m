Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287498AbSAEEGd>; Fri, 4 Jan 2002 23:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287499AbSAEEGW>; Fri, 4 Jan 2002 23:06:22 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:46546 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287498AbSAEEGI>;
	Fri, 4 Jan 2002 23:06:08 -0500
Date: Fri, 4 Jan 2002 23:06:06 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [FIX] missing piece from fs/super.c in -pre8
Message-ID: <Pine.GSO.4.21.0201042302410.27334-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	/me scratches head wondering how the ^*#! did it manage to disappear
from the version of patch sent to Linus...

--- S2-pre8/fs/super.c	Fri Jan  4 22:59:27 2002
+++ linux/fs/super.c	Fri Jan  4 23:02:06 2002
@@ -718,6 +718,10 @@
 	s->s_bdev = bdev;
 	s->s_flags = flags;
 	insert_super(s, fs_type);
+	error = -ENOMEM;
+	s->s_id = kmalloc(32, GFP_KERNEL);
+	if (!s->s_id)
+		goto failed;
 	strncpy(s->s_id, bdevname(dev), sizeof(s->s_id));
 	error = -EINVAL;
 	if (!fs_type->read_super(s, data, flags & MS_VERBOSE ? 1 : 0))

