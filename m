Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287173AbRL2KYD>; Sat, 29 Dec 2001 05:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287174AbRL2KXx>; Sat, 29 Dec 2001 05:23:53 -0500
Received: from [202.54.26.202] ([202.54.26.202]:28576 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S287173AbRL2KXs>;
	Sat, 29 Dec 2001 05:23:48 -0500
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256B31.0038FC61.00@sandesh.hss.hns.com>
Date: Sat, 29 Dec 2001 15:47:48 +0530
Subject: Mapped pages handling in shrink_cache()
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi, In the following code from shrink_cache()

          if (PageDirty(page) && is_page_cache_freeable(page) && page->mapping)
{
               .
               .
               .

               int (*writepage)(struct page *);

               writepage = page->mapping->a_ops->writepage;
               if ((gfp_mask & __GFP_FS) && writepage) {
                    ClearPageDirty(page);
                    SetPageLaunder(page);
                    page_cache_get(page);
                    spin_unlock(&pagemap_lru_lock);

                    writepage(page);
                    page_cache_release(page);

                    spin_lock(&pagemap_lru_lock);
                    continue;      <<<<<<< shouldn't the page be unlocked before
 continuing with the next page <<<<<
               }

I am reading 2.4.16

-- Amol


