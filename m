Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbTABGWg>; Thu, 2 Jan 2003 01:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265880AbTABGWg>; Thu, 2 Jan 2003 01:22:36 -0500
Received: from main.gmane.org ([80.91.224.249]:37012 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S265939AbTABGWf>;
	Thu, 2 Jan 2003 01:22:35 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Andres Salomon" <dilinger@voxel.net>
Subject: [PATCH] 2.5.54 atyfb_base.c compile fix
Date: Thu, 02 Jan 2003 01:30:58 -0500
Message-ID: <pan.2003.01.02.06.30.55.638527@voxel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.13.3 (That cat's something I can't explain)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

atyfb doesn't compile for me; this fixes it.  Someone was referencing the
wrong variable (or fb_cursor and aty_cursor used to be similar, and
fb_cursor changed).


--- a/drivers/video/aty/atyfb_base.c.orig       2003-01-02 00:22:48.000000000 -0500
+++ b/drivers/video/aty/atyfb_base.c    2003-01-02 01:24:15.000000000 -0500
@@ -2605,12 +2605,12 @@
        if (info->screen_base)
                iounmap((void *) info->screen_base);
 #ifdef __BIG_ENDIAN
-       if (info->cursor && info->cursor->ram)
-               iounmap(info->cursor->ram);
+       if (par->cursor && par->cursor->ram)
+               iounmap(par->cursor->ram);
 #endif
 #endif
-       if (info->cursor)
-               kfree(info->cursor);
+       if (par->cursor)
+               kfree(par->cursor);
 #ifdef __sparc__
        if (par->mmap_map)
                kfree(par->mmap_map);



