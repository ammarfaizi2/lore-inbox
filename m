Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271757AbRIGL51>; Fri, 7 Sep 2001 07:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271756AbRIGL5T>; Fri, 7 Sep 2001 07:57:19 -0400
Received: from itfhep.nlh.no ([128.39.186.139]:40452 "EHLO itfhep.nlh.no")
	by vger.kernel.org with ESMTP id <S271757AbRIGL5A>;
	Fri, 7 Sep 2001 07:57:00 -0400
From: Hans Ekkehard Plesser <hans.plesser@itf.nlh.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Message-ID: <15256.46615.267860.271814@itfhep.nlh.no>
Date: Fri, 7 Sep 2001 13:57:11 +0200 (MEST)
To: linux-kernel@vger.kernel.org
Subject: Onstream Di30 Tape Drive: Successes and Problems
CC: gadio@netvision.net.il
X-Mailer: VM 6.75 under Emacs 20.7.1
Reply-To: hans.plesser@itf.nlh.no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I would like to report about my successes and remaining problems
with Onstream Di30 tape drives.  If anyone knows how to solve the
problems I have incurred, let me know (please mail directly, I am not
subscribing to this list).   

My configuration:

* Asus CUV4X-D mainboard with 2 PentiumIII Coppermine, 866MHz
* Internal Onstream Di30 as master on second IDE (/dev/hdc)
* Kernel 2.4.9

Initial issues:

* The 2.4.4-SMP-4GB kernel shipped with SuSE 7.2 did NOT support the
  Di30 reliably.  mt -f /dev/ht0 status wouldn't work.  The kernel 
  upgrade helped.

Successes:

* It looks I can now create tar archives at least in rewinding mode
  (i.e. on /dev/ht0), and can restore that archive (I have tried only
  one per tape yet).  I backed up ca 13GB uncompressed using tar,
  restored some 5% of the files, randomly chosen, and ran diff on the
  result: no errors found!

* The --verify switch for tar does not work.

* I can write to tape in non-rewind mode (/dev/nht0), but I have only
  been able to restore the first archive stored.


Remaining issues:

* Inserting a new tape and doing
  mt -f /dev/nht0 rewind
  mt -f /dev/nht0 eod     (or eom)
  mt -f /dev/nht0 status

  makes status take a very long time, and in the end I get a status
  report like (note block number -1) 

  drive type = Generic SCSI-2 tape	
  drive status = 32768
  sense key error = 0
  residue count = 0
  file number = 0
  block number = -1
  Tape block size 32768 bytes. Density code 0x0 (default).
  Soft error count since last status=0
  General status bits on (1000000):

  and there are lots of error messages in /var/log/messages, like

  kernel: ide-tape: ht0: skipping frame 31, incorrect application signature
  kernel: ide-tape: ht0: skipping frame 31, incorrect application signature
  kernel: ide-tape: ht0: skipping frame 32, incorrect application signature
  kernel: ide-tape: ht0: skipping frame 32, incorrect application signature
  :
  :
  kernel: ide-tape: ht0: skipping frame 1031, incorrect application signature
  kernel: ide-tape: ht0: skipping frame 1031, incorrect application signature
  kernel: ide-tape: ht0: couldn't find logical block -1, aborting


* Trying to navigate around on a tape with several archives using
  status, fsf or fsr commands with mt -f /dev/nht0, I got errors like

  kernel: ide-tape: ht0: skipping frame 914, wrt_pass_cntr 1 (expected 2)(logical_blk_num 893)
  kernel: ide-tape: ht0: skipping frame 914, wrt_pass_cntr 1 (expected 2)(logical_blk_num 893)
  kernel: ide-tape: ht0: skipping frame 915, wrt_pass_cntr 1 (expected 2)(logical_blk_num 894)


* I sometimes get error messages like

  kernel: ide-tape: ht0: I/O error, pc = 2b, key =  2, asc =  4, ascq =  1


I hope this info is helpful for further development.  If you want more
information, please let me know, although I might take a few days to
get back to you.

Best regards,
Hans
---------------------------------------------------------------------
Dr. Hans Ekkehard Plesser             Tel.  :           +47 6494 8832
Physics Section / ITF                 Fax   :           +47 6494 8810
Agricultural University of Norway     e-mail: hans.plesser@itf.nlh.no
N-1432 Ås, Norway		      WWW   :    arken.nlh.no/~itfhep
---------------------------------------------------------------------
