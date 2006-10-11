Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161412AbWJKVGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161412AbWJKVGc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161417AbWJKVGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:06:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:54431 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161409AbWJKVGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:06:16 -0400
Date: Wed, 11 Oct 2006 14:05:28 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Woodhouse <dwmw2@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 23/67] One line per header in Kbuild files to reduce conflicts
Message-ID: <20061011210528.GX16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0001-HEADERS-One-line-per-header-in-Kbuild-files-to-reduce-conflicts.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Woodhouse <dwmw2@infradead.org>

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/Kbuild                        |   11 
 include/asm-alpha/Kbuild              |   10 
 include/asm-generic/Kbuild            |   15 +
 include/asm-generic/Kbuild.asm        |   38 ++-
 include/asm-i386/Kbuild               |    9 
 include/asm-ia64/Kbuild               |   18 +
 include/asm-powerpc/Kbuild            |   45 +++
 include/asm-s390/Kbuild               |   11 
 include/asm-sparc/Kbuild              |   24 +-
 include/asm-sparc64/Kbuild            |   27 +-
 include/asm-x86_64/Kbuild             |   18 +
 include/linux/Kbuild                  |  400 ++++++++++++++++++++++++++++------
 include/linux/byteorder/Kbuild        |    9 
 include/linux/dvb/Kbuild              |   11 
 include/linux/netfilter/Kbuild        |   47 +++
 include/linux/netfilter_arp/Kbuild    |    5 
 include/linux/netfilter_bridge/Kbuild |   21 +
 include/linux/netfilter_ipv4/Kbuild   |   82 +++++-
 include/linux/netfilter_ipv6/Kbuild   |   27 +-
 include/linux/nfsd/Kbuild             |    9 
 include/linux/raid/Kbuild             |    3 
 include/linux/sunrpc/Kbuild           |    2 
 include/linux/tc_act/Kbuild           |    5 
 include/linux/tc_ematch/Kbuild        |    5 
 include/mtd/Kbuild                    |    8 
 include/rdma/Kbuild                   |    2 
 include/scsi/Kbuild                   |    4 
 include/sound/Kbuild                  |   12 -
 include/video/Kbuild                  |    2 
 29 files changed, 721 insertions(+), 159 deletions(-)

--- linux-2.6.18.orig/include/Kbuild
+++ linux-2.6.18/include/Kbuild
@@ -1,2 +1,9 @@
-header-y += asm-generic/ linux/ scsi/ sound/ mtd/ rdma/ video/
-header-y += asm-$(ARCH)/ 
+header-y += asm-generic/
+header-y += linux/
+header-y += scsi/
+header-y += sound/
+header-y += mtd/
+header-y += rdma/
+header-y += video/
+
+header-y += asm-$(ARCH)/
--- linux-2.6.18.orig/include/asm-alpha/Kbuild
+++ linux-2.6.18/include/asm-alpha/Kbuild
@@ -1,5 +1,11 @@
 include include/asm-generic/Kbuild.asm
 
-unifdef-y += console.h fpu.h sysinfo.h compiler.h
+header-y += gentrap.h
+header-y += regdef.h
+header-y += pal.h
+header-y += reg.h
 
-header-y += gentrap.h regdef.h pal.h reg.h
+unifdef-y += console.h
+unifdef-y += fpu.h
+unifdef-y += sysinfo.h
+unifdef-y += compiler.h
--- linux-2.6.18.orig/include/asm-generic/Kbuild
+++ linux-2.6.18/include/asm-generic/Kbuild
@@ -1,3 +1,12 @@
-header-y += atomic.h errno-base.h errno.h fcntl.h ioctl.h ipc.h mman.h \
-	signal.h statfs.h
-unifdef-y := resource.h siginfo.h
+header-y += atomic.h
+header-y += errno-base.h
+header-y += errno.h
+header-y += fcntl.h
+header-y += ioctl.h
+header-y += ipc.h
+header-y += mman.h
+header-y += signal.h
+header-y += statfs.h
+
+unifdef-y += resource.h
+unifdef-y += siginfo.h
--- linux-2.6.18.orig/include/asm-generic/Kbuild.asm
+++ linux-2.6.18/include/asm-generic/Kbuild.asm
@@ -1,8 +1,34 @@
-unifdef-y += a.out.h auxvec.h byteorder.h errno.h fcntl.h ioctl.h	\
-	ioctls.h ipcbuf.h mman.h msgbuf.h param.h poll.h		\
-	posix_types.h ptrace.h resource.h sembuf.h shmbuf.h shmparam.h	\
-	sigcontext.h siginfo.h signal.h socket.h sockios.h stat.h	\
-	statfs.h termbits.h termios.h types.h unistd.h user.h
+unifdef-y += a.out.h
+unifdef-y += auxvec.h
+unifdef-y += byteorder.h
+unifdef-y += errno.h
+unifdef-y += fcntl.h
+unifdef-y += ioctl.h
+unifdef-y += ioctls.h
+unifdef-y += ipcbuf.h
+unifdef-y += mman.h
+unifdef-y += msgbuf.h
+unifdef-y += param.h
+unifdef-y += poll.h
+unifdef-y += posix_types.h
+unifdef-y += ptrace.h
+unifdef-y += resource.h
+unifdef-y += sembuf.h
+unifdef-y += shmbuf.h
+unifdef-y += sigcontext.h
+unifdef-y += siginfo.h
+unifdef-y += signal.h
+unifdef-y += socket.h
+unifdef-y += sockios.h
+unifdef-y += stat.h
+unifdef-y += statfs.h
+unifdef-y += termbits.h
+unifdef-y += termios.h
+unifdef-y += types.h
+unifdef-y += unistd.h
+unifdef-y += user.h
 
 # These probably shouldn't be exported
