Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267129AbTBDE0c>; Mon, 3 Feb 2003 23:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267124AbTBDE0c>; Mon, 3 Feb 2003 23:26:32 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:5643 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267129AbTBDE0P>;
	Mon, 3 Feb 2003 23:26:15 -0500
Date: Mon, 3 Feb 2003 20:31:44 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.59
Message-ID: <20030204043144.GI8341@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a series of USB patches from a lot of different people.  They
range from a lot of speedtouch driver updates, some usb-storage changes
to not keep scsi devices around in memory, to more usb-serial device
ids, to some host controller minor updates, and finally some minor
scanner driver tweaks.  There's also some network Makefile changes that
were blessed by Jeff Garzik needed for one of the usb network drivers.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h


 drivers/net/Kconfig                |    8 
 drivers/net/Makefile               |    4 
 drivers/usb/class/cdc-acm.c        |    3 
 drivers/usb/core/devices.c         |    2 
 drivers/usb/core/hcd.c             |   11 
 drivers/usb/core/hcd.h             |   14 
 drivers/usb/core/message.c         |   33 -
 drivers/usb/core/usb.c             |   24 
 drivers/usb/host/ehci-dbg.c        |   88 ++
 drivers/usb/host/ehci-hcd.c        |   45 -
 drivers/usb/host/ehci-mem.c        |    2 
 drivers/usb/host/ehci-q.c          |  123 ++-
 drivers/usb/host/ehci.h            |   17 
 drivers/usb/host/hc_simple.c       |    3 
 drivers/usb/host/ohci-hcd.c        |   24 
 drivers/usb/host/ohci-mem.c        |    8 
 drivers/usb/host/ohci-q.c          |   28 
 drivers/usb/host/uhci-hcd.c        |    1 
 drivers/usb/image/scanner.c        |   32 -
 drivers/usb/image/scanner.h        |  143 ++--
 drivers/usb/input/hid-core.c       |    9 
 drivers/usb/misc/atmsar.c          |   82 ++
 drivers/usb/misc/atmsar.h          |    3 
 drivers/usb/misc/speedtouch.c      | 1171 +++++++++++++++++++------------------
 drivers/usb/net/Makefile.mii       |    5 
 drivers/usb/serial/ftdi_sio.c      |    2 
 drivers/usb/serial/ftdi_sio.h      |    3 
 drivers/usb/serial/ipaq.c          |    2 
 drivers/usb/serial/ipaq.h          |    4 
 drivers/usb/serial/pl2303.c        |    1 
 drivers/usb/serial/pl2303.h        |    3 
 drivers/usb/storage/datafab.h      |   14 
 drivers/usb/storage/freecom.c      |  410 ++++++------
 drivers/usb/storage/isd200.c       |  246 +++----
 drivers/usb/storage/protocol.h     |    2 
 drivers/usb/storage/scsiglue.c     |  190 +++---
 drivers/usb/storage/scsiglue.h     |    2 
 drivers/usb/storage/transport.h    |   17 
 drivers/usb/storage/unusual_devs.h |   10 
 drivers/usb/storage/usb.c          |  703 ++++++++++------------
 drivers/usb/storage/usb.h          |   39 -
 include/linux/usb.h                |    1 
 42 files changed, 1922 insertions(+), 1610 deletions(-)
-----

ChangeSet@1.999, 2003-02-04 14:13:27+11:00, greg@kroah.com
  [PATCH] USB: added tripp device id's to pl2303 driver.
  
  Thanks to John Moses <jmoses@lanl.gov> for the information.

 drivers/usb/serial/pl2303.c |    1 +
 drivers/usb/serial/pl2303.h |    3 +++
 2 files changed, 4 insertions(+)
------

ChangeSet@1.998, 2003-02-04 14:01:35+11:00, p.guehring@futureware.at
  [PATCH] USB: FTDI driver, new id added

 drivers/usb/serial/ftdi_sio.c |    2 ++
 drivers/usb/serial/ftdi_sio.h |    3 +++
 2 files changed, 5 insertions(+)
