Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310204AbSCTWHG>; Wed, 20 Mar 2002 17:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310540AbSCTWGp>; Wed, 20 Mar 2002 17:06:45 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:13065 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S310254AbSCTWF5> convert rfc822-to-8bit; Wed, 20 Mar 2002 17:05:57 -0500
Date: Wed, 20 Mar 2002 18:00:08 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Linux 2.4.19-pre4
Message-ID: <Pine.LNX.4.21.0203201757560.9129-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So here goes pre4, now with a much more detailed changelog...



Summary of changes from v2.4.19-pre3 to v2.4.19-pre4
============================================

<marcelo@plucky.distro.conectiva> (02/03/13 1.163)
	Update aic7xxx to 6.2.5

<sfr@canb.auug.org.au> (02/03/13 1.164)
	[PATCH] Trivial APM update part 1
	
	Hi Marcelo, Linus,
	
	This is the first of a series of patches I have got from Thomas Hood
	that modify the apm code mainly for better self documentation.
	
	This one does:
	
	Variable "waiting_for_resume" is renamed 'ignore_sys_suspend'.
	The reason for the change is that this flag variable is
	employed in a manner analogous to that of other flag variables
	named 'ignore ...'.  When the flag is set, the driver needs to
	ignore further system suspends.  The driver does not "wait"
	in the usual sense of that word.  The only sense in which the
	driver waits is the sense in which it needs to continue to
	ignore system suspends until certain events occur.  One such
	event is a resume.  However, another such event is the vetoing
	of the suspend request by a driver.  So it would be more
	accurate to call the flag 'waiting_for_resume_or_suspend_reject'
	or something like that.  But for the reason mentioned first,
	an even better name is 'ignore_sys_suspend'.
	
	Patch against 2.4.19-pre3, but applies to 2.5.6 (with a small offset).
	--
	Cheers,
	Stephen Rothwell                    sfr@canb.auug.org.au
	http://www.canb.auug.org.au/~sfr/

<sfr@canb.auug.org.au> (02/03/13 1.165)
	[PATCH] APM patch: change implementation of ALWAYS_CALL_BUSY
	
	Hi Marcelo, Linus,
	
	Number 6
	
	This patch cleans up the way the ALWAYS_CALL_BUSY macro
	forces calling of the APM BIOS busy routine.  Instead
	of storing a false value in clock_slowed, we disjoin
	clock_slowed with the value of ALWAYS_CALL_BUSY.  This
	simplifies the code.
	
	Patch against 2.4.19-pre3, but applies to 2.5.6 with small offset.
	--
	Cheers,
	Stephen Rothwell                    sfr@canb.auug.org.au
	http://www.canb.auug.org.au/~sfr/

<sfr@canb.auug.org.au> (02/03/13 1.166)
	[PATCH] APM patch: apm_cpu_idle cleanups
	
	Hi Marcelo, Linus,
	
	Number 7.
	
	This patch contains four cleanup changes whose aim
	is better code self-documentation (the best way to
	document IMHO).  They are sent together because they
	overlap.
	
	1. Rename the variable "sys_idle" to 'original_pm_idle'.
	This is where we store the value that we find in pm_idle before
	we substitute the address of our own apm_cpu_idle() function.
	In principle we have no idea whose address this is, so
	the variable name shouldn't imply that we know that this is
	the address of a system idle function; it should simply
	indicate that it is the original value of pm_idle.
	
	2. Variable "apm_is_idle" is renamed 'apm_idle_done'.
	This flag indicates when apm_do_idle() has been called.
	It is a premise of apm_cpu_idle()'s operation that it is
	not known whether the apm_do_idle() function really idles
	the CPU.  The name of the flag should not lead one to
	believe otherwise.
	
	3. Variable "t1" is renamed 'bucket'.  The variable is not
	a time but a countdown ("bucket"), so the variable name
	should not lead one to believe it is some sort of time
	value.
	
	4. A default: case is added to the switch in order to
	remind the reader that there is a third possible return
	value from apm_do_idle().
	
	Patch against 2.4.19-pre3, applies to 2.5.6 with some fuzz.
	--
	Cheers,
	Stephen Rothwell                    sfr@canb.auug.org.au
	http://www.canb.auug.org.au/~sfr/

