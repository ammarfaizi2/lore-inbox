Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289987AbSBFDip>; Tue, 5 Feb 2002 22:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289989AbSBFDic>; Tue, 5 Feb 2002 22:38:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30995 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289987AbSBFDiO>; Tue, 5 Feb 2002 22:38:14 -0500
Date: Tue, 5 Feb 2002 19:37:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <Pine.LNX.4.31.0202051928330.2375-100000@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I've spent about a week trying to change my working habits and
scripting bitkeeper enough to (a) import a good revision controlled tree
into it from the 2.4.x and 2.5.x patch-archives and (b) try to actually
accept patches directly into bitkeeper.

Quite frankly, so far it has definitely made me slower - it took me
basically a week to get about 50 patches applied, but most of that time
by far was writing scripts and just getting used to the thing. Thanks to
Larry and Wayne for helping out with the problems I had.

And I'm not even done yet. I expect to be a bit slower to react to patches
for a while yet, until the scripts are better.

However, some of it pays off already. Basically, I'm aiming to be able to
accept patches directly from email, with the comments in the email going
into the revision control history. For a first example, the ChangeLog file
for 2.5.4-pre1 is rather more detailed than usual (in fact, right now it
is _too_ detailed, and I haven't written the scripts to "terse it down"
for postings to linux-kernel, for example).

The long-range plan, and the real payoff, comes if main developers start
using bk too, which should make syncing a lot easier. That will take some
time, I suspect.

		Linus

-----
ChangeSet@1.220, 2002-02-05 18:36:47-08:00, torvalds@penguin.transmeta.com
  defconfig:
    update

ChangeSet@1.219, 2002-02-05 18:31:49-08:00, torvalds@penguin.transmeta.com
  Makefile:
    Update version

ChangeSet@1.218, 2002-02-05 18:03:32-08:00, vojtech@suse.cz

  The patch moves:

  	* joystick drivers from drivers/char/joystick to drivers/input/joystick
  	* gameport drivers from drivers/char/joystick to drivers/input/gameport
  	* serio drivers from drivers/char/joystick to drivers/input/serio

  I don't think the joystick drivers should stay in char, because they're
  NOT character device drivers (check for register_chrdev, none to be found).

  It also fixes build problems with sound driver gameport support.