-unifdef-y += elf.h page.h
+unifdef-y += shmparam.h
+unifdef-y += elf.h
+unifdef-y += page.h
--- linux-2.6.18.orig/include/asm-i386/Kbuild
+++ linux-2.6.18/include/asm-i386/Kbuild
@@ -1,5 +1,10 @@
 include include/asm-generic/Kbuild.asm
 
-header-y += boot.h debugreg.h ldt.h ucontext.h
+header-y += boot.h
+header-y += debugreg.h
+header-y += ldt.h
+header-y += ucontext.h
 
-unifdef-y += mtrr.h setup.h vm86.h
+unifdef-y += mtrr.h
+unifdef-y += setup.h
+unifdef-y += vm86.h
--- linux-2.6.18.orig/include/asm-ia64/Kbuild
+++ linux-2.6.18/include/asm-ia64/Kbuild
@@ -1,7 +1,17 @@
 include include/asm-generic/Kbuild.asm
 
-header-y += break.h fpu.h fpswa.h gcc_intrin.h ia64regs.h		\
-	 intel_intrin.h intrinsics.h perfmon_default_smpl.h	\
-	 ptrace_offsets.h rse.h setup.h ucontext.h
+header-y += break.h
+header-y += fpu.h
+header-y += fpswa.h
+header-y += gcc_intrin.h
+header-y += ia64regs.h
+header-y += intel_intrin.h
+header-y += intrinsics.h
+header-y += perfmon_default_smpl.h
+header-y += ptrace_offsets.h
+header-y += rse.h
+header-y += setup.h
+header-y += ucontext.h
 
-unifdef-y += perfmon.h ustack.h
+unifdef-y += perfmon.h
+unifdef-y += ustack.h
--- linux-2.6.18.orig/include/asm-powerpc/Kbuild
+++ linux-2.6.18/include/asm-powerpc/Kbuild
@@ -1,10 +1,41 @@
 include include/asm-generic/Kbuild.asm
 
-unifdef-y += a.out.h asm-compat.h bootx.h byteorder.h cputable.h elf.h	\
-	nvram.h param.h posix_types.h ptrace.h seccomp.h signal.h	\
-	termios.h types.h unistd.h
+header-y += auxvec.h
+header-y += ioctls.h
+header-y += mman.h
+header-y += sembuf.h
+header-y += siginfo.h
+header-y += stat.h
+header-y += errno.h
+header-y += ipcbuf.h
+header-y += msgbuf.h
+header-y += shmbuf.h
+header-y += socket.h
+header-y += termbits.h
+header-y += fcntl.h
+header-y += ipc.h
+header-y += poll.h
+header-y += shmparam.h
+header-y += sockios.h
+header-y += ucontext.h
+header-y += ioctl.h
+header-y += linkage.h
+header-y += resource.h
+header-y += sigcontext.h
+header-y += statfs.h
 
-header-y += auxvec.h ioctls.h mman.h sembuf.h siginfo.h stat.h errno.h	\
-	ipcbuf.h msgbuf.h shmbuf.h socket.h termbits.h fcntl.h ipc.h	\
-	poll.h shmparam.h sockios.h ucontext.h ioctl.h linkage.h	\
-	resource.h sigcontext.h statfs.h
+unifdef-y += a.out.h
+unifdef-y += asm-compat.h
+unifdef-y += bootx.h
+unifdef-y += byteorder.h
+unifdef-y += cputable.h
+unifdef-y += elf.h
+unifdef-y += nvram.h
+unifdef-y += param.h
+unifdef-y += posix_types.h
+unifdef-y += ptrace.h
+unifdef-y += seccomp.h
+unifdef-y += signal.h
+unifdef-y += termios.h
+unifdef-y += types.h
+unifdef-y += unistd.h
--- linux-2.6.18.orig/include/asm-s390/Kbuild
+++ linux-2.6.18/include/asm-s390/Kbuild
@@ -1,4 +1,11 @@
 include include/asm-generic/Kbuild.asm
 
-unifdef-y += cmb.h debug.h
-header-y += dasd.h qeth.h tape390.h ucontext.h vtoc.h z90crypt.h
+header-y += dasd.h
+header-y += qeth.h
+header-y += tape390.h
+header-y += ucontext.h
+header-y += vtoc.h
+header-y += z90crypt.h
+
+unifdef-y += cmb.h
+unifdef-y += debug.h
--- linux-2.6.18.orig/include/asm-sparc/Kbuild
+++ linux-2.6.18/include/asm-sparc/Kbuild
@@ -1,6 +1,22 @@
 include include/asm-generic/Kbuild.asm
 
-unifdef-y += fbio.h perfctr.h psr.h
-header-y += apc.h asi.h auxio.h bpp.h head.h ipc.h jsflash.h	\
-	openpromio.h pbm.h pconf.h pgtsun4.h reg.h traps.h	\
-	turbosparc.h vfc_ioctls.h winmacro.h
+header-y += apc.h
+header-y += asi.h
+header-y += auxio.h
+header-y += bpp.h
+header-y += head.h
+header-y += ipc.h
+header-y += jsflash.h
+header-y += openpromio.h
+header-y += pbm.h
+header-y += pconf.h
+header-y += pgtsun4.h
+header-y += reg.h
+header-y += traps.h
+header-y += turbosparc.h
+header-y += vfc_ioctls.h
+header-y += winmacro.h
+
+unifdef-y += fbio.h
+unifdef-y += perfctr.h
+unifdef-y += psr.h
--- linux-2.6.18.orig/include/asm-sparc64/Kbuild
+++ linux-2.6.18/include/asm-sparc64/Kbuild
@@ -4,7 +4,26 @@ ALTARCH := sparc
 ARCHDEF := defined __sparc__ && defined __arch64__
 ALTARCHDEF := defined __sparc__ && !defined __arch64__
 
