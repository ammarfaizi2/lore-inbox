Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWEPOlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWEPOlT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWEPOlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:41:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15773 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751167AbWEPOlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:41:16 -0400
Date: Tue, 16 May 2006 07:37:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Stian B. Barmen" <stian@barmen.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ide hdma dma_timer_expiry
Message-Id: <20060516073756.7ed63eb9.akpm@osdl.org>
In-Reply-To: <ZULUfWoqFXfyY0QUUBP00000043@zulu.barmen.nu>
References: <20060516071541.1072c360.akpm@osdl.org>
	<ZULUfWoqFXfyY0QUUBP00000043@zulu.barmen.nu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stian B. Barmen" <stian@barmen.nu> wrote:
>
> > Can I confirm that 2.6.16.15 is bad and 2.6.16.4 is OK?  Or 
>  > did you mean
>  > 2.6.15.4 there?
>  > 
> 
>  Yes, 2.6.16.4 i OK and working, the problem is on 2.6.16.15 and I mean that
>  I had the same problem on an earlier 2.6.16 kernel aswell, but I am not
>  certain about the version. 
> 
>  For now I have to reboot to 2.6.16.4 because we have holiday in Norway
>  tomorrow and I cannot guard the server. 

Strange.  The 2.6.16.4 -> 2.6.16.15 diff is at
http://www.zip.com.au/~akpm/linux/patches/stuff/2 and the diffstat is
below.  It's hard to see anything in there which would cause IDE IRQ
handling to go bad every 24 hours or so.

/dev/hdi is on the Promise controller, yes?

VIA chipsets have been troublesome - it could be a problem in that area
rather than in IDE.

It'd be interesting to test 2.6.17-rc4, but I'm not sure what that'll tell
us either way.