------

ChangeSet@1.997, 2003-02-04 13:20:08+11:00, mdharm-usb@one-eyed-alien.net
  [PATCH] USB usb-storage: implement clearing of device queue
  
  This patch clears out the device queue when a unit is removed.

 drivers/usb/storage/usb.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)
------

ChangeSet@1.996, 2003-02-04 12:05:32+11:00, mdharm-usb@one-eyed-alien.net
  [PATCH] USB usb-storage: implement device-offline code
  
  This code implements the setting of devices offline during the removal
  phase.

 drivers/usb/storage/usb.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)
------

ChangeSet@1.995, 2003-02-04 12:04:38+11:00, mdharm-usb@one-eyed-alien.net
  [PATCH] USB usb-storage: host a host refcount a little bit longer
  
  This patch makes us hold the host reference count a little bit longer in
  the /proc interface code.  We were releasing it too early before.

 drivers/usb/storage/scsiglue.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)
------

ChangeSet@1.994, 2003-02-04 11:56:06+11:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: earlier rejection of outgoing speedtouch packets
  
    speedtouch: reject outgoing packets earlier when the firmware is not loaded.

 drivers/usb/misc/speedtouch.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.993, 2003-02-04 11:55:16+11:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: allocate speedtouch send urbs in the USB probe routine
  
    speedtouch: allocate send urbs in udsl_usb_probe rather than in udsl_usb_data_init.
    Since this diminishes udsl_usb_data_init down to almost nothing, roll it into the one
    place it was used.  Get rid of the semaphore Oliver put it - it is no longer needed.
  
  
   speedtouch.c |   86 ++++++++++++++++++++++++++---------------------------------
   1 files changed, 38 insertions(+), 48 deletions(-)

 drivers/usb/misc/speedtouch.c |   86 ++++++++++++++++++------------------------
 1 files changed, 38 insertions(+), 48 deletions(-)
------

ChangeSet@1.992, 2003-02-04 11:54:27+11:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: tweak speedtouch status logic
  
    speedtouch: change data_started to firmware_loaded, which is what it actually
    means, plus some minor related changes.

 drivers/usb/misc/speedtouch.c |   35 ++++++++++++++---------------------
 1 files changed, 14 insertions(+), 21 deletions(-)
------

ChangeSet@1.991, 2003-02-04 11:53:05+11:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: re-cosmetic speedtouch changes
  
    speedtouch: a pile of cosmetic changes to make me feel happier (no code changes).

 drivers/usb/misc/speedtouch.c |  391 +++++++++++++++++++++---------------------
 1 files changed, 198 insertions(+), 193 deletions(-)
------

ChangeSet@1.990, 2003-02-04 11:52:04+11:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: re-wait for speedtouch completion handlers after usb_unlink_urb
  
    speedtouch: wait for receive urb completion handlers to finish after calling
    usb_unlink_urb.

 drivers/usb/misc/speedtouch.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+)
------

ChangeSet@1.989, 2003-02-04 11:51:11+11:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: re-recycle failed speedtouch receive urbs
  
    speedtouch: more robust handling of receive urb failure: retry failed urbs whenever
    a new connection is opened.  This should work well with pppd's persist option.

 drivers/usb/misc/speedtouch.c |  133 +++++++++++++++++++++++++++---------------
 1 files changed, 88 insertions(+), 45 deletions(-)
------

ChangeSet@1.988, 2003-02-04 11:47:48+11:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: re-recycle speedtouch receive buffers
  
  Rediffed version of the original patch - no sk_buff on the stack this time.
  
    speedtouch: recycle the receive urb's buffer.  Currently, every time a receive urb
      completes, its old buffer is thrown away and replaced with a new one.  This patch
      performs the minor changes needed to reuse the old buffer.

 drivers/usb/misc/atmsar.c     |    5 ++---
 drivers/usb/misc/speedtouch.c |   37 ++++++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 20 deletions(-)
