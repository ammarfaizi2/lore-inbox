Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbTEAWQN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 18:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbTEAWQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 18:16:13 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:5608 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S262713AbTEAWQF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 18:16:05 -0400
Date: Thu, 01 May 2003 16:28:12 -0600
From: "Justin T. Gibbs" <gibbs@btc.adaptec.com>
To: linux-scsi@vger.kernel.org
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Aic7xxx and Aic79xx Driver Updates
Message-ID: <1866260000.1051828092@aslan.btc.adaptec.com>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I've just uploaded version 1.3.8 of the aic79xx driver and version 
6.2.33 of the aic7xxx driver.  Both are available for 2.4.X and
2.5.X kernels in either bk send format or as a tarball from here:

http://people.FreeBSD.org/~gibbs/linux/SRC/

RPMs and DUDs for various distributions are also available:

http://people.FreeBSD.org/~gibbs/linux/DUD/aic7xxx/
http://people.FreeBSD.org/~gibbs/linux/DUD/aic79xx/
http://people.FreeBSD.org/~gibbs/linux/RPM/aic7xxx/
http://people.FreeBSD.org/~gibbs/linux/RPM/aic79xx/

BK changes relative to top of the 2.5.X tree are listed below.

--
Justin

ChangeSet
  1.1118.33.8 03/05/01 11:06:21 gibbs@overdrive.btc.adaptec.com +3 -0
  Aic7xxx Driver Update (6.2.33)
   o Correct MODULE_INFO string.
   o Bump version number.

ChangeSet
  1.1118.33.7 03/05/01 11:04:13 gibbs@overdrive.btc.adaptec.com +2 -0
  Update Aic79xx and Aic7xxx Documenation

ChangeSet
  1.1118.33.6 03/05/01 11:00:31 gibbs@overdrive.btc.adaptec.com +5 -0
  Aic79xx Driver Update (version 1.3.8)
   o Correct a few BE processor bugs
   o Print an additional diagnostic during recovery processing

ChangeSet
  1.1118.33.5 03/04/24 15:12:48 gibbs@overdrive.btc.adaptec.com +7 -0
  Aic7xxx and Aic79xx Driver Updates
   o Adapt to new IRQ handler declaration/behavior for 2.5.X

ChangeSet
  1.1118.33.4 03/04/24 15:10:16 gibbs@overdrive.btc.adaptec.com +2 -0
  Aic79xx and Aic7xxx driver Update
   o Fix build on 2.5.X

ChangeSet
  1.1118.33.3 03/04/24 13:30:58 gibbs@overdrive.btc.adaptec.com +2 -0
  Merge http://linux.bkbits.net/linux-2.5
  into overdrive.btc.adaptec.com:/usr/home/gibbs/bk/linux-2.5

ChangeSet
  1.971.94.14 03/04/24 13:23:49 gibbs@overdrive.btc.adaptec.com +4 -0
  aic7xxx_osm.h, aic7xxx_osm.c, aic79xx_osm.h, aic79xx_osm.c:
    Remove pre-2.2.X kernel support. 

ChangeSet
  1.971.94.13 03/04/24 12:46:43 gibbs@overdrive.btc.adaptec.com +8 -0
  Aic79xx Driver Upate
   o Switch to handling bad SCSI status as a sequencer interrupt
     instead of having the kernel proccess these failures via
     the completion queue.  This is done because:
  
      - The old scheme required us to pause the sequencer and clear
        critical sections for each SCB.  It seems that these pause
        actions, if coincident with a sequencer FIFO interrupt, would
        result in a FIFO interrupt getting lost or directing to the
        wrong FIFO.  This caused hangs when the driver was stressed
        under high "queue full" loads.
      - The completion code assumed that it was always called with
        the sequencer running.  This may not be the case in timeout
        processing where completions occur manually via
        ahd_pause_and_flushwork().
      - With this scheme, the extra expense of clearing critical
        sections is avoided since the sequencer will only self pause
        once all pending selections have cleared and it is not in
        a critical section.

ChangeSet
  1.971.94.12 03/04/24 12:36:46 gibbs@overdrive.btc.adaptec.com +1 -0
  Aic79xx Driver Update
   o Revert ahd_pause_and_flushwork() behavior so that ENSELO can
     be cleared.  This makes ahd_pause_and_flushwork() more effective
     when the bus is hung.

ChangeSet
  1.971.94.11 03/04/24 12:24:31 gibbs@overdrive.btc.adaptec.com +1 -0
  Aic79xx Driver Update
   o Correct "Unexpected PKT Busfree" error observed under high
     tag loads.

ChangeSet
  1.971.94.10 03/04/24 12:15:47 gibbs@overdrive.btc.adaptec.com +7 -0
  Aic79xx Driver Update
   o Perform a few firmware optimizations
   o Correct the packetized status handler so that
     it can handle CRC errors during status data packets.

ChangeSet
  1.971.94.9 03/04/24 12:10:40 gibbs@overdrive.btc.adaptec.com +2 -0
  Aic7xxx Driver Update
   o Auto disable PCI parity error reporting after 10 parity errors
     are observed.  The user is given a loud warning message telling
     them that eiter a device plugged into their motherboard or their
     motherboard is not very healthy.

