Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTLAUMU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 15:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTLAUMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 15:12:20 -0500
Received: from fmr06.intel.com ([134.134.136.7]:11219 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262914AbTLAUMT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 15:12:19 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: Re: memory hotremove prototype, take 3
Date: Mon, 1 Dec 2003 12:12:09 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F4FAED7@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: memory hotremove prototype, take 3
Thread-Index: AcO4R2ZWOKlCuw/iTqacnjxlAutegA==
From: "Luck, Tony" <tony.luck@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Pavel Machek" <pavel@suse.cz>
X-OriginalArrivalTime: 01 Dec 2003 20:12:10.0386 (UTC) FILETIME=[66D3EF20:01C3B847]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> hotunplug seems cool... How do you deal with kernel data structures in
> memory "to be removed"? Or you simply don't allow kmalloc() to
> allocate there?

You guessed right.  Hot removeable memory can only be allocated
for uses that we can easily re-allocate.  So kmalloc() etc. have
to get memory from some area that we promise not to ever try to
remove.

> During hotunplug, you copy pages to new locaion. Would it simplify
> code if you forced them to be swapped out, instead? [Yep, it would be
> slower...]

There are some pages that will have to be copied (e.g. pages that
the user "mlock()d" should still be locked in their new location,
same for hugetlbfs pages).

-Tony Luck  

