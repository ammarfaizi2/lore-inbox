Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbTBLBd4>; Tue, 11 Feb 2003 20:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbTBLBd4>; Tue, 11 Feb 2003 20:33:56 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:13031 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264920AbTBLBdz>; Tue, 11 Feb 2003 20:33:55 -0500
Date: Tue, 11 Feb 2003 17:35:17 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 349] New: stripped MD0 splits requests incorrectly 
Message-ID: <628570000.1045013717@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=349

           Summary: stripped MD0 splits requests incorrectly
    Kernel Version: See 2.5.4x upto 2.5.60
            Status: NEW
          Severity: blocking
             Owner: bugme-janitors@lists.osdl.org
         Submitter: ak@suse.de


Distribution: SuSE 8.1
Hardware Environment: Two disk RAID on adaptec SCSI 
Software Environment: XFS on MD0 (stripped) on two SCSI disks
Problem Description:

When trying to mount an XF  S system on such a RAID system and XFS replays
its log its hits BIO_BUG_ON(!bio->bi_io_vec) in ll_rw_block:submit_bio.

According to axboe the problem is that MD splits requests incorrectly. It
needs to ensure that when splitting requests between each resulting
subrequest is at least one page long. 0 length BIOs as generated here are
illegal.

Fixing requires extended surgery in the MD request splitting.