------

ChangeSet@1.987, 2003-02-04 11:46:01+11:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: let the tasklet do all processing of speedtouch receive urbs
  
    speedtouch: move all processing of receive urbs to udsl_atm_processqueue.  This has
    several advantages, as will be seen in the next few patches.  The most important is
    that it makes it easy to reuse of the urb's buffer (right now a new buffer is
    allocated every time the urb completes).  By the way, this patch is much smaller than
    it looks: most of the bulk is due to indentation changes.

 drivers/usb/misc/speedtouch.c |  203 +++++++++++++++++++++---------------------
 1 files changed, 103 insertions(+), 100 deletions(-)
------

ChangeSet@1.986, 2003-02-04 11:25:17+11:00, henning@meier-geinitz.de
  [PATCH] USB scanner.c: Adjust syslog output
  
  This patch prints the vendor + product ids of the scanner after it has
  been successfully detected.
  
  Also the annoying error message about "Scanner device is already open"
  was downgraded to a dbg. Scanning for devices while one scanner device
  was open produced several 100 error messages in syslog.

 drivers/usb/image/scanner.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)
------

ChangeSet@1.985, 2003-02-04 11:24:05+11:00, henning@meier-geinitz.de
  [PATCH] USB scanner.h, scanner.c: maintainer change
  
  This patch changes the maintainer from Brian Beattie to Henning
  Meier-Geinitz and adds a link to the documentation and website.

 drivers/usb/image/scanner.c |   19 ++++++++++++++-----
 drivers/usb/image/scanner.h |   18 ++++++++++++------
 2 files changed, 26 insertions(+), 11 deletions(-)
------

ChangeSet@1.984, 2003-02-04 10:55:55+11:00, mdharm-usb@one-eyed-alien.net
  [PATCH] Replace a line of code that shouldn't have been removed.

 drivers/usb/storage/usb.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.983, 2003-02-04 10:55:22+11:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb-storage: convert spaces to tabs
  
  This is a minor cleanup to convert 8 spaces into tabs.  There is no
  functional change here.

 drivers/usb/storage/datafab.h      |   14 -
 drivers/usb/storage/freecom.c      |  410 ++++++++++++++++++-------------------
 drivers/usb/storage/isd200.c       |  246 +++++++++++-----------
 drivers/usb/storage/protocol.h     |    2 
 drivers/usb/storage/transport.h    |   17 -
 drivers/usb/storage/unusual_devs.h |   10 
 drivers/usb/storage/usb.c          |    2 
 7 files changed, 350 insertions(+), 351 deletions(-)
------

ChangeSet@1.982, 2003-02-04 10:54:46+11:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb-storage: remove US_FL_DEV_ATTACHED
  
  This patch removes the US_FL_DEV_ATTACHED flag, which is now rendered
  obsolete by the new hotplug system.
  
  It also adds a comment or two about areas of code that need to be
  re-examined.

 drivers/usb/storage/scsiglue.c |   41 ++++++++++++++++-------------------------
 drivers/usb/storage/usb.c      |   31 -------------------------------
 drivers/usb/storage/usb.h      |    2 --
 3 files changed, 16 insertions(+), 58 deletions(-)
------

ChangeSet@1.981, 2003-02-04 10:54:15+11:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb-storage: comments, cleanup
  
  This patch does the following:
  (o) Add comments showing what needs to be done to complete the hot-unplug
      system.
  (o) Add a BUG_ON() for (what is now) a critical failure case.
  (o) Make certain that a debug print happens even if a usb_get_intfdata()
      crashes.
  (o) Add an un-necessary up() to balance a down, for the auto-code-checkers.

 drivers/usb/storage/usb.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)
------

