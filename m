Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266733AbUITPq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266733AbUITPq2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 11:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266725AbUITPq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 11:46:28 -0400
Received: from zeus.kernel.org ([204.152.189.113]:7419 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266748AbUITPpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 11:45:53 -0400
Date: Mon, 20 Sep 2004 08:44:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: akpm@osdl.org, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, wli@holomorphy.com, davem@redhat.com,
       raybry@sgi.com, ak@muc.de, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch V8: [7/7] atomic pte operations
 for s390
In-Reply-To: <200409191435.09445.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.58.0409200843570.3633@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <B6E8046E1E28D34EB815A11AC8CA312902CD3243@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409181630480.24054@schroedinger.engr.sgi.com>
 <200409191435.09445.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004, Denis Vlasenko wrote:

> On Sunday 19 September 2004 02:31, Christoph Lameter wrote:
> > +static inline int
> > +pmd_test_and_populate(struct mm_struct *mm, pmd_t *pmd, struct page *page)
> > +{
> > +	int rc;
> > +	spin_lock(&mm->page_table_lock);
> > +
> > +	rc=pte_same(*pmd, _PAGE_INVALID_EMPTY);
> > +	if (rc) pmd_populate(mm, pmd, page);
> > +	spin_unlock(&mm->page_table_lock);
> > +	return rc;
> > +}
>
> Considering that spin_lock and spin_unlock are inline functions,
> this function may end up being large.
>
> I didn't see a single non-inlined function in these patches yet.
> Please think about code size.

This function is only used once.

