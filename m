Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263583AbTKXDrD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 22:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTKXDrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 22:47:03 -0500
Received: from ns1.citynetwireless.net ([209.218.71.4]:43271 "EHLO
	mail.citynetwireless.net") by vger.kernel.org with ESMTP
	id S263583AbTKXDqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 22:46:36 -0500
Message-ID: <011101c3b23d$aa41e420$fd01000a@bp>
From: "Brad Parker" <parker@citynetwireless.net>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0311231804170.17378-100000@home.osdl.org>
Subject: Re: Linux 2.6.0-test10
Date: Sun, 23 Nov 2003 21:47:17 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this trying to compile for the user-mode-linux arch:

gcc -o arch/um/util/mk_task_user.o -c arch/um/util/mk_task_user.c
  CC      arch/um/util/mk_task_kern.o
In file included from include/asm/system-generic.h:4,
                 from include/asm/system.h:4,
                 from include/linux/list.h:8,
                 from include/linux/signal.h:4,
                 from include/asm/processor-generic.h:14,
                 from include/asm/processor.h:22,
                 from include/asm/thread_info.h:11,
                 from include/linux/thread_info.h:21,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/um/util/mk_task_kern.c:1:
include/asm/arch/system.h:7: asm/cpufeature.h: No such file or directory
make[1]: *** [arch/um/util/mk_task_kern.o] Error 1
make: *** [arch/um/util] Error 2


----- Original Message -----
From: "Linus Torvalds" <torvalds@osdl.org>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Sunday, November 23, 2003 20:43
Subject: Linux 2.6.0-test10


>
> Ok,
>
>  it's been almost a month between test9 and test10, with a constant but
> diminishing trickle of small patches. The full changes are slightly larger
> than I was hoping for, but considering that the patch is barely over 100kB
> compressed for a month worth of work, I'm still fairly pleased.
>
> There is still something strange going on that seems to be triggered by
> preemption, so for now we suggest not enabling CONFIG_PREEMPT if you want
> the highest stability. On the other hand, I'd love to have more testing,
> so that we can try to figure out what the pattern is - but please mention
> explicitly that you ran with preemption if you have problems.
>
> Quite a lot of the -test10 patches are one-liners and quite trivial. I've
> tried to be quite strict in patch acceptance, so the changes are largely
> fixes for things that can crash the machine, and they are also of the type
> "this can't possibly break anything". But hey, we all know that theory and
> practice don't always match ;)
>
> I'm planning/hoping on basically turning this over to Andrew, and let him
> decide to make the final 2.6.0 or not. Timing-wise Andrew is apparently
> going to be off for a few weeks, so regardless of whether this turns out
> to be rock solid or not, we'll have a few weeks of final testing before
> that were to happen. Which means that I might still end up making a test11
> if Andrew hasn't come back and we find something that warrants it.
>
> Btw, I'm happy to say that maintainers have been self-policing themselves
> quite admirably. Thanks to everybody involved.
>
> The changelog gives more details, but the bigger things here are various
> networking fixes, and the SCSI layer being better at refcounting some data
> structures (the oopses on USB storage removal that some people have seen
> should hopefully be fixed).
>
> [ Btw, I tried to come up with a good name for this release. But the fact
>   is, that as Scott Adams has so often pointed out, you can't do much
>   better than "weasel" when it comes to funny. Ever since the "greased
>   weasel" series of kernel releases I have been stuck for a good name.
>
>   This release is tentatively called the "stoned beaver" release (beavers
>   are _almost_ as good as weasels, as I'm sure Scott Adams would agree).
>
>   If you feel strongly about the issue, please send your votes and
>   ideas to "feedback@beaver-overlord.com", I'm sure somebody will find
>   your insight fascinating.
>
>   Thank you in advance. ]
>
> Linus
>
>
> Summary of changes from v2.6.0-test9 to v2.6.0-test10
> ============================================
>
> Adam Belay:
>   o Fix ISAPNP netdev initialization
>   o reserve resources specified by the PnPBIOS properly
>
> Alan Mayer:
>   o ia64: fix bug in SN2 sn_pci_map_sg that causes MCA
>
> Alan Stern:
>   o Off-by-one bug in user page calculations for Direct I/O
>
> Alexander Viro:
>   o Fix cramfs metadata races
>
> Alexey Kuznetsov:
>   o [IPV4]: Fix SKB handling in ipmr xmit
>
> Amir Noam:
>   o [netdrvr bonding] fix monitoring functions
>   o [bonding 2.6] Restore missing backward compatibility
>   o [bonding 2.6] fix creation of /proc/net/bonding dir
>
> Andi Kleen:
>   o [NET]: Limit SO_BSDCOMPAT warning
>   o Essential x86-64 updates
>   o [NET]: Fix oops in ethertap_rx()
>   o Fix IP checksum for SuSE 9.0 compiler
>   o Fix TSS limit on x86-64
>   o Fix oops in x86-64 strace path
>   o Fix critical issue in x86-64 IOMMU code
>   o Work around K8 errata on x86-64
>
> Andrew Morton:
>   o Fix binfmt_misc locking
>   o digi_accelport warning fix
>   o JBD: use-after-free fix
>   o WinTV-D patch to make tuner functional
>   o bttv jiffies warning fix
>   o Export some symbols on x86-64
>   o /proc/tty/driver/serial formatting fix
>   o direct-io typo fix
>   o sis900 skb free fix
>   o [netdrvr 3c527] add MODULE_LICENSE tag
>   o AS: handle non-block requests
>   o 3c509 MCA compile fix
>   o ext2 block allocation race fix
>   o Disable IDE Tagged Command Queueing
>   o char dev request_module fix
>   o Fix RAID1 recovery
>   o JBD: fix assertion failure
>   o compile fix for voyager with gcc-3.3
>   o [NET]: Remove __devinitdata from board_info[] in tlan.c driver
>   o Fix scsi_report_lun_scan sign bug
>   o gcc bug workaround for constant_test_bit()
>   o videobuf_waiton race fix
>   o gettimeofday resolution fix
>   o sched_clock() fix
>   o reiserfs pinned buffer fix
>   o ia32: hugetlb needs pse
>   o Fix bugs in ext2_new_inode()
>   o remove ext2_reserve_inode()
>   o fix percpu_counter_mod linkage problem
>   o ide-scsi: warn when used for cdroms
>   o ext3_new_inode fixlet
>   o ext2 block allocator fixes
>   o init.h needs to include compiler.h
>   o cpu_sibling_map fix
>   o fs/ext[23]/xattr.c pointer arithmetic fix
>   o resource.c bounds checking fix
>   o mpparse printk fix
>   o disallow modular BINFMT_ELF
>   o fix scsi_report_lun_scan bug
>
> Andrew Victor:
>   o [SERIAL PATCH] 1672/1: Restore sizeof(struct serial_struct)
>
> Andrey Panin:
>   o fix visws irq breakage
>
> Andries E. Brouwer:
>   o atkbd: 0xfa is ACK
>   o Relax FATFS validity tests
>   o Strange SCSI messages
>   o Warn about old EZD and DM disk remappers
>
> Anton Altaparmakov:
>   o NTFS: Minor bug fix in attribute list attribute handling that fixes
>     the I/O errors on "ls" of certain fragmented files found by at
>     least two people running Windows XP.
>
> Arjan van de Ven:
>   o r8169 module license tag
>   o fix starfire 64-bit b0rkage
>
> Arnaldo Carvalho de Melo:
>   o [LLC]: Fix array indexing in llc_add_pack()
>   o [LLC]: In llc_ui_connect(), return error properly when device not
>     found
>   o [LLC]: Fix oops in procf handling
>   o [LLC]: llc_lookup_listener has to consider the 'any' mac address
>   o [LLC]: fix net_device refcounting bug
>   o [LLC]: fix bug that prevented fcntl(O_NONBLOCK) from working with
>     PF_LLC sockets
>   o [LLC]: set local mac addr at connect time when userland left it as
>     zeroes
>   o [NET]: Introduce dev_getbyfirsthwtype
>   o [LLC]: when the user doesn't specifies a local address to connect,
>     do an autobind
>   o [LLC]: Fix sockaddr, only need to provide one MAC address not three
>   o [IPX]: Memset newly allocated atalk private area
>   o [IPX]: Missing memset()'s in route and interface creation
>   o [APPLETALK]: Mark me as the maintainer
>   o [LLC]: fix procfs reading when there are saps without sockets
>   o [LLC]: fix client side after sockaddr_llc fixup
>
> Arun Sharma:
>   o ia64: invoke schedule_tail unconditionally on ia32 emulation
>
> Bart De Schuymer:
>   o [NETFILTER]: Fix potential OOPS in ipt_REDIRECT
>   o [NET]: Bart wrote arpt_mangle not DaveM. :-)
>
> Bartlomiej Zolnierkiewicz:
>   o add support for new nForce IDE controllers
>   o AMD/nForce driver update
>   o fix ide-tape oops
>   o fix rq->flags use in ide-tape.c
>
> Christoph Hellwig:
>   o scsi_device refcounting and list lockdown
>
> Daniel McNeil:
>   o Fix AIO reference counts
>
> Dave Kleikamp:
>   o JFS: remove racy, redundant call to block_invalidatepage
>   o JFS: Fix race between link() and unlink()
>
> David Brownell:
>   o USB: usb ignores 64bit dma
>
> David Mosberger:
>   o Fix pte_modify() bug which allowed mprotect() to change too many
>     bits
>   o ia64: Fix _PAGE_CHG_MASK so PROT_NONE works again.  Caught by Linus
>   o ia64: From Linus: Always disable system call restart when invoking
>     a signal handler.  Otherwise, a restarted system call that gets
>     interrupted before the restart has taken effect by _another_ signal
>     will potentially restart the wrong system call.
>   o ia64: Fix bug in fsys_rt_sigprocmask() which breaks
>     new-stub-enabled libc/NPTL
>   o ia64: Fix off-by-1 error in imm60 patching.  The bug hasn't been
>     observed in practice, but it's clearly wrong and just waiting there
>     to get triggered...
>   o ia64: From Linus/Paulus: reset restart_block function in
>     restore_sigcontext().  Also update ia32 subsystem accordingly.
>   o ia64: Drop printk from ia64_ni_syscall().  This is a temporary fix
>     for 2.6.0.  The proper fix is to replace ia64_ni_syscall with
>     sys_ni_syscall, but that would make the patch quite large, so we
>     defer that till 2.6.1.
>
> David S. Miller:
>   o [SPARC]: Fix emul paths to be root relative
>   o [IPV4]: Fix typo in ipmr.c
>   o Revert signal handling changes in tcp.c - they break SIGURG
>   o Revert "Zero initial timestamps are valid" changeset
>   o [IPV6]: Do not virt_to_page() on stack addresses, fixes OOPS
>   o [SPARC]: Add AIO syscalls, 32-bit compat handling will come later
>   o [SPARC64]: Fix preempt handling in dec_and_lock.S
>   o [SPARC64]: Get preempt building and working again
>   o [NET/COMPAT]: Fix copying of ipt_entry objects in
>     do_netfilter_replace()
>   o [NET]: Make skb_copy_expand() copy header area too
>   o [IPX]: Fix checksum computation
>   o Cset exclude: akpm@osdl.org|ChangeSet|20031029192849|64746
>   o [NETLINK]: Initialize nl_pad in getname and recvmsg, noticed by Uli
>     Drepper
>   o [IPV4]: Initialize ARP seqfile state in start() method
>   o [SPARC64]: Preserve cache/side-effect PTE bits in pte_modify()
>   o [IRDA]: Fix IRQ save/restore handling in seq file handlers
>   o [TG3]: Fix bugs in ETHTOOL_SSET introduced by ethtool_ops
>     conversion
>   o [TG3]: Bump driver version and release date
>   o [TCP]: Normalize jiffies values reported to userspace
>   o [SPARC64]: Fix PCI floppy IRQ enable/disable handling
>   o [IPV6]: Fix packet quoting in icmpv6_send()
>   o [SPARC]: Port over x86 signal bugfix in cset 1.1431
>   o [COMPAT]: Fix arguments to compat statfs64 syscalls, 'sz' was
>     missing
>   o [SPARC64]: For 32-bit processes, use compat statfs64 syscall
>     handlers not the normal ones
>   o [SPARC]: Update to changeset 1.1445 version of signal fix
>   o [SPARC]: Do not provide VGA_CONSOLE for sparc builds
>   o [SPARC]: Port over cset 1.1459 x86 gettimeofday fix
>   o [SPARC64]: Get PCI floppies fully functional again
>   o [IPV4]: igmp.c needs linux/times.h
>
> David Stevens:
>   o [IPV6]: Fix UDP socket selection for multicast
>   o [IPV6]: Fix milliseconds to jiffies conversion in multicast code
>   o [IPV6]: In multicast code, set MAF_TIMER_RUNNING when timer is set
>   o [IPV6]: Fix jiffies procfs output in multicast code
>   o [IPV6]: In igmp6_group_queried, fix address check to comply with
>     RFC2710
>   o [IPV6]: Fix header length calculation in multicast input
>
> Davide Libenzi:
>   o More SiS interrupt routing
>
> Eric Brower:
>   o [SPARC]: Fix _IOC_SIZE() macro when direction is _IOC_NONE
>
> George Anzinger:
>   o Fix clock_nanosleep() signal restart issues
>
> Greg Kroah-Hartman:
>   o I2C: remove some MOD_INC and MOD_DEC usages that are not needed
>     anymore
>   o USB: don't build the whiteheat driver if on SMP as the locking is
>     all messed up
>   o fix reference count bug with class devices
>
> Harald Welte:
>   o [NETFILTER]: Fix ip_queue_maxlen sysctl
>
> Herbert Xu:
>   o [IPSEC]: Strengthen policy checks
>   o [IPSEC]: Fix accidental too many ref drops on policies
>   o [IPSEC]: Missing NULL algorithm checks in AH and IPCOMP init
>   o [NET]: Use cpumask_t for cpumap in flow cache
>   o [netdrvr tg3] initialize workqueue correctly
>   o Fix double module_put in lockd
>   o [IPV4]: Always set hoplimit metric, even for non-unicast routes
>   o [netdrvr tg3] fix BCM5705 pending-RX count (was 64, now 63)
>
> Hideaki Yoshifuji:
>   o [NET]: Forward port iproute2 build fix from 2.4.23-preX
>   o [IPV6]: Typo in address comparison
>   o [IPV6]: Use real storage for cork'd packets, else MSG_MORE corrupts
>     UDP packets
>   o [IPV4,6]: Use common storage for cork'd flow, needed to handle
>     mapped-ipv4 ipv6 addresses properly
>   o [IPV6]: Process ipv4-mapped addresses properly on UDPv6 sockets
>   o [IPV6]: Fix bogus semicolon typo in mcast.c
>   o [IPV6]: Fix inappropriate usage of inet{,6}_sk()
>   o [IPV4]: Remove out-of-date info CONFIG_INET help text
>   o [IPV6]: Fix outdated and inaccurate information in Kconfig help
>   o [CRYPTO]: crypto_alg_lookup() should fail when passed a NULL name
>   o [IPV4/IPV6]: Fix one more inappropriate use of inet6_sk()->ipv6only
>   o [IPV6]: Fix OOPS on NETDEV_CHANGENAME events
>   o [JIFFIES]: linux/times.h needs asm/param.h (for USER_HZ)
>   o [IPV4/IPV6]: Normalize jiffies reported to userspace in routing
>     code
>   o [DECNET]: Normalize jiffies reported to userspace
>   o [IPV4/IPV6]: More userland jiffies reporting fixes for routing
>   o [IPV4]: Fix jiffies procfs output in multicast code
>
> Ingo Molnar:
>   o SMP signal latency fix
>
> Ivan Kokshaysky:
>   o PCI: fix bug in pci_setup_bridge()
>   o ALI IDE forward port from 2.4.x
>
> Jack Steiner:
>   o ia64: fix is_headless_node() for SN
>
> James Bottomley:
>   o Buslogic is MCA capable as well as PCI and ISA
>   o lasi700: Fix missed variable name change causing module load error
>   o Add missing .module initialisation to lasi700 and sim710
>
> Jan Kara:
>   o Drop spin lock when calling request_module in quota code
>
> Jan Oravec:
>   o [IPV6]: Fix len calculation after icmp changes
>
> Jason Holmes:
>   o make 2.6 megaraid recognize intel vendor id
>
> Javier Achirica:
>   o Fix compatibily issue with some APs
>   o Fix wireless stats locking
>
> Jay Estabrook:
>   o Fix alpha "white box" boot
>
> Jean Tourrilhes:
>   o [IRDA]: Fix SKB leaks in af_irda.c, from Arnaldo Carvalho de Melo
>   o [IRDA]: Fix two OOPSers in IrCOMM
>   o [IRDA]: Fix races between IRNET and PPP
>   o [IRDA]: Fix IrLMP open leak
>
> Jeff Garzik:
>   o [libata] only reset if ATA_FLAG_SATA_RESET is present
>   o [libata] add per-driver port init/shutdown hooks, with helper
>     defaults
>   o [libata] convert Promise to packetized DMA
>   o [libata] add ->host_stop hook, and copy ->private_data from
>     probe_ent
>   o [libata] fill in a lot more Promise PDC20621 support
>   o [libata] more pdc20621 work
>   o [libata] kill timer when thread dies
>   o [libata] fix Promise build on older compilers
>   o [libata] PDC20621 hdma fixes
>   o [libata] Add paranoia checks/settings suggested by Promise
>   o [libata] fix bugs in SATA reset code path
>   o [libata] add Promise SATA pci id
>   o [libata] fix ugly Promise interrupt masking bug
>   o [libata] bump libata version
>   o [libata] fix Promise PCI posting bugs
>   o [libata promise] fixes suggested by Promise
>   o [netdrvr sis190] fix oopsable bug in TX path, related to skb_padto
>     return
>
> Jens Axboe:
>   o fix segment accounting with bounced pages
>
> Jesse Barnes:
>   o Fix bootmem breakage on ARM
>
> John Levon:
>   o [NETFILTER]: Fix modular iptables build
>
> Julian Anastasov:
>   o [IPVS]: avoid NULL ptr deref for dest in __ip_vs_get_out_rt
>   o [IPVS]: make sure timer expires on one cpu
>
> Jun Komuro:
>   o [pcmcia fmvj18x_cs] share interrupts properly for TDK multifunction
>     cards
>
> Kawazoe Tomonori:
>   o [netdrvr 8139too] add pci id
>
> Kazunori Miyazawa:
>   o [IPV6]: Fix IPSEC oops, RTF_NDISC flag gets dropped in
>     __xfrm6_bundle_create()
>
> Kevin Corry:
>   o Fix DM on top of raid
>
> Kevin Lahey:
>   o [TCP]: When SYN is set, the window is not scaled
>
> Kochi Takayoshi:
>   o ia64: don't access per-CPU data of off-line CPUs
>
> Krishna Kumar:
>   o [NET]: Do not run netdev todo work from linkwatch code
>   o [IPV6]: Fix hangs during interface down caused by ipv6_del_addr()
>   o [IPV6]: Fix ref count bug in MLDv2, test idev->dead instead of
>     IFF_UP
>
> Len Brown:
>   o [ACPI] REVERT acpi_ec_gpe_query(ec) fix that crashed non-T40 boxes
>     http://bugme.osdl.org/show_bug.cgi?id=1171
>   o [ACPI] REVERT ACPICA-20030918 CONFIG_ACPI_DEBUG printk that caused
>     crash http://bugzilla.kernel.org/show_bug.cgi?id=1341
>
> Linus Torvalds:
>   o Add a sticky "PF_DEAD" task flag to keep track of dead processes
>   o Put the compiler barrier() on the right side of the preemption
>     enable on UP-PREEMPT.
>   o Fix ZOMBIE race with self-reaping threads
>   o Don't force PS/2 mouse rate or resolution by default
>   o Stop SIS 96x chips from lying about themselves
>   o Forward-port PIRQ table updates from 2.4.x
>   o Avoid user space access with interrupts disabled in vm86 support
>   o Only truncate file types that can be truncated on minixfs
>   o Fix cut-and-paste error in radeonfb.c
>   o Don't fold nanosleep() into clock_nanosleep()
>   o Fix double unlock of page_table_lock in do_wp_page()
>   o Avoid racy optimization in signal sending
>   o Fix ALI 15x3 IDE driver oops
>   o Always disable system call restart when invoking a signal handler
>   o Re-instate the ALI northbridge checks in ALI IDE driver
>   o Don't panic on a corrupt MP table. It's likely just a broken UP
>     BIOS
>   o Disable system call restart at sigreturn time rather than when
>     invoking the signal. This fixes all races.
>   o Limit USB storage transfers to 240 sectors
>   o Work around binutils bug
>
> Matthew Dharm:
>   o USB: fix a thread-exit problem at module unload
>
> Matthew Wilcox:
>   o Fix panic-at-boot
>
> Matthias Andree:
>   o Properly terminate /proc/tty/driver/serial output lines of known
>     UARTS when the caller has no CAP_SYS_ADMIN capability.
>
> Maximilian Attems:
>   o [NETFILTER]: Add IPCHAINS to MAINTAINERS entry
>
> Michael Clark:
>   o PCI: Fix oops in quirk_via_bridge
>
> Mike Phillips:
>   o ibmtr_cs/ibmtr - get working again
>
> Neil Brown:
>   o Fix nfsd extra dput()
>
> Nickolai Zeldovich:
>   o [NET]: Allow SOMAXCONN to be adjusted via sysctl
>
> Patrick McHardy:
>   o [NET]: Fix skb_copy_expand offset calculation
>   o [NET SCHED]: Adjust qlen when grafting in multiple qdiscs
>   o [NET SCHED]: Reset q.qlen in tbf_reset instead of purging an unused
>     queue
>   o [NET SCHED]: Fix queue limits in multiple qdiscs
>
> Paul E. Erkkila:
>   o [IPV4]: Make sure ipgre_tunnel_init() gets the correct ioctl
>     settings
>
> Paul Jackson:
>   o ia64: fix bug in prof_cpu_mask_read_proc()
>
> Paul Mackerras:
>   o PPC32: Fix alignment problem with __ex_table and __bug_table
>   o PPC32: Don't oops on out-of-range system call
>   o PPC32: cancel syscall restart on signal delivery
>   o Fix ppc system restart properly
>   o PPC64: Fix possible race in syscall restart
>
> Pekka Pietikäinen:
>   o [netdrvr b44] Fix irq enable/disable; fix oops due to lack of
>     SET_NETDEV_DEV() call
>
> Pete Zaitcev:
>   o [SPARC]: Eliminate references to linux/smp_lock.h, from willy
>
> Philip Craig:
>   o [netdrvr 8139cp] fix NAPI race
>
> Prasanna Meda:
>   o [netdrvr tulip] fix hashed setup frame code
>
> Ralf Bächle:
>   o drivers/pci DEBUG build fix
>   o [netdrvr pcnet32] add missing pci_dma_sync_single
>
> Randolph Chung:
>   o fix __div64_32 to do division properly
>
> Randy Dunlap:
>   o Fix crash-on-boot in init_l440gx SMP
>
> Rik van Riel:
>   o [netdrvr starfire] include asm/io.h
>
> Russell King:
>   o [PCMCIA] Fix card detection
>   o 2.6.0-test8: fix ARM ether driver naming
>   o [ARM] Fix ARM signal handling
>   o [ARM] Fix system call restarting
>
> Rusty Russell:
>   o [NETFILTER]: Fix ipchains oops in NAT
>   o Fix for module initialization failure
>   o [NETFILTER]: get_unique_tuple doesn't always return unique tuple
>
> Stelian Pop:
>   o sonypi: fix Zoom/Thumbphrase button events
>   o meye: documentation
>
> Stephen Hemminger:
>   o [IRDA]: Fix references to dead mailing lists and URLs
>   o [IPX]: Fix OOPS when ipxcfg_auto_create_interfaces is on
>   o [IRDA]: Fix irlmp seqfile, initialize the iterator in start
>   o [netdrvr de4x5] NE54-de4x5 - fix missing free on error path - found
>     by viro
>
> Stéphane Eranian:
>   o ia64: fix perfmon UP breakage
>   o ia64: fix 2 more perfmon2 bugs
>
> Thomas Habets:
>   o [SPARC]: Add missing symbol exports, this is fallout from
>     kernel/ksyms.c being nuked
>
> Thomas Winischhofer:
>   o More SiS AGP ids
>
> Tim Shepard:
>   o [IPV6]: Fix /proc/sys/net/ipv6/icmp permissions
>
> Tom Marshall:
>   o [EBTABLES]: Fix ebt_limit for HZ=1000
>
> Venkatesh Pallipadi:
>   o Improper mapping of ACPI-HPET table
>
> Ville Nuorvala:
>   o [IPV6]: In ip6ip6 tunnel, set skb->h.raw after obtaining private
>     copy
>   o [IPV6]: In ip6ip6 tunnel, user provides flowlabel in network byte
>     order
>   o [IPV6]: Verify nlmsg_len in rt6_dump_route()
>
> Vojtech Pavlik:
>   o input: Always reset PS/2 mouse resolution and update speed to
>     default values after probing
>
> Wei Ni:
>   o Legacy ALi5455 Audio Driver update
>
> Willem Riede:
>   o osst buglet
>
> Yoshinori Sato:
>   o fix h8/300 support
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

