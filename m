Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUC3Ob1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 09:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263168AbUC3Ob0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 09:31:26 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:63644 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S263683AbUC3ObW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 09:31:22 -0500
Message-ID: <40698501.BD3E12BF@nospam.org>
Date: Tue, 30 Mar 2004 16:32:33 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Hirokazu Takahashi <taka@valinux.co.jp>
CC: haveblue@us.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, iwamoto@valinux.co.jp
Subject: Re: Migrate pages from a ccNUMA node to another - patch
References: <20040330082741.541B77054E@sv1.valinux.co.jp>
		<20040330.180523.08003015.taka@valinux.co.jp>
		<40695802.1F13AB0D@nospam.org> <20040330.210804.71938972.taka@valinux.co.jp>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takahashi wrote:

[...]
> 
> It's not hard to add "no-retry-mode" to "remap_onepage()" function
> if you want. It may skip to migrate some pages if they are accessed
> heavily. In paticular if you only want to care about anonymous pages,
> they will be handled very well.

Well, why not to give it a try ?
Yet your code is not really easy to read. :-)
I do not dare to adapt it on my own, I am afraid of breaking something.
Could you please provide me a modified version of your "remap_onepage()" ?
Can we move to 2.6.4 ?

In addition to "no-retry-mode", I need to specify where the new page
should be allocated from.

Here is my interface I need to implement with "remap_onepage()":

/*
 * Common part of checking & migrating the pages one by one.
 *
 * Arguments:	src_node:	Source NUMA node
 *		old_p:		-> old page structure
 *		node:		Destination NUMA node
 *		mm:		-> victim "mm_struct"
 *		pte:		-> PTE of the page to be moved
 *
 * Returns:	1:		Migration O. K.
 *		0:		Minor error, no actual migration has been done
 *		-Exxx:		Catastrophic error
 *
 * Notes:	- "mm->page_table_lock" and "mm->mmap_sem" have to be held.
 *		- The old page is "get_page()"-ed on entry to make sure it does not go
 *		  away in the mean time - on return it gets "put_page()"-ed.
 */
int
common_check_migrate_1_page(const int src_node, struct page * const old_p,
			const int node, struct mm_struct * const mm, pte_t * const pte)

Notes: "pte" can be NULL if I do not know it apriori
       I cannot release "mm->page_table_lock" otherwise I have to re-scan the "mm->pgd".

Thanks,

Zoltán Menyhárt