ChangeSet@1.980, 2003-02-04 10:53:38+11:00, mdharm-scsi@one-eyed-alien.net
  [PATCH] usb-storage: fix oops
  
  It should fix the OOPS on attach.
  
  This fixes a silly error where I fail to initialize a pointer early enough
  for the scanning code.  If this isn't a perfect example of why
  scsi_register() and scsi_add_host() aren't two separate functions, I don't
  know what is.  :)
  
  Oh, and I added a couple of comments, too.
  
    -  Fix an OOPS by moving the setting of the hostdata[] pointer to _before_
       the device scan starts.

 drivers/usb/storage/usb.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)
------

ChangeSet@1.979, 2003-02-04 10:52:56+11:00, mdharm-scsi@one-eyed-alien.net
  [PATCH] usb-storage: fix typo
  
  This patch goes on top of the last one.  It fixes a typo in the test for
  scsi_register() failure.
  
    -- reversed the logic of failure test for scsi_register()

 drivers/usb/storage/usb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.978, 2003-02-04 10:51:33+11:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb-storage: move to SCSI hotplugging
  
  The attached patch is my first implementation of SCSI hotplugging.
  
  It's only been tested that it compiles, as I can't get the current
  linux-2.5 tree from linuxusb to boot.  It dies _very_ early.  Greg, I'm not
  sure if you'll want to apply this.  Linus seemed to want this very much,
  and it is 2.5.x... I say go for it, but I can understand if you have
  reservations.
  
  I would definately like to see this tested by anyone who can get a kernel
  to boot.
  
  This patch is quite large.  Lots of things had to be changed.  Among them:
  
  (o) The proc interface now uses the host number to look up the SCSI host
      structure, and then finds the usb-storage structure from that.
  (o) The SCSI interface has been changed.  The code flow is now much
      clearer, as more work is done from the USB probe/detach functions than
      from auxillary functions.
  (o) Names have been changed for newer conventions
  (o) GUIDs have been removed
  (o) The linked-list of devices has been removed, and it's associated
      semaphore
  (o) All code dealing with re-attaching a device to it's old association has
      been removed
  (o) Some spaces changed to tabs
  (o) usb-storage now takes one directory under /proc/scsi instead of
      one per virtual-HBA
  (o) All control threads now have the same name.  This could be changed back
      to the old behavior, if enough people want it.
  
  Known problems:
  (o) Testing, testing, testing
  (o) More dead code needs to be cut
  (o) It's a unclear how a LLD is supposed to cut off the flow of
      commands, so that the unregister() call always succeeds.  SCSI folks
      need to work on this.
  (o) Probing needs to be broken down into smaller functions, probably.

 drivers/usb/storage/scsiglue.c |  145 +++++----
 drivers/usb/storage/scsiglue.h |    2 
 drivers/usb/storage/usb.c      |  619 ++++++++++++++++++-----------------------
 drivers/usb/storage/usb.h      |   37 --
 4 files changed, 368 insertions(+), 435 deletions(-)
------

ChangeSet@1.977, 2003-02-04 10:49:44+11:00, greg@kroah.com
  [PATCH] USB: fix to get usb-storage code to work again.
  
  Thanks to Matt Dharm and David Brownell for tracking this bug down.

 drivers/usb/core/message.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.976, 2003-02-04 10:48:46+11:00, greg@kroah.com
  [PATCH] USB: add a blank line between each device in usbfs/devices

 drivers/usb/core/devices.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.975, 2003-01-31 15:26:33+11:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: add a new speedtouch encoding function
  
    speedtouch: add a new encoding function, atmsar_encode.  Calling it amounts to doing
    atmsar_encode_aal5 followed by atmsar_encode_rawcell in one fell swoop.  It eliminates
    the need for intermediate buffers and reduces memory movement.  The following patches
    use it to simplify the send logic (and get rid of those annoying little oopsen).

 drivers/usb/misc/atmsar.c |   77 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/misc/atmsar.h |    3 +
 2 files changed, 80 insertions(+)