<jgarzik@mandrakesoft.com> (02/03/13 1.167)
	[PATCH] PATCH: add MWI support to PCI
	
	This code has existed and been stable in various drivers/net/*.c drivers
	for a while.
	
	As applied in 2.5, these API functions allows a driver to control the
	PCI Memory-Write-Invalidate transaction, which is a performance speedup
	for newer boards, but more importantly a requirement on some hardware.

<jgarzik@mandrakesoft.com> (02/03/13 1.168)
	[PATCH] PATCH: starfire updates
	
	       LK1.3.6 (Ion Badulescu)
	       - Sparc64 support and fixes
	       - Better stats and error handling

<jgarzik@mandrakesoft.com> (02/03/13 1.169)
	[PATCH] PATCH: tulip use pci_set_mwi
	
	Fix tulip bugs in _experimental_, non-default MWI code path.
	Use new pci_set_mwi to save code and fix more bugs.

<jgarzik@mandrakesoft.com> (02/03/13 1.170)
	[PATCH] PATCH: starfire use pci_set_mwi
	
	Update starfire driver to use pci_set_mwi, fixing one bug
	(cache_line_size setting should go before mwi bit set) and saves some
	code.
	Kernel compatibility is updated, so this driver works on kernels without
	the new pci_set_mwi function too.

<akpm@zip.com.au> (02/03/14 1.171)
	[PATCH] fix layout of mapped files
	
	If you create a shared mapping of a sparse file, dirty it
	and then run msync, all the file's blocks are laid out
	backwards:
	
	mnm:/mnt/sda6> 0 bmap foo
	0-0: 530-530 (1)
	1-1: 529-529 (1)
	2-2: 528-528 (1)
	3-3: 527-527 (1)
	4-4: 526-526 (1)
	5-5: 525-525 (1)
	6-6: 524-524 (1)
	7-7: 523-523 (1)
	8-8: 522-522 (1)
	9-9: 521-521 (1)
	10-10: 520-520 (1)
	11-11: 519-519 (1)
	12-12: 518-518 (1)
	13-13: 517-517 (1)
	14-14: 516-516 (1)
	15-15: 515-515 (1)
	
	This is because filemap_sync puts the lowest-index page at
	mapping->dirty_pages.prev and the highest at mapping->dirty_pages.next.
	
	I think that by walking the dirty pages list in ascending file
	offset order as we instantiate their disk mappings we will generally
	get better layout.
	
	mnm:/mnt/sda6> 0 bmap foo2
	0-11: 531-542 (12)
	12-15: 544-547 (4)

<greg@kroah.com> (02/03/14 1.172)
	[PATCH] export IO_APIC_get_PCI_irq_vector for IBM PCI Hotplug driver
	
	Hi,
	
	Here's a patch against 2.4.19-pre2 that exports a symbol that is needed
	by the IBM PCI hotplug driver if it is built as a module.
	
	thanks,
	
	greg k-h

<kaos@ocs.com.au> (02/03/14 1.173)
	[PATCH] 2.4.19-pre3 rename duplicate partition_name()
	
	ksymoops gets confused by two symbols called partition_name when one of
	them is exported.  Since the version in fs/partitions/msdos.c is local,
	rename it, leave the version in drivers/md/md.c alone.
	
	Index: 19-pre3.1/fs/partitions/msdos.c

<rml@tech9.net> (02/03/14 1.174)
	[PATCH] more lseek cleanup
	
	Marcelo,
	
	The -ac merge in 2.4.19-pre3 merged the majority of my 2.4 lseek
	cleanup, but not all.  The following patch continues the cleanup by
	removing more instances of reimplementations of no_llseek and having the
	driver in question use no_llseek.
	
	Most of these are in a later -ac release.  Patch is against 2.4.19-pre3,
	please apply.
	
		Robert Love

<rml@tech9.net> (02/03/14 1.175)
	[PATCH] 2.4: UFS lseek cleanup
	
	Marcelo,
	
	The following patch continues the 2.4 lseek cleanup by removing a
	redundant ufs_file_lseek implementation and having UFS use the standard
	generic_file_llseek.
	
	Al (who signed off on this for 2.5) says the implementation assumed it
	needed explicit size checking, but the standard generic_file_llseek does
	this just fine.  So it is redundant and a sane cleanup.  The patch is
	already in -ac, but not in 2.4.19-pre3.
	
	This is against 2.4.19-pre3, please apply.
	
		Robert Love

<bcrl@redhat.com> (02/03/14 1.176)
	[PATCH] ns83820 0.17 (Re: Broadcom 5700/5701 Gigabit Ethernet Adapters)
	
	On Sun, Mar 10, 2002 at 06:30:33PM -0800, David S. Miller wrote:
	> Syskonnect sk98 with jumbo frames gets ~107MB/sec TCP bandwidth
	> without NAPI, there is no reason other cards cannot go full speed as
	> well.
	>
	> NAPI is really only going to help with high packet rates not with
	> thinks like raw bandwidth tests.
	
	A day's tweaking later, and I'm getting 810mbit/s with netperf between
	two Athlons with default settings (1500 byte packets).  What I've found
	is that increasing the size of the RX/TX rings or the max sizes of the
	tcp r/wmem backlogs really slows things down, so I'm not doing that
	anymore.  The pair of P3s shows 262mbit/s (up from 67).
	
	Interrupt mitigation is now pretty stupid, but it helped: the irq
	handler disables the rx interrupt and then triggers a tasklet to run
	through the rx ring.  The tasklet later enables rx interrupts again.
	More tweaking tomorrow...
	
	Marcelo, please apply the patch below to the next 2.4 prepatch: it
	also has a fix for a tx hang problem, and a few other nasties.  Thanks!
	
			-ben
	--
	"A man with a bass just walked in,
	 and he's putting it down
	 on the floor."

<sfr@canb.auug.org.au> (02/03/14 1.177)
	[PATCH] dnotify
	
	Hi Marcelo, Linus,
	
	The following patch makes directory notifications per thread group instead
	of per process tree as they are now.  This means, in particular, that if
	a child closes a file descriptor that has a directory open with notifies
	enabled, the notification will not be removed.
	
	Thanks to Andrea for the push in the right direction.
	
	Patch against 2.4.19-pre3, but also applies to 2.5.6 with a small offset.
	--
	Cheers,
	Stephen Rothwell                    sfr@canb.auug.org.au
	http://www.canb.auug.org.au/~sfr/

<trond.myklebust@fys.uio.no> (02/03/14 1.178)
	[PATCH] Fix 2.4.19-pre3 NFS client file creation
	
	Hi Marcelo,
	
	  The following patch fixes a bug in NFS file creation. Recently (not
	sure exactly when), open_namei() was changed so that it expects
	vfs_create() to always return a fully instantiated dentry for the new
	file.
	
	The following patch ensures this is done in the cases where the RPC
	CREATE call does not return valid attributes/filehandles. This is
	always the case for NFSv2, and can sometimes be the case for v3...
	
	Cheers,
	  Trond

<trond.myklebust@fys.uio.no> (02/03/14 1.179)
	[PATCH] Fix 2.4.19-pre3 NFS reads from holding a write leases.
	
	Hi,
	
	  The VFS does not like us holding the 'write_access' lease on a
	file for too long. The function 'get_write_access()' gets called on an
	inode whenever a struct file is created for writing, and is only
	released on the last fput() of that struct file.
	
	  NFS caches the struct file in the nfs_page in order to access
	the RPC credentials that are cached in the filp->private_data area.
	Unfortunately this means that both NFS reads and writes can end up
	prolonging the write_access lease beyond the end of the 'sys_close()'.
	
	
	  The following patch changes the NFS code so that it caches the RPC
	credentials directly in the nfs_page.  The struct file is still kept
	around for ordinary writes, in order that we can report asynchronous
	write errors in sys_close() via filp->f_error.
	
	Cheers,
	  Trond

<trond.myklebust@fys.uio.no> (02/03/14 1.180)
	[PATCH] 2.4.19-pre3 NFS close-to-open fixes
	
	Hi,
	
	  The following patch implements close-to-open semantics for the 2.4.x
	series.
	
	  Most programs rely on NFS always checking the data cache integrity
	on file open() (and then flushing out all writes on close()). This is
	the same patch that was included in 2.5.x.
	
	Issues fixed:
	
	 - Use the directory mtime in order to give us a hint when we should
	   check for namespace changes.
	
	 - Add support for the 'nocto' flag, in order to turn off the strict
	   attribute cache revalidation on file open().
	
	 - Simplify inode lookup. Don't check the 'fsid' field (which appears
	   to be buggy in too many servers in order to be reliable). Instead
	   we only rely on the inode number (a.k.a. 'fileid') and the
	   (supposedly unique) filehandle.
	
	Cheers,
	  Trond

<trond.myklebust@fys.uio.no> (02/03/14 1.181)
	[PATCH] 2.4.19-pre3 NFS close-to-open fix part 2 (VFS change)
	
	Hi,
	
	  The following patch fixes the one remaining hole in the
	NFS close-to-open checking. It is due to the VFS assuming that it
	doesn't have to revalidate the dentry when one does open("."), or
	open(".."). This means that the NFS layer is never notified that it
	needs to check the data cache integrity for this case.
	
	
	Al has said he plans to plug this hole in 2.5.x as part of his unionfs
	changes, however we also need a fix in 2.4.x. Other networked
	filesystems (Alan has mentioned OpenGFS) are also having the same
	problem...
	Unless Al has a different suggestion (Al?), the following patch
	inserts the necessary lines into link_path_walk().
	
	Cheers,
	  Trond

<davem@nuts.ninka.net> (02/03/13 1.182)
	Sparc64 updates and fixes:
	1) Add kernel stack overflow debugger, from Kanoj Sarcar.
	2) Initialize FHC irq mapping registers early so we do not
	   scribble over the settings done by Zilog request_irq
	3) Fix misintepretation of EBUS device reg properties.
	4) Add Tunnel, random,  and VLAN ioctl32 translations.
	5) Fix PCI IRQ probing in certain bridging situations.
	6) IPIs can sometimes mistakedly run a BH when IRQs are
	   disabled, fix this by rescheduling IPIs to PIL based
	   interrupts.  Bug discovered by Kanoj Sarcar.
	7) Work around some hw bugs in Schizo PCI controllers.
	8) Fix ramdisk image handling ifdefs, from Ben Collins.
	9) Handle better clock probing in the presence of both
	   EBUS and ISA bridges.
	10) Make set_brkpt work on UltraSPARC-III by not assuming
	    anything about the layout of the rest of the LSU_CONTROL
	    register.
	11) Add missing file->fd[] locking in Solaris emulation layer.
	12) Include linux/in6.h in asm/checksum.h
	13) Fix some FHC controller register offsets, luckily they
	    are currently unreferenced.

<davem@nuts.ninka.net> (02/03/13 1.183)
	Fix unterminated comment in asm-sparc64/ide.h

<marcelo@plucky.distro.conectiva> (02/03/14 1.181.1.1)
	Remove off-by-one Davej's fix in bluesmoke.c: it causes some 
	machines to crash at boot.
	 

<davem@nuts.ninka.net> (02/03/14 1.184)
	Missed this add during sparc64 updates.

<davem@nuts.ninka.net> (02/03/14 1.185)
	Sparc64 build fix: add nop flush_icache_user_range definition.

<davem@nuts.ninka.net> (02/03/14 1.186)
	Kill unused variable warnings in sunlance driver.

<davem@nuts.ninka.net> (02/03/14 1.181.2.1)
	Networking updates and fixes:
	1) Clean up ifdefs in netfilter conntrack header.
	2) Make sock_writeable (used by datagram protocols mostly) much
	   more reasonable.  Kill SOCK_MIN_WRITE_SPACE and replace references
	   with appropriate sock_writeable calls.  The gem discovered by this
	   fix in the sunrpc code was particularly amusing.
	3) In IPV4 output, do not use read/modify/write cycles to set the
	   frag_off field of the IP header.  This avoid pipeline stalls
	   in this hot path.
	4) CONFIG_NETLINK died, do not reference it in netfilter Config.in
	5) Move IRC support make rules into appropriate groups.
	6) Export more NAT netfilter symbols.
	7) In ipt_REJECT module, do not use xchg on potentially unaligned
	pointers.
	8) In ipt_REJECT, do not out ICMP packets with IP_DF set.
	9) Fix networking procfs nodes that report large inode numbers
	as negative.
	10) When creating a timewait bucket, put it into the bind hashes
	first, then the established hash.  This avoids races and consequent
	OOPSes in TCP.
	11) Make UDP short packet log message give more pertinent information.
	12) ipv6 netfilter ip6_table module uses SMP_ALIGN improperly
	13) GRED packet scheduler bug fixes from Jamal Hadi Salim.

<davem@nuts.ninka.net> (02/03/14 1.181.2.2)
	Fix "performance optimization" that breaks the build
	of the ns83820.c on every non-i386 platform.

<davem@nuts.ninka.net> (02/03/14 1.187)
	Kill unused variable warnings in sunbmac.c and sunqe.c

<davem@nuts.ninka.net> (02/03/14 1.188)
	SunGEM driver updates:
	1) Include config.h
	2) Deal with RX fifo hang condition by carefully resetting
	the RX side of the chip.
	3) Wake up TX queue only when MAX_SKB_FRAGS + 1 are free.
	4) Enforce minimum of 68 in gem_change_mtu.
	5) Set cache line size in sw reset register on RIO chips.
	6) Fix all the locking and document it.
	7) When link comes up, indicate if pause is enabled.
	8) Decrease RX fifo threshold to 128.
	9) When setting max frame size register, add in 4 more
	bytes for the sake of VLAN.
	10) Tweak XON/XOFF threshold settings.
	11) Only use infinite bursts on non-sparc64 non-alpha
	as the PCI controllers on those platforms disconnect
	at 64/128 byte boundaries anyways.

<davem@nuts.ninka.net> (02/03/14 1.189)
	Fix unterminated comment in asm-sparc/ide.h

<davem@nuts.ninka.net> (02/03/14 1.181.2.3)
	New driver for Tigon3 gigabit chipsets, written by
	Jeff Garzik and myself.
	Revamp VLAN layer so the locking and refounting are correct
	and add hooks for network driver hw acceleration of VLAN.
	Also improve performance of sw VLANs by using a hash table
	for VLAN group lookups.
	Add VLAN support for 8139cp driver plus other enhancements
	by Jeff.
	Add VLAN acceleration to acenic driver.
	Add new ethtool interfaces for tuning interrupt coalescing,
	RX/TX ring parameters, Pause negotiation, checksumming etc.
	Add packet generator module from Robert Olsson.  Great for
	driver stress testing and performance analysis.

<geert@linux-m68k.org> (02/03/14 1.181.1.2)
	[PATCH] Yearly m68k update (part 41)
	
		Hi Marcelo,

<geert@linux-m68k.org> (02/03/14 1.181.1.3)
	[PATCH] Yearly m68k update (part 40)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Dmasound driver updates for m68k machines
	
	### Comments for drivers/sound/dmasound/dmasound.h
	Reorder to reduce #ifdef HAS_RECORD clutter
	
	### Comments for drivers/sound/dmasound/dmasound_atari.c
	Fix return value of write_sq_setup() implementation
	
	### Comments for drivers/sound/dmasound/dmasound_core.c
	  - Reorder to reduce #ifdef HAS_RECORD clutter
	  - Fix uninitialized `setup_func'
	  - Fix uninitialized `uUsed'
	  - Add dummy routines to reduce #ifdef HAS_RECORD clutter
	
	### Comments for drivers/sound/dmasound/dmasound_paula.c
	Fix return value of write_sq_setup() implementation
	
	### Comments for drivers/sound/dmasound/dmasound_q40.c
	Q40 sound driver updates

<geert@linux-m68k.org> (02/03/14 1.181.1.4)
	[PATCH] Yearly m68k update (part 39)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Cirrus Logic frame buffer device driver updates for Zorro bus
	
	### Comments for drivers/video/clgenfb.c
	  - release_io_ports is used for PCI boards only, not for Zorro boards
	  - kill warnings when unmapping Zorro space

<geert@linux-m68k.org> (02/03/14 1.181.1.5)
	[PATCH] Yearly m68k update (part 36)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Amiga CyberVision64/3D graphics card driver updates
	
	### Comments for drivers/video/virgefb.c
	  - Add video mode programming support
	  - Add Zorro II support
	
	### Comments for drivers/video/virgefb.h
	Add CyberVision64/3D register definitions

<geert@linux-m68k.org> (02/03/14 1.181.1.6)
	[PATCH] Yearly m68k update (part 31)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Remove superfluous includes in m68k drivers
	
	### Comments for drivers/block/z2ram.c
	Remove superfluous #include <asm/io.h>
	
	### Comments for drivers/char/amiserial.c
	Remove superfluous #include <asm/io.h>
	
	### Comments for drivers/net/a2065.c
	Remove superfluous #include <asm/io.h>
	
	### Comments for drivers/net/ariadne.c
	Remove superfluous #include <asm/io.h>
	
	### Comments for drivers/net/ariadne2.c
	Remove superfluous #include <asm/io.h>
	
	### Comments for drivers/video/amifb.c
	Remove superfluous #include <asm/io.h>
	
	### Comments for drivers/ide/falconide.c
	Remove superfluous #include <linux/config.h>

<geert@linux-m68k.org> (02/03/14 1.181.1.7)
	[PATCH] Yearly m68k update (part 27)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Update support for Sun 3/3x Ethernet adapters
	
	### Comments for Documentation/Configure.help
	Add help entries for CONFIG_SUN3LANCE and CONFIG_SUN3_82586
	
	### Comments for drivers/net/sun3lance.c
	Update for the Sun3 LANCE Ethernet driver for the Sun 3/50, 3/60, and 3/80
	workstations (add support for Sun 3x a.o.)
	
	### Comments for drivers/net/sun3_82586.c
	Add Sun3 i82586 Ethernet driver for the Sun 3/1xx and 3/2xx motherboards, by
	Sam Creasey <sammy@sammy.net>
	
	### Comments for drivers/net/sun3_82586.h
	Add Intel i82586 Ethernet definitions
	
	### Comments for drivers/net/Makefile
	Add Sun3 i82586 Ethernet driver
	
	### Comments for drivers/net/Space.c
	Add Sun3 i82586 Ethernet driver

<geert@linux-m68k.org> (02/03/14 1.181.1.8)
	[PATCH] Yearly m68k update (part 35)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Remove unused variables on m68k
	
	### Comments for arch/m68k/kernel/ptrace.c
	Remove unused variable `flags'
	
	### Comments for drivers/block/amiflop.c
	Remove unused variable `sb'

<geert@linux-m68k.org> (02/03/14 1.181.1.9)
	[PATCH] Yearly m68k update (part 24)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Spelling fix on m68k
	
	### Comments for include/asm-m68k/serial.h
	Spelling fix

<geert@linux-m68k.org> (02/03/14 1.181.1.10)
	[PATCH] Yearly m68k update (part 38)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Amiga Zorro bus updates
	
	### Comments for arch/ppc/amiga/config.c
	Print Zorro bus type in /proc/hardware (cfr. m68k)
	
	### Comments for drivers/block/z2ram.c
	Use z_remap_nocache_nonser() to map Zorro II RAM
	
	### Comments for drivers/net/ariadne2.c
	Use z_*() routines to access Zorro space
	
	### Comments for drivers/net/hydra.c
	Use z_*() routines to access Zorro space
	
	### Comments for drivers/zorro/zorro.ids
	Add ID for Super Big Bang Accelerator, SCSI Host Adapter and RAM Expansion
	
	### Comments for include/asm-ppc/zorro.h
	Add z_*() Zorro bus access routines (cfr. m68k)
	
	### Comments for include/linux/zorro.h
	Always include <asm/zorro.h> for arch (m68k/PPC) dependencies

<geert@linux-m68k.org> (02/03/14 1.181.1.11)
	[PATCH] Yearly m68k update (part 28)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Add Sun-3x floppy support
	
	### Comments for drivers/block/floppy.c
	Add Sun-3x support to the standard floppy driver

<geert@linux-m68k.org> (02/03/14 1.181.1.12)
	[PATCH] Yearly m68k update (part 13)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Add missing MODULE_LICENSE("GPL") in m68k drivers
	
	### Comments for drivers/net/7990.c
	Add missing MODULE_LICENSE("GPL")
	
	### Comments for drivers/net/ariadne.c
	Add missing MODULE_LICENSE("GPL")
	
	### Comments for drivers/net/ariadne2.c
	Add missing MODULE_LICENSE("GPL")
	
	### Comments for drivers/net/daynaport.c
	  - Add missing MODULE_LICENSE("GPL")
	  - Remove incorrect Emacs compile command (-m486 can't be correct on m68k)
	
	### Comments for drivers/parport/parport_mfc3.c
	Add missing MODULE_LICENSE("GPL")
	
	### Comments for drivers/scsi/NCR53C9x.c
	Add missing MODULE_LICENSE("GPL")
	
	### Comments for drivers/scsi/a2091.c
	Add missing MODULE_LICENSE("GPL")
	
	### Comments for drivers/scsi/a3000.c
	Add missing MODULE_LICENSE("GPL")
	
	### Comments for drivers/scsi/atari_scsi.c
	Add missing MODULE_LICENSE("GPL")
	
	### Comments for drivers/scsi/blz1230.c
	Add missing MODULE_LICENSE("GPL")
	
	### Comments for drivers/scsi/blz2060.c
	Add missing MODULE_LICENSE("GPL")
	
	### Comments for drivers/scsi/cyberstorm.c
	Add missing MODULE_LICENSE("GPL")
	
	### Comments for drivers/scsi/cyberstormII.c
	Add missing MODULE_LICENSE("GPL")
	
	### Comments for drivers/scsi/fastlane.c
	Add missing MODULE_LICENSE("GPL")
	
	### Comments for drivers/scsi/gvp11.c
	Add missing MODULE_LICENSE("GPL")
	
	### Comments for drivers/scsi/mac_esp.c
	Add missing MODULE_LICENSE("GPL")
	
	### Comments for drivers/scsi/oktagon_esp.c
	Add missing MODULE_LICENSE("GPL")
	
	### Comments for drivers/scsi/wd33c93.c
	Add missing MODULE_LICENSE("GPL")

<geert@linux-m68k.org> (02/03/14 1.181.1.13)
	[PATCH] Yearly m68k update (part 37)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Add support for the Amiga X-Surf IDE interface
	
	### Comments for drivers/ide/Config.in
	Add X-Surf IDE interface
	
	### Comments for drivers/ide/buddha.c
	Add support for the Amiga X-Surf IDE interface (very similar to the
	Buddha/Catweasel driver)

<geert@linux-m68k.org> (02/03/14 1.181.1.14)
	[PATCH] Yearly m68k update (part 7)
	
		Hi Marcelo,
	
	### Comments for Changeset
	/proc/cpuinfo updates for m68k
	
	### Comments for arch/m68k/kernel/setup.c
	  - get_cpuinfo() was replaced by show_cpuinfo()
	  - Add cpuinfo_op seq_file operations

<geert@linux-m68k.org> (02/03/14 1.181.1.15)
	[PATCH] Yearly m68k update (part 32)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Syscall updates for m68k
	
	### Comments for arch/m68k/kernel/entry.S
	Add pivot_root syscall
	
	### Comments for include/asm-m68k/unistd.h
	Add pivot_root syscall

<geert@linux-m68k.org> (02/03/14 1.181.1.16)
	[PATCH] Yearly m68k update (part 34)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Update m68k trap handling
	
	### Comments for arch/m68k/kernel/traps.c
	  - Fix list of included header files
	  - Fix address of access error on 68060
	  - Prohibit the compiler from reordering some inline asm code
	  - Update stack dump code

<geert@linux-m68k.org> (02/03/14 1.181.1.17)
	[PATCH] Yearly m68k update (part 25)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Update Atari ST-RAM driver for changes in VM subsystem
	
	### Comments for arch/m68k/atari/stram.c
	Update Atari ST-RAM driver for changes in VM subsystem

<geert@linux-m68k.org> (02/03/14 1.181.1.18)
	[PATCH] Yearly m68k update (part 11)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Update I/O handling on m68k (inb() and friends are for real ISA/PCMCIA/PCI I/O
	space only)
	
	### Comments for arch/m68k/atari/time.c
	Use atari_writeb() for Atari builtin hardware accesses
	
	### Comments for drivers/net/8390.h
	Use {in,out}_8() for 8-bit memory space accesses on m68k
	
	### Comments for drivers/net/apne.c
	Convert AMIGA PCMCIA NE2000 driver to use real PCMCIA space accesses

<geert@linux-m68k.org> (02/03/14 1.181.1.19)
	[PATCH] Yearly m68k update (part 30)
	
		Hi Marcelo,
	
	### Comments for Changeset:
	Sun-3/3x SCSI host adapter updates
	
	### Comments for Documentation/Configure.help:
	Add help entries for CONFIG_SUN3_SCSI and CONFIG_SUN3X_ESP
	
	### Comments for drivers/scsi/sun3_scsi.c
	Update code
	Add MODULE_LICENSE
	
	### Comments for drivers/scsi/sun3x_esp.c
	Add MODULE_LICENSE
	
	### Comments for drivers/scsi/sun3_NCR5380.c
	  - Call BUG() on fatal error
	  - Update email address of author

<geert@linux-m68k.org> (02/03/14 1.181.1.20)
	[PATCH] Yearly m68k update (part 6)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Update general m68k configuration
	
	### Comments for arch/m68k/config.in
	  - Update PPP configuration
	  - Allow NE2000 support to be modular
	  - Update kernel debugging configuration

<geert@linux-m68k.org> (02/03/14 1.181.1.21)
	[PATCH] Yearly m68k update (part 33)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Fix struct tq_struct initialization in m68k SCSI drivers
	
	### Comments for drivers/scsi/atari_NCR5380.c
	Fix struct tq_struct initialization
	
	### Comments for drivers/scsi/mac_NCR5380.c
	Fix struct tq_struct initialization
	
	### Comments for drivers/scsi/oktagon_esp.c
	Fix struct tq_struct initialization
	
	### Comments for drivers/scsi/sun3_NCR5380.c
	Fix struct tq_struct initialization

<geert@linux-m68k.org> (02/03/14 1.181.1.22)
	[PATCH] Yearly m68k update (part 4)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Updates for the m68k floating point emulator
	
	### Comments for arch/m68k/math-emu/fp_emu.h
	Protect C definitions against inclusion from asm sources.

<geert@linux-m68k.org> (02/03/14 1.181.1.23)
	[PATCH] Yearly m68k update (part 2)
	
		Hi Marcelo,
	
	### Comments for Changeset
	A3000 SCSI host adapter updates
	
	### Comments for drivers/scsi/a3000.c
	Remove superfluous #ifdefs

<geert@linux-m68k.org> (02/03/14 1.181.1.24)
	[PATCH] Yearly m68k update (part 8)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Add <asm/hw_irq.h> for m68k
	
	### Comments for include/asm-m68k/hw_irq.h
	Add dummy <asm/hw_irq.h>

<geert@linux-m68k.org> (02/03/14 1.181.1.25)
	[PATCH] Yearly m68k update (part 12)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Update ISA space code on m68k
	
	### Comments for arch/m68k/config.in
	  - Q40 has real ISA
	  - Amiga PCMCIA behaves like ISA
	
	### Comments for arch/m68k/kernel/setup.c
	Add support for multiple types of ISA busses in one kernel image (e.g. an
	image for both Q40 and Amiga with PCMCIA)
	
	### Comments for drivers/char/mem.c
	Allow port operations on m68k if CONFIG_ISA is defined

<geert@linux-m68k.org> (02/03/14 1.181.1.26)
	[PATCH] Yearly m68k update (part 16)
	
		Hi Marcelo,
	
	### Comments for Changeset
	MVME serial driver updates
	
	### Comments for drivers/char/serial167.c
	  - Add missing save of interrupt state
	  - _tty_name() got renamed to tty_name()
	  - Add devfs support
	
	### Comments for drivers/char/vme_scc.c
	  - Add devfs support
	  - Add KERN_* to kernel messages
	  - Simplify baud logic
	  - Add missing MOD_DEC_USE_COUNT
	  - Add missing cli()
	  - block_til_ready() got renamed to gs_block_til_ready()

<geert@linux-m68k.org> (02/03/14 1.181.1.27)
	[PATCH] Yearly m68k update (part 3)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Inline asm updates for m68k
	
	### Comments for arch/m68k/hp300/time.c
	Fix inline asm constraint
	
	### Comments for arch/m68k/kernel/process.c
	Optimize asm constraints
	
	### Comments for arch/m68k/math-emu/multi_arith.h
	Fix inline asm constraints

<geert@linux-m68k.org> (02/03/14 1.181.1.28)
	[PATCH] Yearly m68k update (part 29)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Sun-3 MMU updates
	
	### Comments for arch/m68k/kernel/sun3-head.S
	Sun-3 MMU updates

<geert@linux-m68k.org> (02/03/14 1.181.1.29)
	[PATCH] Yearly m68k update (part 19)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Misc Q40/Q60 updates
	
	### Comments for CREDITS
	Update info for Richard Zidlicky
	
	### Comments for include/asm-m68k/q40_master.h
	Prefix symbols with Q40_

<geert@linux-m68k.org> (02/03/14 1.181.1.30)
	[PATCH] Yearly m68k update (part 21)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Update struct scatterlist on m68k
	
	### Comments for include/asm-m68k/scatterlist.h
	Update struct scatterlist on m68k

<geert@linux-m68k.org> (02/03/14 1.181.1.31)
	[PATCH] Yearly m68k update (part 17)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Update m68k for changes in the mm subsystem
	
	### Comments for include/asm-m68k/motorola_pgtable.h
	  - Remove page_address() (was moved to <linux/mm.h>)
	  - Remove obsolete __page_address()
	
	### Comments for include/asm-m68k/sun3_pgtable.h
	  - Remove page_address() (was moved to <linux/mm.h>)
	  - Remove obsolete __page_address()

<geert@linux-m68k.org> (02/03/14 1.181.1.32)
	[PATCH] Yearly m68k update (part 5)
	
		Hi Marcelo,
	
	### Comments for Changeset
	M68k BUG() updates
	
	### Comments for include/asm-m68k/page.h
	Make BUG() a simple illegal instruction unless #ifdef CONFIG_DEBUG_BUGVERBOSE

<geert@linux-m68k.org> (02/03/14 1.181.1.33)
	[PATCH] Yearly m68k update (part 15)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Update m68k misc character drivers
	
	### Comments for drivers/char/Makefile
	  - Fix keyboard selection for Mac and Q40
	  - Q40 uses the standard NS16550 serial driver

<geert@linux-m68k.org> (02/03/14 1.181.1.34)
	[PATCH] Yearly m68k update (part 26)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Sun-3 DVMA updates
	
	### Comments for arch/m68k/sun3/sun3dvma.c
	Sun-3 DVMA updates

<geert@linux-m68k.org> (02/03/14 1.181.1.35)
	[PATCH] Yearly m68k update (part 22)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Signal updates for m68k
	
	### Comments for arch/m68k/kernel/signal.c
	Signal updates for m68k

<geert@linux-m68k.org> (02/03/14 1.181.1.36)
	[PATCH] Yearly m68k update (part 1)
	
		Hi Marcelo,
	
	### Comments for Changeset
	A2065 Ethernet driver updates
	
	### Comments for drivers/net/a2065.c
	Stop the LANCE before calling request_irq() (cfr. sunlance.c)

<geert@linux-m68k.org> (02/03/14 1.181.1.37)
	[PATCH] Yearly m68k update (part 23)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Update m68k for changes in softirq handling
	
	### Comments for arch/m68k/atari/ataints.c
	Update for changes in softirq handling
	
	### Comments for arch/m68k/kernel/entry.S
	Update for changes in softirq handling

<geert@linux-m68k.org> (02/03/14 1.181.1.38)
	[PATCH] Yearly m68k update (part 9)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Remove duplicated code in m68k mm code
	
	### Comments for arch/m68k/mm/memory.c
	Remove duplicated code

<geert@linux-m68k.org> (02/03/14 1.181.1.39)
	[PATCH] Yearly m68k update (part 10)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Update m68k fault handling
	
	### Comments for arch/m68k/mm/fault.c
	  - Update page fault handling
	  - Allow init to survive page faults

<geert@linux-m68k.org> (02/03/14 1.181.1.40)
	[PATCH] Yearly m68k update (part 18)
	
		Hi Marcelo,
	
	### Comments for Changeset
	Add /proc/hardware (m68k and PPC/Amiga) and /proc/stram (m68k/Atari)
	
	### Comments for fs/proc/proc_misc.c
	Add /proc/hardware and /proc/stram

<geert@linux-m68k.org> (02/03/14 1.181.1.41)
	[PATCH] Yearly m68k update (part 20)
	
		Hi Marcelo,

<kraxel@bytesex.org> (02/03/14 1.181.1.42)
	[PATCH] v4l: video4linux API doc update
	
	This patch updates/fixes the video4linux API documentation.  The current
	description for mmap() based capture is unclear and somewhat misleading.

<kraxel@bytesex.org> (02/03/14 1.181.1.43)
	[PATCH] vmalloc_to_page() backport for 2.4
	
	
	This is a 2.4.x backport of the new 2.5.x vmalloc_to_page() function.
	I'd like to see that function in 2.4.x too because it makes driver
	maintaining easier.

<kraxel@bytesex.org> (02/03/14 1.181.1.44)
	[PATCH] v4l: videodev redesign
	
	
	This patch is a redesign for videodev.[ch].  2.5.7-pre1 has a similar
	update, the main difference is that this 2.4 version of the patch
	supports both traditional (for backward compatibility) and 2.5-like (to
	simplify backporting 2.5 drivers) registration of v4l drivers.
	
	Changes in detail:
	
	- Allow drivers to use struct file_operations directly instead of the
	  read/write/mmap/poll/... function pointers in struct video_device.
	  2.5.x will drop the function pointers altogether.  Dispatching to
	  different drivers by minor number is done the same way soundcore.o
	  handles this: swap file->f_fops at open() time.
	
	- Stop using the BKL, use a mutex to protect open,register+unregister
	  calls against races.
	
	- provide a video_generic_ioctl() function which can (and should) be
	  used by v4l drivers to handle copying from and to userspace.
	
	- provide video_exclusive_open/release functions which can be used by
	  v4l drivers to make sure only one process at a time opens the
	  device.  They can be hooked directly into struct file_operations if
	  some driver has nothing to initialize at open time (which is true
	  for many drivers in drivers/media/radio/).

<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.45)
	[PATCH] ISDN fixes / update
	

<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.46)
	[PATCH] ISDN fixes / update
	
	Marcelo,
	
	this patch moves ISDN initialization behind USB initialization.
	When the ST5481 USB ISDN driver was built into the kernel, it initialized
	before the USB subsystem, causing a crash. As nothing else depends on
	ISDN, it's safe to have it go last.
	
	--Kai

<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.47)
	[PATCH] ISDN fixes / update
	
	Marcelo,
	
	this patch fixes a couple of minor bugs in the build system. Some rare
	selections at configure time would cause objects to be missing in the
	build.
	
	--Kai

<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.48)
	[PATCH] ISDN fixes / update
	
	Marcelo,
	
	this patch disables some config choices which would result in a failing
	build.
	
	--Kai

<kai-germaschewski@uiowa.edu> (02/03/14 1.181.1.49)
	[PATCH] ISDN fixes / update
	
	Marcelo,
	
	this patch adds the PCMCIA client driver for the AVM A1/Fritz!PCMCIA
	ISDN cards, which was only available as an external patch before.
	
	The combined patch has been test by two people who have the hardware and
	has been reported to work fine.
	
	--Kai

<greg@kroah.com> (02/03/14 1.181.1.50)
	[PATCH] USB Config.in update
	
	Hi,
	
	Here's a patch against 2.4.19-pre3 for the USB Config.in files that
	fixes a problem when CONFIG_USB is not selected, and updates the
	CONFIG_USB_SERIAL_IPAQ description.
	
	thanks,
	
	greg k-h

<greg@kroah.com> (02/03/14 1.181.1.51)
	[PATCH] USB edgeport driver bugfix
	
	Hi,
	
	Here's a patch against 2.4.19-pre3 for the USB edgeport driver that
	fixes a bug when more than one edgeport device is in the system at the
	same time.
	
	thanks,
	
	greg k-h

<greg@kroah.com> (02/03/14 1.181.1.52)
	[PATCH] USB usbfs name added
	
	Hi,
	
	Here's a patch against 2.4.19-pre3 for the USB file system that allows
	people to mount it as 'usbfs' as well as the old 'usbdevfs' name.  This
	is due to the 'usbdevfs' name being phased out over time due to people
	mistaking it with devfs.
	
	thanks,
	
	greg k-h

<greg@kroah.com> (02/03/14 1.181.1.53)
	[PATCH] USB ipaq driver bugfix
	
	Hi,
	
	Here's a patch against 2.4.19-pre3 for the USB ipaq driver that fixes a
	bug where the connection could get messed up.  The patch is by Ganesh
	Varadarajan.
	
	thanks,
	
	greg k-h

<greg@kroah.com> (02/03/14 1.181.1.54)
	[PATCH] USB catc ethtool support
	
	Hi,
	
	Here's a patch against 2.4.19-pre3 for the USB catc driver that adds
	ethtool support to the driver.  The patch was done by Brad Hards.
	
	thanks,
	
	greg k-h

<greg@kroah.com> (02/03/14 1.181.1.55)
	[PATCH] USB CREDITS and MAINTAINERS update
	
	Hi,
	
	Here's a patch against 2.4.19-pre3 that updates the CREDITS and
	MAINTAINERS file entry for Petko Manolov, and changes the maintainer
	info for the USB Keyspan drivers from Hugh to me.
	
	thanks,
	
	greg k-h

<greg@kroah.com> (02/03/14 1.181.1.56)
	[PATCH] USB pegasus ethtool support
	
	Hi,
	
	Here's a patch against 2.4.19-pre3 for the USB pegasus driver that adds
	ethtool support to the driver and adds support for a few new devices.
	The patch was done by Petko Manolov.
	
	thanks,
	
	greg k-h

<greg@kroah.com> (02/03/14 1.181.1.57)
	[PATCH] USB em26 driver added
	
	Hi,
	
	Here's a patch against 2.4.19-pre3 that adds support for the Emagic EMI
	2|6 USB devices.  This driver was done by Tapio Laxström.
	
	thanks,
	
	greg k-h

<davem@nuts.ninka.net> (02/03/14 1.181.2.4)
	Allow ARP packets to be seen by netfilter.

<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.58)
	Put back the option to support AVM A1 / Fritz! PCMCIA cards inside hisax.
	People may want to use it with the standalone PCMCIA package.

<davem@nuts.ninka.net> (02/03/14 1.181.2.5)
	Include linux/netfilter_arp.h

<marcelo@plucky.distro.conectiva> (02/03/14 1.192)
	Add missing aic7xxx updates

<axboe@suse.de> (02/03/14 1.193)
	[PATCH] cciss driver pci_*_consistent(NULL,...) fix for 2.4.19-pre2 (1 of 4)
	
	Use the right pci dev passed in for pci_alloc

<axboe@suse.de> (02/03/14 1.194)
	[PATCH] cciss driver GETLUNINFO ioctl (2 of 4)
	
	Add GETLUNINFO as used by Compaq online array utilities.

<axboe@suse.de> (02/03/14 1.195)
	[PATCH] cciss driver HDIO_GETGEO_BIG ioctl for 2.4.19-pre2 (3 of 4)
	
	Patch to add HDIO_GETGEO_BIG ioctl, and clean up HDIO_GETGEO ioctl
	for cciss driver.

<axboe@suse.de> (02/03/14 1.196)
	[PATCH] remove CCISS_REVALIDVOLS ioctl for 2.4.19-pre2 (4 of 4)
	
	Patch to remove CCISS_REVALIDVOLS ioctl from cciss driver.
	The ioctl require the process calling this ioctl to be the
	_only_ process with _anything_ open on the controller, a
	requirement which makes the ioctl next to useless.  It is
	superceded by the ioctls to register and deregister new disks
	which are already in the driver.  I know of no application
	which uses this ioctl.   -- steve.cameron@compaq.com

<marcelo@plucky.distro.conectiva> (02/03/14 1.197)
	The problem is that both the sd and sr drivers treat an
	error that was recovered by the device as a fatal error.  SCSI
	devices use the recovered error status to inform the host that
	some recovery action was required to complete the command, but
	that the command was successfully completed.  Since Recovered
	Errors can be the harbinger of a future device failure, they
	should be logged for the system adminstrator to see, but the
	command should not be reported as failed to the rest of the system.
	
	The mechanics of the patch are pretty simple.  If you don't
	explicitly filter out an error in the "rw_intr", the default
	action by the completion code is to fail it.  The change is
	to look for recovered errors in each driver, print out the
	sense information about the error, and then clear the error
	status so that the command is completed as though no error
	were reported by the device.
	

<davem@nuts.ninka.net> (02/03/14 1.181.2.6)
	From Harald Welte and the Netfilter team:
	
	This patch adds support for destination nat on connections initiated by
	local processes.  This is needed in a couple of setups but not supported
	by our current codebase.
	
	However, as it is a little bit expensive to hook the nat table into yet
	another netfilter hoook, we have made it a kernel config option

<davem@nuts.ninka.net> (02/03/14 1.181.2.7)
	From Harald Welte and the Netfilter team:
	
	This patch fixes two issues:
	
	1) implement missing ip_conntrack_protocol_unregister function
	2) export ip_conntrack_unexpect_related symbol

<EdV@macrolink.com> (02/03/15 1.198)
	This patch corrects PCI device id in pci_ids.h for Oxford Semi OX16PCI952
	PCI/dual 16950 UART chip, and adds this entry to pci.ids.  I downloaded the
	datasheet today and verified that 9521 is the correct device id.

<jgarzik@mandrakesoft.com> (02/03/15 1.199)
	Remove VT8233 pci ids from via82cxxx_audio sound driver.
	VT8233 is not supported by this driver without several additions (besides pci id).

<nahshon@actcom.co.il> (02/03/15 1.200)
	Fix via audio recording, when frag size < page size.

<silicon@falcon.sch.bme.hu> (02/03/15 1.201)
	Add new slicecom/munich WAN driver.

<hch@caldera.de> (02/03/15 1.197.1.1)
	[PATCH] remove superflous assignment in mmap()
	
	Hi Marcelo,
	
	the appended patch removes a superflous assignment in mm/mmap.c.
	Proof: no codepatch that uses error after line 479 can be executed
	without assigning to error before.  From -aa.
	
	Please apply,
	
		Christoph
	
	--
	Of course it doesn't work. We've performed a software upgrade.

<hch@caldera.de> (02/03/15 1.197.1.2)
	[PATCH] Error return fixes
	
	Hi Marcelo,
	
	it looks like SuSE did some audit of the syscall error return values.
	(Maybe for LSB?), the attached patch, which I extracted from their tree,
	contains following fixes:
	
	 o msync/mrptotect are not supposed to return EFAULT, return ENOMEM instead.
	 o msync can't be both sync and async
	 o shmdt is only supposed to return 0 in success case.  This actually
	   looks like a typo in the original code :)
	
	Please apply,
	
		Christoph
	
	--
	Of course it doesn't work. We've performed a software upgrade.

<hch@caldera.de> (02/03/15 1.197.1.3)
	[PATCH] missing include in net/sunrpc/stats.c
	
	Hi Marcelo,
	
	the appended patch adds a missing #include <linux/init.h> to
	net/sunrpc/stats.c.  You don't see this as it is accidentally
	picked up by some <asm/*> header on i386.
	
	Please apply,
	
		Christoph
	
	--
	Of course it doesn't work. We've performed a software upgrade.

<davem@nuts.ninka.net> (02/03/15 1.181.2.8)
	Add arptables netfilter module for registering ARP
	packet filtering rules.

<bfennema@falcon.csc.calpoly.edu> (02/03/15 1.197.1.4)
	Missing byte swaps needed for big endian archs
	Fixes writing the descriptor version for udf revisions >= 2.0
	Fixes an extent preallocation bug and adds missing sb_bread == NULL checks
	Moves the udf spec header files into the fs/udf directory and removes all the
	non-standard sized typedefs

<mikpe@csd.uu.se> (02/03/15 1.197.1.5)
	[PATCH] boot_cpu_data corruption on SMP x86
	
	The patch below eliminates a case of boot_cpu_data corruption
	on SMP x86 machines. This was first observed on SMP Athlons,
	but it also affects SMP Intel boxes in a less serious way.
	
	When the secondary processors boot and execute head.S:checkCPUtype,
	the code performs a 32-bit write of a small constant to the
	byte-sized variable boot_cpu_data.x86 (X86 in head.S). Since the
	write is 32-bit, it also writes zeros to the following 3 bytes,
	which clobbers the x86_vendor, x86_model, and x86_mask fields
	previously set up by check_bugs()'s call to identify_cpu().
	Thus, after smp_init(), boot_cpu_data will _always_ identify
	the CPU as an Intel (X86_VENDOR_INTEL == 0 in processor.h) with
	model 0 and stepping 0.
	
	The effect in standard kernels is not catastrophic, since:
	(a) most SMP x86 boxes are Intel
	(b) most uses of x86_vendor occur before smp_init() or reference
	    the SMP cpu_data[] array
	(c) most post-boot references to boot_cpu_data occur in the
	    cpu_has_XXX macros which only read the x86_capability[] array
	However, third-party extensions (like my x86 performance-monitoring
	conters driver) can get seriously confused by this mis-identification.
	
	The patch is for 2.4.19-pre3, but it also applies to 2.5.6 and
	2.2.21rc1. Please apply.
	
	/Mikael

<bfennema@falcon.csc.calpoly.edu> (02/03/15 1.197.1.7)
	Fix videodev build warning

<davem@nuts.ninka.net> (02/03/17 1.181.2.9)
	Fix netfilter IPv4 conntrack build.

<marcelo@plucky.distro.conectiva> (02/03/19 1.204)
	Changed EXTRAVERSION in Makefile to pre4

<stelian.pop@fr.alcove.com> (02/03/19 1.205)
	[PATCH] videodev.c oopses in video_exclusive_register
	
	Hi,
	
	The recent videodev.c backport doesn't initialise the 'lock' mutex
	which is used in video_exclusive_register. Any driver using
	this function will cause an oops in this function.
	
	Apply this patch to make it work.
	
	Note to Gerd: I've ported the meye driver (see next patch) to the
	new API and I'm pleased to report that it works correctly on
	both 2.4 and 2.5 kernel lines. Good job!
	
	Stelian.
	
	
	You can import this changeset into BK by piping this whole message to
	'| bk receive [path to repository]' or apply the patch as usual.
	
	===================================================================
	
	
	ChangeSet@1.198, 2002-03-15 11:47:32+01:00, stelian@popies.net
	  Do initialise the vfd->lock or else video_exclusive_register will oops.
	
	
	 videodev.c |    1 +
	 1 files changed, 1 insertion(+)

<stelian.pop@fr.alcove.com> (02/03/19 1.206)
	[PATCH] meye driver update to new V4L API.
	
	Hi,
	
	The attached BK patch (dependent on the previous videodev.c one)
	backports the 2.5 version of the Motion Eye driver to 2.4 using
	the recent changes in V4L API and the memory allocation cleanups,
	thanks to vmalloc_to_page.
	
	Stelian.
	
	You can import this changeset into BK by piping this whole message to
	'| bk receive [path to repository]' or apply the patch as usual.
	
	===================================================================
	
	
	ChangeSet@1.199, 2002-03-15 11:53:50+01:00, stelian@popies.net
	  Backport the 2.5 meye driver thanks to the recent Gerd's work:
	  	- use the new V4L API
	  	- use vmalloc_to_page and clean up memory allocation
	
	
	 meye.c |  279 ++++++++++++++++++++++++++---------------------------------------
	 meye.h |    3
	 2 files changed, 114 insertions(+), 168 deletions(-)

<rusty@rustcorp.com.au> (02/03/19 1.207)
	[PATCH] 2.4.19-pre3 Trivial I: seq_file.h update
	
	Hi Marcelo,
	
		It's Monday again (well, it was a public holiday here Monday,
	so I'm a day late).  That means trivial patch day!  Yay!
	
	David Gibson <david@gibson.dropbear.id.au>: struct seq_file private pointer:
	  The patch below adds a private pointer field to struct seq_file.
	  Without this the seq_file interface is essentially unusable for
	  drivers.  2.5 already has the field, please apply to 2.4.
	
	
	(Included in 2.5)

<rusty@rustcorp.com.au> (02/03/19 1.208)
	[PATCH] Trivial I: fs_exec.c core fix
	
	Obviously correct.
	
	Martin Pool <mbp@samba.org>: trivial kernel patch -- clean up fs_exec.c:

<rusty@rustcorp.com.au> (02/03/19 1.209)
	[PATCH] 2.4.19-pre3 Trivial III: -ENOTTY for nvram
	
	Paul Gortmaker <p_gortmaker@yahoo.com>: ENOTTY for nvram ioctl:
	   ioctl(d, valid, crap) --> -EINVAL
	   ioctl(d, crap, ....)  --> -ENOTTY
	
	  man ioctl agrees:
	
	         ENOTTY The specified request does not apply to the kind of
	                object that the descriptor d references.
	
	  Currently we return -EINVAL for both cases which is not as
	  informative for debugging stuff.
	
	  Patch is for 2.5.6 but applies cleanly (with minor offset) to 2.4.19p2
	
	  Paul.

<rusty@rustcorp.com.au> (02/03/19 1.210)
	[PATCH] 2.4.19-pre3 Trivial IV: -ENOTTY
	
	Paul Gortmaker <p_gortmaker@yahoo.com>: ENOTTY for rtc ioctl:
	   ioctl(d, valid, crap) --> -EINVAL
	   ioctl(d, crap, ....)  --> -ENOTTY
	
	  man ioctl agrees:
	
	         ENOTTY The specified request does not apply to the kind of
	                object that the descriptor d references.
	
	  Currently we return -EINVAL for both cases which is not as
	  informative for debugging stuff.
	
	  Patch is for 2.5.6 but applies cleanly (with minor offset) to 2.4.19p2
	
	  Paul.

<rusty@rustcorp.com.au> (02/03/19 1.211)
	[PATCH] 2.4.19-pre3 Trivial VI: MSDOS options
	
	René Scharfe <l.s.r@web.de>: MSDOS filesystem option mistreatment:
	  Hello,
	
	  this fixes a longstanding buglet in kernels 2.4 and 2.5, where
	  the MSDOS filesystem would ignore its 'check' mount option.
	
	  René
	
	[Approved by Al Viro]

<marcelo@plucky.distro.conectiva> (02/03/19 1.212)
	If setup_arg_pages() fails, we continue
	although nothing went wrong.  The following patch kills the process
	instead.

<rmk@arm.linux.org.uk> (02/03/19 1.213)
	[PATCH] 2.4 and 2.5: remove Alt-Sysrq-L
	
	Linus, Marcelo, Dave,
	
	The following patch removes Alt-Sysrq-L and its associated hack to kill
	of PID1, the init process.  This is a mis-feature.
	
	If PID1 is killed, the kernel immediately enters an infinite loop in the
	depths of do_exit() with interrupts disabled, completely locking the
	machine.  Obviously you can only reach for the reset button or power
	switch after this, leaving you with dirty filesystems.
	
	This patch has appeared on LKML a couple of months ago.

<rmk@arm.linux.org.uk> (02/03/19 1.214)
	[PATCH] 2.5 and 2.4: fix PCI IO BAR flags
	
	There is a problem where the resource flags sometimes contain bits from
	the address part of the PCI BAR, especially when you have the low address
	bit set for an IO BAR.
	
	(bit 3 of a PCI IO BAR is an address bit, and (bar & 0xf) propagates this
	to res->flags).
	
	This exists in Ivan Kokshaysky PCI patches, and so far hasn't made it into
	the kernel.  It's required for IDE on certain ARM machines to even work.
	
	This patch fixes this.  Please apply.

<marcelo@plucky.distro.conectiva> (02/03/19 1.215)
	Remove unused videodev_register_lock

<marcelo@plucky.distro.conectiva> (02/03/19 1.216)
	Avoid page_to_phys() from truncating the physical addresses to 32bit,
	loosing higher bits.

<hch@caldera.de> (02/03/19 1.217)
	[PATCH] fix Config.in breakage
	
	The appended patch fixes an Config.in abuse in drivers/net/Config.in.
	The problem is that a mips-specific choice tries to redefine CONFIG_NE2000
	as bool although it is a tristate - this breaks strict parses such as
	mconfig.

<hch@caldera.de> (02/03/19 1.218)
	[PATCH] kill slow-path micro-optimization
	
	With the struct page reduction patch a micro-optimization that
	only applies to a very slow path has crept in: __SetPageReserved.
	
	The additional locked instructions absoloutly don't matter when
	booting up, it also is in wrong place in mm.h :)

<hch@caldera.de> (02/03/19 1.219)
	[PATCH] export rbtree routines
	
	It makes sense to use rbtree routines in modules. From -aa.

<paulus@samba.org> (02/03/19 1.220)
	[PATCH] Re: [PATCH] zlib double-free bug
	
	Someone pointed me at a previously-posted patch for the zlib
	vulnerability.  While I was looking at that patch I realized that both
	that patch and mine were buggy in different ways.  My patch was
	freeing s->sub.trees.blens after that word had been overwritten by an
	assignment to s->sub.decode.codes, whereas with the previously-posted
	patch, it is still possible to get a double-free (if inflate_codes_new
	returns NULL, it will leave s->mode == DTREE but s->sub.trees.blens
	has already been freed).
	
	Here is a new patch which should fix both those problems.
	
	Paul.

<trond.myklebust@fys.uio.no> (02/03/20 1.222)
	[PATCH] Fix bug in sunrpc code...
	
	Marcelo,
	
	  The following change is necessary to prevent a hang in NFS when UDP
	sockets run out of buffer space.
	
	Cheers,
	  Trond
	
	# This is a BitKeeper generated patch for the following project:
	# Project Name: Linux kernel tree
	# This patch format is intended for GNU patch command version 2.5 or higher.
	# This patch includes the following deltas:
	#	           ChangeSet	1.220   -> 1.221
	#	   net/sunrpc/xprt.c	1.9     -> 1.10
	#
	# The following is the BitKeeper ChangeSet Log
	# --------------------------------------------
	# 02/03/20	trond.myklebust@fys.uio.no	1.221
	# Fix bug in sunrpc/xprt.c:udp_write_space() that was introduced by the
	# recent sock_writeable() change.
	# --------------------------------------------
	#


Summary of changes from v2.4.19-pre2 to v2.4.19-pre3
============================================

<marcelo@plucky.distro.conectiva> (02/03/13 1.162)
	- -ac merge (including new IDE)                         (Alan Cox)
	- S390 merge                                            (IBM)
	- More cciss fixes                                      (Stephen Cameron)
	- Eicon SMP race fix                                    (Armin Schindler)
	- w9966 driver update                                   (Jakob Kemi)
	- Unify crc32 routine (removes lots of duplicated
	  code from drivers)                                    (Matt Domsch)
	- Lanstreamer bugfixes                                  (Kent Yoder)
	- Update scsi_debug                                     (Douglas Gilbert)
	- MCE Configure.help update                             (Paul Gortmaker)
	- Fix SMB NLS oops                                      (Urban Widmark)
	- AGP Config.in update                                  (Daniele Venzano)
	- Fix small thinko in UFS set_blocksize return handling (me)
	- Avoid unecessary cache flushes on PPC                 (Paul Mackerras)
	- PPP deadlock fixes                                    (Paul Mackerras)
	- Signal changes for thread groups                      (Dave McCracken)
	- Make max_threads be based on normal zone size         (Dave McCracken)
	- ray_cs wireless extension fix                         (Jean Tourrilhes)
	- irda bugfixes and enhancements                        (Jean Tourrilhes)
	- USB update                                            (Greg KH)
	- Fix through-8259A mode for IRQ0 routing on APIC       (Maciej W. Rozycki/Joe Korty)
	- Add Dell Inspiron 2500 to broken APM blacklist        (Arjan van de Ven)
	- Fix off-by-one error in bluesmoke                     (Dave Jones)
	- Reiserfs update                                       (Oleg Drokin)
	- Fix PCI compile without /proc support                 (Eric Sandeen)
	- Fix problem with bad inode handling                   (Alexander Viro)
	- aic7xxx update                                        (Justin T. Gibbs)
	- Do not consider SCSI recovered errors as fatal errors (Justin T. Gibbs)
	- Add Memory-Write-Invalidate support to PCI            (Jeff Garzik)
	- Starfire update                                       (Ion Badulescu)
	- tulip update                                          (Jeff Garzik)


Summary of changes from v2.4.19-pre1 to v2.4.19-pre2
============================================

<marcelo@plucky.distro.conectiva> (02/03/13 1.161)
	- -ac merge                                             (Alan Cox)
	- Huge MIPS/MIPS64 merge                                (Ralf Baechle)
	- IA64 update                                           (David Mosberger)
	- PPC update                                            (Tom Rini)
	- Shrink struct page                                    (Rik van Riel)
	- QNX4 update (now its able to mount QNX 6.1 fses)      (Anders Larsen)
	- Make max_map_count sysctl configurable                (Christoph Hellwig)
	- matroxfb update                                       (Petr Vandrovec)
	- ymfpci update                                         (Pete Zaitcev)
	- LVM update                                            (Heinz J . Mauelshagen)
	- btaudio driver update                                 (Gerd Knorr)
	- bttv update                                           (Gerd Knorr)
	- Out of line code cleanup                              (Keith Owens)
	- Add watchdog API documentation                        (Christer Weinigel)
	- Rivafb update                                         (Ani Joshi)
	- Enable PCI buses above quad0 on NUMA-Q                (Martin J. Bligh)
	- Fix PIIX IDE slave PCI timings                        (Dave Bogdanoff)
	- Make PLIP work again                                  (Tim Waugh)
	- Remove unecessary printk from lp.c                    (Tim Waugh)
	- Make parport_daisy_select work for ECP/EPP modes      (Max Vorobiev)
	- Support O_NONBLOCK on lp/ppdev correctly              (Tim Waugh)
	- Add PCI card hooks to parport                         (Tim Waugh)
	- Compaq cciss driver fixes                             (Stephen Cameron)
	- VFS cleanups and fixes                                (Alexander Viro)
	- USB update (including USB 2.0 support)                (Greg KH)
	- More jiffies compare cleanups                         (Tim Schmielau)
	- PCI hotplug update                                    (Greg KH)
	- bluesmoke fixes                                       (Dave Jones)
	- Fix off-by-one in ide-scsi                            (John Fremlin)
	- Fix warnings in make xconfig                          (René Scharfe)
	- Make x86 MCE a configure option                       (Paul Gortmaker)
	- Small ramdisk fixes                                   (Christoph Hellwig)
	- Add missing atime update to pipe code                 (Christoph Hellwig)
	- Serialize microcode access                            (Tigran Aivazian)
	- AMD Elan handling on serial.c                         (Robert Schwebel)


Summary of changes from v2.4.18 to v2.4.19-pre1
============================================

<marcelo@plucky.distro.conectiva> (02/03/13 1.160)
	- Add tape support to cciss driver                      (Stephen Cameron)
	- Add Permedia3 fb driver                               (Romain Dolbeau)
	- meye driver update                                    (Stelian Pop)
	- opl3sa2 update                                        (Zwane Mwaikambo)
	- JFFS2 update                                          (David Woodhouse)
	- NBD deadlock fix                                      (Steven Whitehouse)
	- Correct sys_shmdt() return value on failure           (Adam Bottchen)
	- Apply the SET_PERSONALITY patch missing from 2.4.18   (me)
	- Alpha update                                          (Jay Estabrook)
	- SPARC64 update                                        (David S. Miller)
	- Fix potential blk freelist corruption                 (Jens Axboe)
	- Fix potential hpfs oops                               (Chris Mason)
	- get_request() starvation fix                          (Andrew Morton)
	- cramfs update                                         (Daniel Quinlan)
	- Allow binfmt_elf as module                            (Paul Gortmaker)
	- ymfpci Configure.help update                          (Pete Zaitcev)
	- Backout one eepro100 change made in 2.4.18: it
	  was causing slowdowns on some cards                   (Jeff Garzik)
	- Tridentfb compilation fix                             (Jani Monoses)
	- Fix refcounting of directories on renames in tmpfs    (Christoph Rohland)
	- Add Fujitsu notebook to broken APM implementation
	  blacklist                                             (Arjan Van de Ven)
	- "do { ... } while(0)" cleanups on some fb drivers     (Geert Uytterhoeven)
	- Fix natsemi's ETHTOOL_GLINK ioctl                     (Tim Hockin)
	- Fix clik! drive detection code in ide-floppy          (Paul Bristow)
	- Add additional support for the 82801 I/O controller   (Wim Van Sebroeck)
	- Remove duplicates in pci_ids.h                        (Wim Van Sebroeck)


