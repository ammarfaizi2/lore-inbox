Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318893AbSIIWQO>; Mon, 9 Sep 2002 18:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318923AbSIIWQO>; Mon, 9 Sep 2002 18:16:14 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:12043 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318893AbSIIWPi>;
	Mon, 9 Sep 2002 18:15:38 -0400
Date: Mon, 9 Sep 2002 15:17:27 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020909221727.GF7433@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This includes the previous USB changes I sent out for 2.5.33 but never
made it into your tree.

Pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 drivers/usb/core/hcd.c             |   21 +-
 drivers/usb/core/inode.c           |   43 +++--
 drivers/usb/host/ehci-dbg.c        |  141 +++++++++-------
 drivers/usb/host/ehci-hcd.c        |  117 +++++++++----
 drivers/usb/host/ehci-hub.c        |   13 +
 drivers/usb/host/ehci-q.c          |  107 +++++-------
 drivers/usb/host/ehci-sched.c      |   32 +--
 drivers/usb/host/ehci.h            |   24 ++
 drivers/usb/host/ohci-dbg.c        |  256 ++++++++++++++++++++++++++----
 drivers/usb/host/ohci-hcd.c        |   79 ++++-----
 drivers/usb/host/ohci-mem.c        |   27 ---
 drivers/usb/host/ohci-q.c          |  314 +++++++++++++++++++------------------
 drivers/usb/host/ohci.h            |   27 +--
 drivers/usb/host/uhci-hcd.c        |  187 ++++++++++------------
 drivers/usb/host/uhci-hcd.h        |   43 ++++-
 drivers/usb/image/scanner.c        |    6 
 drivers/usb/media/se401.c          |  128 +++++++--------
 drivers/usb/media/se401.h          |    1 
 drivers/usb/net/kaweth.c           |    2 
 drivers/usb/net/pegasus.h          |    6 
 drivers/usb/net/usbnet.c           |    5 
 drivers/usb/storage/protocol.c     |   69 ++++++--
 drivers/usb/storage/transport.c    |    5 
 drivers/usb/storage/unusual_devs.h |   14 +
 drivers/usb/storage/usb.c          |    8 
 drivers/usb/storage/usb.h          |    1 
 26 files changed, 1018 insertions(+), 658 deletions(-)
-----

ChangeSet@1.622, 2002-09-09 14:21:49-07:00, pe1rxq@amsat.org
  [PATCH] USB: se401 driver update
  

 drivers/usb/media/se401.c |  128 +++++++++++++++++++++++-----------------------
 drivers/usb/media/se401.h |    1 
 2 files changed, 65 insertions(+), 64 deletions(-)
------

ChangeSet@1.621, 2002-09-09 13:59:18-07:00, david-b@pacbell.net
  [PATCH] [PATCH 2.5.33+] ohci and iso-in
  
  I added a bug in 2.5.23 when cleaning up something that
  was broken ... it wasn't broken in quite the way I had
  thought at the time!
  
  This fixes a problem some folk have reported recently
  with ISO-IN, by masking a common non-error outcome.
  
  Please merge to Linus' tree, on top of the one patch
  you already have queued.  Thanks to Nemosoft for such
  quick turnaround on testing!

 drivers/usb/host/ohci-q.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)
------

ChangeSet@1.620, 2002-09-09 13:58:51-07:00, fzago@austin.rr.com
  [PATCH] [PATCH] (repost) fix for big endian machines in scanner.c
  
  This patch fixes a problem with big endian machines and scanner drivers which
  use the SCANNER_IOCTL_CTRLMSG ioctl. The big endian to little endian swap was
  done twice, resulting in a no-op.

 drivers/usb/image/scanner.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.619, 2002-09-09 13:58:32-07:00, stern@rowland.harvard.edu
  [PATCH] USB storage: abort bug fix
  
  Also, have you sent in the one-line fix I found for the abort bug?
  Andries found that it cured his BUG_ON problem.  In case you didn't save a
  copy of it, I've included it below.

 drivers/usb/storage/transport.c |    3 +++
 1 files changed, 3 insertions(+)
------

ChangeSet@1.616, 2002-09-05 08:40:44-07:00, david-b@pacbell.net
  [PATCH] usbnet, add YOPY device IDs
  
  A now-happy Yopy user sent me these IDs.

 drivers/usb/net/usbnet.c |    5 +++++
 1 files changed, 5 insertions(+)
------

