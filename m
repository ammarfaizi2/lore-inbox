Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268190AbTCFSoe>; Thu, 6 Mar 2003 13:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268198AbTCFSoe>; Thu, 6 Mar 2003 13:44:34 -0500
Received: from ip68-107-142-198.tc.ph.cox.net ([68.107.142.198]:34978 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S268190AbTCFSod>; Thu, 6 Mar 2003 13:44:33 -0500
Date: Thu, 6 Mar 2003 11:54:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Gabriel Paubert <paubert@iram.es>, randy.dunlap@verizon.net,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] move SWAP option in menu
Message-ID: <20030306185458.GD23580@ip68-0-152-218.tc.ph.cox.net>
References: <3E657EBD.59E167D6@verizon.net> <20030305181748.GA11729@iram.es> <20030305131444.1b9b0cf2.rddunlap@osdl.org> <20030306184332.GA23580@ip68-0-152-218.tc.ph.cox.net> <20030306184922.A15683@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030306184922.A15683@infradead.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 06:49:22PM +0000, Christoph Hellwig wrote:
> On Thu, Mar 06, 2003 at 11:43:32AM -0700, Tom Rini wrote:
> > How's this look?  I picked MMU=x implies SWAP=x for defaults, just
> > because that's how they were before...
> 
> CONFIG_SWAP must be n if CONFIG_MMU isn't set either, so it shouldn't
> be an option for those targets.

Erm, yes, that makes sense.  How about this (for brevity, just
init/Kconfig):

===== init/Kconfig 1.10 vs edited =====
--- 1.10/init/Kconfig	Mon Feb  3 13:19:37 2003
+++ edited/init/Kconfig	Thu Mar  6 11:54:30 2003
@@ -37,6 +37,16 @@
 
 menu "General setup"
 
+config SWAP
+	bool "Support for paging of anonymous memory"
+	depends on MMU
+	default y
+	help
+	  This option allows you to choose whether you want to have support
+	  for socalled swap devices or swap files in your kernel that are
+	  used to provide more virtual memory than the actual RAM present
+	  in your computer.  If unusre say Y.
+
 config SYSVIPC
 	bool "System V IPC"
 	---help---

-- 
Tom Rini
http://gate.crashing.org/~trini/