------

ChangeSet@1.974, 2003-01-31 15:25:48+11:00, david-b@pacbell.net
  [PATCH] USB: ehci-hcd updates
  
  This should apply to 2.5.59 too.  It seems to get rid of some pesky
  hangs, on at least some hardware, but I won't have time to test it
  on either VIA version ... maybe someone else will make the time?  :)
  
        New QH state prevents a re-activation race
  	- nobody can un-halt a qh before its cleanup is done
  	- resubmit-from-completion had this race (some usbtest cases)
  	  as could some normal submit paths on busy endpoints (storage)
  	- faster controllers would trip on this more consistently
  
        Queues of qtds
  	- work harder to avoid ever modifing any qh in software
  	- short reads block queue advance much less often
  	- be more cautious with large (>~19KB) unaligned buffers
  
        Unlinking urbs
  	- if qtd unlinked is at queue head, use its latest status
  	  (main effect is reporting bytes from partial transfers)
  	- another new qh state:  defer qh unlink if IAA is busy
  	  (eliminates a busy-wait loop in a rare scenario)
  
        Enable features to improve bus utilization
  	- PCI MWI ... can produce better write throughput; and by
  	  using right cacheline size, sometimes read throughput too
  	- USB NAK throttle ... sometimes reduces PCI access rates
  
        Other
  	- async dump shows more funky qh+qtd states, and NAK count
  	- cope with with some of the sprintf wierdness
  	- periodic dump is usually smaller (so is that schedule)
        	- minor cleanups

 drivers/usb/host/ehci-dbg.c |   88 ++++++++++++++++++++++++++-----
 drivers/usb/host/ehci-hcd.c |   45 ++++++++++------
 drivers/usb/host/ehci-mem.c |    2 
 drivers/usb/host/ehci-q.c   |  123 +++++++++++++++++++++++++++++---------------
 drivers/usb/host/ehci.h     |    7 +-
 5 files changed, 190 insertions(+), 75 deletions(-)
------

ChangeSet@1.973, 2003-01-28 23:25:03+11:00, vojtech@suse.cz
  [PATCH] USB: additions to hid-core.c blacklist

 drivers/usb/input/hid-core.c |    9 +++++++++
 1 files changed, 9 insertions(+)
------

ChangeSet@1.972, 2003-01-28 23:02:36+11:00, vojtech@suse.cz
  [PATCH] USB: Add an entry in cdc-acm.c for devices with ACM class (some Motorola phones)
  
  Normally the CDC ACM devices have an subclass of 0, and the ACM subclass is
  only applied to their first interface. But some have the subclass set on
  the device itself, namely Motorola mobile phones. This patch takes those
  devices into account.

 drivers/usb/class/cdc-acm.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.971, 2003-01-27 23:12:19+11:00, david-b@pacbell.net
  [PATCH] USB: usbcore misc cleanup (notably for non-dma hcds)
  
  The support for non-dma HCDs is likely the most interesting bit here.
  
      - makes dma calls behave sensibly when used with host controllers
        that don't use dma (including sl811).  usb_buffer_map() is a nop
        while scatterlist dma mappings fail (as they must).
  
      - make usb_sg_init() behave sensibly when used with non-dma hcs.
        the urbs are initted with transfer_buffer, not transfer_dma.
        this is the higher level analogue to usb_buffer_map(), so it
        needs to succeed unless there's a Real Error (tm).
  
      - moves two compatibility inlines from ehci.h into hcd.h so
        it'll be more practical to have the other hcds work in other
        environments (notably lk 2.4) too
  
      - remove URB_TIMEOUT_KILLED flag ... no device driver tests it;
        hcds don't really (uhci sets it, never reads it; sl811 doesn't
        enable the path that might set it), and it's not well defined.
        if any hcd needs such state, keep it in hc-private storage.
  
      - in usb_sg_wait(), use yield() instead of schedule() to let
        other activities free resources needed to continue.  (This
        was noted recently by Oliver.)

 drivers/usb/core/hcd.c       |    7 +++++--
 drivers/usb/core/hcd.h       |   14 ++++++++++++++
 drivers/usb/core/message.c   |   31 ++++++++++++++++++++++++-------
 drivers/usb/core/usb.c       |   24 +++++++++++++++++-------
 drivers/usb/host/ehci.h      |   10 ----------
 drivers/usb/host/hc_simple.c |    3 +--
 drivers/usb/host/uhci-hcd.c  |    1 -
 include/linux/usb.h          |    1 -
 8 files changed, 61 insertions(+), 30 deletions(-)
