Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbTJ2Xio (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 18:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTJ2Xio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 18:38:44 -0500
Received: from havoc.gtf.org ([63.247.75.124]:48004 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262061AbTJ2Xib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 18:38:31 -0500
Date: Wed, 29 Oct 2003 18:34:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [BK PATCHES] 2.6.x experimental net driver queue
Message-ID: <20031029233411.GA21890@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen was kind enough to gather up and send the vendor netpoll
patches that have been lying around in various vendor, -aa, etc. trees
and send them along.  So here goes -test9-bk3-netdrvr-exp2.



BK users:

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5-exp

Patch:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test9-bk3-netdrvr-exp2.patch.bz2

This will update the following files:

 Documentation/networking/netconsole.txt |   57 ++
 drivers/net/3c501.c                     |  116 ++---
 drivers/net/3c501.h                     |    1 
 drivers/net/3c505.c                     |  128 +++---
 drivers/net/3c507.c                     |  110 ++---
 drivers/net/3c515.c                     |   23 -
 drivers/net/3c527.c                     |  584 +++++++++++++----------------
 drivers/net/3c59x.c                     |   15 
 drivers/net/8139too.c                   |   51 +-
 drivers/net/82596.c                     |   83 ++--
 drivers/net/Kconfig                     |    7 
 drivers/net/Makefile                    |    1 
 drivers/net/Space.c                     |  161 +++++---
 drivers/net/amd8111e.c                  |   14 
 drivers/net/de620.c                     |   63 ++-
 drivers/net/defxx.c                     |    2 
 drivers/net/dummy.c                     |    2 
 drivers/net/eepro100.c                  |   21 +
 drivers/net/eql.c                       |    2 
 drivers/net/natsemi.c                   |   39 +
 drivers/net/netconsole.c                |  120 ++++++
 drivers/net/ni5010.c                    |  184 ++++-----
 drivers/net/ni52.c                      |  118 +++--
 drivers/net/ni65.c                      |  101 +++--
 drivers/net/ns83820.c                   |    2 
 drivers/net/pcnet32.c                   |   11 
 drivers/net/plip.c                      |   14 
 drivers/net/shaper.c                    |   11 
 drivers/net/sk_g16.c                    |  179 +++------
 drivers/net/skfp/skfddi.c               |   32 -
 drivers/net/tg3.c                       |   16 
 drivers/net/tokenring/proteon.c         |  184 ++++-----
 drivers/net/tokenring/skisa.c           |  182 ++++-----
 drivers/net/tokenring/smctr.c           |  194 +++++----
 drivers/net/tulip/Kconfig               |   20 +
 drivers/net/tulip/interrupt.c           |  410 +++++++++++++++-----
 drivers/net/tulip/tulip.h               |   18 
 drivers/net/tulip/tulip_core.c          |   76 ++-
 drivers/net/tun.c                       |   18 
 drivers/net/wan/lmc/lmc_main.c          |  375 ++++++------------
 drivers/net/wan/lmc/lmc_var.h           |   15 
 drivers/net/wireless/arlan-main.c       |  261 ++++---------
 drivers/net/wireless/arlan.h            |    6 
 drivers/net/wireless/wavelan.c          |  171 +++-----
 drivers/net/wireless/wavelan.p.h        |    5 
 include/linux/netdevice.h               |   18 
 include/linux/netpoll.h                 |   38 +
 net/Kconfig                             |   20 -
 net/core/Makefile                       |    1 
 net/core/dev.c                          |   39 +
 net/core/netpoll.c                      |  636 ++++++++++++++++++++++++++++++++
 net/wanrouter/wanmain.c                 |    2 
 52 files changed, 2971 insertions(+), 1986 deletions(-)

through these ChangeSets:

<ak@muc.de> (03/10/29 1.1404)
   [PATCH] netpoll for eepro100
   
   netpoll for eepro100
   
   This was in Ingo's old original netconsole patches.

<ak@muc.de> (03/10/29 1.1403)
   [PATCH] fix tg3 netpoll
   
   No need to use disable_irq because tg3 is properly spinlocked.
   Can just call the interrupt handler directly.

<ak@muc.de> (03/10/29 1.1402)
   [PATCH] Netpoll for pcnet32
   
   netpoll for pcnet32

<ak@muc.de> (03/10/29 1.1401)
   [PATCH] netpoll for amd8111e
   
   netpoll for amd8111e

<ak@muc.de> (03/10/29 1.1400)
   [PATCH] netpoll for tulip
   
   Netpoll for tulip. Uses disable_irq() because tulip is unfortunately
   still lockless.

<ak@muc.de> (03/10/29 1.1399)
   [PATCH] netpoll for 3c59x
   
   >From the old -aa tree with minor changes. Orginally done
   by Andrea I think.

<mpm@selenic.com> (03/10/29 1.1389.1.3)
   [NET] use the netpoll API to transmit kernel printks over UDP

<mpm@selenic.com> (03/10/29 1.1389.1.2)
   [NET] Add netpoll support for tg3

<mpm@selenic.com> (03/10/29 1.1389.1.1)
   [NET] add netpoll API

<shemminger@osdl.org> (03/10/29 1.1397)
   [PATCH] trivial -- skfp_probe should be static
   
   skfp_probe used to be called from Space.c but isn't any more.
   Therefore it no longer needs to be global.  All the calls to insert_device()
   pass skfp_probe as a second arg, so just use it directly.
   
   Jeff, this also is janitor type stuff, so just put it in net-2.5-exp

<shemminger@osdl.org> (03/10/29 1.1396)
   [PATCH] (4/6) skisa -- probe2
   
   Convert the SK-NET TMS380 ISA card to the new probe2 format.

<shemminger@osdl.org> (03/10/29 1.1395)
   [PATCH] (3/6) proteon -- probe2
   
   Convert proteon token ring driver to new probing.

<shemminger@osdl.org> (03/10/29 1.1394)
   [PATCH] (2/6) smctr -- probe2
   
   Convert the SMC tokenring driver to new probing.

<shemminger@osdl.org> (03/10/29 1.1393)
   [PATCH] (1/6) tokenring probing change
   
   Ugh, two patches got crossed. This is the correct first one.

<rnp@paradise.net.nz> (03/10/29 1.1392)
   [netdrvr 3c527] fix race

<rnp@paradise.net.nz> (03/10/29 1.1391)
   [netdrvr 3c527] whitespace changes (sync up with maintainer)

<shemminger@osdl.org> (03/10/14 1.1337.26.21)
   [PATCH] (12/12) Probe2 -- 82596
   
   Originally by Al Viro (NE23-82596)
   	* switched 82596 to dynamic allocation
   	* 82596: fixed resource leaks on failure exits
   Updated to apply agains jgarzik/net-drivers-2.5-exp

<shemminger@osdl.org> (03/10/14 1.1337.26.20)
   [PATCH] (11/12) Probe2 -- 3c501
   
   >From viro NE22-3c501
   	* switched 3c501 to dynamic allocation
   	* 3c501: embedded ->priv
   	* 3c501: fixed clobbering on autoprobe
   	* 3c501: fixed resource leaks on failure exits
   Additional:
   	* probe correctly when no device present
   	* fix loop forever bug in probing
   	* free_netdev

<shemminger@osdl.org> (03/10/14 1.1337.26.19)
   [PATCH] (10/12) Probe2 -- wavelan
   
   Original by Al Viro (NE21-wavelan)
   	* switched wavelan to dynamic allocation
   	* wavelan: embedded ->priv
   	* wavelan: fixed clobbering on autoprobe
   	* wavelan: fixed IO before request_region()
   	* wavelan: fixed resource leaks on failure exits
   	* wavelan: fixed order of freeing bugs
   Updated to apply agains jgarzik/net-drivers-2.5-exp

<shemminger@osdl.org> (03/10/14 1.1337.26.18)
   [PATCH] (09/12) Probe2 -- arlan
   
   Convert arlan driver to new probing.  This meant a rather large
   rework of the probing code for this driver since it did a lot ofnon
   standard things.

<shemminger@osdl.org> (03/10/14 1.1337.26.17)
   [PATCH] (08/12) Probe2 -- 3c507
   
   Originally by Al Viro (NE19-3c507)
   	* switched 3c507 to dynamic allocation
   	* 3c507: embedded ->priv
   	* 3c507: fixed clobbering on autoprobe
   	* NB: 3c507.c buggers port 0x100 without claiming it.  Most likely it
   	  should be doing request_region() there.
   Updated to apply agains jgarzik/net-drivers-2.5-exp

<shemminger@osdl.org> (03/10/14 1.1337.26.16)
   [PATCH] (07/12) Probe2 -- 3c505
   
   from viro NE18-3c505
   	* switched 3c505 to dynamic allocation
   	* 3c505: embedded ->priv
   	* 3c505: fixed use of uninitialized variable
   	* 3c505: fixed resource leaks on failure exits
   Additional:
   	* add free_netdev

<shemminger@osdl.org> (03/10/14 1.1337.26.15)
   [PATCH] (06/12) Probe2 -- sk16
   
   from viro NE17-sk16
   	* switched sk_g16 to dynamic allocation
   	* sk_g16: embedded ->priv
   	* sk_g16: fixed buggy check for signature (|| instead of &&, somebody
   	  forgot to replace it when inverting the test).
   	* sk_g16: fixed use after kfree()
   	* sk_g16: fixed init_etherdev() race
   Additional:
   	* add free_netdev

<shemminger@osdl.org> (03/10/14 1.1337.26.14)
   [PATCH] (05/12) Probe2 -- ni5010
   
   from viro NE16-ni5010
   	* switched ni5010 to dynamic allocation
   	* ni5010: embedded ->priv
   	* ni5010: fixed clobbering ->irq
   	* ni5010: fixed IO before request_region()
   Additional:
   	* add free_netdev

<shemminger@osdl.org> (03/10/14 1.1337.26.13)
   [PATCH] (04/12) Probe2 -- ni52
   
   >From viro NE15-ni52
   	* switched ni52 to dynamic allocation
   	* ni52: embedded ->priv
   	* ni52: fixed clobbering of everything on autoprobe
   Additional:
   	* add free_netdev

<shemminger@osdl.org> (03/10/14 1.1337.26.12)
   [PATCH] (03/12) Probe2 -- ni65
   
   Convert ni65 driver to new probing; patch sequence goes bottom
   up on the probe list.
   
   	* switched ni65 to dynamic allocation
   	* ni65: fixed ->irq and ->dma clobbering on autoprobe

<shemminger@osdl.org> (03/10/14 1.1337.26.11)
   [PATCH] (2/12) Probe2 -- de620
   
   Rework de620 driver to new dynamic allocation
   Originally by Al Viro.
   	* switched de620 to dynamic allocation
   	* de620: embedded ->priv
   	* de620: fixed IO before request_region()
   
   Updated to ~jgarzik/net-drivers-2.5-exp

<shemminger@osdl.org> (03/10/14 1.1337.26.10)
   [PATCH] (1/12) Probe2 infrastructure for 2.6 experimental
   
   New infrastructure to allow probing older builtin drivers (like ISA)
   Originally by Al Viro, updated to apply agains jgarzik/net-drivers-2.5-exp

<jgarzik@redhat.com> (03/10/14 1.1337.26.9)
   [netdrvr tulip] support NAPI
   
   Contributed by Robert Ollsson.

<shemminger@osdl.org> (03/10/14 1.1337.26.8)
   [PATCH] smctr - get rid of MOD_INC/DEC
   
   Get rid of warning now that module refcounting now done by network code not drivers.
   
   Not tested on real hardware.

<rddunlap@osdl.org> (03/10/14 1.1337.26.7)
   [PATCH] janitor: insert missing iounmap(), add error handling
   
   Hi,
   Please apply to 2.6.0-test6-current.
   
   Thanks,
   --
   ~Randy
   
   
   
   From: Leann Ogasawara <ogasawara@osdl.org>
   Subject: Re: [Kernel-janitors] [PATCH] insert missing iounmap()
   
   > > Patch inserts a missing iounmap().  Implements a cleanup path
   > > for error handling as well.  Feedback is much appreciated.  Thanks :)
   
   
   
   ===== drivers/net/natsemi.c 1.55 vs edited =====
   
   
    linux-260-test6-kj1-rddunlap/drivers/net/natsemi.c |   39 ++++++++++-----------
    1 files changed, 20 insertions(+), 19 deletions(-)

<felipewd@terra.com.br> (03/10/14 1.1337.26.6)
   [PATCH] release region in skfddi driver
   
   This is a multi-part message in MIME format.

<felipewd@terra.com.br> (03/10/14 1.1337.26.5)
   [netdrvr 3c527] remove cli/sti
   
   
       Richard Procter and I worked to remove cli/sti to add proper SMP support (I did the original stuff and Richard did the actual current code :)).
   
       Besides that, Richard did a great jog improving the perfomance of the driver quite a bit:
   
       - Improve mc32_command by 770% (438% non-inlined) over the semaphore version (at a cost of 1 sem + 2 completions per driver).
   
       - Removed mutex covering mc32_send_packet (hard_start_xmit). This lets the interrupt handler operate concurrently and removes unnecessary locking. It makes the code only slightly more brittle
   
       Original post:
   
   http://marc.theaimsgroup.com/?l=linux-netdev&m=106438449315202&w=2
   
       Since it didn't apply cleanly against 2.6.0-test6, I forward ported it. Patch attached.
   
       Jeff, please consider applying,
   
       Thanks.

