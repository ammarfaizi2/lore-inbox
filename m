Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965493AbWJBWsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965493AbWJBWsn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 18:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965494AbWJBWsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 18:48:43 -0400
Received: from outbound-red.frontbridge.com ([216.148.222.49]:1750 "EHLO
	outbound2-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S965493AbWJBWsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 18:48:42 -0400
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Date: Mon, 2 Oct 2006 16:57:38 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       devel@laptop.org
Subject: [PATCH] video: Get the default mode from the right database
Message-ID: <20061002225738.GD7716@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 02 Oct 2006 22:48:27.0933 (UTC)
 FILETIME=[E03D0CD0:01C6E674]
X-WSS-ID: 693F48B60C43578102-01-01
Content-Type: multipart/mixed;
 boundary=OXfL5xGRrasGEqWY
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

fb_find_mode() is behaving in an non-intuitive way.  When I specify my
own video mode database, and no default mode, I would have expected it
to assume the first mode in my database as the default mode.  Instead, it
uses the built in database:

> if (!db) {
>     db = modedb;
>     dbsize = ARRAY_SIZE(modedb);
> }
> if (!default_mode)
>     default_mode = &modedb[DEFAULT_MODEDB_INDEX];

Personally, I think this is incorrect - if an alternate database is
specified, it should be always using that.  Patch is attached.

Regards,
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>

--OXfL5xGRrasGEqWY
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=modedb-fix.patch
Content-Transfer-Encoding: 7bit

[PATCH] video: Get the default mode from the right database

From: Jordan Crouse <jordan.crouse@amd.com>

If no default mode is specified, it should be grabbed from the supplied
database, not the default one.  

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/video/modedb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index d126790..e068f52 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -506,7 +506,7 @@ int fb_find_mode(struct fb_var_screeninf
 	dbsize = ARRAY_SIZE(modedb);
     }
     if (!default_mode)
-	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
+	default_mode = &db[DEFAULT_MODEDB_INDEX];
     if (!default_bpp)
 	default_bpp = 8;
 

--OXfL5xGRrasGEqWY--


