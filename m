Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965199AbVKPDPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbVKPDPG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965200AbVKPDPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:15:05 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:56488 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965199AbVKPDPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:15:03 -0500
Date: Wed, 16 Nov 2005 12:14:18 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: pfn_to_nid under CONFIG_SPARSEMEM and CONFIG_NUMA
Cc: linux-mm@kvack.org, Andy Whitcroft <apw@shadowen.org>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051115221003.GA2160@w-mikek2.ibm.com>
References: <20051115221003.GA2160@w-mikek2.ibm.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.051
Message-Id: <20051116115548.EE18.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2005 14:10:03 -0800
Mike Kravetz <kravetz@us.ibm.com> wrote:

> The following code/comment is in <linux/mmzone.h> if SPARSEMEM
> and NUMA are configured.
> 
> /*
>  * These are _only_ used during initialisation, therefore they
>  * can use __initdata ...  They could have names to indicate
>  * this restriction.
>  */
> #ifdef CONFIG_NUMA
> #define pfn_to_nid              early_pfn_to_nid
> #endif
> 
> However, pfn_to_nid is certainly used in check_pte_range() mm/mempolicy.c.
> I wouldn't be surprised to find more non init time uses if you follow all
> the call chains.
> 
> On ppc64, early_pfn_to_nid now only uses __initdata.  So, I would expect
> policy code that calls check_pte_range to cause serious problems on ppc64.
> 
> Any suggestions on how this should really be structured?  I'm thinking
> of removing the above definition of pfn_to_nid to force each architecture
> to provide a (non init only) version.

Yes! I worried about same things.
How is this?

static inline int pfn_to_nid(unsigned long pfn)
{
	return page_to_nid(pfn_to_page(pfn));
}

page_to_nid() and pfn_to_page() is well defined.
Probably, this will work on all architecture.
So, just we should check this should be used after that memmap
is initialized.


Bye.

-- 
Yasunori Goto 


