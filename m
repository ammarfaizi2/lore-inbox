Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbVLPAzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbVLPAzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVLPAzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:55:06 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61196 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751231AbVLPAzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:55:04 -0500
Date: Fri, 16 Dec 2005 01:55:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: drivers/mtd/onenand/: unacceptable stack usage
Message-ID: <20051216005505.GW23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.15-rc, the following driver was added:


include/linux/mtd/onenand.h:
#define MAX_ONENAND_PAGESIZE        (2048 + 64)


drivers/mtd/onenand/onenand_base.c:
static int onenand_writev_ecc(struct mtd_info *mtd, const struct kvec *vecs,
        unsigned long count, loff_t to, size_t *retlen,
        u_char *eccbuf, struct nand_oobinfo *oobsel)
{
        struct onenand_chip *this = mtd->priv;
        unsigned char buffer[MAX_ONENAND_PAGESIZE], *pbuf;


drivers/mtd/onenand/onenand_bbt.c:
static inline int onenand_memory_bbt (struct mtd_info *mtd, struct nand_bbt_descr *bd)
{
        unsigned char data_buf[MAX_ONENAND_PAGESIZE];


These are variables on the stack that are > 2kB which is not acceptable 
since the complete stack might be only 4kB.


Please either fix this before 2.6.15 or mark the MTD_ONENAND driver as 
BROKEN until it's fixed.


TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

