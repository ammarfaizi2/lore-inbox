Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVFOBO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVFOBO0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 21:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVFOBOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 21:14:19 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:14316 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261462AbVFOBOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 21:14:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17071.32978.176262.634056@wombat.chubb.wattle.id.au>
Date: Wed, 15 Jun 2005 11:13:54 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andreas Hirstius <Andreas.Hirstius@cern.ch>
Subject: Re: Tuning ext3 for large disk arrays
In-Reply-To: <1118794936.4301.363.camel@dyn9047017072.beaverton.ibm.com>
References: <17071.25351.996975.416810@wombat.chubb.wattle.id.au>
	<1118794936.4301.363.camel@dyn9047017072.beaverton.ibm.com>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Badari" == Badari Pulavarty <pbadari@us.ibm.com> writes:

Badari> What kernel are you running ?  Does the kernel has ext3
Badari> "reservation" support enabled ? 
2.6.11, and yes, although it's not set in the mount options.


Badari> Do you see performance problem
Badari> with "read" tests also ? 

Yes.

Badari> And also, does the write test writes
Badari> to multiple files in the same directory ? Or multiple threads
Badari> writing to same file ?

It's standard iozone --- mutliple processes writing to multiple files in
the same directory.

All the mount options are the defaults.

A sample test is:

mdadm -Ss
mdadm -C /dev/md0 -l 0 -c 1024 -n 2 -R  /dev/sdc /dev/sdk 
mke2fs -j  /dev/md0 
mount /dev/md0 /shift/oplapro97/data01
cd /shift/oplapro97/data01
iozone -MCew -t1 -f IOZONE -s32g -r256k -i0 -i1 > ~/tests/unsw_ext3/iozone_2_disk_1stream_ext3
rm -rf /shift/oplapro97/data01/*
iozone -MCew -t2 -f IOZONE -s32g -r256k -i0 -i1 > ~/tests/unsw_ext3/iozone_2_disk_2stream_ext3


-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
