Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbULNU1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbULNU1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 15:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbULNU1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 15:27:53 -0500
Received: from zeus.kernel.org ([204.152.189.113]:1408 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261651AbULNU1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 15:27:44 -0500
Date: Tue, 14 Dec 2004 12:25:11 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Akinobu Mita <amgta@yacht.ocn.ne.jp>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, nickpiggin@yahoo.com.au,
       Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org, hugh@veritas.com,
       benh@kernel.crashing.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Anticipatory prefaulting in the page fault handler V1
In-Reply-To: <200412142124.11685.amgta@yacht.ocn.ne.jp>
Message-ID: <Pine.LNX.4.58.0412141224520.3044@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <200412132330.23893.amgta@yacht.ocn.ne.jp> <Pine.LNX.4.58.0412130905140.360@schroedinger.engr.sgi.com>
 <200412142124.11685.amgta@yacht.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004, Akinobu Mita wrote:

> This is why I inserted pte_none() for each page_table in case of
> read fault too.
>
> If read access fault occured for the address "addr".
> It is completely unnecessary to check by pte_none() to the page_table
> for "addr". Because page_table_lock has never been released until
> do_anonymous_page returns (in case of read access fault)
>
> But there is not any guarantee that the page_tables for addr+PAGE_SIZE,
> addr+2*PAGE_SIZE, ...  have not been mapped yet.

Right. Thanks for pointing that out.

