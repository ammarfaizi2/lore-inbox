Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbVKOWKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbVKOWKL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVKOWKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:10:10 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:59861 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932143AbVKOWKI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:10:08 -0500
Date: Tue, 15 Nov 2005 14:10:03 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: linux-mm@kvack.org
Cc: Andy Whitcroft <apw@shadowen.org>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
Subject: pfn_to_nid under CONFIG_SPARSEMEM and CONFIG_NUMA
Message-ID: <20051115221003.GA2160@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following code/comment is in <linux/mmzone.h> if SPARSEMEM
and NUMA are configured.

/*
 * These are _only_ used during initialisation, therefore they
 * can use __initdata ...  They could have names to indicate
 * this restriction.
 */
#ifdef CONFIG_NUMA
#define pfn_to_nid              early_pfn_to_nid
#endif

However, pfn_to_nid is certainly used in check_pte_range() mm/mempolicy.c.
I wouldn't be surprised to find more non init time uses if you follow all
the call chains.

On ppc64, early_pfn_to_nid now only uses __initdata.  So, I would expect
policy code that calls check_pte_range to cause serious problems on ppc64.

Any suggestions on how this should really be structured?  I'm thinking
of removing the above definition of pfn_to_nid to force each architecture
to provide a (non init only) version.

-- 
Mike
