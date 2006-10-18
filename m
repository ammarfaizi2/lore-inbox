Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWJRJPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWJRJPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 05:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWJRJPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 05:15:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:40838 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S932147AbWJRJPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 05:15:19 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,323,1157353200"; 
   d="scan'208"; a="146805752:sNHT157970267"
Message-ID: <4535F0A4.1090709@intel.com>
Date: Wed, 18 Oct 2006 17:15:16 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: ak@suse.de
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64 add NX mask for PTE entry
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    If function change_page_attr_addr calls revert_page to revert
to original pte value, mk_pte_phys does not mask NX bit. If NX bit
is set on no NX hardware supported x86_64 machine, there is will
be RSVD type page fault and system will crash. This patch adds NX
mask bit for PTE entry.

Signed-off-by: bibo,mao <bibo.mao@intel.com>

diff --git a/include/asm-x86_64/pgtable.h b/include/asm-x86_64/pgtable.h
index 6899e77..0555c1c 100644
--- a/include/asm-x86_64/pgtable.h
+++ b/include/asm-x86_64/pgtable.h
@@ -366,6 +366,7 @@ static inline pte_t mk_pte_phys(unsigned
  {
  	pte_t pte;
  	pte_val(pte) = physpage | pgprot_val(pgprot);
+	pte_val(pte) &= __supported_pte_mask;
  	return pte;
  }
