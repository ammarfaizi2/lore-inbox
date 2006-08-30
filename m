Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWH3OHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWH3OHQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 10:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWH3OHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 10:07:15 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:47576 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751060AbWH3OHN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 10:07:13 -0400
Message-ID: <44F59B84.3090906@fr.ibm.com>
Date: Wed, 30 Aug 2006 16:07:00 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrew Morton <akpm@osdl.org>, video4linux-list@redhat.com,
       kraxel@bytesex.org, Containers@lists.osdl.org,
       linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH] kthread: saa7134-tvaudio.c
References: <20060829211555.GB1945@us.ibm.com>	<20060829143902.a6aa2712.akpm@osdl.org>	<m1k64rf9om.fsf@ebiederm.dsl.xmission.com> <m164gafld6.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m164gafld6.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> With the kthread api new kernel threads are started as children of keventd
>> in well defined circumstances.  If you don't do this kernel threads
>> can wind up sharing weird parts of a parent process's resources and
>> locking resources in the kernel long past the time when they are
>> actually used by anything a user space process can kill.
>>
>> We have actually witnessed this problem with the kernels filesystem mount
>> namespace.  Mostly daemonize in the kernel unshares everything that
>> could be a problem but the problem is sufficiently subtle it makes
>> more sense to the change kernel threads.  So these weird and subtle
>> dependencies go away.
>>
>> So in essence the container work needs the new kthread api for the
>> same reasons everyone else does it is just more pronounced in that
>> case.
> 
> That plus the obvious bit.  For the pid namespace we have to declare
> war on people storing a pid_t values.  Either converting them to
> struct pid * or removing them entirely.  Doing the kernel_thread to
> kthread conversion removes them entirely.

we've started that war, won a few battles but some drivers need more work
that a simple replace. If we could give some priorities, it would help to
focus on the most important ones. check out the list bellow.

thanks,

C.

arch/arm/kernel/ecard.c
arch/i386/kernel/apm.c
arch/i386/kernel/io_apic.c
arch/i386/mach-voyager/voyager_thread.c
arch/ia64/sn/kernel/xpc_main.c
arch/mips/au1000/db1x00/mirage_ts.c
arch/mips/kernel/apm.c
arch/parisc/kernel/process.c
arch/powerpc/platforms/pseries/eeh_event.c
arch/powerpc/platforms/pseries/rtasd.c
arch/s390/mm/cmm.c
arch/sparc64/kernel/power.c

drivers/base/firmware_class.c
drivers/block/loop.c
drivers/ieee1394/nodemgr.c
drivers/macintosh/adb.c
drivers/macintosh/mediabay.c
drivers/macintosh/therm_pm72.c
drivers/macintosh/therm_windtunnel.c
drivers/media/dvb/dvb-core/dvb_ca_en50221.c
drivers/media/dvb/dvb-core/dvb_frontend.c
drivers/media/dvb/ttpci/av7110.c
drivers/media/video/saa7134/saa7134-tvaudio.c
drivers/media/video/tvaudio.c
drivers/mmc/mmc_queue.c
drivers/mtd/mtd_blkdevs.c
drivers/net/wireless/airo.c
drivers/pci/hotplug/cpci_hotplug_core.c
drivers/pci/hotplug/cpqphp_ctrl.c
drivers/pci/hotplug/ibmphp_hpc.c
drivers/pci/hotplug/pciehp_ctrl.c
drivers/pnp/pnpbios/core.c
drivers/s390/net/lcs.c
drivers/s390/net/qeth_main.c
drivers/s390/scsi/zfcp_erp.c
drivers/usb/atm/usbatm.c
drivers/usb/storage/libusual.c

fs/afs/cmservice.c
fs/afs/kafsasyncd.c
fs/afs/kafstimod.c
fs/cifs/connect.c
fs/jffs2/background.c
fs/jffs/inode-v23.c
fs/lockd/clntlock.c
fs/nfs/delegation.c

init/do_mounts_initrd.c
kernel/kmod.c
kernel/stop_machine.c

net/bluetooth/bnep/core.c
net/bluetooth/cmtp/core.c
net/bluetooth/hidp/core.c
net/bluetooth/rfcomm/core.c
net/core/pktgen.c
net/ipv4/ipvs/ip_vs_sync.c
net/rxrpc/krxiod.c
net/rxrpc/krxsecd.c
net/rxrpc/krxtimod.c
net/sunrpc/svc.c
