Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUDHQc5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 12:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUDHQcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 12:32:53 -0400
Received: from hellhawk.shadowen.org ([212.13.208.175]:63757 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S262008AbUDHQcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 12:32:48 -0400
Date: Thu, 08 Apr 2004 17:35:30 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: Andrew Morton <akpm@osdl.org>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Ray Bryant'" <raybry@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org, anton@samba.org, sds@epoch.ncsc.mil,
       ak@suse.de, lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: HUGETLB commit handling.
Message-ID: <15037082.1081445730@42.150.104.212.access.eclipse.net.uk>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have been looking at the HUGETLB page commit issue (offlist) and are
close a final merged patch.  However, our testing seems to have thrown up
an inconsistency in interface which we are not sure whether to fix or not.

With normal shm segments we commit the pages we will need at shmget() time.
The real pages being allocated on demand.  With hugetlb pages we currently
do not manage commit, but allocate them on map, shmat() in this case.  When
we add commit handling it would seem most appropriate to commit the pages
in shmget() as for small page mappings.  However, this might seem to change
the semantics slightly, in that if there is insufficient hugepages
available then the failure would come at shmget() and not shmat() time.

I would contend this is the right thing to do, as it makes the semantics of
hugepages match that of the existing small pages.  We are looking for a
consensus as this might be construed as a semantic change.

Thoughts.

-apw


