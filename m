Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbUEAJXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUEAJXh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 05:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUEAJXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 05:23:37 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:12967 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262103AbUEAJXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 05:23:34 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: <linux-kernel@VGER.KERNEL.ORG>
Subject: Large page support in the Linux Kernel?
Date: Sat, 1 May 2004 02:28:07 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcQvXpzW0YJM0eEdSOOX2w78jLSVgA==
Message-Id: <S262103AbUEAJXe/20040501092334Z+498@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering if there is going to be large page support for the linux
kernel in the near future. I am sure most people know the benefit this has
for large databases like Oracle, ultimately larger pages means the TLB slots
refer to a much larger area of memory increasing the chance of a TLB hit and
avoiding the need to walk the page tables in the MMU.

I have spotted a few previous threads where fragmentation and the complexity
in making these pages such that they can be evicted were offered as reasons
to defer this feature. I think this is a mistake. 

In Solaris, the first large page support was added to the shared memory
segment driver and called Intimate Shared Memory. ISM uses 4MB pages, and is
a segment that is locked in memory (non-pagable). Solaris hasn't done
anything to address fragmentation as far as I know until recently in Solaris
9 (ISM has been available since 2.6, maybe prior). 

I have seen many cases where a DBA shuts down an Oracle instance, but cannot
restart it because significant memory use has taken place since the instance
was shut down (filesystem backed pages read into the page cache, malloc,
free, etc..), and in these cases, there was plenty of available memory on
the system to handle the request for the ISM segment. In most Oracle
installations, the SGA is allocated with an ISM segment that stays resident
for entire duration that the Oracle instance is running. This is hardly a
case where fragmentation is going to cause an issue since normal 4k or 8k
pages are allocated easily in the presence of this segment.

To a kernel programmer, the fragmentation and paging issues may seem like a
big issue, but any DBA I know would happily make this tradeoff on their
production databases for the additional performance that large pages offers.

If fragmentation isn't a big deal, and pages can be locked in memory, are
large pages still a difficult feature to add to the linux kernel?

Lastly, I know I have mentioned Oracle and Solaris a lot. Please don't flame
me for this, I think the points I am trying to make are reasonable.

Regards,

--Buddy