------

ChangeSet@1.970, 2003-01-27 23:10:42+11:00, david-b@pacbell.net
  [PATCH] USB ohci-hcd, don't force SLAB_ATOMIC allocations
  
  This is a minor cleanup to let per-request memory allocations block,
  when the caller allows (it provided the bitmask).  The driver used
  to work that way until something like 2.4.3; an update (a few months
  back) to how the "dma_addr_t" hashes to a "struct ohci_td *" lets us
  simplify things again.  Another benfit:  it blocks irqs for less time
  on the submit path.  (The ehci driver already acts this way.)

 drivers/usb/host/ohci-hcd.c |   24 ++++++++++++------------
 drivers/usb/host/ohci-mem.c |    8 +-------
 drivers/usb/host/ohci-q.c   |   28 +++++++++++++++++-----------
 3 files changed, 30 insertions(+), 30 deletions(-)
------

ChangeSet@1.969, 2003-01-27 22:48:24+11:00, petkan@users.sourceforge.net
  [PATCH] USB: pegasus & mii cset
  
    Some ethernet drivers other than those in .../drivers/net need generic
    MII code too and this cset shows how we do it for .../drivers/usb/net;
    For now only pegasus.c is using this feature, but as soon as we find
    more MII compliant controllers we'll put them in Makefile.mii too.
    Note: drivers which use the generic mii routines should bracket the
    code with #ifdef CONFIG_MII #endif since CONFIG_MII may not be present.
    See pegasus.c for more details.

 drivers/net/Kconfig          |    8 ++++++++
 drivers/net/Makefile         |    4 ++++
 drivers/usb/net/Makefile.mii |    5 +++++
 3 files changed, 17 insertions(+)
------

ChangeSet@1.968, 2003-01-21 15:40:32+08:00, henning@meier-geinitz.de
  [PATCH] USB scanner.h, scanner.c: New vendor/product ids
  
  This patch adds vendor/product ids for Artec, Canon, Compaq, Epson,
  HP, and Microtek scanners. Further more, the device list was cleaned
  up, sorted and duplicated entries have been removed.

 drivers/usb/image/scanner.c |    5 +
 drivers/usb/image/scanner.h |  125 ++++++++++++++++++++++++--------------------
 2 files changed, 73 insertions(+), 57 deletions(-)
------

ChangeSet@1.967, 2003-01-21 15:11:51+08:00, baldrick@wanadoo.fr
  [PATCH] USB: simplify speedtouch receive urb lifecycle
  
    speedtouch: simplify the receive urb lifecycle: allocate them in the usb probe function,
    free them on disconnect.

 drivers/usb/misc/speedtouch.c |   81 ++++++++++++++++++++++++++----------------
 1 files changed, 51 insertions(+), 30 deletions(-)
------

