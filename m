Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbULWTu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbULWTu0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 14:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbULWTuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 14:50:15 -0500
Received: from canuck.infradead.org ([205.233.218.70]:7175 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261293AbULWTt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 14:49:29 -0500
Subject: Re: Prezeroing V2 [0/3]: Why and When it works
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, linux-ia64@vger.kernel.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
	 <41C20E3E.3070209@yahoo.com.au>
	 <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Thu, 23 Dec 2004 20:49:13 +0100
Message-Id: <1103831353.4139.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The most expensive operation in the page fault handler is (apart of SMP
> locking overhead) the zeroing of the page. This zeroing means that all
> cachelines of the faulted page (on Altix that means all 128 cachelines of
> 128 byte each) must be loaded and later written back. This patch allows to
> avoid having to load all cachelines if only a part of the cachelines of
> that page is needed immediately after the fault.

eh why will all cachelines be loaded? Surely you can avoid the write-
allocate behavior for this case.....


