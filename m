Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUC2UrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 15:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUC2UrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 15:47:12 -0500
Received: from fmr03.intel.com ([143.183.121.5]:41386 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262049AbUC2UrE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 15:47:04 -0500
Message-Id: <200403292045.i2TKjnF11402@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andy Whitcroft'" <apw@shadowen.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, "Ray Bryant" <raybry@sgi.com>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Cc: <anton@samba.org>, <sds@epoch.ncsc.mil>, <ak@suse.de>,
       <lse-tech@lists.sourceforge.net>, <linux-ia64@vger.kernel.org>
Subject: RE: [PATCH] [0/6] HUGETLB memory commitment
Date: Mon, 29 Mar 2004 12:45:49 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQVkBQZE22XHoMUTr6zcz3m3jTLKAAO2bgQ
In-Reply-To: <11580712.1080567019@42.150.104.212.access.eclipse.net.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Andy Whitcroft wrote on Mon, March 29, 2004 4:30 AM
> Indeed.  The previous patches I submitted only address #1.  Attached is
> another patch which should address #2, it supplies hugetlb commit
> accounting.  This is checked and applied when the segment is created.  It
> also supplements the meminfo information to display this new commitment.
> The patch only implments strict commitment, but as has been stated here
> often, it is not clear that overcommit of unswappable memory makes any
> sense in the absence of demand allocation.  When that is implemented then
> this will likely need a policy.
>
> Patch applies on top of my previous patch and has been tested on i386.


+int hugetlbfs_report_meminfo(char *buf)
+{
+	long htlb = atomic_read(&hugetlb_committed_space);
+	return sprintf(buf, "HugeCommited_AS: %5lu\n", htlb);
+}

"HugeCommited_AS", typo?? Should that be double "t"?  Also can we print
in terms of kB instead of num pages to match all other entries? Something
Like: htlb<<(PAGE_SHIFT-10)?

overcomit is not checked for hugetlb mmap, is it intentional here?

- Ken