-unifdef-y += fbio.h perfctr.h
-header-y += apb.h asi.h bbc.h bpp.h display7seg.h envctrl.h floppy.h	\
-	ipc.h kdebug.h mostek.h openprom.h openpromio.h parport.h	\
-	pconf.h psrcompat.h pstate.h reg.h uctx.h utrap.h watchdog.h
+header-y += apb.h
+header-y += asi.h
+header-y += bbc.h
+header-y += bpp.h
+header-y += display7seg.h
+header-y += envctrl.h
+header-y += floppy.h
+header-y += ipc.h
+header-y += kdebug.h
+header-y += mostek.h
+header-y += openprom.h
+header-y += openpromio.h
+header-y += parport.h
+header-y += pconf.h
+header-y += psrcompat.h
+header-y += pstate.h
+header-y += reg.h
+header-y += uctx.h
+header-y += utrap.h
+header-y += watchdog.h
+
+unifdef-y += fbio.h
+unifdef-y += perfctr.h
--- linux-2.6.18.orig/include/asm-x86_64/Kbuild
+++ linux-2.6.18/include/asm-x86_64/Kbuild
@@ -4,8 +4,18 @@ ALTARCH := i386
 ARCHDEF := defined __x86_64__
 ALTARCHDEF := defined __i386__
 
-header-y += boot.h bootsetup.h cpufeature.h debugreg.h ldt.h \
-	 msr.h prctl.h setup.h sigcontext32.h ucontext.h \
-	 vsyscall32.h
+header-y += boot.h
+header-y += bootsetup.h
+header-y += cpufeature.h
+header-y += debugreg.h
+header-y += ldt.h
+header-y += msr.h
+header-y += prctl.h
+header-y += setup.h
+header-y += sigcontext32.h
+header-y += ucontext.h
+header-y += vsyscall32.h
 
-unifdef-y += mce.h mtrr.h vsyscall.h
+unifdef-y += mce.h
+unifdef-y += mtrr.h
+unifdef-y += vsyscall.h
--- linux-2.6.18.orig/include/linux/Kbuild
+++ linux-2.6.18/include/linux/Kbuild
@@ -1,63 +1,343 @@
-header-y := byteorder/ dvb/ hdlc/ isdn/ nfsd/ raid/ sunrpc/ tc_act/	\
-	netfilter/ netfilter_arp/ netfilter_bridge/ netfilter_ipv4/	\
-	netfilter_ipv6/
+header-y += byteorder/
+header-y += dvb/
+header-y += hdlc/
+header-y += isdn/
+header-y += nfsd/
+header-y += raid/
+header-y += sunrpc/
+header-y += tc_act/
+header-y += netfilter/
+header-y += netfilter_arp/
+header-y += netfilter_bridge/
+header-y += netfilter_ipv4/
+header-y += netfilter_ipv6/
 