ChangeSet@1.615, 2002-09-05 08:40:25-07:00, Oliver.Neukum@lrz.uni-muenchen.de
  [PATCH] two byte offset for kaweth
  
  this is the two byte offset patch to kaweth for 2.5
  to prevent MIPS crashing and speed up other arches.

 drivers/usb/net/kaweth.c |    2 ++
 1 files changed, 2 insertions(+)
------

ChangeSet@1.614, 2002-09-05 08:33:20-07:00, greg@kroah.com
  USB: storage driver: replace show_trace() with BUG()

 drivers/usb/storage/transport.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.613, 2002-09-04 17:35:36-07:00, Andries.Brouwer@cwi.nl
  [PATCH] Feiya 5-in-1 Card Reader
  
  I have a USB 5-in-1 Card Reader, that will read CF and SM and SD/MMC.
  Under Linux it appears as three SCSI devices.
  For today, the report is on the CF part.
  
  The CF part works fine under ordinary usb-storage SCSI simulation,
  with one small problem: 8 and 32 MB cards, that are detected as
  having 15872 and 63488 sectors by other readers, are detected as
  having 15873 and 63489 sectors by this Feiya reader
  (0x090c / 0x1132).
  In the good old days probably nobody would have noticed, but these
  days the partition reading code also wants to read the last sector.
  This results in the SCSI code taking the device off line:
  
  [USB storage does a READ_10, which fails since the sector is past
  the end of the disk. Then it tries a READ_6 and nothing ever happens,
  probably because the device does not support READ_6. Then the
  error handler does an abort which triggers some bugs in scsiglue.c
  and transport.c, then the error handler does a device reset, then
  a host reset, then a bus reset, and finally the device is taken offline.]
  
  The patch below does not address any bugs in the SCSI error code
  (a big improvement would be just to rip it all out - this error code
  never achieves anything useful but has crashed many a machine)
  and does not fix the USB code either.
  It just adds a flag to the unusual_devices section mentioning that
  this device (my revision is 1.00) has this bug.
  
  Without the patch the kernel crashes, or insmod usb-storage hangs.
  With the patch the CF part of the device works perfectly.
  
  (Another change is to only print "Fixing INQUIRY data" when
  really something is changed, not when the data was OK already.)
  
  Andries

 drivers/usb/storage/protocol.c     |   69 ++++++++++++++++++++++++++++---------
 drivers/usb/storage/unusual_devs.h |    7 +++
 drivers/usb/storage/usb.h          |    1 
 3 files changed, 62 insertions(+), 15 deletions(-)
------

ChangeSet@1.600.2.12, 2002-09-04 12:08:14-07:00, greg@kroah.com
  USB: clean up the error path in create_special_files() for usbfs
  
  Thanks to David Brownell for pointing out the problem here.

 drivers/usb/core/inode.c |   42 ++++++++++++++++++++++++++++++++----------
 1 files changed, 32 insertions(+), 10 deletions(-)
------

ChangeSet@1.600.2.11, 2002-09-04 11:16:26-07:00, rmk@arm.linux.org.uk
  [PATCH] 2.5.32-usb
  
  This patch appears not to be in 2.5.32, but applies cleanly.
  
  The following patch fixes 3 problems in USB:
  
  1. Don't pci_map buffers when we know we're not going to pass them
     to a device.
  
     This was first noticed on ARM (no surprises here); the root hub
     code, rh_call_control(), placed data into the buffer and then
     called usb_hcd_giveback_urb().  This function called
     pci_unmap_single() on this region which promptly destroyed the
     data that rh_call_control() had placed there.  This lead to a
     corrupted device descriptor and the "too many configurations"
     message.
  
  2. If controller->hcca is NULL, don't try to dereference it.
  
  3. If we free the root hub (in ohci-hcd.c or uhci-hcd.c), don't
     leave a dangling pointer around to trip us up in usb_disconnect().
     EHCI appears to get this right.

 drivers/usb/core/hcd.c      |   21 +++++++++++----------
 drivers/usb/host/ohci-dbg.c |    3 ++-
 drivers/usb/host/ohci-hcd.c |    3 ++-
 drivers/usb/host/uhci-hcd.c |    1 +
 4 files changed, 16 insertions(+), 12 deletions(-)
------

ChangeSet@1.600.2.10, 2002-09-04 11:04:10-07:00, greg@kroah.com
  USB: remove __NO_VERSION__
  
  Thanks to Rusty "trivial" Russell

 drivers/usb/core/inode.c |    1 -
 1 files changed, 1 deletion(-)
