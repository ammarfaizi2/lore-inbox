Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVIYBeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVIYBeA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 21:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVIYBeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 21:34:00 -0400
Received: from [139.30.44.16] ([139.30.44.16]:37262 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1750806AbVIYBd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 21:33:59 -0400
Date: Sun, 25 Sep 2005 03:33:29 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: Dave Jones <davej@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: [patch] fix more missing includes
In-Reply-To: <Pine.LNX.4.53.0509241258460.2235@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.53.0509250330180.28093@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.53.0509241258460.2235@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To be applied on top of the previous fix-missing-includes patch.
Still preparing for removing #include <linux/sched.h> from module.h.
I'm now about half-way through the architectures. This is getting
boring...

Again, if any hunk rejects or gets in the way of other patches, just drop
it. I will pick it up again in the next round.

thanks,
Tim



Fix more missing includes as a preparatory step for not including
sched.h from module.h. This should now cover i386, x86_64, alpha,
arm, ppc64, and s390 architectures.

Signed-off-by: Tim Schmielau <tim@physik3.uni-rostock.de>


--- linux-2.6.14-rc2-mm1-sr-dj6/Documentation/firmware_class/firmware_sample_driver.c	2005-09-24 10:47:20.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/Documentation/firmware_class/firmware_sample_driver.c	2005-09-25 02:33:39.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/string.h>

 #include "linux/firmware.h"


--- linux-2.6.14-rc2-mm1-sr-dj6/Documentation/firmware_class/firmware_sample_firmware_class.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/Documentation/firmware_class/firmware_sample_firmware_class.c	2005-09-25 02:33:39.000000000 +0200
@@ -14,6 +14,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/timer.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/firmware.h>



--- linux-2.6.14-rc2-mm1-sr-dj6/arch/arm/common/amba.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/arm/common/amba.c	2005-09-25 02:33:39.000000000 +0200
@@ -10,6 +10,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include <asm/io.h>
 #include <asm/irq.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/arch/arm/common/scoop.c	2005-09-24 10:47:21.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/arm/common/scoop.c	2005-09-25 02:33:39.000000000 +0200
@@ -12,6 +12,9 @@
  */

 #include <linux/device.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+
 #include <asm/io.h>
 #include <asm/hardware/scoop.h>


--- linux-2.6.14-rc2-mm1-sr-dj6/arch/arm/kernel/arthur.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/arm/kernel/arthur.c	2005-09-25 02:33:39.000000000 +0200
@@ -18,6 +18,7 @@
 #include <linux/stddef.h>
 #include <linux/signal.h>
 #include <linux/init.h>
+#include <linux/sched.h>

 #include <asm/ptrace.h>


--- linux-2.6.14-rc2-mm1-sr-dj6/arch/arm/mach-imx/generic.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/arm/mach-imx/generic.c	2005-09-25 02:33:39.000000000 +0200
@@ -26,6 +26,8 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/string.h>
+
 #include <asm/arch/imxfb.h>
 #include <asm/hardware.h>


--- linux-2.6.14-rc2-mm1-sr-dj6/arch/arm/mach-integrator/clock.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/arm/mach-integrator/clock.c	2005-09-25 02:33:39.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/string.h>

 #include <asm/semaphore.h>
 #include <asm/hardware/clock.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/arch/arm/mach-integrator/integrator_ap.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/arm/mach-integrator/integrator_ap.c	2005-09-25 02:33:39.000000000 +0200
@@ -30,6 +30,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/setup.h>
+#include <asm/param.h>		/* HZ */
 #include <asm/mach-types.h>
 #include <asm/hardware/amba.h>
 #include <asm/hardware/amba_kmi.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/arch/arm/mach-integrator/lm.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/arm/mach-integrator/lm.c	2005-09-25 02:33:39.000000000 +0200
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/slab.h>

 #include <asm/arch/lm.h>


--- linux-2.6.14-rc2-mm1-sr-dj6/arch/arm/mach-iop3xx/iq31244-pci.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/arm/mach-iop3xx/iq31244-pci.c	2005-09-25 02:33:39.000000000 +0200
@@ -14,6 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include <asm/hardware.h>
 #include <asm/irq.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/arch/arm/mach-iop3xx/iq80321-pci.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/arm/mach-iop3xx/iq80321-pci.c	2005-09-25 02:33:39.000000000 +0200
@@ -14,6 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include <asm/hardware.h>
 #include <asm/irq.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/arch/arm/mach-iop3xx/iq80331-pci.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/arm/mach-iop3xx/iq80331-pci.c	2005-09-25 02:33:39.000000000 +0200
@@ -13,6 +13,8 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include <asm/hardware.h>
 #include <asm/irq.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/arch/arm/mach-iop3xx/iq80332-pci.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/arm/mach-iop3xx/iq80332-pci.c	2005-09-25 02:33:39.000000000 +0200
@@ -13,6 +13,8 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include <asm/hardware.h>
 #include <asm/irq.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/arch/arm/mach-pxa/generic.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/arm/mach-pxa/generic.c	2005-09-25 02:33:39.000000000 +0200
@@ -23,6 +23,7 @@
 #include <linux/device.h>
 #include <linux/ioport.h>
 #include <linux/pm.h>
+#include <linux/string.h>

 #include <asm/hardware.h>
 #include <asm/irq.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/arch/arm/mach-sa1100/generic.c	2005-09-24 10:47:21.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/arm/mach-sa1100/generic.c	2005-09-25 02:33:39.000000000 +0200
@@ -17,6 +17,7 @@
 #include <linux/pm.h>
 #include <linux/cpufreq.h>
 #include <linux/ioport.h>
+#include <linux/sched.h>	/* just for sched_clock() - funny that */

 #include <asm/div64.h>
 #include <asm/hardware.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/arch/arm/mach-versatile/clock.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/arm/mach-versatile/clock.c	2005-09-25 02:33:39.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/string.h>

 #include <asm/semaphore.h>
 #include <asm/hardware/clock.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/arch/arm/plat-omap/clock.c	2005-09-24 10:47:21.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/arm/plat-omap/clock.c	2005-09-25 02:33:39.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/string.h>

 #include <asm/io.h>
 #include <asm/semaphore.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/arch/ia64/kernel/cyclone.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/ia64/kernel/cyclone.c	2005-09-25 02:33:39.000000000 +0200
@@ -2,6 +2,7 @@
 #include <linux/smp.h>
 #include <linux/time.h>
 #include <linux/errno.h>
+#include <linux/timex.h>
 #include <asm/io.h>

 /* IBM Summit (EXA) Cyclone counter code*/

--- linux-2.6.14-rc2-mm1-sr-dj6/arch/ppc64/kernel/hvcserver.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/ppc64/kernel/hvcserver.c	2005-09-25 02:33:39.000000000 +0200
@@ -22,6 +22,8 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+
 #include <asm/hvcall.h>
 #include <asm/hvcserver.h>
 #include <asm/io.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/arch/ppc64/kernel/of_device.c	2005-09-24 10:52:00.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/ppc64/kernel/of_device.c	2005-09-25 02:33:39.000000000 +0200
@@ -4,6 +4,8 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/slab.h>
+
 #include <asm/errno.h>
 #include <asm/of_device.h>


--- linux-2.6.14-rc2-mm1-sr-dj6/arch/ppc64/lib/locks.c	2005-09-24 10:47:23.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/arch/ppc64/lib/locks.c	2005-09-25 02:33:39.000000000 +0200
@@ -17,6 +17,8 @@
 #include <linux/spinlock.h>
 #include <linux/module.h>
 #include <linux/stringify.h>
+#include <linux/smp.h>
+
 #include <asm/hvcall.h>
 #include <asm/iSeries/HvCall.h>


--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/base/class.c	2005-09-24 10:52:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/base/class.c	2005-09-25 02:33:39.000000000 +0200
@@ -17,6 +17,7 @@
 #include <linux/string.h>
 #include <linux/kdev_t.h>
 #include <linux/err.h>
+#include <linux/slab.h>
 #include "base.h"

 #define to_class_attr(_attr) container_of(_attr, struct class_attribute, attr)

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/base/platform.c	2005-09-24 10:47:24.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/base/platform.c	2005-09-25 02:33:39.000000000 +0200
@@ -16,6 +16,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/bootmem.h>
 #include <linux/err.h>
+#include <linux/slab.h>

 struct device platform_bus = {
 	.bus_id		= "platform",

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/block/cciss_scsi.c	2005-09-24 10:47:24.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/block/cciss_scsi.c	2005-09-25 02:33:39.000000000 +0200
@@ -28,13 +28,17 @@
    through the array controller.  Note in particular, neither
    physical nor logical disks are presented through the scsi layer. */

+#include <linux/timer.h>
+#include <linux/completion.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include <asm/atomic.h>
+
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
-#include <asm/atomic.h>
-#include <linux/timer.h>
-#include <linux/completion.h>

 #include "cciss_scsi.h"


--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/char/agp/ati-agp.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/char/agp/ati-agp.c	2005-09-25 02:33:39.000000000 +0200
@@ -6,6 +6,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>
 #include <linux/agp_backend.h>
 #include <asm/agp.h>
 #include "agp.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/char/agp/i460-agp.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/char/agp/i460-agp.c	2005-09-25 02:33:39.000000000 +0200
@@ -10,6 +10,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>
 #include <linux/agp_backend.h>

 #include "agp.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/char/agp/isoch.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/char/agp/isoch.c	2005-09-25 02:33:39.000000000 +0200
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/agp_backend.h>
 #include <linux/module.h>
+#include <linux/slab.h>

 #include "agp.h"


--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/char/agp/sworks-agp.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/char/agp/sworks-agp.c	2005-09-25 02:33:39.000000000 +0200
@@ -5,6 +5,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>
 #include <linux/agp_backend.h>
 #include "agp.h"


--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/char/drm/drm_sysfs.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/char/drm/drm_sysfs.c	2005-09-25 02:33:39.000000000 +0200
@@ -15,6 +15,8 @@
 #include <linux/device.h>
 #include <linux/kdev_t.h>
 #include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/string.h>

 #include "drm_core.h"
 #include "drmP.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/infiniband/core/sa_query.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/infiniband/core/sa_query.c	2005-09-25 02:33:39.000000000 +0200
@@ -43,6 +43,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/kref.h>
 #include <linux/idr.h>
+#include <linux/workqueue.h>

 #include <rdma/ib_pack.h>
 #include <rdma/ib_sa.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/infiniband/hw/mthca/mthca_av.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/infiniband/hw/mthca/mthca_av.c	2005-09-25 02:33:39.000000000 +0200
@@ -34,6 +34,8 @@
  */

 #include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include <rdma/ib_verbs.h>
 #include <rdma/ib_cache.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/infiniband/hw/mthca/mthca_mad.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/infiniband/hw/mthca/mthca_mad.c	2005-09-25 02:35:07.000000000 +0200
@@ -34,6 +34,9 @@
  * $Id: mthca_mad.c 1349 2004-12-16 21:09:43Z roland $
  */

+#include <linux/string.h>
+#include <linux/slab.h>
+
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_mad.h>
 #include <rdma/ib_smi.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/infiniband/hw/mthca/mthca_mcg.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/infiniband/hw/mthca/mthca_mcg.c	2005-09-25 02:33:39.000000000 +0200
@@ -33,6 +33,8 @@
  */

 #include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include "mthca_dev.h"
 #include "mthca_cmd.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/infiniband/hw/mthca/mthca_profile.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/infiniband/hw/mthca/mthca_profile.c	2005-09-25 02:33:39.000000000 +0200
@@ -35,6 +35,8 @@

 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include "mthca_profile.h"


--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/infiniband/hw/mthca/mthca_qp.c	2005-09-24 10:52:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/infiniband/hw/mthca/mthca_qp.c	2005-09-25 02:33:39.000000000 +0200
@@ -36,6 +36,8 @@
  */

 #include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include <rdma/ib_verbs.h>
 #include <rdma/ib_cache.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/infiniband/hw/mthca/mthca_reset.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/infiniband/hw/mthca/mthca_reset.c	2005-09-25 02:33:39.000000000 +0200
@@ -37,6 +37,7 @@
 #include <linux/errno.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
+#include <linux/slab.h>

 #include "mthca_dev.h"
 #include "mthca_cmd.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/input/joystick/joydump.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/input/joystick/joydump.c	2005-09-25 02:33:39.000000000 +0200
@@ -34,6 +34,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/slab.h>

 #define DRIVER_DESC	"Gameport data dumper module"


--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/macintosh/macio_asic.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/macintosh/macio_asic.c	2005-09-25 02:33:39.000000000 +0200
@@ -17,6 +17,8 @@
 #include <linux/pci_ids.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+
 #include <asm/machdep.h>
 #include <asm/macio.h>
 #include <asm/pmac_feature.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mca/mca-device.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mca/mca-device.c	2005-09-25 02:33:39.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/mca.h>
+#include <linux/string.h>

 /**
  *	mca_device_read_stored_pos - read POS register from stored data

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/common/ir-common.c	2005-09-24 10:47:26.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/media/common/ir-common.c	2005-09-25 02:33:39.000000000 +0200
@@ -22,6 +22,7 @@

 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/string.h>
 #include <media/ir-common.h>

 /* -------------------------------------------------------------------------- */

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/bcm3510.c	2005-09-24 10:53:20.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/media/dvb/frontends/bcm3510.c	2005-09-25 02:33:39.000000000 +0200
@@ -37,6 +37,8 @@
 #include <linux/device.h>
 #include <linux/firmware.h>
 #include <linux/jiffies.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include "dvb_frontend.h"
 #include "bcm3510.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/dib3000mb.c	2005-09-24 10:47:26.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/media/dvb/frontends/dib3000mb.c	2005-09-25 02:33:39.000000000 +0200
@@ -27,6 +27,8 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include "dib3000-common.h"
 #include "dib3000mb_priv.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/dib3000mc.c	2005-09-24 10:47:26.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/media/dvb/frontends/dib3000mc.c	2005-09-25 02:33:39.000000000 +0200
@@ -26,6 +26,8 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include "dib3000-common.h"
 #include "dib3000mc_priv.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/dvb_dummy_fe.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/media/dvb/frontends/dvb_dummy_fe.c	2005-09-25 02:33:39.000000000 +0200
@@ -22,6 +22,8 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include "dvb_frontend.h"
 #include "dvb_dummy_fe.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/lgdt330x.c	2005-09-24 10:47:26.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/media/dvb/frontends/lgdt330x.c	2005-09-25 02:33:39.000000000 +0200
@@ -37,6 +37,8 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/slab.h>
 #include <asm/byteorder.h>

 #include "dvb_frontend.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/mt312.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/media/dvb/frontends/mt312.c	2005-09-25 02:33:39.000000000 +0200
@@ -29,6 +29,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include "dvb_frontend.h"
 #include "mt312_priv.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/mt352.c	2005-09-24 10:47:26.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/media/dvb/frontends/mt352.c	2005-09-25 02:33:39.000000000 +0200
@@ -35,6 +35,8 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include "dvb_frontend.h"
 #include "mt352_priv.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/nxt2002.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/media/dvb/frontends/nxt2002.c	2005-09-25 02:33:39.000000000 +0200
@@ -32,6 +32,8 @@
 #include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include "dvb_frontend.h"
 #include "nxt2002.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/or51132.c	2005-09-24 10:47:26.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/media/dvb/frontends/or51132.c	2005-09-25 02:33:39.000000000 +0200
@@ -36,6 +36,8 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/slab.h>
 #include <asm/byteorder.h>

 #include "dvb_frontend.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/or51211.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/media/dvb/frontends/or51211.c	2005-09-25 02:33:39.000000000 +0200
@@ -34,6 +34,8 @@
 #include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
+#include <linux/string.h>
+#include <linux/slab.h>
 #include <asm/byteorder.h>

 #include "dvb_frontend.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/sp8870.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/media/dvb/frontends/sp8870.c	2005-09-25 02:33:39.000000000 +0200
@@ -32,6 +32,8 @@
 #include <linux/device.h>
 #include <linux/firmware.h>
 #include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include "dvb_frontend.h"
 #include "sp8870.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/sp887x.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/media/dvb/frontends/sp887x.c	2005-09-25 02:33:39.000000000 +0200
@@ -14,6 +14,8 @@
 #include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #include "dvb_frontend.h"
 #include "sp887x.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/stv0297.c	2005-09-24 10:53:20.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/media/dvb/frontends/stv0297.c	2005-09-25 02:33:39.000000000 +0200
@@ -25,6 +25,7 @@
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/jiffies.h>
+#include <linux/slab.h>

 #include "dvb_frontend.h"
 #include "stv0297.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/tda1004x.c	2005-09-24 10:53:20.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/media/dvb/frontends/tda1004x.c	2005-09-25 02:33:39.000000000 +0200
@@ -33,6 +33,9 @@
 #include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/jiffies.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+
 #include "dvb_frontend.h"
 #include "tda1004x.h"


--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/message/i2o/device.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/message/i2o/device.c	2005-09-25 02:33:39.000000000 +0200
@@ -16,6 +16,8 @@
 #include <linux/module.h>
 #include <linux/i2o.h>
 #include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/slab.h>
 #include "core.h"

 /**

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/message/i2o/driver.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/message/i2o/driver.c	2005-09-25 02:33:39.000000000 +0200
@@ -17,6 +17,9 @@
 #include <linux/module.h>
 #include <linux/rwsem.h>
 #include <linux/i2o.h>
+#include <linux/workqueue.h>
+#include <linux/string.h>
+#include <linux/slab.h>
 #include "core.h"

 #define OSM_NAME	"i2o"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/message/i2o/exec-osm.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/message/i2o/exec-osm.c	2005-09-25 02:33:39.000000000 +0200
@@ -30,6 +30,10 @@
 #include <linux/module.h>
 #include <linux/i2o.h>
 #include <linux/delay.h>
+#include <linux/workqueue.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <asm/param.h>		/* HZ */
 #include "core.h"

 #define OSM_NAME "exec-osm"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/message/i2o/iop.c	2005-09-24 10:52:02.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/message/i2o/iop.c	2005-09-25 02:33:39.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/module.h>
 #include <linux/i2o.h>
 #include <linux/delay.h>
+#include <linux/sched.h>
 #include "core.h"

 #define OSM_NAME	"i2o"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/chips/jedec.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/chips/jedec.c	2005-09-25 02:33:39.000000000 +0200
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/mtd/jedec.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/mtd.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/devices/lart.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/devices/lart.c	2005-09-25 02:33:39.000000000 +0200
@@ -44,6 +44,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 #include <linux/mtd/mtd.h>
 #ifdef HAVE_PARTITIONS
 #include <linux/mtd/partitions.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/devices/phram.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/devices/phram.c	2005-09-25 02:33:39.000000000 +0200
@@ -22,6 +22,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/slab.h>
 #include <linux/mtd/mtd.h>

 #define ERROR(fmt, args...) printk(KERN_ERR "phram: " fmt , ## args)

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/maps/bast-flash.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/maps/bast-flash.c	2005-09-25 02:33:39.000000000 +0200
@@ -33,6 +33,7 @@
 #include <linux/string.h>
 #include <linux/ioport.h>
 #include <linux/device.h>
+#include <linux/slab.h>

 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/maps/ceiva.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/maps/ceiva.c	2005-09-25 02:33:39.000000000 +0200
@@ -20,6 +20,7 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/slab.h>

 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/maps/dc21285.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/maps/dc21285.c	2005-09-25 02:33:39.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/slab.h>

 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/maps/dilnetpc.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/maps/dilnetpc.c	2005-09-25 02:33:39.000000000 +0200
@@ -30,12 +30,15 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <asm/io.h>
+#include <linux/string.h>
+
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/concat.h>

+#include <asm/io.h>
+
 /*
 ** The DIL/NetPC keeps its BIOS in two distinct flash blocks.
 ** Destroying any of these blocks transforms the DNPC into

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/maps/epxa10db-flash.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/maps/epxa10db-flash.c	2005-09-25 02:33:39.000000000 +0200
@@ -27,12 +27,15 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <asm/io.h>
+#include <linux/slab.h>
+
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>

+#include <asm/io.h>
 #include <asm/hardware.h>
+
 #ifdef CONFIG_EPXA10DB
 #define BOARD_NAME "EPXA10DB"
 #else

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/maps/fortunet.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/maps/fortunet.c	2005-09-25 02:33:39.000000000 +0200
@@ -7,11 +7,14 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <asm/io.h>
+#include <linux/string.h>
+
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>

+#include <asm/io.h>
+
 #define MAX_NUM_REGIONS		4
 #define MAX_NUM_PARTITIONS	8


--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/maps/ixp2000.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/maps/ixp2000.c	2005-09-25 02:33:39.000000000 +0200
@@ -22,11 +22,13 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
-#include <linux/ioport.h>
-#include <linux/device.h>

 #include <asm/io.h>
 #include <asm/hardware.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/maps/ixp4xx.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/maps/ixp4xx.c	2005-09-25 02:33:39.000000000 +0200
@@ -20,11 +20,14 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
-#include <linux/ioport.h>
-#include <linux/device.h>
+
 #include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/mach/flash.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/maps/lubbock-flash.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/maps/lubbock-flash.c	2005-09-25 02:33:39.000000000 +0200
@@ -15,10 +15,13 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/slab.h>
+
 #include <linux/dma-mapping.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
+
 #include <asm/io.h>
 #include <asm/hardware.h>
 #include <asm/arch/pxa-regs.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/maps/mainstone-flash.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/maps/mainstone-flash.c	2005-09-25 02:33:39.000000000 +0200
@@ -16,9 +16,12 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/dma-mapping.h>
+#include <linux/slab.h>
+
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
+
 #include <asm/io.h>
 #include <asm/hardware.h>
 #include <asm/arch/pxa-regs.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/maps/omap-toto-flash.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/maps/omap-toto-flash.c	2005-09-25 02:33:39.000000000 +0200
@@ -12,9 +12,9 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/slab.h>

 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/maps/omap_nor.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/maps/omap_nor.c	2005-09-25 02:33:39.000000000 +0200
@@ -36,6 +36,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/slab.h>
+
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/maps/pci.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/maps/pci.c	2005-09-25 02:33:39.000000000 +0200
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/slab.h>

 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/maps/plat-ram.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/maps/plat-ram.c	2005-09-25 02:33:39.000000000 +0200
@@ -30,6 +30,7 @@
 #include <linux/string.h>
 #include <linux/ioport.h>
 #include <linux/device.h>
+#include <linux/slab.h>

 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/maps/tqm8xxl.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/maps/tqm8xxl.c	2005-09-25 02:33:39.000000000 +0200
@@ -27,12 +27,14 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <asm/io.h>
+#include <linux/slab.h>

 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>

+#include <asm/io.h>
+
 #define FLASH_ADDR 0x40000000
 #define FLASH_SIZE 0x00800000
 #define FLASH_BANK_MAX 4

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/nand/s3c2410.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/mtd/nand/s3c2410.c	2005-09-25 02:33:39.000000000 +0200
@@ -51,6 +51,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/slab.h>

 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/pci/hotplug/cpcihp_generic.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/pci/hotplug/cpcihp_generic.c	2005-09-25 02:33:39.000000000 +0200
@@ -39,6 +39,7 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/pci.h>
+#include <linux/string.h>
 #include "cpci_hotplug.h"

 #define DRIVER_VERSION	"0.1"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/pci/hotplug/cpcihp_zt5550.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/pci/hotplug/cpcihp_zt5550.c	2005-09-25 02:33:39.000000000 +0200
@@ -36,6 +36,7 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/pci.h>
+#include <linux/signal.h>	/* SA_SHIRQ */
 #include "cpci_hotplug.h"
 #include "cpcihp_zt5550.h"


--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/pci/hotplug/fakephp.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/pci/hotplug/fakephp.c	2005-09-25 02:33:39.000000000 +0200
@@ -37,6 +37,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>
 #include "pci_hotplug.h"
 #include "../pci.h"


--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/pci/hotplug/rpadlpar_core.c	2005-09-24 10:47:27.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/pci/hotplug/rpadlpar_core.c	2005-09-25 02:36:22.000000000 +0200
@@ -16,10 +16,13 @@
  */
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/string.h>
+
 #include <asm/pci-bridge.h>
 #include <asm/semaphore.h>
 #include <asm/rtas.h>
 #include <asm/vio.h>
+
 #include "../pci.h"
 #include "rpaphp.h"
 #include "rpadlpar.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/pci/hotplug/rpaphp_pci.c	2005-09-24 10:47:27.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/pci/hotplug/rpaphp_pci.c	2005-09-25 02:33:39.000000000 +0200
@@ -23,11 +23,13 @@
  *
  */
 #include <linux/pci.h>
+#include <linux/string.h>
+
 #include <asm/pci-bridge.h>
 #include <asm/rtas.h>
 #include <asm/machdep.h>
-#include "../pci.h"		/* for pci_add_new_bus */

+#include "../pci.h"		/* for pci_add_new_bus */
 #include "rpaphp.h"

 static struct pci_bus *find_bus_among_children(struct pci_bus *bus,

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/pci/hotplug/rpaphp_slot.c	2005-09-24 10:47:27.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/pci/hotplug/rpaphp_slot.c	2005-09-25 02:33:39.000000000 +0200
@@ -27,6 +27,9 @@
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
 #include <linux/pci.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+
 #include <asm/rtas.h>
 #include "rpaphp.h"


--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/pci/pci-driver.c	2005-09-24 10:47:27.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/pci/pci-driver.c	2005-09-25 02:37:52.000000000 +0200
@@ -8,6 +8,8 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/mempolicy.h>
+#include <linux/string.h>
+#include <linux/slab.h>
 #include "pci.h"

 /*

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/pci/pci.c	2005-09-24 10:47:27.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/pci/pci.c	2005-09-25 02:37:01.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <linux/string.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"


--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/pci/pcie/portdrv_core.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/pci/pcie/portdrv_core.c	2005-09-25 02:37:01.000000000 +0200
@@ -11,6 +11,8 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/pm.h>
+#include <linux/string.h>
+#include <linux/slab.h>
 #include <linux/pcieport_if.h>

 #include "portdrv.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/pci/pcie/portdrv_pci.c	2005-09-24 10:47:27.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/pci/pcie/portdrv_pci.c	2005-09-25 02:37:01.000000000 +0200
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/pm.h>
 #include <linux/init.h>
+#include <linux/slab.h>
 #include <linux/pcieport_if.h>

 #include "portdrv.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/pci/rom.c	2005-09-24 10:47:27.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/pci/rom.c	2005-09-25 02:37:01.000000000 +0200
@@ -9,6 +9,7 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/slab.h>

 #include "pci.h"


--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/pnp/manager.c	2005-09-24 10:47:27.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/pnp/manager.c	2005-09-25 02:40:11.000000000 +0200
@@ -12,6 +12,8 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/pnp.h>
+#include <linux/slab.h>
+#include <linux/bitmap.h>
 #include "base.h"

 DECLARE_MUTEX(pnp_res_mutex);

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/pnp/pnpbios/rsparser.c	2005-09-24 10:47:27.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/pnp/pnpbios/rsparser.c	2005-09-25 02:37:01.000000000 +0200
@@ -7,6 +7,8 @@
 #include <linux/ctype.h>
 #include <linux/pnp.h>
 #include <linux/pnpbios.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 #ifdef CONFIG_PCI
 #include <linux/pci.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/s390/cio/cmf.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/s390/cio/cmf.c	2005-09-25 02:37:01.000000000 +0200
@@ -30,10 +30,13 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/slab.h>
+#include <linux/timex.h>	/* get_clock() */

 #include <asm/ccwdev.h>
 #include <asm/cio.h>
 #include <asm/cmb.h>
+#include <asm/div64.h>

 #include "cio.h"
 #include "css.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/s390/cio/device.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/s390/cio/device.c	2005-09-25 02:37:01.000000000 +0200
@@ -22,6 +22,7 @@

 #include <asm/ccwdev.h>
 #include <asm/cio.h>
+#include <asm/param.h>		/* HZ */

 #include "cio.h"
 #include "css.h"

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/s390/cio/device_fsm.c	2005-09-24 10:47:27.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/s390/cio/device_fsm.c	2005-09-25 02:37:01.000000000 +0200
@@ -11,6 +11,8 @@
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/string.h>

 #include <asm/ccwdev.h>
 #include <asm/cio.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/scsi/scsi_transport_iscsi.c	2005-09-24 10:52:03.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/scsi/scsi_transport_iscsi.c	2005-09-25 02:41:33.000000000 +0200
@@ -22,7 +22,11 @@
  */
 #include <linux/module.h>
 #include <linux/mempool.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+
 #include <net/tcp.h>
+
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/scsi/sym53c8xx_2/sym_hipd.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/scsi/sym53c8xx_2/sym_hipd.c	2005-09-25 02:37:01.000000000 +0200
@@ -37,6 +37,9 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+
+#include <linux/slab.h>
+
 #include "sym_glue.h"
 #include "sym_nvram.h"


--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/scsi/sym53c8xx_2/sym_hipd.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/scsi/sym53c8xx_2/sym_hipd.h	2005-09-25 02:37:01.000000000 +0200
@@ -37,6 +37,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */

+#include <linux/gfp.h>
+
 #ifndef SYM_HIPD_H
 #define SYM_HIPD_H


--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/sh/superhyway/superhyway.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/sh/superhyway/superhyway.c	2005-09-25 02:37:01.000000000 +0200
@@ -16,6 +16,8 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/superhyway.h>
+#include <linux/string.h>
+#include <linux/slab.h>

 static int superhyway_devices;


--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/usb/host/ohci-omap.c	2005-09-24 10:52:03.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/usb/host/ohci-omap.c	2005-09-25 02:37:01.000000000 +0200
@@ -14,6 +14,9 @@
  * This file is licenced under the GPL.
  */

+#include <linux/signal.h>	/* SA_INTERRUPT */
+#include <linux/jiffies.h>
+
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <asm/mach-types.h>

--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/zorro/zorro-sysfs.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/zorro/zorro-sysfs.c	2005-09-25 02:37:01.000000000 +0200
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/zorro.h>
 #include <linux/stat.h>
+#include <linux/string.h>

 #include "zorro.h"


--- linux-2.6.14-rc2-mm1-sr-dj6/drivers/zorro/zorro.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/drivers/zorro/zorro.c	2005-09-25 02:37:01.000000000 +0200
@@ -16,6 +16,8 @@
 #include <linux/init.h>
 #include <linux/zorro.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
+
 #include <asm/setup.h>
 #include <asm/amigahw.h>


--- linux-2.6.14-rc2-mm1-sr-dj6/include/linux/i2o.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/include/linux/i2o.h	2005-09-25 02:37:01.000000000 +0200
@@ -25,10 +25,14 @@
 /* How many different OSM's are we allowing */
 #define I2O_MAX_DRIVERS		8

-#include <asm/io.h>
-#include <asm/semaphore.h>	/* Needed for MUTEX init macros */
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>	/* work_struct */
+
+#include <asm/io.h>
+#include <asm/semaphore.h>	/* Needed for MUTEX init macros */

 /* message queue empty */
 #define I2O_QUEUE_EMPTY		0xffffffff

--- linux-2.6.14-rc2-mm1-sr-dj6/include/linux/mtd/map.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/include/linux/mtd/map.h	2005-09-25 02:37:01.000000000 +0200
@@ -8,7 +8,10 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/string.h>
+
 #include <linux/mtd/compatmac.h>
+
 #include <asm/unaligned.h>
 #include <asm/system.h>
 #include <asm/io.h>

diff -urp linux-2.6.14-rc2-mm1-sr-dj6/include/linux/textsearch.h linux-2.6.14-rc2-mm1-sr-dj8/include/linux/textsearch.h
--- linux-2.6.14-rc2-mm1-sr-dj6/include/linux/textsearch.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/include/linux/textsearch.h	2005-09-25 02:37:01.000000000 +0200
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/err.h>
+#include <linux/slab.h>

 struct ts_config;


--- linux-2.6.14-rc2-mm1-sr-dj6/kernel/params.c	2005-09-24 10:47:34.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/kernel/params.c	2005-09-25 02:37:01.000000000 +0200
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/slab.h>

 #if 0
 #define DEBUGP printk

--- linux-2.6.14-rc2-mm1-sr-dj6/lib/kobject.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/lib/kobject.c	2005-09-25 02:37:01.000000000 +0200
@@ -14,6 +14,7 @@
 #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/stat.h>
+#include <linux/slab.h>

 /**
  *	populate_dir - populate directory with attributes.

--- linux-2.6.14-rc2-mm1-sr-dj6/lib/sort.c	2005-09-24 10:47:34.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj8/lib/sort.c	2005-09-25 02:47:38.000000000 +0200
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sort.h>
+#include <linux/slab.h>

 static void u32_swap(void *a, void *b, int size)
 {
