Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWCVSZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWCVSZq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 13:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWCVSZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 13:25:46 -0500
Received: from palrel12.hp.com ([156.153.255.237]:59602 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1751044AbWCVSZp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 13:25:45 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC PATCH 31/35] Add Xen grant table support
Date: Wed, 22 Mar 2006 10:25:42 -0800
Message-ID: <516F50407E01324991DD6D07B0531AD5A64C58@cacexc12.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH 31/35] Add Xen grant table support
Thread-Index: AcZNjeOyN+awk9XAS5mvABbfh6SptAAT3Sfw
From: "Magenheimer, Dan (HP Labs Fort Collins)" <dan.magenheimer@hp.com>
To: "Arjan van de Ven" <arjan@infradead.org>,
       "Chris Wright" <chrisw@sous-sol.org>
Cc: <virtualization@lists.osdl.org>, <xen-devel@lists.xensource.com>,
       <linux-kernel@vger.kernel.org>, "Ian Pratt" <ian.pratt@xensource.com>
X-OriginalArrivalTime: 22 Mar 2006 18:25:41.0055 (UTC) FILETIME=[064EE4F0:01C64DDE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +#ifndef __ia64__
> > +static int map_pte_fn(pte_t *pte, struct page *pte_page,
> > +		      unsigned long addr, void *data)
> > +{
> > +	unsigned long **frames = (unsigned long **)data;
> > +
> > +	set_pte_at(&init_mm, addr, pte, pfn_pte((*frames)[0], 
> PAGE_KERNEL));
> > +	(*frames)++;
> > +	return 0;
> > +}
> 
> looks to me the wrong ifdef for a file in arch/i386... please fix

FYI, the grant table support is also used by non-x86 Xen architectures
(currently ia64 and soon ppc) so grant table files (along with event
channel files and some others) will eventually need to move out
of mach-xen.  The files are currently in drivers/xen/core in the Xen
tree, which is not really a good place either.  Suggestions?

Dan

