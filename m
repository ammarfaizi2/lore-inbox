Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUC3UFf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 15:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUC3UFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 15:05:35 -0500
Received: from fmr04.intel.com ([143.183.121.6]:35006 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261221AbUC3UFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 15:05:20 -0500
Message-Id: <200403302004.i2UK4JF23059@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andy Whitcroft'" <apw@shadowen.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, "Ray Bryant" <raybry@sgi.com>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Cc: <anton@samba.org>, <sds@epoch.ncsc.mil>, <ak@suse.de>,
       <lse-tech@lists.sourceforge.net>, <linux-ia64@vger.kernel.org>
Subject: RE: [PATCH] [0/6] HUGETLB memory commitment
Date: Tue, 30 Mar 2004 12:04:18 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQWViZdcApwN7MSSjqhELA2fpbnVgANOuDA
In-Reply-To: <20541286.1080655059@42.150.104.212.access.eclipse.net.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andy Whitcroft wrote on Tuesday, March 30, 2004 4:58 AM
> >
> > Just to follow up myself, I meant overcommit accounting is not done
> > for mmap hugetlb page.  (typical Monday morning symptom :))
>
> Essentially, hugetlb pages can only be part of a shared mapping in
> the current implementation.  As a result all commitments are made
> and checked at segment create time.  The commitment cannot change.
>
> Hope that's what you meant.

Not quite, I can simply mmap on a hugetlbfs backed file to get hugetlb
pages.  File expansion is transparent.  It gets even trickier with file
that has holes in it.

I can do:
	fd = open("/mnt/htlb/myhtlbfile", O_CREAT|O_RDWR, 0755);
	mmap(..., fd, offset);

Accounting didn't happen in this case, (grep Huge /proc/meminfo):

HugePages_Total:    10
HugePages_Free:      9
Hugepagesize:    262144 kB
HugeCommitted_AS:     0 kB

Now if I remove the file "myhtlbfile", accounting is done for inode
removal and hugetlb_committed_space underflows.

HugePages_Total:    10
HugePages_Free:     10
Hugepagesize:    262144 kB
HugeCommitted_AS: 18446744073709289472 kB