<shemminger@osdl.org> (03/10/14 1.1337.26.4)
   [PATCH] remove dev_get from wanrouter
   
   The call to dev_get() in wanrouter_device_new_if is racy and redundant and should
   be removed.  The later 'register_netdev()' does the same test internally and will
   return the appropriate error if the name already exists.
   
   This patch is against 2.6.0-test6.
   Resend of earlier patch because it was ignored, or missed.

<romieu@fr.zoreil.com> (03/10/14 1.1337.26.3)
   [PATCH] 2.6.0-test6 - more free_netdev() conversion
   
   Compiles ok (with true .o generated, yeah). Please review.
   
   free_netdev() of devices allocated through use of alloc_netdev().
   Though baroque, drivers/net/3c515.c now uses alloc_etherdev().
   
   
    drivers/net/3c515.c   |   23 ++++++++++++-----------
    drivers/net/defxx.c   |    2 +-
    drivers/net/dummy.c   |    2 +-
    drivers/net/eql.c     |    2 +-
    drivers/net/ns83820.c |    2 +-
    drivers/net/plip.c    |   14 ++++++++++----
    drivers/net/shaper.c  |   11 ++++++++---
    drivers/net/tun.c     |   18 +++++++++---------
    9 files changed, 43 insertions(+), 31 deletions(-)

<shemminger@osdl.org> (03/10/14 1.1337.26.2)
   [PATCH] wan/lmc -- convert to new network device model
   
   Resend of LMC driver patch for 2.6.0-test6
     * do proper probing
     * allocate network device with alloc_netdev
     * use standard pci_id's instead of local defines
     * use standard PCI device interface to find and remove devices.

<krishnakumar@naturesoft.net> (03/10/14 1.1337.26.1)
   [netdrvr 8139too] support netif_msg_* interface

