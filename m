Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUASNfv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 08:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbUASNfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 08:35:51 -0500
Received: from smtp11.eresmas.com ([62.81.235.111]:9935 "EHLO
	smtp11.eresmas.com") by vger.kernel.org with ESMTP id S264929AbUASNfg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 08:35:36 -0500
Message-ID: <400BDC85.8040907@wanadoo.es>
Date: Mon, 19 Jan 2004 14:32:53 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Tosatti <marcelo.tosatti@cyclades.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: AIC7xxx kernel problem with 2.4.2[234] kernels
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.0 (++)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> About the aic7xxx update, well, I believe aic7xxx 6.2.36 is pretty stable
> (I dont remember seeing any reliable bug report and I also cant find one
> in lkml archives) except this one (and a pair of "lockup on initialization
> with SMP").

Justin already put updates in BK, but James did not like the "new error recovery"
code. So, kernel driver is *SIX months* behind ADAPTEC driver release.

There is more info in this linux-scsi thread, why the patch was not applied:
http://marc.theaimsgroup.com/?l=linux-scsi&m=107228516327580&w=2

It looks like the _kernel_ driver is going to be without a maintainer
unless somebody works on it, porting ADAPTEC fixes/features to the kernel driver.


> What bugs are you aware of in 2.4's aic7xxx ?

aic7xxx/aic79xx CHANGELOG has info about all bugs fixed:

o Adaptec Aic7xxx

Version History:

   6.3.4 (December 22nd, 2003)
        - Provide a better description string for the 2915/30LP.
        - Sniff sense information returned by targets for unit
          attention errors that may indicate that the device has
          been changed.  If we see such status for non Domain
          Validation related commands, start a DV scan for the
          target.  In the past, DV would only occur for hot-plugged
          devices if no target had been previously probed for a
          particular ID.  This change guarantees that the DV process
          will occur even if the user swaps devices without any
          interveining I/O to tell us that a device has gone missing.
          The old behavior, among other things, would fail to spin up
          drives that were hot-plugged since the Linux mid-layer
          will only spin-up drives on initial attach.

   6.3.3 (November 6th, 2003)
        - Support the 2.6.0-test9 kernel
        - Fix rare deadlock caused by using del_timer_sync from within
          a timer handler.

   6.3.2 (October 28th, 2003)
        - Enforce a bus settle delay for bus resets that the
          driver initiates.
        - Fall back to basic DV for U160 devices that lack an
          echo buffer.
        - Correctly detect that left over BIOS data has not
          been initialized when the CHPRST status bit is set
          during driver initialization.

   6.3.1 (October 21st, 2003)
        - Fix a compiler error when building with only EISA or PCI
          support compiled into the kernel.
        - Add chained dependencies to both the driver and aicasm Makefiles
          to avoid problems with parallel builds.
        - Move additional common routines to the aiclib OSM library
          to reduce code duplication.
        - Fix a bug in the testing of the AHC_TMODE_WIDEODD_BUG that
          could cause target mode operations to hang.
        - Leave removal of softcs from the global list of softcs to
          the OSM.  This allows us to avoid holding the list_lock during
          device destruction.

   6.3.0 (September 8th, 2003)
        - Move additional common routines to the aiclib OSM library
          to reduce code duplication.
        - Bump minor number to reflect change in error recovery strategy.

   6.2.38 (August 31st, 2003)
        - Avoid an inadvertant reset of the controller during the
          memory mapped I/O test should the controller be left in
          the reset state prior to driver initialization.  On some
          systems, this extra reset resulted in a system hang due
          to a chip access that occurred too soon after reset.
        - Move additional common routines to the aiclib OSM library
          to reduce code duplication.
        - Add magic sysrq handler that causes a card dump to be output
          to the console for each controller.

   6.2.37 (August 12th, 2003)
        - Perform timeout recovery within the driver instead of relying
          on the Linux SCSI mid-layer to perform this function.  The
          mid-layer does not know the full state of the SCSI bus and
          is therefore prone to looping for several minutes to effect
          recovery.  The new scheme recovers within 15 seconds of the
          failure.
        - Support writing 93c56/66 SEEPROM on newer cards.
        - Avoid clearing ENBUSFREE during single stepping to avoid
          spurious "unexpected busfree while idle" messages.
        - Enable the use of the "Auto-Access-Pause" feature on the
          aic7880 and aic7870 chips.  It was disabled due to an
          oversight.  Using this feature drastically reduces command
          delivery latency.

   6.2.36 **KERNEL DRIVER**


o Adaptec Aic79xx

Version History:

   2.0.5 (December 22nd, 2003)
        - Correct a bug preventing the driver from renegotiating
          during auto-request operations when a check condition
          occurred for a zero length command.
        - Sniff sense information returned by targets for unit
          attention errors that may indicate that the device has
          been changed.  If we see such status for non Domain
          Validation related commands, start a DV scan for the
          target.  In the past, DV would only occur for hot-plugged
          devices if no target had been previously probed for a
          particular ID.  This change guarantees that the DV process
          will occur even if the user swaps devices without any
          interveining I/O to tell us that a device has gone missing.
          The old behavior, among other things, would fail to spin up
          drives that were hot-plugged since the Linux mid-layer
          will only spin-up drives on initial attach.
        - Correct several issues in the rundown of the good status
          FIFO during error recovery.  The typical failure scenario
          evidenced by this defect was the loss of several commands
          under high load when   several queue full conditions occured
          back to back.

   2.0.4 (November 6th, 2003)
        - Support the 2.6.0-test9 kernel
        - Fix rare deadlock caused by using del_timer_sync from within
          a timer handler.

   2.0.3 (October 21st, 2003)
        - On 7902A4 hardware, use the slow slew rate for transfer
          rates slower than U320.  This behavior matches the Windows
          driver.
        - Fix some issues with the ahd_flush_qoutfifo() routine.
        - Add a delay in the loop waiting for selection activity
          to cease.  Otherwise we may exhaust the loop counter too
          quickly on fast machines.
        - Return to processing bad status completions through the
          qoutfifo.  This reduces the amount of time the controller
          is paused for these kinds of errors.
        - Move additional common routines to the aiclib OSM library
          to reduce code duplication.
        - Leave removal of softcs from the global list of softcs to
          the OSM.  This allows us to avoid holding the list_lock during
          device destruction.
        - Enforce a bus settle delay for bus resets that the
          driver initiates.
        - Fall back to basic DV for U160 devices that lack an
          echo buffer.

   2.0.2 (September 4th, 2003)
        - Move additional common routines to the aiclib OSM library
          to reduce code duplication.
        - Avoid an inadvertant reset of the controller during the
          memory mapped I/O test should the controller be left in
          the reset state prior to driver initialization.  On some
          systems, this extra reset resulted in a system hang due
          to a chip access that occurred too soon after reset.
        - Correct an endian bug in ahd_swap_with_next_hscb.  This
          corrects strong-arm support.
        - Reset the bus for transactions that timeout waiting for
          the bus to go free after a disconnect or command complete
          message.

   2.0.1 (August 26th, 2003)
        - Add magic sysrq handler that causes a card dump to be output
          to the console for each controller.
        - Avoid waking the mid-layer's error recovery handler during
          timeout recovery by returning DID_ERROR instead of DID_TIMEOUT
          for timed-out commands that have been aborted.
        - Move additional common routines to the aiclib OSM library
          to reduce code duplication.

   2.0.0 (August 20th, 2003)
        - Remove MMAPIO definition and allow memory mapped
          I/O for any platform that supports PCI.
        - Avoid clearing ENBUSFREE during single stepping to avoid
          spurious "unexpected busfree while idle" messages.
        - Correct deadlock in ahd_run_qoutfifo() processing.
        - Optimize support for the 7901B.
        - Correct a few cases where an explicit flush of pending
          register writes was required to ensure acuracy in delays.
        - Correct problems in manually flushing completed commands
          on the controller.  The FIFOs are now flushed to ensure
          that completed commands that are still draining to the
          host are completed correctly.
        - Correct incomplete CDB delivery detection on the 790XB.
        - Ignore the cmd->underflow field since userland applications
          using the legacy command pass-thru interface do not set
          it correctly.  Honoring this field led to spurious errors
          when users used the "scsi_unique_id" program.
        - Perform timeout recovery within the driver instead of relying
          on the Linux SCSI mid-layer to perform this function.  The
          mid-layer does not know the full state of the SCSI bus and
          is therefore prone to looping for several minutes to effect
          recovery.  The new scheme recovers within 15 seconds of the
          failure.
        - Correct support for manual termination settings.
        - Increase maximum wait time for serial eeprom writes allowing
          writes to function correctly.

   1.3.12 (August 11, 2003)
        - Implement new error recovery thread that supercedes the existing
          Linux SCSI error recovery code.
        - Fix termination logic for 29320ALP.
        - Fix SEEPROM delay to compensate for write ops taking longer.

   1.3.11 (July 11, 2003)
        - Fix several deadlock issues.
        - Add 29320ALP and 39320B Id's.

   1.3.10 **KERNEL DRIVER**