ChangeSet@1.217, 2002-02-05 17:50:12-08:00, kai@tp1.ruhr-uni-bochum.de
  [PATCH] 2.5.3 ISDN work around buggy hw

  the appended patch works around a bug in the PLX9050 chip. This chip is
  used in various PCI ISDN adapters (it's an PCI interface chip) and has
  an erratum when the BAR 0/1 has bit 7 set (the size of the region is
  0x80, so aligning it to 0x80 is legal and really happens for people).

  This workaround has been tested by a user who hit this problem with a
  Gazel card. Basically the same fix has been done for Elsa cards, but it's
  untested.

ChangeSet@1.216, 2002-02-05 17:50:08-08:00, kai@tp1.ruhr-uni-bochum.de
  [PATCH] 2.5.3 ISDN hisax_fcpcipnp driver fix

  the appended patch fixes a problem where the ->rcvidx variable was not
  initialized properly.

ChangeSet@1.215, 2002-02-05 17:50:04-08:00, kai@tp1.ruhr-uni-bochum.de
  [PATCH] 2.5.3 ISDN undefined behavior fix

  the appended patch fixes a case of undefined behavior, found by
  Urs Thuermann and "VDA".

ChangeSet@1.214, 2002-02-05 17:50:00-08:00, kai@tp1.ruhr-uni-bochum.de
  [PATCH] 2.5.3 ISDN charge hup fix

  the appended patch by Igmar Palsenberg fixes the CHARGE_HUP functionality
  (automatically hang up just before the next charging unit)

ChangeSet@1.213, 2002-02-05 17:49:56-08:00, kai@tp1.ruhr-uni-bochum.de
  [PATCH] 2.5.3 ISDN devfs fix

  the appended patch by Adrian Bunk removes yet another leftover from
  the /dev/isdnX devices (which causes an build error when
  CONFIG_DEVFS_FS=y).

ChangeSet@1.212, 2002-02-05 17:41:43-08:00, nkbj@image.dk
  [PATCH] Two fixes for linux-2.5.3.

   Correct typo in Documentation/Changes.
   Remove duplicate code in arch/i386/boot/bootsect.S.

ChangeSet@1.211, 2002-02-05 17:24:28-08:00, vandrove@vc.cvut.cz
  [PATCH] crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does

    I've found that multiple level initcalls went into kernel
  behind my back, so you can throw away my yesterday patch
  which converted lib.a => lib.o, and apply this one.

  [Patch tested with both lib.a and lib.o - it boots correctly
  in both cases]

ChangeSet@1.210, 2002-02-05 17:24:24-08:00, vandrove@vc.cvut.cz
  [PATCH] Re: [PATCH] nbd in 2.5.3 does not work, and can cause severe damage when read-write

  Linus, this reverts limit for request size from 10KB to unlimited.
  Although no released nbd version supports it, it is certainly better to
  add support to servers than cripple clients if incompatibility does
  not matter.

ChangeSet@1.209, 2002-02-05 17:24:21-08:00, trond.myklebust@fys.uio.no
  [PATCH] Drop reliance on file->f_dentry in NFS reads/writes

  Following a request by David Chow on linux fsdevel, this patch causes
  NFS read and write requests to take the inode from page->mapping->host
  rather than relying on file->f_dentry->d_inode. Apparently this will
  simplify some work he is doing on another filesystem.

  In any case, it cleans up the current mix of sometimes doing one
  thing, sometimes the other (historical cruft), and puts NFS client
  behaviour on par with what is done in other filesystems...

ChangeSet@1.208, 2002-02-05 17:24:18-08:00, trond.myklebust@fys.uio.no
  [PATCH] Fix spurious ETXTBSY errors due to late release of struct file

    The following patch should fix a problem of ETXTBSY sometimes
  occurring if one tries to run a file straight after compilation.

  The problem is that both NFS read and write requests can currently
  hold a count on the struct file. This is done partly so as to be able
  to pass along the RPC credential (which is cached in the struct file),
  and partly so that asynchronous writes can report any errors via the
  file->f_error mechanism.

  The problem is that both the read and write requests may persist even
  after file close() occurs. For O_RDONLY files, this is not a problem,
  but for O_WRONLY, and O_RDWR files, the fact that the struct file is
  not released until the last call to nfs_release_request() means that
  inode->i_writecount does not necessarily get cleared upon file
  close().

  The following patch fixes both these issues.

    - NFS read requests no longer hold the struct file. They take a
      count on the the RPC credential itself.

    - NFS write requests still hold the struct file, since they want to
      report errors to sys_close() using the file->f_error mechanism.
      However they are made to release the page, credential, and file
      structures as soon as the write is completed instead of following
      the current practice of waiting for the last nfs_page request
      release.

ChangeSet@1.207, 2002-02-05 17:24:14-08:00, trond.myklebust@fys.uio.no
  [PATCH] NFS lookup code rewrite w/o open(".") fix...

    This is a resend of the NFS lookup code rewrite, but with the open(".")
  VFS fix removed. (I'll resend the 'uses d_revalidate()' version
  separately after a suitable delay to allow for comments.)

    Issues fixed by this patch:

   - Use the directory mtime in order to give us a hint when we should
     check for namespace changes.

   - Add support for the 'nocto' flag, in order to turn off the strict
     attribute cache revalidation on file open().

   - Simplify inode lookup. Don't check the 'fsid' field (which appears
     to be buggy in too many servers in order to be reliable). Instead
     we only rely on the inode number (a.k.a. 'fileid') and the
     (supposedly unique) filehandle.

ChangeSet@1.206, 2002-02-05 17:17:24-08:00, greg@kroah.com
  [PATCH] USB ohci-hcd driver update

  Here's a patch against 2.5.3 for the USB ohci-hcd driver that does the
  following:
  	- doesn't assume CONFIG_DEBUG_SLAB
  	- unlink from interrupt completions now work
  	- doesn't force debugging on
  	- updated copyright / license statements
  	- slightly smaller object size
  	- fewer inlined magic numbers
  	- removes unused fields from data structures
  	- header file reorg, doc fixup
  This patch was done by David Brownell.

ChangeSet@1.205, 2002-02-05 17:17:21-08:00, greg@kroah.com
  [PATCH] USB vicam driver update

  Here's a patch against 2.5.3 for the USB vicam driver that removes the
  use of interruptible_sleep_on() in the driver.  This patch was done by
  Oliver Neukum.

