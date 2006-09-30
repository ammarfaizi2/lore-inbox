Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWI3F0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWI3F0L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 01:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWI3F0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 01:26:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:27021 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1750925AbWI3F0J convert rfc822-to-8bit
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 01:26:09 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,239,1157353200"; 
   d="scan'208"; a="139680604:sNHT19004237"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Postal 56% waits for flock_lock_file_wait
Date: Sat, 30 Sep 2006 09:25:53 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC3AD921@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Postal 56% waits for flock_lock_file_wait
Thread-Index: AcbkUOY9O9GDFATzR1+0EiAFS+qL0w==
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Sep 2006 05:26:09.0340 (UTC) FILETIME=[EF818FC0:01C6E450]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A benchmark
             'postal -p 16 localhost list_of_1000_users'
56% of run time waits for flock_lock_file_wait;
Vmstat reports that 66% cpu is idle and  vmstat bi+bo=3600 (far from
max).
Postfix server with FD_SETSIZE=2048 was used.
Similar results got for sendmail. 
Wchan is counted by
            while :; do
                        ps -o user,wchan=WIDE-WCHAN-COLUMN,comm;
sleep 1;
           done | awk '/ postfix /{a[$2]++}END{for (i in a) print
a[i]"\t"i}'
If ext2 fs is used the Postal throughput is twice more and bi+bo by 50%
less while  flock_lock_file_wait 60% still.

Is flock_lock_file_wait considered as a performance limiting waiting for
similar applications in smp?

Leonid
