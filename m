Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUCaIwo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 03:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbUCaIwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 03:52:44 -0500
Received: from fmr04.intel.com ([143.183.121.6]:27534 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261852AbUCaIwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 03:52:41 -0500
Message-Id: <200403310851.i2V8pkF28306@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andy Whitcroft'" <apw@shadowen.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, "Ray Bryant" <raybry@sgi.com>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Cc: <anton@samba.org>, <sds@epoch.ncsc.mil>, <ak@suse.de>,
       <lse-tech@lists.sourceforge.net>, <linux-ia64@vger.kernel.org>
Subject: RE: [PATCH] [0/6] HUGETLB memory commitment
Date: Wed, 31 Mar 2004 00:51:45 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQWwl76iu0VJkTJQ6CkU4koWvSWEwAMZN5g
In-Reply-To: <27832908.1080701317@[192.168.0.89]>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Andy Whitcroft wrote on Tuesday, March 30, 2004 5:49 PM
>>> 	fd = open("/mnt/htlb/myhtlbfile", O_CREAT|O_RDWR, 0755);
>>> 	mmap(..., fd, offset);
>>>
>>> Accounting didn't happen in this case, (grep Huge /proc/meminfo):
>
> O.k.  Try this one.  Should fix that case.  There is some uglyness in
> there which needs review, but my testing says this works.

Under common case, worked perfectly!  But there are always corner cases.

I can think of two ugliness:
1. very sparse hugetlb file.  I can mmap one hugetlb page, at offset
   512 GB.  This would account 512GB + 1 hugetlb page as committed_AS.
   But I only asked for one page mapping.  One can say it's a feature,
   but I think it's a bug.

2. There is no error checking (to undo the committed_AS accounting) after
   hugetlb_prefault(). hugetlb_prefault doesn't always succeed in allocat-
   ing all the pages user asked for due to disk quota limit.  It can have
   partial allocation which would put the committed_AS in a wedged state.

- Ken


