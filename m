Return-Path: <linux-kernel-owner+w=401wt.eu-S1753823AbWLWWgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbWLWWgK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 17:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753831AbWLWWgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 17:36:10 -0500
Received: from hera.kernel.org ([140.211.167.34]:50168 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823AbWLWWgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 17:36:09 -0500
Date: Sat, 23 Dec 2006 22:36:04 +0000
From: Willy Tarreau <wtarreau@hera.kernel.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Linux 2.4.34 released
Message-ID: <20061223223604.GA13010@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I finally managed to update my release scripts to safely produce a
final release, so I have released a 2.4.34 identical to -rc4, which
added just a security fix to -rc3. Complete changelog appended.
I've also released 2.4.33.7 with the same fix for those still
tracking 2.4.33.x.

Depending on the load on the servers here, it might take some time
before 2.4.34 shows up on www.kernel.org. Also, _please_ only use
www2.kernel.org, which is less loaded than www1.

For those who did not track the pre-releases, 2.4.34 brings the usual
bunch of security fixes, bugfixes, and adds support for gcc 4 to x86,
x86-64 and sparc64, thanks to Mikael Pettersson's work. What I did
not expect first is that it seems to ease the maintenance job for some
subsystem maintainers who mostly work on 2.6 right now.

One user reported regular panics with aacraid since 2.4.32, so there's
no regression here. I will seek for some help to get this fixed in
2.4.35. I also get reports of people getting trapped by NIC vendors
who suddenly change their ethernet chips with no big warning notice.
The i82546GB chip which replaced the i82546EB in e1000 cards come to
mind. It is not supported by the driver in 2.4.34 but I will try to
solve this in 2.4.35 (right now, you have to download the vendor's
drivers when you replace a NIC).

Another driver should get some lifting : skge. I have got a few
reports of problems with the vendor's sk98lin driver and I noticed
the same problems at work (UDP becoming silent on NFS server). I
already have adapted Stephen Hemminger's backport for a merge, and
it seems to work correctly on my personal kernels. Stephen kindly
offered to help me get this driver in sync with 2.6, which will fix
problems for people who previously had problems with the vendor's
driver, and it will ease further maintenance.

I also received a request to merge the gcc 4 fixes for mips, but the
patch came as a big chunk. I might consider reviewing it later when
I have time. I should also merge most of the typo fixes that Mariusz
Kozlowski sent me.

Concerning the 2.4.X.Y tree, as Greg recommended to me, I will
create a different git repository for 2.4.34.Y, and will probably
do a little cleanup in the existing branches. It will be easier
to release stable kernels that way. I don't think I will still
provide 2.4.33.Y trees, unless it does not take me more time and
there is real and justified demand.

Last but not least, a really big thanks to Grant Coady who saves
me some CPU (and human) time by building and testing all the
pre-releases on several machines, and who then puts the results
online.

Best regards,
Willy

---- complete 2.4.33 - 2.4.34 changelog ---

final:
 - v2.4.34-rc4 was released as 2.4.34 with no changes.

Summary of changes from v2.4.34-rc3 to v2.4.34-rc4
============================================

Marcel Holtmann (1):
      Call init_timer() for ISDN PPP CCP reset state timer (CVE-2006-5749)

Willy Tarreau (1):
      Change VERSION to 2.4.34-rc4

Summary of changes from v2.4.34-rc2 to v2.4.34-rc3
============================================

Hugh Dickins (1):
      zeromap may find a pte

Linus Torvalds (1):
      Fix incorrect user space access locking in mincore() (CVE-2006-4814)

Willy Tarreau (1):
      Change VERSION to 2.4.34-rc3

Summary of changes from v2.4.34-rc1 to v2.4.34-rc2
============================================

Marcel Holtmann (1):
      [Bluetooth] Add packet size checks for CAPI messages (CVE-2006-6106)

Willy Tarreau (1):
      Change VERSION to 2.4.34-rc2

Summary of changes from v2.4.34-pre6 to v2.4.34-rc1
============================================

dann frazier (1):
      smbfs : don't ignore uid/gid/mode mount opts w/ unix extensions

Jean Delvare (6):
      i2c cleanup : typos and whitespace
      i2c cleanup : dead code removal
      i2c cleanup : c99 struct init
      i2c cleanup : simplify code
      i2c cleanup : resync algo ids
      i2c cleanup : warning fix

Oliver Neukum (2):
      fix for transient error in usb printer driver
      task stte leak in pegasus usb driver

Ralf Baechle (1):
      Masking bug in 6pack driver

Shaohua Li (1):
      x86 microcode: dont check the size

Willy Tarreau (8):
      rio: typo in bitwise AND expression.
      flashpoint: use '!' instead of '~' with EE_SYNC_MASK
      jfs: incorrect use of "&&" instead of "&"
      arm: incorrect use of "&&" instead of "&"
      e100: incorrect use of "&&" instead of "&"
      ps2esdi: typo may cause premature timeout
      fbcon: incorrect use of "&&" instead of "&"
      Change VERSION to 2.4.34-rc1

Summary of changes from v2.4.34-pre5 to v2.4.34-pre6
============================================

Jean Delvare (5):
      [PATCH][I2C] update web site address and contacts
      [PATCH][I2C] do not ignore error when returning from i2c_add_adapter()
      [PATCH][I2C] i2c-matroxfb: Struct init conversion
      [PATCH][I2C] Fix copy-n-paste error in i2c Config.in.
      [PATCH][I2C] remove non-existing functions declarations.

NeilBrown (1):
      knfsd: Fix race that can disable NFS server.

Willy Tarreau (12):
      [PATCH-2.4] i2c-elv: fix erroneous '&&' operator
      fix "&& 0xffff" typo in gdth.c
      fix obvious "&& 0xFFFFFF" typo in cpqfcTSworker
      fix "&& 0xff" typo in qeth_qdio_input_handler
      fix two "&& 0x03" in usbnet
      EXT3: avoid crashing by not dividing by zero.
      EXT2: avoid crashing by not dividing by zero.
      [GCC4] fix build error in arch/alpha/kernel/osf_sys.c
      [GCC4] fix build error in arch/alpha/kernel/irq.c
      [GCC4] fix build error in arch/alpha/lib/io.c
      [GCC4] fix build error in arch/alpha/math-emu/math.c
      Change VERSION to 2.4.34-pre6

Summary of changes from v2.4.34-pre4 to v2.4.34-pre5
============================================

Akinobu Mita (1):
      WATCHDOG: sc1200wdt.c pnp unregister fix.

Dick Streefland (1):
      incorrect timeout in mtd AMD driver of 2.4 kernel

Herbert Xu (1):
      SCTP: Always linearise packet on input

Jeff Garzik (1):
      ISDN: fix drivers, by handling errors thrown by ->readstat()

Martin Schwidefsky (3):
      copy_from_user information leak on s390.
      s390 : fix typo in recent copy_from_user fix
      [S390] user readable uninitialised kernel memory (3rd version)

Patrick McHardy (1):
      [NETFILTER]: Fix deadlock on NAT helper unload

Stephen Hemminger (1):
      [BRIDGE]: netfilter deadlock

Willy Tarreau (3):
      i386: remove unsigned long long cast in __pte() macro.
      2.4.x: i386/x86_64 bitops clobberings
      Change VERSION to 2.4.34-pre5

Summary of changes from v2.4.34-pre3 to v2.4.34-pre4
============================================

dann frazier:
      Backport fix for CVE-2006-4997 to 2.4 tree

Geert Uytterhoeven:
      fbdev: correct buffer size limit in fbmem_read_proc()

Jurzitza, Dieter:
      really fix size display for sun partitions larger than 1TByte

Michael Chen:
      i386: fix overflow in vmap on an x86 system which has more than 4GB memory.

mostrows@earthlink.net:
      Advertise PPPoE MTU

PaX Team:
      MIPS: fix long long cast in pte macro
      MIPS: fix long long cast in pte macro
      i386: fix long long cast in pte macro

Steffen Maier:
      block: fix negative bias of ios_in_flight (CONFIG_BLK_STATS) because of unbalanced I/O accounting

Toyo Abe:
      x86_64: Fix missing delay when the TSC counter just overflowed

Willy Tarreau:
      fix Configure.help concerning rp_filter
      Revert "MIPS: fix long long cast in pte macro"
      Change VERSION to 2.4.34-pre4

Summary of changes from v2.4.34-pre2 to v2.4.34-pre3
============================================

Mikael Pettersson:
      [GCC4] SPARC64: fix UP build error in arch/sparc64/mm/init.c

Willy Tarreau:
      [GCC4] add preliminary support for GCC 4 (Mikael Pettersson)
      [GCC4] fix build error in include/linux/generic_serial.h
      [GCC4] fix build error in include/net/irda/qos.h
      [GCC4] fix build error in include/linux/fsfilter.h
      [GCC4] fix build error in include/linux/intermezzo_fs.h
      [GCC4] fix build error in include/net/udp.h
      [GCC4] fix build error in include/net/irda/irttp.h
      [GCC4] fix build error in include/net/irda/irlan_event.h
      [GCC4] fix build error in include/asm-ppc/spinlock.h
      [GCC4] fix build error in fs/intermezzo/presto.c
      [GCC4] fix build error in net/ipv6/ip6_fib.c
      [GCC4] fix build error in net/ipv6/sysctl_net_ipv6.c
      [GCC4] fix build error in net/khttpd/prototypes.h
      [GCC4] fix build error in drivers/block/nbd.c
      [GCC4] fix build error in drivers/block/xd.c
      [GCC4] fix build error in drivers/block/paride/pd.c
      [GCC4] fix build error in drivers/char/sonypi.h
      [GCC4] fix build error in drivers/char/sonypi.h
      [GCC4] fix build error in drivers/char/tpqic02.c
      [GCC4] fix build error in drivers/char/drm-4.0/drmP.h
      [GCC4] fix build error in drivers/char/rio/rio_linux.c
      [GCC4] fix build error in drivers/net/acenic.c
      [GCC4] fix build error in drivers/net/wan/comx.h
      [GCC4] fix build error in drivers/net/3c507.c
      [GCC4] fix build error in drivers/net/arlan.c
      [GCC4] fix build error in drivers/net/irda/donauboe.c
      [GCC4] fix build error in drivers/net/sk98lin/skvpd.c
      [GCC4] fix build error in drivers/net/wan/comx-hw-comx.c
      [GCC4] fix build error in drivers/net/wan/sdladrv.c
      [GCC4] fix build error in drivers/net/wan/sdlamain.c
      [GCC4] fix build error in drivers/net/wan/sdla_fr.c
      [GCC4] fix build error in drivers/net/hamradio/baycom_epp.c
      [GCC4] fix build error in drivers/net/hamradio/soundmodem/sm.h
      [GCC4] fix build error in drivers/scsi/advansys.c
      [GCC4] fix build error in drivers/scsi/atp870u.c
      [GCC4] fix build error in drivers/scsi/cpqfcTS*
      [GCC4] fix build error in drivers/ide/legacy/hd.c
      [GCC4] fix build error in drivers/cdrom/sbpcd.c
      [GCC4] fix build error in drivers/md/lvm-internal.h
      [GCC4] fix build error in drivers/atm/iphase.c
      [GCC4] fix build error in drivers/atm/fore200e.c
      [GCC4] fix build error in drivers/isdn/eicon/eicon.h
      [GCC4] fix build error in drivers/isdn/hisax/hfc_pci.c
      [GCC4] fix build error in drivers/i2c/i2c-core.c
      [GCC4] fix build error in drivers/i2c/i2c-proc.c
      [GCC4] fix build error in drivers/media/video/videodev.c
      [GCC4] fix build error in drivers/usb/audio.c
      [GCC4] fix build error in drivers/ieee1394/highlevel.c
      [GCC4] fix build error in drivers/media/video/bttvp.h
      [GCC4] fix build error in drivers/sound/wavfront.c
      [GCC4] fix warning in include/linux/atalk.h
      [GCC4] fix warnings in include/linux/isdnif.h
      [GCC4] fix warnings in include/net/dn_dev.h
      [GCC4] fix warnings in include/net/dn_nsp.h
      [GCC4] fix warnings in sdla.h and if_frad.h
      [GCC4] fix warnings in sdla_x25.c and sdla_x25.h
      [GCC4] fix warnings in include/linux/wanpipe.h
      [GCC4] fix warnings in drivers/char/sx.c
      [GCC4] fix warning in drivers/char/ip2/i2lib.c
      [GCC4] fix warnings in drivers/net/de4x5,depca,arcnet
      [GCC4] fix warnings in drivers/isdn/eicon/eicon*.h
      [GCC4] fix warnings in drivers/isdn/hisax/hisax.h
      [GCC4] fix build in drivers/atm/horizon.c
      [GCC4] fix build error in drivers/net/rrunner.c
      [GCC4] SPARC64: fix build error in arch/sparc64/kernel/smp.c
      [GCC4] SPARC64: fix build error in arch/sparc64/kernel/time.c
      [GCC4] SPARC64: fix build error in drivers/sbus/char/pcikbd.c
      [GCC4] SPARC: fix build error in arch/sparc/kernel/signal.c
      [GCC4] SPARC: fix build error in arch/sparc/kernel/time.c
      [GCC4] SPARC: fix build error in drivers/fc4/soc.c
      Merge branch 'gcc4'
      Change VERSION to 2.4.34-pre3

Summary of changes from v2.4.34-pre1 to v2.4.34-pre2
============================================

dann frazier:
      drivers/scsi/sg.c : fix CVE-2006-1528
      [SCTP] Fix sctp_primitive_ABORT() call in sctp_close()
      Fix possible UDF deadlock and memory corruption (CVE-2006-4145)

Ernie Petrides:
      binfmt_elf.c : fix checks for bad address

Jeff Mahoney:
      [DISKLABEL] SUN: Fix signed int usage for sector count

PaX Team:
      cciss: do not mark cciss_scsi_detect __init
      i386 : fix exception processing in early boot

Solar Designer:
      crypto : prevent cryptoloop from oopsing on stupid ciphers
      loop.c: kernel_thread() retval check

Sridhar Samudrala:
      [SCTP] Local privilege elevation - CVE-2006-3745

Willy Tarreau:
      powerpc: Clear HID0 attention enable on PPC970 at boot time
      Revert "export memchr() which is used by smbfs and lp driver."
      [SPARC] export memchr() which is used by smbfs and lp driver.
      Change VERSION to 2.4.34-pre2

Summary of changes from v2.4.33 to v2.4.34-pre1
============================================

Jeff Layton:
      2.4 NFS client - update d_cache when server reports ENOENT on an NFS remove

Jukka Partanen:
      Fix AVM C4 ISDN card init problems with newer CPUs

Pete Zaitcev:
      Bug with USB proc_bulk in 2.4 kernel
      USB: Little Rework for usbserial
      USB: unsigned long flags

Willy Tarreau:
      [BLKMTD] : missing offset sometimes causes panics
      AVM C4 ISDN card : use cpu_relax() in busy loops
      [PKTGEN] : fix an oops when used with bonding driver (Tien ChenLi)
      export memchr() which is used by smbfs and lp driver.
      Merge branch 'next'
      Change VERSION to 2.4.34-pre1

