Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSFBXd7>; Sun, 2 Jun 2002 19:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317234AbSFBXd6>; Sun, 2 Jun 2002 19:33:58 -0400
Received: from holomorphy.com ([66.224.33.161]:49314 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317232AbSFBXd6>;
	Sun, 2 Jun 2002 19:33:58 -0400
Date: Sun, 2 Jun 2002 16:33:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: make memclass() an inline functino
Message-ID: <20020602233336.GC14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

memclass is too large to be a #define; it overflows 80 columns and does
not make use of facilities available only to macros.

This patch convert memclass() to be an inline function.


Cheers,
Bill


===== include/linux/mmzone.h 1.10 vs edited =====
--- 1.10/include/linux/mmzone.h	Sat May 25 16:25:47 2002
+++ edited/include/linux/mmzone.h	Sun Jun  2 16:32:35 2002
@@ -142,8 +142,14 @@
 extern int numnodes;
 extern pg_data_t *pgdat_list;
 
-#define memclass(pgzone, classzone)	(((pgzone)->zone_pgdat == (classzone)->zone_pgdat) \
-			&& ((pgzone) <= (classzone)))
+static inline int memclass(zone_t *pgzone, zone_t *classzone)
+{
+	if (pgzone->zone_pgdat != classzone->zone_pgdat)
+		return 0;
+	if (pgzone > classzone)
+		return 0;
+	return 1;
+}
 
 /*
  * The following two are not meant for general usage. They are here as
