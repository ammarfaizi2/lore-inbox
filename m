Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUEFDnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUEFDnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 23:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUEFDnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 23:43:45 -0400
Received: from dcs-server2.cs.uiuc.edu ([128.174.252.3]:2433 "EHLO
	dcs-server2.cs.uiuc.edu") by vger.kernel.org with ESMTP
	id S261451AbUEFDnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 23:43:41 -0400
From: "Zhenmin Li" <zli4@cs.uiuc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: [OPERA] Potential bugs detected by static analysis tool in 2.6.4
Date: Wed, 5 May 2004 22:41:37 -0500
Message-ID: <002701c4331c$092a3b40$76f6ae80@Turandot>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We ran our static analysis tool upon Linux 2.6.4 source files, and found
some potential errors. Since all of them are detected by the tool, we need
more effort to inspect. We would appreciate your help if anyone can verify
whether they are bugs or not.

Thanks a lot,

OPERA Research Group
University of Illinois at Urbana-Champaign



Version: 2.6.4
Files:
/arch/sparc/prom/memory.c
/arch/sparc64/prom/memory.c
/arch/sparc/kernel/sun4m_smp.c
/arch/sparc64/kernel/sunos_ioctl32.c
/arch/x86_64/kernel/mpparse.c
/arch/mips/kernel/sysirix.c
/arch/ppc/platforms/pmac_feature.c
/arch/m68k/mac/iop.c
/drivers/pci/hotplug/shpchp_ctrl.c
/sound/oss/swarm_cs4297a.c



1. /arch/sparc/prom/memory.c, Line 158-159:
prom_prom_taken[iter].theres_more = &prom_phys_total[iter+1];

Maybe change to:
prom_prom_taken[iter].theres_more = &prom_prom_taken[iter+1];



2. /arch/sparc64/prom/memory.c, Line 116-117:
prom_prom_taken[iter].theres_more = &prom_phys_total[iter+1];

Maybe change to:
prom_prom_taken[iter].theres_more = &prom_prom_taken[iter+1];



3. /arch/sparc/kernel/sun4m_smp.c, Line 227-228:
__cpu_number_map[i] = i;
__cpu_logical_map[i] = i;

Maybe change to:
__cpu_number_map[i] = cpucount;
__cpu_logical_map[cpucount] = i;



4. /arch/sparc64/kernel/sunos_ioctl32.c, Line 163-168:
case _IOW('i', 21, struct ifreq): /* SIOCSIFMTU */
ret = sys_ioctl(fd, SIOCSIFMTU, arg);
goto out;
case _IOWR('i', 22, struct ifreq): /* SIOCGIFMTU */
ret = sys_ioctl(fd, SIOCGIFMTU, arg);
goto out;

Maybe change to:
case _IOW('i', 21, struct ifreq32): /* SIOCSIFMTU */
ret = compat_sys_ioctl(fd, SIOCSIFMTU, arg);
goto out;
case _IOWR('i', 22, struct ifreq32): /* SIOCGIFMTU */
ret = compat_sys_ioctl(fd, SIOCGIFMTU, arg);
goto out;



5. /arch/x86_64/kernel/mpparse.c, Line 652:
Dprintk("Boot CPU = %d\n", boot_cpu_physical_apicid);

Maybe change to:
Dprintk("Boot CPU = %d\n", boot_cpu_id);



6. /arch/mips/kernel/sysirix.c, Line 1643:
error = verify_area(VERIFY_WRITE, buf, sizeof(struct irix_statvfs));

Maybe change to:
error = verify_area(VERIFY_WRITE, buf, sizeof(struct irix_statvfs64));



7. /arch/ppc/platforms/pmac_feature.c, Line 1160:
MACIO_BIS(KEYLARGO_FCR0, KL1_USB2_CELL_ENABLE);

Maybe change to:
MACIO_BIS(KEYLARGO_FCR1, KL1_USB2_CELL_ENABLE);



8. /arch/m68k/mac/iop.c, Line 164:
iop_base[IOP_NUM_SCC]->status_ctrl = 0;

Maybe change to:
iop_base[IOP_NUM_ISM]->status_ctrl = 0;



9. /drivers/pci/hotplug/shpchp_ctrl.c, Line 1575:
err("%s: Failed to disable slot, error code(%d)\n", __FUNCTION__, rc);

Maybe change to:
err("%s: Failed to disable slot, error code(%d)\n", __FUNCTION__, retval);



10. /sound/oss/swarm_cs4297a.c, Line 2019:
s->dma_adc.blocks = s->dma_dac.wakeup = 0;

Maybe change to:
s->dma_adc.blocks = s->dma_adc.wakeup = 0;