ChangeSet
  1.971.94.8 03/04/24 12:07:37 gibbs@overdrive.btc.adaptec.com +4 -0
  Aic7xxx and Aic79xx Driver Updates
   o Correct type safty of option parsing logic
   o Make option toggling work correctly
   o Add "probe_eisa_vlb" as an alias for the "no_probe" option so
     that there is a clearly defined name associated with the command
     line feature that allows eisa_vlb probes to be enabled/disabled
     in the aic7xxx driver.
   o PCI parity error checking defaults to being enabled.

ChangeSet
  1.971.94.7 03/04/24 11:53:55 gibbs@overdrive.btc.adaptec.com +2 -0
  Aic7xxx and Aic79xx driver Update
   o Fix style nits.

ChangeSet
  1.971.94.6 03/04/24 11:49:01 gibbs@overdrive.btc.adaptec.com +2 -0
  Aic7xxx and Aic79xx driver updates
   o Remove extra complexity and code duplication in processing
     the completeq now that the completeq can be run while holding
     both the ah?_lock and the done_lock.

ChangeSet
  1.971.94.5 03/04/24 11:46:55 gibbs@overdrive.btc.adaptec.com +2 -0
  Aic7xxx and Aic79xx driver updates
   o Work around peculiarities in the scan_scsis routines
     that could, due to having duplicate devices on our
     host's device list, cause tagged queing to be disabled
     for devices added via /proc.

ChangeSet
  1.971.94.4 03/04/24 11:42:36 gibbs@overdrive.btc.adaptec.com +2 -0
  Aic7xxx and Aic79xx Driver Update
   o Correct channel information in our /proc output.

ChangeSet
  1.971.94.3 03/04/24 11:24:15 gibbs@overdrive.btc.adaptec.com +6 -0
  Aic7xxx and Aic79xx driver Update
  o Avoid pre-2.5.X mid-layer deadlock due to SCSI malloc fragmentation
  
  For pre-2.5.X kernels, attempt to calculate a safe value
  for our S/G list length.  In these kernels, the midlayer
  allocates an S/G array dynamically when a command is issued
  using SCSI malloc.  This list, which is in an OS dependent
  format that must later be copied to our private S/G list, is
  sized to house just the number of segments needed for the
  current transfer.  Since the code that sizes the SCSI malloc
  pool does not take into consideration fragmentation of the
  pool, executing transactions numbering just a fraction of our
  concurrent transaction limit with list lengths aproaching
  AH?_NSEG in length will quickly depleat the SCSI malloc pool
  of usable space.
  
  Unfortunately, the mid-layer does not properly handle this
  scsi malloc failure.  In kernels prior to 2.4.20, should
  the device that experienced the malloc failure be idle and
  never have any new I/O initiated (block queue is not "kicked"),
  the process will hang indefinitely.  In 2.4.20 and beyond,
  the disk experiencing the failure is marked as a "starved
  device", but this only helps if I/O is initiated to or completes
  on that HBA.  If the failure was induced by another HBA, and
  no other I/O is pending on the HBA and no new transactions are
  queued, we are still succeptible to the hang.  (Also note that
  many 2.4.X kernels do not properly lock the "some_device_starved"
  and "device_starved" fields calling into question their overall
  effectiveness).
  
  By sizing our S/G list to avoid SCSI malloc pool fragmentation,
  we will hopefully avoid this deadlock at least for configurations
  where our own HBAs are the only ones using the SCSI subsystem.

ChangeSet
  1.971.94.2 03/04/09 18:12:31 gibbs@overdrive.btc.adaptec.com +1 -0
  Aic79xx Driver Update
   o Correct failed-wait recovery code so that the controller's registers
     will not be accessed without pausing the controller first.

ChangeSet
  1.971.94.1 03/04/09 13:07:08 gibbs@overdrive.btc.adaptec.com +1 -0
  Merge http://linux.bkbits.net/linux-2.5
  into overdrive.btc.adaptec.com:/usr/home/gibbs/bk/linux-2.5

ChangeSet
  1.971.37.4 03/04/09 13:01:11 gibbs@overdrive.btc.adaptec.com +4 -0
  Aic7xxx Driver Update (version 6.2.32)
   o Perform an audit on use of del_timer() and switch to del_timer_sync()
     where appropriate.
   o Remove the reboot notifier hook which is unused in 2.5.X.
   o Correct some driver unload bugs.

ChangeSet
  1.971.37.3 03/04/09 12:52:07 gibbs@overdrive.btc.adaptec.com +3 -0
  Aic79xx Driver Update (version 1.3.6)
   o Correct bus hang on SE->LVD/LVD->SE tranceiver changes
   o Close a race condition in handling bad scsi status that could
     allow the driver to modify the waiting for selection queue while
     selections were enabled.
   o Perform an audit on use of del_timer() and switch to del_timer_sync()
     where appropriate.
   o Remove the reboot notifier hook which is unused in 2.5.X.
   o Correct some driver unload bugs.

ChangeSet
  1.971.37.2 03/04/09 11:56:15 gibbs@overdrive.btc.adaptec.com +2 -0
  Change the callback argument for aic brace option parsing to u_long
  to avoid casting problems with different architectures.