Probably a better use of your time (if you have any) would be to search
through 2.6.16.4 ...  2.6.16.15, see which version broke it.


 Documentation/dvb/get_dvb_firmware           |    8 
 Makefile                                     |    2 
 arch/alpha/kernel/setup.c                    |   17 +
 arch/alpha/kernel/smp.c                      |    8 
 arch/alpha/lib/strncpy.S                     |    8 
 arch/i386/kernel/apm.c                       |    2 
 arch/i386/kernel/cpu/amd.c                   |    2 
 arch/i386/kernel/vm86.c                      |   12 +
 arch/m32r/kernel/m32r_ksyms.c                |    4 
 arch/m32r/kernel/setup.c                     |   12 -
 arch/m32r/kernel/smpboot.c                   |   19 +
 arch/m32r/lib/Makefile                       |    4 
 arch/m32r/lib/getuser.S                      |   88 --------
 arch/m32r/lib/putuser.S                      |   84 --------
 arch/mips/kernel/branch.c                    |    2 
 arch/mips/mm/c-r4k.c                         |    3 
 arch/powerpc/kernel/setup_64.c               |   10 -
 arch/powerpc/kernel/signal_64.c              |    2 
 arch/x86_64/ia32/Makefile                    |    4 
 arch/x86_64/kernel/entry.S                   |   28 +-
 arch/x86_64/kernel/pci-gart.c                |    4 
 arch/x86_64/kernel/process.c                 |    8 
 arch/x86_64/kernel/setup.c                   |    4 
 block/genhd.c                                |  103 +---------
 drivers/block/cciss.c                        |   96 ++++-----
 drivers/char/agp/efficeon-agp.c              |    8 
 drivers/char/cs5535_gpio.c                   |    5 
 drivers/char/ipmi/ipmi_bt_sm.c               |    2 
 drivers/char/snsc.c                          |    3 
 drivers/char/sonypi.c                        |    3 
 drivers/char/tipar.c                         |    2 
 drivers/char/tlclk.c                         |   36 +--
 drivers/char/tty_io.c                        |    8 
 drivers/edac/Kconfig                         |    2 
 drivers/i2c/busses/i2c-i801.c                |    5 
 drivers/i2c/chips/m41t00.c                   |    8 
 drivers/ide/pci/alim15x3.c                   |    2 
 drivers/macintosh/therm_adt746x.c            |    4 
 drivers/md/dm-snap.c                         |    6 
 drivers/md/dm.c                              |    5 
 drivers/md/kcopyd.c                          |   17 +
 drivers/media/dvb/dvb-usb/cxusb.c            |   17 +
 drivers/media/video/saa7127.c                |    1 
 drivers/mtd/nand/Kconfig                     |   17 -
 drivers/net/e1000/e1000_main.c               |    1 
 drivers/net/sky2.c                           |    4 
 drivers/net/sky2.h                           |    1 
 drivers/scsi/3w-9xxx.c                       |    8 
 drivers/scsi/3w-xxxx.c                       |    3 
 drivers/usb/serial/console.c                 |    2 
 drivers/usb/serial/option.c                  |    4 
 drivers/usb/storage/Kconfig                  |    3 
 drivers/video/fbmem.c                        |   14 +
 fs/char_dev.c                                |   87 +-------
 fs/cifs/cifsencrypt.c                        |   36 ++-
 fs/cifs/dir.c                                |   14 +
 fs/compat.c                                  |    4 
 fs/ext3/resize.c                             |    1 
 fs/fuse/file.c                               |    8 
 fs/locks.c                                   |    9 
 fs/open.c                                    |   24 ++
 fs/partitions/check.c                        |    5 
 fs/proc/base.c                               |   21 +-
 fs/proc/proc_misc.c                          |  161 +++-------------
 fs/reiserfs/xattr_acl.c                      |    5 
 fs/smbfs/dir.c                               |    5 
 fs/xfs/linux-2.6/xfs_iops.c                  |    3 
 include/asm-i386/cpufeature.h                |    1 
 include/asm-i386/i387.h                      |   30 ++-
 include/asm-i386/pgtable-2level.h            |    3 
 include/asm-i386/pgtable-3level.h            |   20 ++
 include/asm-i386/pgtable.h                   |    4 
 include/asm-m32r/smp.h                       |    3 
 include/asm-m32r/uaccess.h                   |  266 +++++++++++----------------
 include/asm-mips/bitops.h                    |   14 +
 include/asm-mips/byteorder.h                 |    4 
 include/asm-mips/interrupt.h                 |    8 
 include/asm-mips/r4kcache.h                  |    2 
 include/asm-x86_64/cpufeature.h              |    1 
 include/asm-x86_64/i387.h                    |   20 +-
 include/linux/cpumask.h                      |    1 
 include/linux/fs.h                           |   15 -
 include/linux/mm.h                           |    5 
 include/linux/page-flags.h                   |    8 
 include/net/ip.h                             |    1 
 include/net/sctp/structs.h                   |    1 
 ipc/shm.c                                    |    2 
 ipc/util.c                                   |    3 
 kernel/auditsc.c                             |    5 
 kernel/power/process.c                       |    3 
 kernel/ptrace.c                              |    7 
 kernel/signal.c                              |    5 
 kernel/sys.c                                 |   14 +
 kernel/uid16.c                               |   59 ++++-
 mm/madvise.c                                 |    3 
 mm/page_alloc.c                              |   31 +--
 net/atm/clip.c                               |   42 ++--
 net/bridge/br_netfilter.c                    |   13 +
 net/core/dev.c                               |    2 
 net/ipv4/ip_output.c                         |    6 
 net/ipv4/netfilter/ip_conntrack_proto_sctp.c |   11 -
 net/ipv4/route.c                             |    5 
 net/ipv4/tcp_output.c                        |    4 
 net/ipv6/exthdrs.c                           |   12 +
 net/ipv6/xfrm6_policy.c                      |    8 
 net/netfilter/nf_conntrack_proto_sctp.c      |   11 -
 net/sctp/inqueue.c                           |    1 
 net/sctp/sm_statefuns.c                      |   57 ++++-
 net/sctp/sm_statetable.c                     |   10 -
 net/sctp/ulpqueue.c                          |   27 ++
 security/selinux/ss/mls.c                    |    2 
 sound/oss/dmasound/tas_common.c              |    4 
 sound/ppc/daca.c                             |    2 
 sound/ppc/tumbler.c                          |    2 
 114 files changed, 906 insertions(+), 960 deletions(-)