------

ChangeSet@1.600.2.9, 2002-09-04 09:54:02-07:00, petkan@users.sourceforge.net
  [PATCH] USB: pegasus driver patch
  
    one more adapter, changed company name and forgotten flag

 drivers/usb/net/pegasus.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)
------

ChangeSet@1.600.2.8, 2002-09-04 09:21:00-07:00, david-b@pacbell.net
  [PATCH] ohci-hcd endpoint scheduling, driverfs
  
  This patch cleans up some messy parts of this driver, and
  was pleasantly painless.
  
        - gets rid of ED dma hashtables
           * less memory needed
           * also less (+faster) code
           * ... rewrites all ED scheduling ops, they now use
             cpu addresses, like EHCI and UHCI do already
  
        - simplifies ED scheduling (no dma hashtables)
           * control and bulk lists are now doubly linked
           * periodic tree still singly linked; driver uses a
             new CPU view "shadow" of the hardware framelist
           * previous periodic code was cryptic, almost read-only
           * simpler tree code for EDs with {branch,period}
  
        - bugfixes periodic scheduling
           * when CONFIG_USB_BANDWIDTH, checks per-frame load
             against the limit; no more dodgey accounting
           * handles iso period != 1; interrupt and iso schedule
             EDs with the same routine (HW sees special TDs)
           * credit usbfs with bandwidth for endpoints, not URBs
  
        - adds driverfs output (when CONFIG_USB_DEBUG)
           * resembles EHCI:  'async' (control+bulk) and
             'periodic' (interrupt+iso) files show schedules
           * shows only queue heads (EDs) just now (*)
  
        - has minor text and code cleanups, etc
  
  Now that this logic has morphed into more comprehensible
  form, I know what to borrow into the EHCI code!
  
  
       (*) It shows TDs on the td_list, but this patch won't
           put them there.  A queue fault handling update will.

 drivers/usb/host/ohci-dbg.c |  253 +++++++++++++++++++++++++++++++-----
 drivers/usb/host/ohci-hcd.c |   67 ++++-----
 drivers/usb/host/ohci-mem.c |   27 ---
 drivers/usb/host/ohci-q.c   |  308 +++++++++++++++++++++++---------------------
 drivers/usb/host/ohci.h     |   27 +--
 5 files changed, 425 insertions(+), 257 deletions(-)
------

ChangeSet@1.600.2.7, 2002-09-04 09:18:15-07:00, mdharm-usb@one-eyed-alien.net
  [PATCH] PATCH: usb-storage: fix software eject
  
  This patch fixes the recently broken software eject of media.  At least, it
  should.  I'm back to having compile problems again, but the fix should
  be pretty self-evident.

 drivers/usb/storage/usb.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)
------

ChangeSet@1.600.2.6, 2002-09-04 09:16:59-07:00, david-b@pacbell.net
  [PATCH] Re: updated ehci patch ...
  
   * keep watchdog on shorter leash, and just do
     standard irq processing when it barks.  this
     means I can use a somewhat iffy vt8235 mobo.
  
   * updates to the driverfs debug output, including
     using S_IRUGO so anyone can gawk.
  
   * some updates, mostly to use a new hcd_to_bus(),
     so this version also compiles on a (slightly
     patched) 2.4.20-pre5 kernel.  (*)

 drivers/usb/host/ehci-dbg.c   |  141 +++++++++++++++++++++++-------------------
 drivers/usb/host/ehci-hcd.c   |   53 +++++++++------
 drivers/usb/host/ehci-hub.c   |   13 ++-
 drivers/usb/host/ehci-q.c     |    9 +-
 drivers/usb/host/ehci-sched.c |    6 -
 drivers/usb/host/ehci.h       |   22 ++++++
 6 files changed, 150 insertions(+), 94 deletions(-)
------

