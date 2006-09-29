Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWI2PgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWI2PgS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 11:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWI2PgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 11:36:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:35340 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751065AbWI2PgR convert rfc822-to-8bit
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 11:36:17 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,238,1157353200"; 
   d="scan'208"; a="404005:sNHT18947142"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Postal 56% waits for flock_lock_file_wait
Date: Fri, 29 Sep 2006 19:36:05 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC3AD8EB@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Postal 56% waits for flock_lock_file_wait
Thread-Index: Acbj3PpKN3F1zXYXSsCe55HorqKUNQ==
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Sep 2006 15:36:16.0448 (UTC) FILETIME=[00A13400:01C6E3DD]
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