-header-y += affs_fs.h affs_hardblocks.h aio_abi.h a.out.h arcfb.h	\
-	atmapi.h atmbr2684.h atmclip.h atm_eni.h atm_he.h		\
-	atm_idt77105.h atmioc.h atmlec.h atmmpc.h atm_nicstar.h		\
-	atmppp.h atmsap.h atmsvc.h atm_zatm.h auto_fs4.h auxvec.h	\
-	awe_voice.h ax25.h b1lli.h baycom.h bfs_fs.h blkpg.h		\
-	bpqether.h cdk.h chio.h coda_psdev.h coff.h comstats.h		\
-	consolemap.h cycx_cfm.h dm-ioctl.h dn.h dqblk_v1.h		\
-	dqblk_v2.h dqblk_xfs.h efs_fs_sb.h elf-fdpic.h elf.h elf-em.h	\
-	fadvise.h fd.h fdreg.h ftape-header-segment.h ftape-vendors.h	\
-	fuse.h futex.h genetlink.h gen_stats.h gigaset_dev.h hdsmart.h	\
-	hpfs_fs.h hysdn_if.h i2c-dev.h i8k.h icmp.h			\
-	if_arcnet.h if_arp.h if_bonding.h if_cablemodem.h if_fc.h	\
-	if_fddi.h if.h if_hippi.h if_infiniband.h if_packet.h		\
-	if_plip.h if_ppp.h if_slip.h if_strip.h if_tunnel.h in6.h	\
-	in_route.h ioctl.h ip.h ipmi_msgdefs.h ip_mp_alg.h ipsec.h	\
-	ipx.h irda.h isdn_divertif.h iso_fs.h ite_gpio.h ixjuser.h	\
-	jffs2.h keyctl.h limits.h major.h matroxfb.h meye.h minix_fs.h	\
-	mmtimer.h mqueue.h mtio.h ncp_no.h netfilter_arp.h netrom.h	\
-	nfs2.h nfs4_mount.h nfs_mount.h openprom_fs.h param.h		\
-	pci_ids.h pci_regs.h personality.h pfkeyv2.h pg.h pkt_cls.h	\
-	pkt_sched.h posix_types.h ppdev.h prctl.h ps2esdi.h qic117.h	\
-	qnxtypes.h quotaio_v1.h quotaio_v2.h radeonfb.h raw.h		\
-	resource.h rose.h sctp.h smbno.h snmp.h sockios.h som.h		\
-	sound.h stddef.h synclink.h telephony.h termios.h ticable.h	\
-	times.h tiocl.h tipc.h toshiba.h ultrasound.h un.h utime.h	\
-	utsname.h video_decoder.h video_encoder.h videotext.h vt.h	\
-	wavefront.h wireless.h xattr.h x25.h zorro_ids.h
+header-y += affs_fs.h
+header-y += affs_hardblocks.h
+header-y += aio_abi.h
+header-y += a.out.h
+header-y += arcfb.h
+header-y += atmapi.h
+header-y += atmbr2684.h
+header-y += atmclip.h
+header-y += atm_eni.h
+header-y += atm_he.h
+header-y += atm_idt77105.h
+header-y += atmioc.h
+header-y += atmlec.h
+header-y += atmmpc.h
+header-y += atm_nicstar.h
+header-y += atmppp.h
+header-y += atmsap.h
+header-y += atmsvc.h
+header-y += atm_zatm.h
+header-y += auto_fs4.h
+header-y += auxvec.h
+header-y += awe_voice.h
+header-y += ax25.h
+header-y += b1lli.h
+header-y += baycom.h
+header-y += bfs_fs.h
+header-y += blkpg.h
+header-y += bpqether.h
+header-y += cdk.h
+header-y += chio.h
+header-y += coda_psdev.h
+header-y += coff.h
+header-y += comstats.h
+header-y += consolemap.h
+header-y += cycx_cfm.h
+header-y += dm-ioctl.h
+header-y += dn.h
+header-y += dqblk_v1.h
+header-y += dqblk_v2.h
+header-y += dqblk_xfs.h
+header-y += efs_fs_sb.h
+header-y += elf-fdpic.h
+header-y += elf.h
+header-y += elf-em.h
+header-y += fadvise.h
+header-y += fd.h
+header-y += fdreg.h
+header-y += ftape-header-segment.h
+header-y += ftape-vendors.h
+header-y += fuse.h
+header-y += futex.h
+header-y += genetlink.h
+header-y += gen_stats.h
+header-y += gigaset_dev.h
+header-y += hdsmart.h
+header-y += hpfs_fs.h
+header-y += hysdn_if.h
+header-y += i2c-dev.h
+header-y += i8k.h
+header-y += icmp.h
+header-y += if_arcnet.h
+header-y += if_arp.h
+header-y += if_bonding.h
+header-y += if_cablemodem.h
+header-y += if_fc.h
+header-y += if_fddi.h
+header-y += if.h
+header-y += if_hippi.h
+header-y += if_infiniband.h
+header-y += if_packet.h
+header-y += if_plip.h
+header-y += if_ppp.h
+header-y += if_slip.h
+header-y += if_strip.h
+header-y += if_tunnel.h
+header-y += in6.h
+header-y += in_route.h
+header-y += ioctl.h
+header-y += ip.h
+header-y += ipmi_msgdefs.h
+header-y += ip_mp_alg.h
+header-y += ipsec.h
+header-y += ipx.h
+header-y += irda.h
+header-y += isdn_divertif.h
+header-y += iso_fs.h
+header-y += ite_gpio.h
+header-y += ixjuser.h
+header-y += jffs2.h
+header-y += keyctl.h
+header-y += limits.h
+header-y += major.h
+header-y += matroxfb.h
+header-y += meye.h
+header-y += minix_fs.h
+header-y += mmtimer.h
+header-y += mqueue.h
+header-y += mtio.h
+header-y += ncp_no.h
+header-y += netfilter_arp.h
+header-y += netrom.h
+header-y += nfs2.h
+header-y += nfs4_mount.h
+header-y += nfs_mount.h
+header-y += openprom_fs.h
+header-y += param.h
+header-y += pci_ids.h
+header-y += pci_regs.h
+header-y += personality.h
+header-y += pfkeyv2.h
+header-y += pg.h
+header-y += pkt_cls.h
+header-y += pkt_sched.h
+header-y += posix_types.h
+header-y += ppdev.h
+header-y += prctl.h
+header-y += ps2esdi.h
+header-y += qic117.h
+header-y += qnxtypes.h
+header-y += quotaio_v1.h
+header-y += quotaio_v2.h
+header-y += radeonfb.h
+header-y += raw.h
+header-y += resource.h
+header-y += rose.h
+header-y += sctp.h
+header-y += smbno.h
+header-y += snmp.h
+header-y += sockios.h
+header-y += som.h
+header-y += sound.h
+header-y += stddef.h
+header-y += synclink.h
+header-y += telephony.h
+header-y += termios.h
+header-y += ticable.h
+header-y += times.h
+header-y += tiocl.h
+header-y += tipc.h
+header-y += toshiba.h
+header-y += ultrasound.h
+header-y += un.h
+header-y += utime.h
+header-y += utsname.h
+header-y += video_decoder.h
+header-y += video_encoder.h
+header-y += videotext.h
+header-y += vt.h
+header-y += wavefront.h
+header-y += wireless.h
+header-y += xattr.h
+header-y += x25.h
+header-y += zorro_ids.h
 
