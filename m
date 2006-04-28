Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbWD1AZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbWD1AZt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWD1AZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:25:36 -0400
Received: from cantor2.suse.de ([195.135.220.15]:21206 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965068AbWD1AZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:25:11 -0400
Date: Thu, 27 Apr 2006 17:23:38 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       Ralf Baechle <ralf@linux-mips.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 23/24] MIPS: Fix tx49_blast_icache32_page_indexed.
Message-ID: <20060428002338.GX18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="MIPS-0003.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Fix the cache index value in tx49_blast_icache32_page_indexed().
This is damage by de62893bc0725f8b5f0445250577cd7a10b2d8f8 commit.
    
Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/mips/mm/c-r4k.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.16.11.orig/arch/mips/mm/c-r4k.c
+++ linux-2.6.16.11/arch/mips/mm/c-r4k.c
@@ -154,7 +154,8 @@ static inline void blast_icache32_r4600_
 
 static inline void tx49_blast_icache32_page_indexed(unsigned long page)
 {
-	unsigned long start = page;
+	unsigned long indexmask = current_cpu_data.icache.waysize - 1;
+	unsigned long start = INDEX_BASE + (page & indexmask);
 	unsigned long end = start + PAGE_SIZE;
 	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
 	unsigned long ws_end = current_cpu_data.icache.ways <<

--
