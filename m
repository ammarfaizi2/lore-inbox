Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262172AbSIZIi7>; Thu, 26 Sep 2002 04:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262188AbSIZIi7>; Thu, 26 Sep 2002 04:38:59 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:48805 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S262172AbSIZIi6>; Thu, 26 Sep 2002 04:38:58 -0400
Date: Thu, 26 Sep 2002 10:43:49 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] 2.5.38+bk: modversions.h generation
Message-ID: <20020926084349.GA941@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The .ver to #include part can be simplified a bit,
if we can assume everyone uses GNU find.


--- linus.linux-2.5/Makefile	2002-09-23 20:01:26.000000000 +0200
+++ v2.5.38+bk/Makefile	2002-09-26 10:34:10.000000000 +0200
@@ -437,9 +437,7 @@
 	   echo "#define _LINUX_MODVERSIONS_H"; \
 	   echo "#include <linux/modsetver.h>"; \
 	   cd .tmp_export-objs >/dev/null; \
-	   for f in `find modules -name \*.ver -print | sort`; do \
-	     echo "#include <linux/$${f}>"; \
-	   done; \
+	   find modules -name \*.ver -printf "#include <linux/%p>\\n" | sort; \
 	   echo "#endif"; \
 	) > $@.tmp; \
 	$(update-if-changed)

