Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290247AbSAXUpV>; Thu, 24 Jan 2002 15:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290255AbSAXUpN>; Thu, 24 Jan 2002 15:45:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21252 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290247AbSAXUo6> convert rfc822-to-8bit; Thu, 24 Jan 2002 15:44:58 -0500
Date: Thu, 24 Jan 2002 12:43:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.3-pre5 - Configurator updates
Message-ID: <Pine.LNX.4.33.0201241233230.8207-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g0OKiRS13877
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Due to a private flame-war about configuration options and behaviour, I
just broke down and did the thing I had asked for from others for a long
time - split up the huge unwieldly "Configure.help" file into many smaller
ones that are closer to the option they describe.

The split was largely automated, with one 25-thousand line file being
split up into almost 100 smaller files. The placement was also entirely
automated, and basically moved each entry to the same subdirectory where
the config question for that entry was located (and if the question was
duplicated over several places, the help was duplicated too).

This should make it _much_ easier to have things like per-architecture
config entries that the rest of the world simply doesn't want to know
about and has no interest in.

[ The automated nature of the split also showed that some questions are
  sometimes oddly placed. Some minimal movement was done to fix the worst
  offenders, but hopefully we can organize some of it more logically in
  the future. ]

However, I would ask that maintainers of config tools, drivers and
architectures would check that their config help entries still exist, and
seem to work. Of the tools, only the basic "make config" script has been
updated to know about the change in location, so menuconfig/xconfig simply
will not find the help right now.

Oh, non-x86 architectures probably need to fix up their config menu
entries too, as I only did a minimal "move architecture-common entries to
init/Config.in" edit (to not duplicate all the questions/help messages
that are common to all architectures), and I'm absolutely positive that
the menu structure didn't move correctly.

Other changes tend to get overwhelmed in the patch (happily it's not every
day that you clean up the largest file in the whole archive), but
ChangeLog appended so you can see what else happened.

		Linus

-----
pre5:
 - Patrick Mochel: devicefs locking cleanups, refcount fixes
 - Brian Gerst: apic timer cleanup
 - Adam Richter: fix loop over block device bio breakage, ipfwadm compile fix
 - me: split up Configure.help over the subdirectories where it is used
 - Peter Anvin: bootproto v2.03
 - Jeff Garzik: net driver updates
 - NIIBE Yutaka: SuperH update

pre4:
 - Patrick Mochel: initcall levels
 - Patrick Mochel: devicefs updates, add PCI devices into the hierarchy
 - Denis Oliver Kropp: neomagic fb driver
 - David Miller: sparc64 and network updates
 - Kai Mäkisara: scsi tape update
 - Al Viro: more inode trimming, VFS cleanup
 - Greg KH: USB update - proper urb allocations
 - Eric Raymond: kdev_t updates for fb devices

pre3:
 - Al Viro: VFS inode allocation moved down to filesystem, trim inodes
 - Greg KH: USB update, hotplug documentation
 - Kai Germaschewski: ISDN update
 - Ingo Molnar: scheduler tweaking ("J2")
 - Arnaldo: emu10k kdev_t updates
 - Ben Collins: firewire updates
 - Björn Wesen: cris arch update
 - Hal Duston: ps2esdi driver bio/kdev_t fixes
 - Jean Tourrilhes: move wireless drivers into drivers/net/wireless,
   update wireless API #1
 - Richard Gooch: devfs race fix
 - OGAWA Hirofumi: FATFS update

pre2:
 - David Howells: abtract out "current->need_resched" as "need_resched()"
 - Frank Davis: ide-tape update for bio
 - various: header file fixups
 - Jens Axboe: fix up bio/ide/highmem issues
 - Kai Germaschewski: ISDN update
 - Greg KH: USB and Compaq PCI hotplug updates
 - Tim Waugh: parport update

pre1:
 - Al Viro: fix up silly problem in swapfile filp cleanups in 2.5.2
 - Tachino Nobuhiro: fix another error return for swapfile filp code
 - Robert Love: merge some of Ingo's scheduler fixes
 - David Miller: networking, sparc and some scsi driver fixes
 - Tim Waugh: parport update
 - OGAWA Hirofumi: fatfs cleanups and bugfixes
 - Roland Dreier: fix vsscanf buglets.
 - Ben LaHaise: include file cleanup
 - Andre Hedrick: IDE taskfile update

