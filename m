Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTKMA14 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 19:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbTKMA14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 19:27:56 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:49370 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S261779AbTKMA1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 19:27:50 -0500
Date: Wed, 12 Nov 2003 18:26:02 -0600 (CST)
From: Pat Gefre <pfg@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: Re: [PATCH] Updating our sn code in 2.6
In-Reply-To: <20031107102514.A2437@infradead.org>
Message-ID: <Pine.SGI.3.96.1031112174709.40512D-100000@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've updated this patch (see comments below) and am posting the url again.

ftp://oss.sgi.com/pub/outgoing

I realize that the tree is currently closed, but think this is at least
an opportunity to get this reviewed and ready when the tree re-opens.


 arch/ia64/sn/Makefile                        |    2 
 arch/ia64/sn/io/Makefile                     |    6 
 arch/ia64/sn/io/cdl.c                        |   16 
 arch/ia64/sn/io/drivers/Makefile             |    2 
 arch/ia64/sn/io/drivers/ioconfig_bus.c       |  119 -
 arch/ia64/sn/io/hwgfs/Makefile               |    2 
 arch/ia64/sn/io/hwgfs/hcl.c                  |  273 --
 arch/ia64/sn/io/hwgfs/hcl_util.c             |   68 
 arch/ia64/sn/io/hwgfs/interface.c            |   46 
 arch/ia64/sn/io/hwgfs/labelcl.c              |    1 
 arch/ia64/sn/io/io.c                         |   44 
 arch/ia64/sn/io/machvec/Makefile             |    2 
 arch/ia64/sn/io/machvec/pci.c                |   35 
 arch/ia64/sn/io/machvec/pci_bus_cvlink.c     |  805 +++-----
 arch/ia64/sn/io/machvec/pci_dma.c            |  130 -
 arch/ia64/sn/io/platform_init/Makefile       |    2 
 arch/ia64/sn/io/platform_init/irix_io_init.c |   69 
 arch/ia64/sn/io/sgi_if.c                     |  136 -
 arch/ia64/sn/io/sgi_io_sim.c                 |   79 
 arch/ia64/sn/io/sn2/Makefile                 |    9 
 arch/ia64/sn/io/sn2/bte_error.c              |   67 
 arch/ia64/sn/io/sn2/geo_op.c                 |    4 
 arch/ia64/sn/io/sn2/klconflib.c              |  201 +-
 arch/ia64/sn/io/sn2/klgraph.c                |  487 +----
 arch/ia64/sn/io/sn2/l1_command.c             |   91 
 arch/ia64/sn/io/sn2/ml_SN_init.c             |   71 
 arch/ia64/sn/io/sn2/ml_SN_intr.c             |   26 
 arch/ia64/sn/io/sn2/ml_iograph.c             |  355 +--
 arch/ia64/sn/io/sn2/module.c                 |  145 -
 arch/ia64/sn/io/sn2/pcibr/Makefile           |    9 
 arch/ia64/sn/io/sn2/pcibr/pcibr_ate.c        |  440 ----
 arch/ia64/sn/io/sn2/pcibr/pcibr_config.c     |  223 +-
 arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c        | 2498 ++++++--------------------
 arch/ia64/sn/io/sn2/pcibr/pcibr_error.c      | 1349 ++++++++------
 arch/ia64/sn/io/sn2/pcibr/pcibr_hints.c      |   51 
 arch/ia64/sn/io/sn2/pcibr/pcibr_intr.c       |  525 +----
 arch/ia64/sn/io/sn2/pcibr/pcibr_reg.c        | 2264 ++++++++++++++++++++++++
 arch/ia64/sn/io/sn2/pcibr/pcibr_rrb.c        |  414 ++--
 arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c       | 1069 +++--------
 arch/ia64/sn/io/sn2/pciio.c                  |  532 +----
 arch/ia64/sn/io/sn2/pic.c                    |  728 ++++++-
 arch/ia64/sn/io/sn2/shub.c                   |   73 
 arch/ia64/sn/io/sn2/shub_intr.c              |   96 -
 arch/ia64/sn/io/sn2/shuberror.c              |   24 
 arch/ia64/sn/io/sn2/shubio.c                 |   22 
 arch/ia64/sn/io/sn2/xbow.c                   |  532 -----
 arch/ia64/sn/io/sn2/xtalk.c                  |   88 
 arch/ia64/sn/io/snia_if.c                    |  144 +
 arch/ia64/sn/io/xswitch.c                    |    4 
 arch/ia64/sn/kernel/Makefile                 |    2 
 arch/ia64/sn/kernel/irq.c                    |  134 -
 arch/ia64/sn/kernel/setup.c                  |   88 
 arch/ia64/sn/kernel/sn2/Makefile             |    4 
 arch/ia64/sn/kernel/sn2/cache.c              |   20 
 arch/ia64/sn/kernel/sn2/timer_interrupt.c    |   76 
 drivers/char/sn_serial.c                     |  324 ++-
 include/asm-ia64/sn/addrs.h                  |   33 
 include/asm-ia64/sn/alenlist.h               |    3 
 include/asm-ia64/sn/arc/hinv.h               |  183 -
 include/asm-ia64/sn/arc/types.h              |   41 
 include/asm-ia64/sn/arch.h                   |    3 
 include/asm-ia64/sn/bte.h                    |   23 
 include/asm-ia64/sn/cdl.h                    |    5 
 include/asm-ia64/sn/clksupport.h             |    3 
 include/asm-ia64/sn/dmamap.h                 |   29 
 include/asm-ia64/sn/driver.h                 |    3 
 include/asm-ia64/sn/geo.h                    |    9 
 include/asm-ia64/sn/hcl.h                    |   40 
 include/asm-ia64/sn/hcl_util.h               |    5 
 include/asm-ia64/sn/hwgfs.h                  |    6 
 include/asm-ia64/sn/intr.h                   |    3 
 include/asm-ia64/sn/invent.h                 |  733 -------
 include/asm-ia64/sn/io.h                     |    6 
 include/asm-ia64/sn/ioc4.h                   |  801 --------
 include/asm-ia64/sn/ioconfig_bus.h           |   39 
 include/asm-ia64/sn/ioerror.h                |    7 
 include/asm-ia64/sn/ioerror_handling.h       |   54 
 include/asm-ia64/sn/iograph.h                |   83 
 include/asm-ia64/sn/klconfig.h               |  359 ---
 include/asm-ia64/sn/ksys/elsc.h              |    9 
 include/asm-ia64/sn/ksys/l1.h                |   37 
 include/asm-ia64/sn/labelcl.h                |   16 
 include/asm-ia64/sn/module.h                 |   15 
 include/asm-ia64/sn/nag.h                    |   32 
 include/asm-ia64/sn/nodepda.h                |    3 
 include/asm-ia64/sn/pci/bridge.h             | 1901 --------------------
 include/asm-ia64/sn/pci/pci_bus_cvlink.h     |   18 
 include/asm-ia64/sn/pci/pci_defs.h           |  267 +-
 include/asm-ia64/sn/pci/pcibr.h              |   84 
 include/asm-ia64/sn/pci/pcibr_asic.h         |  511 +++++
 include/asm-ia64/sn/pci/pcibr_private.h      |  328 ++-
 include/asm-ia64/sn/pci/pciio.h              |  156 +
 include/asm-ia64/sn/pci/pciio_private.h      |   89 
 include/asm-ia64/sn/pci/pic.h                | 2521 ++++++---------------------
 include/asm-ia64/sn/pda.h                    |    4 
 include/asm-ia64/sn/pio.h                    |    7 
 include/asm-ia64/sn/prio.h                   |    3 
 include/asm-ia64/sn/router.h                 |    3 
 include/asm-ia64/sn/sgi.h                    |  134 -
 include/asm-ia64/sn/simulator.h              |    2 
 include/asm-ia64/sn/slotnum.h                |    3 
 include/asm-ia64/sn/sn2/addrs.h              |   40 
 include/asm-ia64/sn/sn2/arch.h               |    5 
 include/asm-ia64/sn/sn2/geo.h                |    9 
 include/asm-ia64/sn/sn2/intr.h               |    7 
 include/asm-ia64/sn/sn2/shub.h               |    1 
 include/asm-ia64/sn/sn2/shub_md.h            |    7 
 include/asm-ia64/sn/sn2/shubio.h             |    8 
 include/asm-ia64/sn/sn2/sn_private.h         |   11 
 include/asm-ia64/sn/sn_fru.h                 |    3 
 include/asm-ia64/sn/sn_private.h             |    3 
 include/asm-ia64/sn/sn_sal.h                 |   43 
 include/asm-ia64/sn/vector.h                 |    3 
 include/asm-ia64/sn/xtalk/xbow.h             |  227 --
 include/asm-ia64/sn/xtalk/xbow_info.h        |   55 
 include/asm-ia64/sn/xtalk/xswitch.h          |    9 
 include/asm-ia64/sn/xtalk/xtalk.h            |   20 
 include/asm-ia64/sn/xtalk/xtalk_private.h    |   15 
 include/asm-ia64/sn/xtalk/xtalkaddrs.h       |    9 
 include/asm-ia64/sn/xtalk/xwidget.h          |   84 
 120 files changed, 9147 insertions(+), 15052 deletions(-)

