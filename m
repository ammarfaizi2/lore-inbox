Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135443AbRECXyb>; Thu, 3 May 2001 19:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135494AbRECXyV>; Thu, 3 May 2001 19:54:21 -0400
Received: from gateway.sequent.com ([192.148.1.10]:18490 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S135443AbRECXyF>; Thu, 3 May 2001 19:54:05 -0400
From: James Washer <washer@sequent.com>
Message-Id: <200105032354.QAA18993@crg8.sequent.com>
Subject: scan_scsis limits LUNs to max_scsi_luns... is this what we want?
To: linux-kernel@vger.kernel.org
Date: Thu, 3 May 2001 16:54:01 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the routine  scan_scsis(),  The following code would appear to limit 
the number of luns a given apapter can use to max_scsi_luns, as opposed 
to the limit the low-level driver passed in the Scsi_Host structure.

Is that the behaviour we want? or should the '<' become a '>' in the ternary, 
thereby scanning the greater of the passed max_lun or the system max_scsi_luns.

It seems to me that if a low level driver passes a large number of luns, 
the midlayer should accept that value.

Of course, the use of the CONFIG_SCSI_MULTI_LUN #define would lead me to 
believe that the kernel does indeed want to limit the number of luns probed 
to the lesser of the two values... but why?? 





	max_dev_lun = (max_scsi_luns < shpnt->max_lun ?
		max_scsi_luns : shpnt->max_lun);
	sparse_lun = 0;
	for (lun = 0; lun < max_dev_lun; ++lun) {
		if (!scan_scsis_single(channel, order_dev, lun, &max_dev_lun,
			&sparse_lun, &SDpnt, shpnt,
			scsi_result)
			&& !sparse_lun) break;

	}
	-- 
	+==============================================================+
	| James W Washer    IBM NUMA-Q Service   KG7HH(US) M0BOR(UK)   |
	|                                                              |
	| 15450 SW Koll Pkwy                                           |
	| MS RHE2-501                                                  |
	| Beaverton, OR 97006                                          |
	|                                                              |
	| 1-800-854-9969   1-503-578-3171(direct line)                 |
	| washer@us.ibm.com                                            |
	+==============================================================+
