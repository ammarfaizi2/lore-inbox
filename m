Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290809AbSBFVEM>; Wed, 6 Feb 2002 16:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290808AbSBFVEC>; Wed, 6 Feb 2002 16:04:02 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:26304 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290810AbSBFVD7>; Wed, 6 Feb 2002 16:03:59 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200202062103.g16L3ng07109@eng2.beaverton.ibm.com>
Subject: kernel BUG at ll_rw_blk.c:1336 using RAW IO
To: linux-kernel@vger.kernel.org
Date: Wed, 6 Feb 2002 13:03:48 -0800 (PST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I and ran into following BUG() while doing RAW IO (2.5.3-pre6).

	 kernel BUG at ll_rw_blk.c:1336

Actual code is:

	BUG_ON(bio_sectors(bio) > q->max_sectors);

I am doing 64k IOs on QLOGIC SCSI controller/disks.
So
	bio_sectors(bio) is 128
	q->max_sectors is 64

Is this a QLOGIC driver bug ? I changed qlogicisp.c and set
host->max_sectors to 128. Now RAW IO seem to work fine. But
I get system hangs and filesystem gets corrupted. Any idea
on how to fix it ?

Thanks,
Badari