-unifdef-y += acct.h adb.h adfs_fs.h agpgart.h apm_bios.h atalk.h	\
-	atmarp.h atmdev.h atm.h atm_tcp.h audit.h auto_fs.h binfmts.h	\
-	capability.h capi.h cciss_ioctl.h cdrom.h cm4000_cs.h		\
-	cn_proc.h coda.h connector.h cramfs_fs.h cuda.h cyclades.h	\
-	dccp.h dirent.h divert.h elfcore.h errno.h errqueue.h		\
-	ethtool.h eventpoll.h ext2_fs.h ext3_fs.h fb.h fcntl.h		\
-	filter.h flat.h fs.h ftape.h gameport.h generic_serial.h	\
-	genhd.h hayesesp.h hdlcdrv.h hdlc.h hdreg.h hiddev.h hpet.h	\
-	i2c.h i2o-dev.h icmpv6.h if_bridge.h if_ec.h			\
-	if_eql.h if_ether.h if_frad.h if_ltalk.h if_pppox.h		\
-	if_shaper.h if_tr.h if_tun.h if_vlan.h if_wanpipe.h igmp.h	\
-	inet_diag.h in.h inotify.h input.h ipc.h ipmi.h ipv6.h		\
-	ipv6_route.h isdn.h isdnif.h isdn_ppp.h isicom.h jbd.h		\
-	joystick.h kdev_t.h kd.h kernelcapi.h kernel.h keyboard.h	\
-	llc.h loop.h lp.h mempolicy.h mii.h mman.h mroute.h msdos_fs.h	\
-	msg.h nbd.h ncp_fs.h ncp.h ncp_mount.h netdevice.h		\
-	netfilter_bridge.h netfilter_decnet.h netfilter.h		\
-	netfilter_ipv4.h netfilter_ipv6.h netfilter_logging.h net.h	\
-	netlink.h nfs3.h nfs4.h nfsacl.h nfs_fs.h nfs.h nfs_idmap.h	\
-	n_r3964.h nubus.h nvram.h parport.h patchkey.h pci.h pktcdvd.h	\
-	pmu.h poll.h ppp_defs.h ppp-comp.h ptrace.h qnx4_fs.h quota.h	\
-	random.h reboot.h reiserfs_fs.h reiserfs_xattr.h romfs_fs.h	\
-	route.h rtc.h rtnetlink.h scc.h sched.h sdla.h			\
-	selinux_netlink.h sem.h serial_core.h serial.h serio.h shm.h	\
-	signal.h smb_fs.h smb.h smb_mount.h socket.h sonet.h sonypi.h	\
-	soundcard.h stat.h sysctl.h tcp.h time.h timex.h tty.h types.h	\
-	udf_fs_i.h udp.h uinput.h uio.h unistd.h usb_ch9.h		\
-	usbdevice_fs.h user.h videodev2.h videodev.h wait.h		\
-	wanrouter.h watchdog.h xfrm.h zftape.h
+unifdef-y += acct.h
+unifdef-y += adb.h
+unifdef-y += adfs_fs.h
+unifdef-y += agpgart.h
+unifdef-y += apm_bios.h
+unifdef-y += atalk.h
+unifdef-y += atmarp.h
+unifdef-y += atmdev.h
+unifdef-y += atm.h
+unifdef-y += atm_tcp.h
+unifdef-y += audit.h
+unifdef-y += auto_fs.h
+unifdef-y += binfmts.h
+unifdef-y += capability.h
+unifdef-y += capi.h
+unifdef-y += cciss_ioctl.h
+unifdef-y += cdrom.h
+unifdef-y += cm4000_cs.h
+unifdef-y += cn_proc.h
+unifdef-y += coda.h
+unifdef-y += connector.h
+unifdef-y += cramfs_fs.h
+unifdef-y += cuda.h
+unifdef-y += cyclades.h
+unifdef-y += dccp.h
+unifdef-y += dirent.h
+unifdef-y += divert.h
+unifdef-y += elfcore.h
+unifdef-y += errno.h
+unifdef-y += errqueue.h
+unifdef-y += ethtool.h
+unifdef-y += eventpoll.h
+unifdef-y += ext2_fs.h
+unifdef-y += ext3_fs.h
+unifdef-y += fb.h
+unifdef-y += fcntl.h
+unifdef-y += filter.h
+unifdef-y += flat.h
+unifdef-y += fs.h
+unifdef-y += ftape.h
+unifdef-y += gameport.h
+unifdef-y += generic_serial.h
+unifdef-y += genhd.h
+unifdef-y += hayesesp.h
+unifdef-y += hdlcdrv.h
+unifdef-y += hdlc.h
+unifdef-y += hdreg.h
+unifdef-y += hiddev.h
+unifdef-y += hpet.h
+unifdef-y += i2c.h
+unifdef-y += i2o-dev.h
+unifdef-y += icmpv6.h
+unifdef-y += if_bridge.h
+unifdef-y += if_ec.h
+unifdef-y += if_eql.h
+unifdef-y += if_ether.h
+unifdef-y += if_frad.h
+unifdef-y += if_ltalk.h
+unifdef-y += if_pppox.h
+unifdef-y += if_shaper.h
+unifdef-y += if_tr.h
+unifdef-y += if_tun.h
+unifdef-y += if_vlan.h
+unifdef-y += if_wanpipe.h
+unifdef-y += igmp.h
+unifdef-y += inet_diag.h
+unifdef-y += in.h
+unifdef-y += inotify.h
+unifdef-y += input.h
+unifdef-y += ipc.h
+unifdef-y += ipmi.h
+unifdef-y += ipv6.h
+unifdef-y += ipv6_route.h
+unifdef-y += isdn.h
+unifdef-y += isdnif.h
+unifdef-y += isdn_ppp.h
+unifdef-y += isicom.h
+unifdef-y += jbd.h
+unifdef-y += joystick.h
+unifdef-y += kdev_t.h
+unifdef-y += kd.h
+unifdef-y += kernelcapi.h
+unifdef-y += kernel.h
+unifdef-y += keyboard.h
+unifdef-y += llc.h
+unifdef-y += loop.h
+unifdef-y += lp.h
+unifdef-y += mempolicy.h
+unifdef-y += mii.h
+unifdef-y += mman.h
+unifdef-y += mroute.h
+unifdef-y += msdos_fs.h
+unifdef-y += msg.h
+unifdef-y += nbd.h
+unifdef-y += ncp_fs.h
+unifdef-y += ncp.h
+unifdef-y += ncp_mount.h
+unifdef-y += netdevice.h
+unifdef-y += netfilter_bridge.h
+unifdef-y += netfilter_decnet.h
+unifdef-y += netfilter.h
+unifdef-y += netfilter_ipv4.h
+unifdef-y += netfilter_ipv6.h
+unifdef-y += netfilter_logging.h
+unifdef-y += net.h
+unifdef-y += netlink.h
+unifdef-y += nfs3.h
+unifdef-y += nfs4.h
+unifdef-y += nfsacl.h
+unifdef-y += nfs_fs.h
+unifdef-y += nfs.h
+unifdef-y += nfs_idmap.h
+unifdef-y += n_r3964.h
+unifdef-y += nubus.h
+unifdef-y += nvram.h
+unifdef-y += parport.h
+unifdef-y += patchkey.h
+unifdef-y += pci.h
+unifdef-y += pktcdvd.h
+unifdef-y += pmu.h
+unifdef-y += poll.h
+unifdef-y += ppp_defs.h
+unifdef-y += ppp-comp.h
+unifdef-y += ptrace.h
+unifdef-y += qnx4_fs.h
+unifdef-y += quota.h
+unifdef-y += random.h
+unifdef-y += reboot.h
+unifdef-y += reiserfs_fs.h
+unifdef-y += reiserfs_xattr.h
+unifdef-y += romfs_fs.h
+unifdef-y += route.h
+unifdef-y += rtc.h
+unifdef-y += rtnetlink.h
+unifdef-y += scc.h
+unifdef-y += sched.h
+unifdef-y += sdla.h
+unifdef-y += selinux_netlink.h
+unifdef-y += sem.h
+unifdef-y += serial_core.h
+unifdef-y += serial.h
+unifdef-y += serio.h
+unifdef-y += shm.h
+unifdef-y += signal.h
+unifdef-y += smb_fs.h
+unifdef-y += smb.h
+unifdef-y += smb_mount.h
+unifdef-y += socket.h
+unifdef-y += sonet.h
+unifdef-y += sonypi.h
+unifdef-y += soundcard.h
+unifdef-y += stat.h
+unifdef-y += sysctl.h
+unifdef-y += tcp.h
+unifdef-y += time.h
+unifdef-y += timex.h
+unifdef-y += tty.h
+unifdef-y += types.h
+unifdef-y += udf_fs_i.h
+unifdef-y += udp.h
+unifdef-y += uinput.h
+unifdef-y += uio.h
+unifdef-y += unistd.h
+unifdef-y += usb_ch9.h
+unifdef-y += usbdevice_fs.h
+unifdef-y += user.h
+unifdef-y += videodev2.h
+unifdef-y += videodev.h
+unifdef-y += wait.h
+unifdef-y += wanrouter.h
+unifdef-y += watchdog.h
+unifdef-y += xfrm.h
+unifdef-y += zftape.h
 
