Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261553AbSJ2Qfi>; Tue, 29 Oct 2002 11:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbSJ2Qfi>; Tue, 29 Oct 2002 11:35:38 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:3794 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261553AbSJ2Qfg>; Tue, 29 Oct 2002 11:35:36 -0500
Date: Tue, 29 Oct 2002 14:05:16 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.20-rc1
Message-ID: <Pine.LNX.4.44L.0210291358010.16425-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Finally, rc1.

Several networking fixes, net drivers fixes, devfs root boot option fixed,
and more.

Please stress test it.


Summary of changes from v2.4.20-pre11 to v2.4.20-rc1
============================================

<adam@nmt.edu>:
  o 3ware driver update

<akropel1@rochester.rr.com>:
  o The following patch adds support for ethtool to the ewrk3 driver. It is against 2.5-BK but should apply to any recent 2.5 and 2.4 as well. In addition to adding ethtool support, it also removes the cli/sti fixup attribution from the changelog since that didn't actually go in yet and fixes a small style issue I introduced in the multi-card support patch.
  o This patch adds some locking fixups to the ewrk3 ioctl routine. None of these are critical since the ioctls AFAIK are used only by the EEPROM config utility.
  o Last ewrk3 for now. Updates the changelog to cover previous patches, bumps the revision number, and replaces the horrific EthwrkSignature function with something (slightly) less horrific.

<bheilbrun@paypal.com>:
  o Add missing part of DMI update

<dhinds@sonic.net>:
  o Change David Hinds email address
  o axnet_cs update
  o nmclan_cs update: fixed cut-and-paste bug in ethtool ioctl handler
  o pcnet_cs update

<fw@deneb.enyo.de>:
  o [TCP]: In TCP_LISTEN state, ignore SYNs with RST set

<jeb.j.cramer@intel.com>:
  o e1000 1/11
  o e1000 2/11
  o e1000 3/11
  o e1000 4/11
  o e1000 5/11
  o e1000 6/11
  o e1000 7/11
  o e1000 8/11
  o e1000 9/11
  o e1000 10/11
  o e1000 11/11

<jgarzik@redhat.com>:
  o Remove cli/sti from ewrk3 net driver
  o Fix tulip net driver multi-port board irq assignment

<johnstul@us.ibm.com>:
  o Fix compile problems with local APIC enabled

<komujun@nifty.com>:
  o Add PCI id to tulip net driver

<leigh@solinno.co.uk>:
  o PPC32: Minor fix in parsing the BI_CMD_LINE bi_record

<marcelo@freak.distro.conectiva>:
  o Add [davem]checkout:none
  o Fix pSeries Hypervisor console Config.in entry
  o Remove debugging printk in ide code
  o Changed EXTRAVERSION to -rc1

<mashirle@us.ibm.com>:
  o [IPV6]: Fix bugs in PMTU handling

<mgreer@mvista.com>:
  o PPC32: Allow the IBM Spruce board to be compiled with gcc-3.x

<okir@suse.de>:
  o Fix NFS IRIX compatibility braindamage

<shaggy@shaggy.austin.ibm.com>:
  o JFS: Add missing byte-swapping macros in xattr.c

<sparker@sun.com>:
  o drivers/net/eepro100.c: simplify wait_for_cmd_done(), better errors
  o drivers/net/eepro100.c: only set priv->last_rx_time if we did work
  o drivers/net/eepro100.c: mask the interrupt and do a small delay on close()

<thockin@freakshow.cobalt.com>:
  o drivers/net/eepro100.c
  o drivers/net/mii.c: only call netif_carrier_{on,off} if there is a state change
  o drivers/net/eepro100.c
  o drivers/net/natsemi.c: init msg_enable in proper way
  o drivers/net/eepro100.c: compile bugs
  o drivers/net/eepro100.c: eliminate speedo_intrmask
  o drivers/net/eepro100.c: cleanup messages that pop up since netif_msg_xxx change
  o drivers/net/eepro100.c: set the PHY ID correctly
  o drivers/net/mii.c: fix flipped logic
  o drivers/net/eepro100.c: set phy_id_mask and reg_num_mask in mii_if

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o dmi fixes from -ac
  o Update sisfb headers
  o del_timer_sync fixes for fmvj18x_cs net driver

Alexander Viro <viro@math.psu.edu>:
  o Fix devfs root boot option problem

Christoph Hellwig <hch@infradead.org>:
  o Fix bug in /proc/partitions handling code

David S. Miller <davem@nuts.ninka.net>:
  o arch/sparc64/kernel/pci_schizo.c: Enable error interrupts in correct PBM
  o [SPARC]: Set highmem_io in ESP and QLOGICPTI scsi drivers
  o arch/sparc64/defconfig: Update
  o [SPARC]: Fix typo in EBUS/QLOGICPTI highmem_io changes
  o arch/sparc64/mm/init.c: Initialize {min,max}_low_pfn properly
  o arch/sparc64/mm/init.c: Set max_pfn too
  o [ESP/QLOGICPTI]: Only set highmem_io on sparc64
  o arch/sparc64/kernel/ioctl32.c: Block ioctl handling fix
  o [SPARC64]: On broken cheetah, enable p-cache around large copies
  o [sparc64/ppc64/x86_64]: Fix socket fd leak in route ioctl32 translation
  o [SPARC64]: Disable old cheetah pcache optimization
  o arch/sparc64/kernel/ioctl32.c: Handle HDIO_GETGEO_BIG{,_RAW}
  o [IPV4]: When advmss of route is zero, report it as zero not 40

David Woodhouse <dwmw2@infradead.org>:
  o JFFS2 / shared-zlib cleanup

Geert Uytterhoeven <geert@linux-m68k.org>:
  o Zorro ID update

Hugh Dickins <hugh@veritas.com>:
  o shmem missing cache flush

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha compile fix

Jens Axboe <axboe@suse.de>:
  o sr wrong return value

Kent Yoder <key@austin.ibm.com>:
  o Add link status checking to pcnet32 net driver

lowekamp@cs.wm.edu <lowekamp@CS.WM.EDU>:
  o Fix reordering of onboard PDC20265

Paul Mackerras <paulus@samba.org>:
  o PPC32: Fix the compile for POWER3, we had an undefined variable

Scott Feldman <scott.feldman@intel.com>:
  o e100 1/5
  o e100 2/5
  o e100 3/5
  o e100 4/5
  o e100 5/5

Tom Callaway <tcallawa@redhat.com>:
  o arch/sparc64/solaris/misc.c: Add MODULE_LICENSE

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Compile ppc_generic_ide_fix_driveid if CONFIG_USB_STORAGE is not disabled.  This allows the USB Storage drivers which call ide_fix_driveid to be compiled on PPC32.
  o PPC32: On CONFIG_ALL_PPC, always have pmac_nvram around, as this cleans up the code nicely in some places and allows the PPC-specific nvram driver to be a module.

Tomas Szepe <szepe@pinerecords.com>:
  o [SPARC]: Move BTFIXUP-able code from inlined routines to the main kernel image

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Remove unbalanced kunmap() in NFS readdir code