ChangeSet@1.600.2.5, 2002-09-04 09:16:29-07:00, david-b@pacbell.net
  [PATCH] ehci locking
  
  I've been chasing problems on a KT333 based system, with
  the 8253 southbridge and EHCI 1.0 (!), and this fixes at
  least some of them:
  
     - locking updates:
        * a few routines weren't protected right
        * less irqsave thrashing for schedule lock
  
     - adds a watchdog timer that should fire when the
       STS_IAA interrupt seems to be missing.
  
     - gives ports back to companion UHCI/OHCI on rmmod
  
     - re-enables faulted QH only after all its completion
       callbacks have done their work
  
     - removes an oops I've seen when usb-storage unlinks
       stuff.  (it seemed confused about error handling, but
       that's not a reason to oops.)
  
     - minor cleanup:  deadcode rm, etc
  
  Right now the watchdog just barks, and that mechanism might
  go away (or into the shared hcd code).  Sometimes the issue
  it reports seems to clear up by itself, but sometimes not...

 drivers/usb/host/ehci-hcd.c   |   64 ++++++++++++++++++++++-----
 drivers/usb/host/ehci-q.c     |   98 +++++++++++++++++-------------------------
 drivers/usb/host/ehci-sched.c |   26 ++++-------
 drivers/usb/host/ehci.h       |    2 
 4 files changed, 105 insertions(+), 85 deletions(-)
------

ChangeSet@1.600.2.4, 2002-09-04 09:06:34-07:00, bmatheny@purdue.edu
  [PATCH] Lexar USB CF Reader
  
  Two weeks ago I sent this patch to the listed USB storage maintainer
  (mdharm-usb@one-eyed-alien.net) and have not yet heard back. The
  attached patch adds support for the Lexar USB CF Reader identified by
  id_product 0xb002, version 0x0113 (which is the version I have). This
  patch is against the 2.4.19 kernel, sorry if this is the wrong address
  to send this stuff to. Thanks.

 drivers/usb/storage/unusual_devs.h |    7 +++++++
 1 files changed, 7 insertions(+)
------

ChangeSet@1.600.2.3, 2002-09-04 09:06:07-07:00, zwane@mwaikambo.name
  [PATCH] pci_free_consistent on ohci initialisation failure
  
  The trace at the end of the message shows the init failure.

 drivers/usb/host/ohci-hcd.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)
------

ChangeSet@1.600.2.2, 2002-09-04 09:05:37-07:00, david-b@pacbell.net
  [PATCH] Re: [patch 2.5.31-bk5] uhci, misc
  
  This patch has some small UHCI bugfixes
  
     - on submit error, frees memory and (!) returns error code
     - root hub should disconnect only once
     - pci pool code shouldn't be given GFP_DMA
     - uses del_timer_sync(), which behaves on SMP, not del_timer()
  
  and cleanups:
  
     - use container_of
     - doesn't replicate so much hcd state
     - no such status -ECONNABORTED
     - uses bus_name in procfs, not "hc0", "hc1" etc

 drivers/usb/host/uhci-hcd.c |  101 ++++++++++++++++----------------------------
 drivers/usb/host/uhci-hcd.h |    8 ---
 2 files changed, 38 insertions(+), 71 deletions(-)
------

ChangeSet@1.600.2.1, 2002-09-04 09:05:07-07:00, david-b@pacbell.net
  [PATCH] uhci, doc + cleanup
  
  Another UHCI patch.  I'm sending this since Dan said he was going to
  start teaching "uhci-hcd" how to do control and interrupt queueing,
  and this may help.  Granted it checks out (I didn't test the part
  that has a chance to break, though it "looks right"), I think it
  should get merged in at some point.  What it does:
  
     - updates and adds some comments/docs
     - gets rid of a "magic number" calling convention, instead passing
       an explicit flag UHCI_PTR_DEPTH or UHCI_PTR_BREADTH (self-doc :)
     - deletes bits of unused/dead code
     - updates the append-to-qh code:
         * start using list_for_each() ... clearer than handcrafted
           loops, and it prefetches too.  Lots of places should get
           updated to do this, IMO.
         * re-orders some stuff to fix a sequencing problem
         * adds ascii-art to show how the urb queueing is done
           (based on some email Johannes sent me recently)
  
  That sequencing problem is that when splicing a QH between A and B,
  it currently splices A-->QH before QH-->B ... so that if the HC is
  looking at that chunk of schedule at that time, everything starting
  at B will be ignored during the rest of that frame.  (Since the QH
  is initted to have UHCI_PTR_TERM next, stopping the schedule scan.)
  
  I said "problem" not "bug" since in the current code it would probably
  (what does that "PIIX bug" do??) just reduce control/bulk throughput.
  That's because the logic is only appending towards the  end of each
  frame's schedule, where the FSBR loopback kicks in.

 drivers/usb/host/uhci-hcd.c |   85 ++++++++++++++++++++++++--------------------
 drivers/usb/host/uhci-hcd.h |   35 +++++++++++++++++-
 2 files changed, 82 insertions(+), 38 deletions(-)
------

