Return-Path: <linux-kernel-owner+willy=40w.ods.org-S379020AbUKAWvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S379020AbUKAWvb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 17:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S379021AbUKAWva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:51:30 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:57100 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S282249AbUKAU7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 15:59:35 -0500
Date: Mon, 1 Nov 2004 15:59:21 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Subject: x86_64 expertise needed re: BUG() at pageattr:107
Message-ID: <20041101155921.C30292@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The x86_64 version of pageattr.c contains the following definition
of revert_page():

static void revert_page(unsigned long address, pgprot_t ref_prot)
{
       pgd_t *pgd;
       pmd_t *pmd;
       pte_t large_pte;

       pgd = pgd_offset_k(address);
       pmd = pmd_offset(pgd, address);
       BUG_ON(pmd_val(*pmd) & _PAGE_PSE);
       pgprot_val(ref_prot) |= _PAGE_PSE;
       large_pte = mk_pte_phys(__pa(address) & LARGE_PAGE_MASK, ref_prot);
       set_pte((pte_t *)pmd, large_pte);
}

Please notice the BUG_ON() (originally at line pageattr.c:107).
I notice that the x86 version of revert_page() has no similar check.

Would someone please explain:

	a) why is this a bug?;
	b) what is likely to have triggered it?; and,
	c) why is x86_64 different from x86?

I've Googled a few references to this problem (latest 10/10/2004),
but I've seen no solutions.  I do not currently have a reproducible
test case, although I have a report (which dates from around 2.6.7)
of seeing this problem when installing the e1000 driver module.

I'd be happy to see some educated guesses... :-)

Thanks for any input!

John
-- 
John W. Linville
linville@tuxdriver.com