ChangeSet@1.966, 2003-01-21 15:11:37+08:00, baldrick@wanadoo.fr
  [PATCH] USB: turn speedtouch micro race into a nano race
  
    speedtouch: turn a micro race into a nano race.  The race is that an ATM device can
    be used the moment atm_dev_register returns, but you only get to fill out the
    atm_dev structure after atm_dev_register returns (this is a design flaw in the
    ATM layer).  Thus there is a small window during which you can be called with an
    incompletely set up data structure.  Workaround this by causing all ATM callbacks
    to fail if the dev_data field has not been set.  There is still a nano race if
    writing/reading the dev_data field is not atomic.  Is it atomic on all architectures?

 drivers/usb/misc/speedtouch.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)
------

ChangeSet@1.965, 2003-01-21 15:11:11+08:00, baldrick@wanadoo.fr
  [PATCH] USB: rework error handling in speedtouch probe function
  
    speedtouch: rework udsl_usb_probe error handling (for example, handle failure of
    atm_dev_register).  Do some trivial cleaning up while we're at it.

 drivers/usb/misc/speedtouch.c |   42 +++++++++++++++++++++++++-----------------
 1 files changed, 25 insertions(+), 17 deletions(-)
------

ChangeSet@1.964, 2003-01-21 15:10:56+08:00, baldrick@wanadoo.fr
  [PATCH] USB: move udsl_atm_startdevice into speedtouch probe function
  
    speedtouch: roll udsl_atm_startdevice into udsl_usb_probe.

 drivers/usb/misc/speedtouch.c |   29 ++++++++++-------------------
 1 files changed, 10 insertions(+), 19 deletions(-)
------

ChangeSet@1.963, 2003-01-21 15:10:30+08:00, baldrick@wanadoo.fr
  [PATCH] USB: eliminate pointless dynamic allocation in speedtouch
  
    speedtouch: use an array for rcvbufs rather than a pointer and dynamic allocation.

 drivers/usb/misc/speedtouch.c |   16 +---------------
 1 files changed, 1 insertion(+), 15 deletions(-)
------

ChangeSet@1.962, 2003-01-21 15:09:55+08:00, baldrick@wanadoo.fr
  [PATCH] USB: move udsl_atm_set_mac into speedtouch probe function
  
    speedtouch: roll udsl_atm_set_mac into udsl_usb_probe.

 drivers/usb/misc/speedtouch.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)
------

ChangeSet@1.961, 2003-01-21 15:09:27+08:00, baldrick@wanadoo.fr
  [PATCH] USB: trivial speedtouch changes
  
    speedtouch: trivial whitespace and debug message changes.

 drivers/usb/misc/speedtouch.c |   35 +++++++++++++++++++++--------------
 1 files changed, 21 insertions(+), 14 deletions(-)
------

ChangeSet@1.960, 2003-01-17 11:58:19-08:00, ganesh@tuxtop.vxindia.veritas.com
  [PATCH] USB ipaq driver ids
  
  Added ids for the Dell Axim and Toshiba E740.
  
  Thanks to Ian Molton and B.I.

 drivers/usb/serial/ipaq.c |    2 ++
 drivers/usb/serial/ipaq.h |    4 ++++
 2 files changed, 6 insertions(+)
------

ChangeSet@1.959, 2003-01-17 11:48:21-08:00, baldrick@wanadoo.fr
  [PATCH] export speedtouch usb info
  
    speedtouch: restore use of MODULE_DEVICE_TABLE to export usb info.  There may have
    been a problem with older 2.4 kernels, but there is none now.

 drivers/usb/misc/speedtouch.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)
------

ChangeSet@1.958, 2003-01-17 11:44:08-08:00, david-b@pacbell.net
  [PATCH] usb root hub strings
  
  Someone changed the "get string" logic to use short reads,
  not long ones, a while back.  That broke many root hub
  string accesses (not through tools like "lsusb"!) because
  that logic didn't handle short reads quite right.

 drivers/usb/core/hcd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.952.1.1, 2003-01-16 17:38:03-08:00, greg@kroah.com
  [PATCH] USB acm: patch from dan carpenter <error27@email.com> to fix typo.

 drivers/usb/class/cdc-acm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

