Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316447AbSETX7l>; Mon, 20 May 2002 19:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316450AbSETX7k>; Mon, 20 May 2002 19:59:40 -0400
Received: from sol.mixi.net ([208.131.233.11]:3257 "EHLO sol.mixi.net")
	by vger.kernel.org with ESMTP id <S316447AbSETX7i>;
	Mon, 20 May 2002 19:59:38 -0400
X-Envelope-From: <todd@tekinteractive.com>
X-Mailer: emacs 21.1.95.1 (via feedmail 8 I);
	VM 7.05 under Emacs 21.1.95.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15593.36325.828828.485554@rtfm.ofc.tekinteractive.com>
Date: Mon, 20 May 2002 18:59:33 -0500
From: "Todd R. Eigenschink" <todd@tekinteractive.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: kswapd OOPS under 2.4.19-pre8 (ext3, Reiserfs + (soft)raid0)
In-Reply-To: <20020520232807.GE2046@holomorphy.com>
Reply-To: todd@tekinteractive.com
X-RAVMilter-Version: 8.3.1(snapshot 20020108) (sol)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
>Actually, getting  a notion of your sourcebase and what's actually
>running sounds like a great idea. Any chance you could rattle off what
>patches you've got and/or name the tree, and maybe send me a .config?
>Also, any chance you could tell me a little about the hardware?
>I'm not going to tell you what to run or not to run, I just want to
>know where to start looking.

Kernel: vanilla 2.4.19-pre8 at the moment.  I recompiled after adding
Steven Tweedie's latest ext3 patch the other night, but that's it.
I've been following the 2.4.19-pre kernels "religiously", but never
mix in *any* other patches.  While I don't have any actual oops output
from previous kernels, I think this has been around in every
2.4.19-pre.  (I've been having trouble for longer than that, but my
last round--see link below--at least *appeared* different.)

Stuff That Runs: vanilla.  syslog-ng, bind 9.2.1, gated, portmap,
ypserv, xinted automount, cron, rpc.mountd, ypbind, rpc.nfsd, Apache
(hardly ever touched), Backup Exec agent, postgres 7.2.1 (only hit by
Apache).

Webtrends runs early every morning.  A bunch of other machines rcp log
files to it between midnight and 04:00.  I've had oopsen while
webtrends is running and while it's not running.  I've had them just
when there are rsh/rcp sessions from a couple different machines at
the same time.  I've even had them when the machine is (as far as I
could predict) completely idle.


If you have suggestions for stuff to run (or not)--whatever--I'll be
glad to try it.  I can start going backwards kernel-wise, if you want
me to try to pin a starting point for the problem.


A couple other references:

http://groups.google.com/groups?q=todd+eigenschink&hl=en&lr=&ie=utf-8&oe=utf-8&scoring=d&selm=linux.kernel.15404.36497.77658.797884%40rtfm.ofc.tekinteractive.com&rnum=7

http://groups.google.com/groups?q=todd+eigenschink&hl=en&lr=&ie=utf-8&oe=utf-8&scoring=d&selm=linux.kernel.3C3D375C.E4A7EE77%40zip.com.au&rnum=6


>Your help in tracking this down has been immense, I hope you have the
>patience to bear with me as I try to fix this for you.

I have a lot more patience than kernel hacking skill, so I'll do what
I can, and you do your thing. :-)

A steak dinner and a case of your favorite if you fix it.  I'm
*really* tired of getting paged and driving in to the office in the
wee hours of the morning to hit the freaking reset button.  I do
preemptive reboots some evenings so I can control it, but it may still
croak a couple hours later.  (I'd love an APC MasterSwitch right now,
but I can do a *lot* of driving and switch-flipping for $600.)


Todd

(Hardware info and .config follows.)

----------------------------------------------------------------------

Hardware:

Intel L440GX-C mainboard.  Dual P3/500 CPUs, 2 GB of RAM.

1 9GB SCSI disk, 1 36GB SCSI, 4 x 30GB IDE disks, all on the internal
IDE & Adaptec SCSI.  (The IDE used to be one 4-disk softraid RAID0
partition; now it's two separate 2-disk RAID0 partitions.)

----------------------------------------------------------------------
"grep =y .config" (nothing configured as modules).  It had been
CONFIG_MPENTIUMIII; I recompiled as M586 a few days ago.  No change.

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_M586=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_FD=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDE_CHIPSETS=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_RTC=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y

----------------------------------------------------------------------

