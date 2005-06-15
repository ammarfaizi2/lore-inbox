Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVFOBWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVFOBWw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 21:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVFOBWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 21:22:52 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:55243 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261470AbVFOBWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 21:22:44 -0400
Subject: Re: Tuning ext3 for large disk arrays
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andreas Hirstius <Andreas.Hirstius@cern.ch>
In-Reply-To: <17071.32978.176262.634056@wombat.chubb.wattle.id.au>
References: <17071.25351.996975.416810@wombat.chubb.wattle.id.au>
	 <1118794936.4301.363.camel@dyn9047017072.beaverton.ibm.com>
	 <17071.32978.176262.634056@wombat.chubb.wattle.id.au>
Content-Type: text/plain
Organization: 
Message-Id: <1118797160.4301.374.camel@dyn9047017072.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jun 2005 17:59:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-14 at 18:13, Peter Chubb wrote:
> >>>>> "Badari" == Badari Pulavarty <pbadari@us.ibm.com> writes:
> 
> Badari> What kernel are you running ?  Does the kernel has ext3
> Badari> "reservation" support enabled ? 
> 2.6.11, and yes, although it's not set in the mount options.

2.6.11 has "reservation" turned ON by default. You should be
fine.

> 
> 
> Badari> Do you see performance problem
> Badari> with "read" tests also ? 
> 
> Yes.

Hmm. 

> 
> Badari> And also, does the write test writes
> Badari> to multiple files in the same directory ? Or multiple threads
> Badari> writing to same file ?
> 
> It's standard iozone --- mutliple processes writing to multiple files in
> the same directory.

If you are running multiple files in the same directory, without
reservations files will be badly fragmented. 

Can you run "filefrag" on the files ?

(I am also assuming each process writes to its own file).


Thanks,
Badari

> 
> All the mount options are the defaults.
> 
> A sample test is:
> 
> mdadm -Ss
> mdadm -C /dev/md0 -l 0 -c 1024 -n 2 -R  /dev/sdc /dev/sdk 
> mke2fs -j  /dev/md0 
> mount /dev/md0 /shift/oplapro97/data01
> cd /shift/oplapro97/data01
> iozone -MCew -t1 -f IOZONE -s32g -r256k -i0 -i1 > ~/tests/unsw_ext3/iozone_2_disk_1stream_ext3
> rm -rf /shift/oplapro97/data01/*
> iozone -MCew -t2 -f IOZONE -s32g -r256k -i0 -i1 > ~/tests/unsw_ext3/iozone_2_disk_2stream_ext3
> 

