Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267450AbUG2POh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267450AbUG2POh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268053AbUG2PNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:13:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:21755 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267450AbUG2OgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:36:12 -0400
Date: Thu, 29 Jul 2004 16:36:06 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org, jffs-dev@axis.com
Subject: Re: 2.6.8-rc2-mm1
Message-ID: <20040729143606.GB2349@fs.tum.de>
References: <20040728020444.4dca7e23.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728020444.4dca7e23.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following issue comes from Linus' tree:

JFFS2_COMPRESSION_OPTIONS is asked even if JFFS2_FS support isn't 
selected.

The patch below adds a dependency on JFFS2_FS to 
JFFS2_COMPRESSION_OPTIONS.

I've also added a dependency on EXPERIMENTAL which seemed to be logical 
after reading the description of this option (but even if you disagree 
with this, please add the dependency on JFFS2_FS).


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-pre2-mm1/fs/Kconfig.old	2004-07-29 16:24:35.000000000 +0200
+++ linux-2.6.8-pre2-mm1/fs/Kconfig	2004-07-29 16:24:55.000000000 +0200
@@ -1088,18 +1088,19 @@
 	  including a link to the mailing list where details of the remaining
 	  work to be completed for NAND flash support can be found, see the 
 	  JFFS2 web site at <http://sources.redhat.com/jffs2>.
 
 	  Say 'N' unless you have NAND flash and you are willing to test and
 	  develop JFFS2 support for it.
 
 config JFFS2_COMPRESSION_OPTIONS
 	bool "Advanced compression options for JFFS2"
+	depends on JFFS2_FS && EXPERIMENTAL
 	default n
 	help
 	  Enabling this option allows you to explicitly choose which
 	  compression modules, if any, are enabled in JFFS2. Removing
 	  compressors and mean you cannot read existing file systems,
 	  and enabling experimental compressors can mean that you
 	  write a file system which cannot be read by a standard kernel.
 
 	  If unsure, you should _definitely_ say 'N'.