On Fri, 7 Nov 2003, Christoph Hellwig wrote:

+ On Thu, Nov 06, 2003 at 05:31:56PM -0600, Pat Gefre wrote:
+ > I have a patch for 2.6 that will update our sn I/O. This patch includes
+ > initial support for new h/w, some code reorganization to accomodate the
+ > new h/w, fixes to our code since the last bulk update earlier this year
+ > and code clean-up. The diffstat follows at the end of this email.
+ 
+ Well, it would be nice again to give credit for people who did this.
+ In fact that SGI let code slip in that clearly wasn't theirs I think you should
+ really identidy who changed what instead of a hude 1.4MB patch.

I'm not sure what you mean here. Was there something specific ? One of
the reasons this is so large is because we hadn't sent any updates in
months, so we are in a bit of a catch-up mode. In the months since our
last updates, we have had several rounds of code clean up, fixed a
number of bugs and re-organized our code - something we feel we will
need down the road.

+ 
+ Comments to the patch:
+ 	- don't reintroduce pciba, it's a broken driver and I removed it
+ 	for a reason.  Use the generic pci procfs and sysfs infrastructure.

OK.

+ 	- please handle OOM situation instead of BUG()ing.

OK.

+ 	- please don't introduce empty functions just for the sake of it
+ 	(e.g. per_ice_init)