-objhdr-y := version.h
+objhdr-y += version.h
--- linux-2.6.18.orig/include/linux/byteorder/Kbuild
+++ linux-2.6.18/include/linux/byteorder/Kbuild
@@ -1,2 +1,7 @@
-unifdef-y += generic.h swabb.h swab.h
-header-y += big_endian.h little_endian.h pdp_endian.h
+header-y += big_endian.h
+header-y += little_endian.h
+header-y += pdp_endian.h
+
+unifdef-y += generic.h
+unifdef-y += swabb.h
+unifdef-y += swab.h
--- linux-2.6.18.orig/include/linux/dvb/Kbuild
+++ linux-2.6.18/include/linux/dvb/Kbuild
@@ -1,2 +1,9 @@
-header-y += ca.h frontend.h net.h osd.h version.h
-unifdef-y := audio.h dmx.h video.h
+header-y += ca.h
+header-y += frontend.h
+header-y += net.h
+header-y += osd.h
+header-y += version.h
+
+unifdef-y += audio.h
+unifdef-y += dmx.h
+unifdef-y += video.h
--- linux-2.6.18.orig/include/linux/netfilter/Kbuild
+++ linux-2.6.18/include/linux/netfilter/Kbuild
@@ -1,11 +1,38 @@
-header-y := nf_conntrack_sctp.h nf_conntrack_tuple_common.h		\
-	    nfnetlink_conntrack.h nfnetlink_log.h nfnetlink_queue.h	\
-	    xt_CLASSIFY.h xt_comment.h xt_connbytes.h xt_connmark.h	\
-	    xt_CONNMARK.h xt_conntrack.h xt_dccp.h xt_esp.h		\
-	    xt_helper.h xt_length.h xt_limit.h xt_mac.h xt_mark.h	\
-	    xt_MARK.h xt_multiport.h xt_NFQUEUE.h xt_pkttype.h		\
-	    xt_policy.h xt_realm.h xt_sctp.h xt_state.h xt_string.h	\
-	    xt_tcpmss.h xt_tcpudp.h xt_SECMARK.h xt_CONNSECMARK.h
+header-y += nf_conntrack_sctp.h
+header-y += nf_conntrack_tuple_common.h
+header-y += nfnetlink_conntrack.h
+header-y += nfnetlink_log.h
+header-y += nfnetlink_queue.h
+header-y += xt_CLASSIFY.h
+header-y += xt_comment.h
+header-y += xt_connbytes.h
+header-y += xt_connmark.h
+header-y += xt_CONNMARK.h
+header-y += xt_conntrack.h
+header-y += xt_dccp.h
+header-y += xt_esp.h
+header-y += xt_helper.h
+header-y += xt_length.h
+header-y += xt_limit.h
+header-y += xt_mac.h
+header-y += xt_mark.h
+header-y += xt_MARK.h
+header-y += xt_multiport.h
+header-y += xt_NFQUEUE.h
+header-y += xt_pkttype.h
+header-y += xt_policy.h
+header-y += xt_realm.h
+header-y += xt_sctp.h
+header-y += xt_state.h
+header-y += xt_string.h
+header-y += xt_tcpmss.h
+header-y += xt_tcpudp.h
+header-y += xt_SECMARK.h
+header-y += xt_CONNSECMARK.h
 
