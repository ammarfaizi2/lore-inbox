Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbULNMXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbULNMXV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 07:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbULNMXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 07:23:21 -0500
Received: from yacht.ocn.ne.jp ([222.146.40.168]:32505 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S261489AbULNMXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 07:23:16 -0500
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: Anticipatory prefaulting in the page fault handler V1
Date: Tue, 14 Dec 2004 21:24:11 +0900
User-Agent: KMail/1.5.4
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, nickpiggin@yahoo.com.au,
       Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org, hugh@veritas.com,
       benh@kernel.crashing.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain> <200412132330.23893.amgta@yacht.ocn.ne.jp> <Pine.LNX.4.58.0412130905140.360@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0412130905140.360@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412142124.11685.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 December 2004 02:10, Christoph Lameter wrote:
> On Mon, 13 Dec 2004, Akinobu Mita wrote:

> > 3) don't set_pte() for the entry which already have been set
>
> Not sure how this could have happened in the patch.

This is why I inserted pte_none() for each page_table in case of
read fault too.

If read access fault occured for the address "addr".
It is completely unnecessary to check by pte_none() to the page_table
for "addr". Because page_table_lock has never been released until
do_anonymous_page returns (in case of read access fault)

But there is not any guarantee that the page_tables for addr+PAGE_SIZE,
addr+2*PAGE_SIZE, ...  have not been mapped yet.

Anyway, I will try your V2 patch.



