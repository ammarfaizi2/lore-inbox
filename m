Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267353AbSLRVna>; Wed, 18 Dec 2002 16:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267354AbSLRVna>; Wed, 18 Dec 2002 16:43:30 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8196 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267353AbSLRVn3>;
	Wed, 18 Dec 2002 16:43:29 -0500
Date: Wed, 18 Dec 2002 22:50:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.5.52 a/arch/i386/mm/init.c 
Message-ID: <20021218215015.GA19885@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In 2.5.52:

Looks suspect to me... Is it okay to do one_md_table_init, then just
discard the result? Why this change?
							Pavel

--- a/arch/i386/mm/init.c       Sun Dec 15 18:08:30 2002
+++ b/arch/i386/mm/init.c       Sun Dec 15 18:08:30 2002
@@ -134,8 +134,10 @@
        pgd = pgd_base + pgd_ofs;
        pfn = 0;

-       for (; pgd_ofs < PTRS_PER_PGD && pfn < max_low_pfn; pgd++,
pgd_ofs++) {
+       for (; pgd_ofs < PTRS_PER_PGD; pgd++, pgd_ofs++) {
                pmd = one_md_table_init(pgd);
+               if (pfn >= max_low_pfn)
+                       continue;
                for (pmd_ofs = 0; pmd_ofs < PTRS_PER_PMD && pfn <
max_low_pfn; pmd++, pmd_ofs++) {
                        /* Map with big pages if possible, otherwise
create normal page tables. */
                        if (cpu_has_pse) {

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
