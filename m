Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751886AbWJXTZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbWJXTZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 15:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbWJXTZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 15:25:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:60103 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751886AbWJXTZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 15:25:04 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: feature-removal-schedule obsoletes
Date: Tue, 24 Oct 2006 21:24:49 +0200
User-Agent: KMail/1.9.5
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Dominik Brodowski <linux@brodo.de>,
       Harald Welte <laforge@netfilter.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jean Delvare <khali@linux-fr.org>
References: <45324658.1000203@gmail.com> <20061016133352.GA23391@lst.de>
In-Reply-To: <20061016133352.GA23391@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610242124.49911.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 October 2006 15:33, Christoph Hellwig wrote:
> On Sun, Oct 15, 2006 at 04:31:29PM +0159, Jiri Slaby wrote:
> > What:   remove EXPORT_SYMBOL(kernel_thread)
> > When:   August 2006
> > Who:    Christoph Hellwig <hch@lst.de>
>
> There are a lot of modular users left.  It'll go away as soon as these
> users have disappeared.

It seems that most of the users that are left are for pretty obscure
functionality, so I wouldn't expect that to happen so soon. Maybe we
should mark it as __deprecated in the declaration?

	Arnd <><

./arch/arm/kernel/ecard.c:      ret = kernel_thread(ecard_task, NULL, CLONE_KERNEL);
./arch/arm/kernel/process.c:pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
./arch/i386/kernel/io_apic.c:   if (kernel_thread(balanced_irq, NULL, CLONE_KERNEL) >= 0)
./arch/i386/mach-voyager/voyager_thread.c:      if(kernel_thread(thread, NULL, CLONE_KERNEL) < 0) {
./arch/ia64/sn/kernel/xpc_main.c:       pid = kernel_thread(xpc_activating, (void *) ((u64) partid), 0);
./drivers/macintosh/adb.c:      adb_probe_task_pid = kernel_thread(adb_probe_task, NULL, SIGCHLD | CLONE_KERNEL);
./drivers/macintosh/mediabay.c:         kernel_thread(media_bay_task, NULL, CLONE_KERNEL);
./drivers/macintosh/therm_pm72.c:       ctrl_task = kernel_thread(main_control_loop, NULL, SIGCHLD | CLONE_KERNEL);
./drivers/macintosh/therm_windtunnel.c:                 x.poll_task = kernel_thread( control_loop, NULL, SIGCHLD | CLONE_KERNEL );
./drivers/media/dvb/dvb-core/dvb_ca_en50221.c:  ret = kernel_thread(dvb_ca_en50221_thread, ca, 0);
./drivers/media/dvb/dvb-core/dvb_frontend.c:    ret = kernel_thread (dvb_frontend_thread, fe, 0);
./drivers/media/dvb/ttpci/av7110.c:     ret = kernel_thread(arm_thread, (void *) av7110, 0);
./drivers/media/video/saa7134/saa7134-tvaudio.c:                dev->thread.pid = kernel_thread(my_thread,dev,0);
./drivers/media/video/msp3400-driver.c:                 v4l_warn(client, "kernel_thread() failed\n");
./drivers/mmc/mmc_queue.c:      ret = kernel_thread(mmc_queue_thread, mq, CLONE_KERNEL);
./drivers/mtd/mtd_blkdevs.c:    ret = kernel_thread(mtd_blktrans_thread, tr, CLONE_KERNEL);
./drivers/pci/hotplug/cpci_hotplug_core.c:              pid = kernel_thread(event_thread, NULL, 0);
./drivers/pci/hotplug/cpci_hotplug_core.c:              pid = kernel_thread(poll_thread, NULL, 0);
./drivers/pci/hotplug/cpqphp_ctrl.c:    pid = kernel_thread(event_thread, NULL, 0);
./drivers/pci/hotplug/ibmphp_hpc.c:     tid_poll = kernel_thread (hpc_poll_thread, NULL, 0);
./drivers/pci/hotplug/pciehp_ctrl.c:    pid = kernel_thread(event_thread, NULL, 0);
./drivers/pnp/pnpbios/core.c:   if (kernel_thread(pnp_dock_thread, NULL, CLONE_KERNEL) > 0)
./drivers/s390/net/lcs.c:               kernel_thread(lcs_recovery, (void *) card, SIGCHLD);
./drivers/s390/net/qeth_main.c:         kernel_thread(qeth_register_ip_addresses, (void *)card,SIGCHLD);
./drivers/s390/scsi/zfcp_erp.c: retval = kernel_thread(zfcp_erp_thread, adapter, SIGCHLD);
./drivers/scsi/libsas/sas_scsi_host.c:  res = kernel_thread(sas_queue_thread, sas_ha, 0);
./drivers/usb/atm/usbatm.c:     int ret = kernel_thread(usbatm_do_heavy_init, instance, CLONE_KERNEL);
./drivers/usb/atm/usbatm.c:             usb_err(instance, "%s: failed to create kernel_thread (%d)!\n", __func__, ret);
./fs/afs/cmservice.c:           ret = kernel_thread(kafscmd, NULL, 0);
./fs/afs/kafsasyncd.c:  ret = kernel_thread(kafsasyncd, NULL, 0);
./fs/afs/kafstimod.c:   ret = kernel_thread(kafstimod, NULL, 0);
./fs/cifs/connect.c:                    rc = (int)kernel_thread((void *)(void *)cifs_demultiplex_thread, srvTcp,
./fs/jffs/inode-v23.c:  c->thread_pid = kernel_thread (jffs_garbage_collect_thread,
./fs/jffs2/background.c:        pid = kernel_thread(jffs2_garbage_collect_thread, c, CLONE_FS|CLONE_FILES);
./fs/lockd/clntlock.c:          if (kernel_thread(reclaimer, host, CLONE_KERNEL) < 0)
./fs/nfs/delegation.c:  status = kernel_thread(recall_thread, &data, CLONE_KERNEL);
./net/bluetooth/bnep/core.c:    err = kernel_thread(bnep_session, s, CLONE_KERNEL);
./net/bluetooth/cmtp/core.c:    err = kernel_thread(cmtp_session, session, CLONE_KERNEL);
./net/bluetooth/hidp/core.c:    err = kernel_thread(hidp_session, session, CLONE_KERNEL);
./net/bluetooth/rfcomm/core.c:  kernel_thread(rfcomm_run, NULL, CLONE_KERNEL);
./net/core/pktgen.c:    err = kernel_thread((void *)pktgen_thread_worker, (void *)t,
./net/core/pktgen.c:            printk("pktgen: kernel_thread() failed for cpu %d\n", t->cpu);
./net/ipv4/ipvs/ip_vs_sync.c:   if ((pid = kernel_thread(sync_thread, startup, 0)) < 0) {
./net/ipv4/ipvs/ip_vs_sync.c:   if ((pid = kernel_thread(fork_sync_thread, &startup, 0)) < 0) {
./net/rxrpc/krxiod.c:   return kernel_thread(rxrpc_krxiod, NULL, 0);
./net/rxrpc/krxsecd.c:  return kernel_thread(rxrpc_krxsecd, NULL, 0);
./net/rxrpc/krxtimod.c: ret = kernel_thread(krxtimod, NULL, 0);
./net/sunrpc/svc.c:     error = kernel_thread((int (*)(void *)) func, rqstp, 0);
