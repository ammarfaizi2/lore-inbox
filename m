Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbUDHV7g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 17:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbUDHV7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 17:59:36 -0400
Received: from fmr06.intel.com ([134.134.136.7]:6086 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262730AbUDHV7e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 17:59:34 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: HUGETLB commit handling.
Date: Thu, 8 Apr 2004 14:58:40 -0700
Message-ID: <01EF044AAEE12F4BAAD955CB75064943014B92FA@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HUGETLB commit handling.
Thread-Index: AcQdkJmYwmNjBCE1RyiI8vJes+zUXwAI5UBg
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "Andy Whitcroft" <apw@shadowen.org>, "Andrew Morton" <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Ray Bryant" <raybry@sgi.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>,
       <anton@samba.org>, <sds@epoch.ncsc.mil>, <ak@suse.de>,
       <lse-tech@lists.sourceforge.net>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 08 Apr 2004 21:58:41.0272 (UTC) FILETIME=[A7617F80:01C41DB4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <> wrote on Thursday, April 08, 2004 9:36 AM:

> We have been looking at the HUGETLB page commit issue (offlist) and
> are close a final merged patch.  However, our testing seems to have
> thrown up an inconsistency in interface which we are not sure whether
> to fix or not.   
> 
> With normal shm segments we commit the pages we will need at shmget()
> time. 
> The real pages being allocated on demand.  With hugetlb pages we
> currently do not manage commit, but allocate them on map, shmat() in
> this case.  When we add commit handling it would seem most
> appropriate to commit the pages in shmget() as for small page
> mappings.  However, this might seem to change the semantics slightly,
> in that if there is insufficient hugepages available then the failure
> would come at shmget() and not shmat() time.      
> 
> I would contend this is the right thing to do, as it makes the
> semantics of hugepages match that of the existing small pages.  We
> are looking for a consensus as this might be construed as a semantic
> change.   
> 

IMO, doing this accounting check at shmget time seems reasonable as it
aligns the accouting semantics of normal and hugepages.


> Thoughts.
> 
> -apw
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html  