-unifdef-y := nf_conntrack_common.h nf_conntrack_ftp.h		\
-	nf_conntrack_tcp.h nfnetlink.h x_tables.h xt_physdev.h
+unifdef-y += nf_conntrack_common.h
+unifdef-y += nf_conntrack_ftp.h
+unifdef-y += nf_conntrack_tcp.h
+unifdef-y += nfnetlink.h
+unifdef-y += x_tables.h
+unifdef-y += xt_physdev.h
--- linux-2.6.18.orig/include/linux/netfilter_arp/Kbuild
+++ linux-2.6.18/include/linux/netfilter_arp/Kbuild
@@ -1,2 +1,3 @@
-header-y := arpt_mangle.h
-unifdef-y := arp_tables.h
+header-y += arpt_mangle.h
+
+unifdef-y += arp_tables.h
--- linux-2.6.18.orig/include/linux/netfilter_bridge/Kbuild
+++ linux-2.6.18/include/linux/netfilter_bridge/Kbuild
@@ -1,4 +1,17 @@
-header-y += ebt_among.h ebt_arp.h ebt_arpreply.h ebt_ip.h ebt_limit.h	\
-	ebt_log.h ebt_mark_m.h ebt_mark_t.h ebt_nat.h ebt_pkttype.h	\
-	ebt_redirect.h ebt_stp.h ebt_ulog.h ebt_vlan.h
-unifdef-y := ebtables.h ebt_802_3.h
+header-y += ebt_among.h
+header-y += ebt_arp.h
+header-y += ebt_arpreply.h
+header-y += ebt_ip.h
+header-y += ebt_limit.h
+header-y += ebt_log.h
+header-y += ebt_mark_m.h
+header-y += ebt_mark_t.h
+header-y += ebt_nat.h
+header-y += ebt_pkttype.h
+header-y += ebt_redirect.h
+header-y += ebt_stp.h
+header-y += ebt_ulog.h
+header-y += ebt_vlan.h
+
+unifdef-y += ebtables.h
+unifdef-y += ebt_802_3.h
--- linux-2.6.18.orig/include/linux/netfilter_ipv4/Kbuild
+++ linux-2.6.18/include/linux/netfilter_ipv4/Kbuild
@@ -1,21 +1,63 @@
+header-y += ip_conntrack_helper.h
+header-y += ip_conntrack_helper_h323_asn1.h
+header-y += ip_conntrack_helper_h323_types.h
+header-y += ip_conntrack_protocol.h
+header-y += ip_conntrack_sctp.h
+header-y += ip_conntrack_tcp.h
+header-y += ip_conntrack_tftp.h
+header-y += ip_nat_pptp.h
+header-y += ipt_addrtype.h
+header-y += ipt_ah.h
+header-y += ipt_CLASSIFY.h
+header-y += ipt_CLUSTERIP.h
+header-y += ipt_comment.h
+header-y += ipt_connbytes.h
+header-y += ipt_connmark.h
+header-y += ipt_CONNMARK.h
+header-y += ipt_conntrack.h
+header-y += ipt_dccp.h
+header-y += ipt_dscp.h
+header-y += ipt_DSCP.h
+header-y += ipt_ecn.h
+header-y += ipt_ECN.h
+header-y += ipt_esp.h
+header-y += ipt_hashlimit.h
+header-y += ipt_helper.h
+header-y += ipt_iprange.h
+header-y += ipt_length.h
+header-y += ipt_limit.h
+header-y += ipt_LOG.h
+header-y += ipt_mac.h
+header-y += ipt_mark.h
+header-y += ipt_MARK.h
+header-y += ipt_multiport.h
+header-y += ipt_NFQUEUE.h
+header-y += ipt_owner.h
+header-y += ipt_physdev.h
+header-y += ipt_pkttype.h
+header-y += ipt_policy.h
+header-y += ipt_realm.h
+header-y += ipt_recent.h
+header-y += ipt_REJECT.h
+header-y += ipt_SAME.h
+header-y += ipt_sctp.h
+header-y += ipt_state.h
+header-y += ipt_string.h
+header-y += ipt_tcpmss.h
+header-y += ipt_TCPMSS.h
+header-y += ipt_tos.h
+header-y += ipt_TOS.h
+header-y += ipt_ttl.h
+header-y += ipt_TTL.h
+header-y += ipt_ULOG.h
 
