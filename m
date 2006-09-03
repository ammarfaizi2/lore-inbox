Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWICWHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWICWHA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWICWHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:07:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7173 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750805AbWICWG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:06:59 -0400
Date: Mon, 4 Sep 2006 00:06:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: frv compile error in set_pte()
Message-ID: <20060903220657.GG4416@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the follosing compile error in 2.6.18-rc5-mm1 (it might not 
be specific to -mm):

<--  snip  -->

...
  CC      arch/frv/mm/dma-alloc.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/arch/frv/mm/dma-alloc.c: In function 'consistent_alloc':
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/arch/frv/mm/dma-alloc.c:66: error: impossible constraint in 'asm'
make[2]: *** [arch/frv/mm/dma-alloc.o] Error 1

<--  snip  -->

The problem is the following code in include/asm-frv/pgtable.h:

<--  snip  -->

#define set_pte(pteptr, pteval) \
do {                                                    \
        *(pteptr) = (pteval);                           \
        asm volatile("dcf %M0" :: "U"(*pteptr));        \
} while(0)

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


-- 
VGER BF report: H 1.45283e-06