ChangeSet@1.204, 2002-02-05 17:17:18-08:00, greg@kroah.com
  [PATCH] USB core update

  Here's a patch against 2.5.3 for the USB core that fixes a possible
  initialization bug for some platforms when allocating a new usb, and
  changes the warning level on a message (it isn't an error.)  This patch
  was done by Oliver Neukum and David Brownell.

ChangeSet@1.203, 2002-02-05 17:17:14-08:00, greg@kroah.com
  [PATCH] USB stv680 driver update

  Here's a patch against 2.5.3 for the USB stv680 driver that fixes two
  bugs in the existing driver.  This patch was done by Kevin Sisson.

ChangeSet@1.202, 2002-02-05 17:17:11-08:00, greg@kroah.com
  [PATCH] USB printer driver update

  Here's a patch against 2.5.3 for the USB printer driver that does the
  following:
  	- removes the races inherent in sleep_on
  	- uses 2.5 style of module usage counting
  	- kills a lockup on failure of usb_submit_urb
  This patch was done by Oliver Neukum.

ChangeSet@1.201, 2002-02-05 17:17:08-08:00, greg@kroah.com
  [PATCH] USB pegasus driver update

  Here's a patch against 2.5.3 for the USB pegasus driver that does the
  following:
  	- fixes __FUNCTION__ warnings on gcc-3.0.3 and up
  	- added 3 more devices
  	- fixed memory leak
  This patch was done by Petko Manolov and Oliver Neukum.

ChangeSet@1.200, 2002-02-05 17:17:05-08:00, greg@kroah.com
  [PATCH] USB Kaweth driver update

  Here's a patch against 2.5.3 for the USB kaweth driver that does the
  following:
  	- removes SMP deadlock
  	- removes nfs deadlock
  	- fixes a memory leak when the firmware is not loaded.
  	- few other minor cleanups.
  This patch was done by Oliver Neukum.

ChangeSet@1.199, 2002-02-05 17:17:02-08:00, greg@kroah.com
  [PATCH] USB Config.help update

  Here's a patch against 2.5.3 that updates the Config.help entries for
  the USB microtek and hpusbscsi drivers.
  This patch was done by Oliver Neukum.

ChangeSet@1.198, 2002-02-05 17:16:58-08:00, greg@kroah.com
  [PATCH] USB Kawasaki driver maintainer change

  Here's a patch against 2.5.3 that changes the maintainer of the USB
  Kawasaki driver to Oliver Neukum.

ChangeSet@1.197, 2002-02-05 17:11:07-08:00, reiser@namesys.com
  [PATCH] reiserfs patchset, patch 9 of 9 09-64bit_bitops_fix-1.diff

  09-64bit_bitops_fix-1.diff
      Bitopts arguments must be long, not int.

ChangeSet@1.196, 2002-02-05 17:11:04-08:00, reiser@namesys.com
  [PATCH] reiserfs patchset, patch 8 of 9 08-unfinished_rebuildtree_message.diff


  08-unfinished_rebuildtree_message.diff
      Give a proper explanation if unfinished reiserfsck --rebuild-tree
      run on a fs was detected.

ChangeSet@1.195, 2002-02-05 17:11:00-08:00, reiser@namesys.com
  [PATCH] reiserfs patchset, patch 7 of 9 07-remove_nospace_warnings.diff

  07-remove_nospace_warnings.diff
      Do not print scary warnings in out of free space situations.

ChangeSet@1.194, 2002-02-05 17:10:57-08:00, reiser@namesys.com
  [PATCH] reiserfs patchset, patch 6 of 9 06-return_braindamage_removal.diff

  06-return_braindamage_removal.diff
      Kill stupid code like 'goto label ; return 1;'

ChangeSet@1.193, 2002-02-05 17:10:54-08:00, reiser@namesys.com
  [PATCH] reiserfs patchset, patch 5 of 9 05-kernel-reiserfs_fs_h-offset_v2.diff

  05-kernel-reiserfs_fs_h-offset_v2.diff
      Convert erroneous le64_to_cpu to cpu_to_le64

ChangeSet@1.192, 2002-02-05 17:10:50-08:00, reiser@namesys.com
  [PATCH] reiserfs patchset, patch 4 of 9 04-nfs_stale_inode_access.diff

  04-nfs_stale_inode_access.diff
      This is to fix a case where stale NFS handles are correctly detected as
      stale, but inodes assotiated with them are still valid and present in cache,
      hence there is no way to deal with files, these handles are attached to.
      Bug was found and explained by
      Anne Milicia <milicia@missioncriticallinux.com>

ChangeSet@1.191, 2002-02-05 17:10:47-08:00, reiser@namesys.com
  [PATCH] reiserfs patchset, patch 3 of 9 03-key_output_fix.diff

  03-key_output_fix.diff
      Fix all the places where cpu key is attempted to be printed as ondisk key

ChangeSet@1.190, 2002-02-05 17:10:44-08:00, reiser@namesys.com
  [PATCH] reiserfs patchset, patch 2 of 9 02-prealloc_list_init.diff

  02-prealloc_list_init.diff
      prealloc list was forgotten to be initialised.

ChangeSet@1.189, 2002-02-05 17:10:40-08:00, reiser@namesys.com
  [PATCH] reiserfs patchset, patch 1 of 9 01-pick_correct_key_version.diff

  01-pick_correct_key_version.diff
      This is to fix certain cases where items may get its keys to be interpreted
      wrong, or to be inserted into the tree in wrong order. This bug was only
      observed live on 2.5.3, though it is present in 2.4, too.

ChangeSet@1.188, 2002-02-05 16:36:53-08:00, mochel@osdl.org
  [PATCH] driver model updates (5/5)

  Remove struct iobus.

  There is a lot of duplication between struct device and struct iobus, both
  in their members and the code in their interfaces. Waxing struct iobus
  removes this duplication and makes things a bit simpler.

ChangeSet@1.187, 2002-02-05 16:36:53-08:00, mochel@osdl.org
  [PATCH] driver model updates (4/5)

  Patch 4: Add some default files for PCI devices.

  This adds two files for PCI devices: 'irq' and 'resources'. They display
  just those things and currently do nothing on write. These are the
  examples for other subsystems to use for creating files ('Hey, look how
  simple it is!')

ChangeSet@1.186, 2002-02-05 16:36:52-08:00, mochel@osdl.org
  [PATCH] driver model updates (3/5)

  Patch 3: Make default callbacks simpler.

  I want to move as much to a 1 file/1 value model as possible. I haven't
  come up with a clean way to enforce it except via social pressure.

  This patch is a step in that direction. It:

  - Reduces the output of 'power' to just the decimal state of the device
  - Adds a 'name' file which exports just the device name
  - Reduces the 'status' file to just export the bus ID. (This will change,
    since the bus ID is obvious based on what directory you're in, but it's
    another patch at another time)

ChangeSet@1.185, 2002-02-05 16:36:51-08:00, mochel@osdl.org
  [PATCH] driver model updates (1/5)

  Patch 1: Make device_driver_init() an initcall.
  It declares it as subsys_initcall and removes the explicit call from
  init/main.c::do_basic_setup().

ChangeSet@1.184, 2002-02-05 16:36:50-08:00, mec@shout.net
  [PATCH] fix xconfig for new help system

  Here is a patch to enhance xconfig to read the new Config.help files.
  Olaf Dietsche wrote this, and Steven Cole passed it on to me.

  Testing: Steven Cole tested it, and I tested it.

ChangeSet@1.183, 2002-02-05 16:36:50-08:00, knan@mo.himolde.no
  [PATCH] typo in drivers/scsi/megaraid.h

  A trivial patch that fixes this irritation in my dmesg, 2.5.3:

  megaraid: v1.18 (Release Date: Thu Oct 11 15:02:53 EDT 2001
  )<5>megaraid: found 0x8086:0x1960:idx 0:bus 2:slot 5:func 1
  scsi0 : Found a MegaRAID controller at 0xe089c000, IRQ: 12

  Please apply.

ChangeSet@1.182, 2002-02-05 16:36:49-08:00, vandrove@vc.cvut.cz
  [PATCH] nbd in 2.5.3 does not work, and can cause severe damage when read-write

  Hi Linus,
      I've got strange idea and tried to build diskless machine around
  2.5.3... Besides problem with segfaulting crc32 (it is initialized after
  net/ipv4/ipconfig.c due to lib/lib.a being a library... I had to hardcode
  lib/crc32.o before --start-group in main Makefile, but it is another
  story) there is bad problem with NBD caused by BIO changes:

  (1) request flags were immediately put into on-wire request format.
      In the past, we had 0=READ, !0=WRITE. Now only REQ_RW bit determines
      direction. As nbd-server from nbd distribution package treats any
      non-zero value as write, it performs writes instead of read. Fortunately
      it will die due to other consistency checks on incoming request, but...

  (2) nbd servers handle only up to 10240 byte requests. So setting max_sectors
      to 20 is needed, as otherwise nbd server commits suicide. Maximum request size
      should be handshaked during nbd initialization, but currently just use
      hardwired 20 sectors, so it will behave like it did in the past.

ChangeSet@1.181, 2002-02-05 16:36:49-08:00, twaugh@redhat.com
  [PATCH] 2.5.3-pre6: mode

  This patch paves the way for a new driver which needs the
  functionality.  Now parport_daisy_select actually _uses_ its mode
  parameter.

  	* drivers/parport/daisy.c: Make parport_daisy_select aware of
  	its 'mode' parameter.
  	* drivers/parport/ChangeLog: Updated.

ChangeSet@1.180, 2002-02-05 16:36:48-08:00, twaugh@redhat.com
  [PATCH] 2.5.3-pre6: deadlock

  This patch fixes a potential deadlock in ppdev.

  	* drivers/char/ppdev.c: Watch out for errors from
  	parport_claim_or_block.
  	* drivers/parport/share.c: Watch out for signals.
  	* drivers/parport/ChangeLog: Updated.

ChangeSet@1.179, 2002-02-05 16:36:47-08:00, twaugh@redhat.com
  [PATCH] 2.5.3-pre6: console

  I finally found the reason that printer console sometimes acted up
  (duh):

  	* drivers/char/lp.c: Fix printer console.

ChangeSet@1.178, 2002-02-05 16:36:47-08:00, twaugh@redhat.com
  [PATCH] 2.5.3-pre6: getmodes

  This patch prevents ppdev from oopsing when the PPGETMODES ioctl is
  used before a PPCLAIM.

  	* drivers/char/ppdev.c: Fix an oops in PPGETMODES handling.

ChangeSet@1.177, 2002-02-05 16:36:46-08:00, twaugh@redhat.com
  [PATCH] 2.5.3-pre6: ecr

  This patch (from 2.4.x) cleans up the use of the ECR in parport_pc.

  	* drivers/parport/parport_pc.c: Integrate fixes and cleanups
  	from Damian Gruszka (VScom).
  	* drivers/parport/ChangeLog: Updated.

ChangeSet@1.176, 2002-02-05 16:36:45-08:00, davem@redhat.com
  [PATCH] Sparc updates

  Gets sparc64 in sync with 2.5.3 final changes.

ChangeSet@1.175, 2002-02-05 16:36:44-08:00, davem@redhat.com
  [PATCH] Missing ZLIB export

ChangeSet@1.174, 2002-02-05 16:36:44-08:00, davem@redhat.com
  [PATCH] Fix UFS build

  Missing smp_lock.h inclusion.

ChangeSet@1.173, 2002-02-05 16:36:43-08:00, davem@redhat.com
  [PATCH] malloc.h references

  linux/malloc.h --> linux/slab.h

ChangeSet@1.172, 2002-02-05 16:36:42-08:00, davem@redhat.com
  [PATCH] Fix typo in i386 PCI header

  I made a typo the other weeks while renaming the interfaces for you,
  oops.  Please apply, thanks.

ChangeSet@1.171, 2002-02-05 16:36:42-08:00, davem@redhat.com
  [PATCH] OSST kdev_t fixes

  MINOR --> minor
  MKDEV --> mk_kdev

ChangeSet@1.170, 2002-02-05 16:36:41-08:00, davem@redhat.com
  [PATCH] Fix IDE printf formatting

  The usual "u64 is long long only on some platforms" problem.

ChangeSet@1.169, 2002-02-05 16:36:40-08:00, davem@redhat.com
  [PATCH] Fix ESP thinko in 2.5.3-final

  I think I told you to revert this bit from 2.5.3, but here
  it is in patch form anyways.  Whoever made this change didn't
  read the driver, and well... didn't even build test it either :-)

ChangeSet@1.168, 2002-02-05 16:36:40-08:00, davem@redhat.com
  [PATCH] Dup in drivers/net/Config.in

  Don't offer SunLANCE twice.