-header-y := ip_conntrack_helper.h ip_conntrack_helper_h323_asn1.h	\
-	    ip_conntrack_helper_h323_types.h ip_conntrack_protocol.h	\
-	    ip_conntrack_sctp.h ip_conntrack_tcp.h ip_conntrack_tftp.h	\
-	    ip_nat_pptp.h ipt_addrtype.h ipt_ah.h	\
-	    ipt_CLASSIFY.h ipt_CLUSTERIP.h ipt_comment.h		\
-	    ipt_connbytes.h ipt_connmark.h ipt_CONNMARK.h		\
-	    ipt_conntrack.h ipt_dccp.h ipt_dscp.h ipt_DSCP.h ipt_ecn.h	\
-	    ipt_ECN.h ipt_esp.h ipt_hashlimit.h ipt_helper.h		\
-	    ipt_iprange.h ipt_length.h ipt_limit.h ipt_LOG.h ipt_mac.h	\
-	    ipt_mark.h ipt_MARK.h ipt_multiport.h ipt_NFQUEUE.h		\
-	    ipt_owner.h ipt_physdev.h ipt_pkttype.h ipt_policy.h	\
-	    ipt_realm.h ipt_recent.h ipt_REJECT.h ipt_SAME.h		\
-	    ipt_sctp.h ipt_state.h ipt_string.h ipt_tcpmss.h		\
-	    ipt_TCPMSS.h ipt_tos.h ipt_TOS.h ipt_ttl.h ipt_TTL.h	\
-	    ipt_ULOG.h
-
-unifdef-y := ip_conntrack.h ip_conntrack_h323.h ip_conntrack_irc.h	\
-	ip_conntrack_pptp.h ip_conntrack_proto_gre.h			\
-	ip_conntrack_tuple.h ip_nat.h ip_nat_rule.h ip_queue.h		\
-	ip_tables.h
+unifdef-y += ip_conntrack.h
+unifdef-y += ip_conntrack_h323.h
+unifdef-y += ip_conntrack_irc.h
+unifdef-y += ip_conntrack_pptp.h
+unifdef-y += ip_conntrack_proto_gre.h
+unifdef-y += ip_conntrack_tuple.h
+unifdef-y += ip_nat.h
+unifdef-y += ip_nat_rule.h
+unifdef-y += ip_queue.h
+unifdef-y += ip_tables.h
--- linux-2.6.18.orig/include/linux/netfilter_ipv6/Kbuild
+++ linux-2.6.18/include/linux/netfilter_ipv6/Kbuild
@@ -1,6 +1,21 @@
-header-y += ip6t_HL.h ip6t_LOG.h ip6t_MARK.h ip6t_REJECT.h ip6t_ah.h	\
-	ip6t_esp.h ip6t_frag.h ip6t_hl.h ip6t_ipv6header.h		\
-	ip6t_length.h ip6t_limit.h ip6t_mac.h ip6t_mark.h		\
-	ip6t_multiport.h ip6t_opts.h ip6t_owner.h ip6t_policy.h		\
-	ip6t_physdev.h ip6t_rt.h
-unifdef-y := ip6_tables.h
+header-y += ip6t_HL.h
+header-y += ip6t_LOG.h
+header-y += ip6t_MARK.h
+header-y += ip6t_REJECT.h
+header-y += ip6t_ah.h
+header-y += ip6t_esp.h
+header-y += ip6t_frag.h
+header-y += ip6t_hl.h
+header-y += ip6t_ipv6header.h
+header-y += ip6t_length.h
+header-y += ip6t_limit.h
+header-y += ip6t_mac.h
+header-y += ip6t_mark.h
+header-y += ip6t_multiport.h
+header-y += ip6t_opts.h
+header-y += ip6t_owner.h
+header-y += ip6t_policy.h
+header-y += ip6t_physdev.h
+header-y += ip6t_rt.h
+
+unifdef-y += ip6_tables.h
--- linux-2.6.18.orig/include/linux/nfsd/Kbuild
+++ linux-2.6.18/include/linux/nfsd/Kbuild
@@ -1,2 +1,7 @@
-unifdef-y := const.h export.h stats.h syscall.h nfsfh.h debug.h auth.h
-
+unifdef-y += const.h
+unifdef-y += export.h
+unifdef-y += stats.h
+unifdef-y += syscall.h
+unifdef-y += nfsfh.h
+unifdef-y += debug.h
+unifdef-y += auth.h
--- linux-2.6.18.orig/include/linux/raid/Kbuild
+++ linux-2.6.18/include/linux/raid/Kbuild
@@ -1 +1,2 @@
-header-y += md_p.h md_u.h
+header-y += md_p.h
+header-y += md_u.h
--- linux-2.6.18.orig/include/linux/sunrpc/Kbuild
+++ linux-2.6.18/include/linux/sunrpc/Kbuild
@@ -1 +1 @@
-unifdef-y := debug.h
+unifdef-y += debug.h
--- linux-2.6.18.orig/include/linux/tc_act/Kbuild
+++ linux-2.6.18/include/linux/tc_act/Kbuild
@@ -1 +1,4 @@
-header-y += tc_gact.h tc_ipt.h tc_mirred.h tc_pedit.h
+header-y += tc_gact.h
+header-y += tc_ipt.h
+header-y += tc_mirred.h
+header-y += tc_pedit.h
--- linux-2.6.18.orig/include/linux/tc_ematch/Kbuild
+++ linux-2.6.18/include/linux/tc_ematch/Kbuild
@@ -1 +1,4 @@
-headers-y := tc_em_cmp.h tc_em_meta.h tc_em_nbyte.h tc_em_text.h
+header-y += tc_em_cmp.h
+header-y += tc_em_meta.h
+header-y += tc_em_nbyte.h
+header-y += tc_em_text.h
--- linux-2.6.18.orig/include/mtd/Kbuild
+++ linux-2.6.18/include/mtd/Kbuild
@@ -1,2 +1,6 @@
-unifdef-y := mtd-abi.h
-header-y := inftl-user.h jffs2-user.h mtd-user.h nftl-user.h
+header-y += inftl-user.h
+header-y += jffs2-user.h
+header-y += mtd-user.h
+header-y += nftl-user.h
+
+unifdef-y += mtd-abi.h
--- linux-2.6.18.orig/include/rdma/Kbuild
+++ linux-2.6.18/include/rdma/Kbuild
@@ -1 +1 @@
-header-y := ib_user_mad.h
+header-y += ib_user_mad.h
--- linux-2.6.18.orig/include/scsi/Kbuild
+++ linux-2.6.18/include/scsi/Kbuild
@@ -1,2 +1,4 @@
 header-y += scsi.h
-unifdef-y := scsi_ioctl.h sg.h
+
+unifdef-y += scsi_ioctl.h
+unifdef-y += sg.h
--- linux-2.6.18.orig/include/sound/Kbuild
+++ linux-2.6.18/include/sound/Kbuild
@@ -1,2 +1,10 @@
-header-y := asound_fm.h hdsp.h hdspm.h sfnt_info.h sscape_ioctl.h
-unifdef-y := asequencer.h asound.h emu10k1.h sb16_csp.h 
+header-y += asound_fm.h
+header-y += hdsp.h
+header-y += hdspm.h
+header-y += sfnt_info.h
+header-y += sscape_ioctl.h
+
+unifdef-y += asequencer.h
+unifdef-y += asound.h
+unifdef-y += emu10k1.h
+unifdef-y += sb16_csp.h
--- linux-2.6.18.orig/include/video/Kbuild
+++ linux-2.6.18/include/video/Kbuild
@@ -1 +1 @@
-unifdef-y := sisfb.h
+unifdef-y += sisfb.h

--