OK.

+ 	- the ioc4 driver is a mess, please rewrite it as a proper linux
+ 	driver using serial_core, etc.. instead of glueing an irix driver
+ 	through a midlyer directly to the tty interface.

I took this out.  Is the only complaint that I didn't use the serial
core interface ?

+ 	- please don't kill xbridge support from pcibr, we want to reuse
+ 	it for the ip27 port soon

Not sure what you mean here. I'm pretty sure if this code is needed for
a non-ia64 system it won't be in the sn2 code.


+ 	- please kill the crap under PCI_HOTPLUG - that wants implementing
+ 	as a proper linux hotplug pci driver instead.

OK.

+ 	- msi support should go into generic code, not sn2-specific.  See
+ 	the patches in Andrew's tree.

OK.

+ 	- please use the generic pci-to-pci bridge code instead of reiplenting
+ 	it.

OK.

+ 	- __HAVE_NEW_SCHEDULER is always true for 2.6, but you don't appear
+ 	to actually use it..

What did you mean here ?


+ 	- the ifdefs in the tio code are broken, you dma mapping has zero
+ 	chance to work for generic kernels

OK.

+ 	- snia_if adds back the snia_pciio interface that were killed for
+ 	a reason, don't do that!

OK. I did however move the ones that we were using into this file.

+ 	- you back out all changes to xswitch.c in 2.6, why?
+ 

OK.

