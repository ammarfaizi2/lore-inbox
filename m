Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVHWQYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVHWQYU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 12:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVHWQYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 12:24:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:11415 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932208AbVHWQYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 12:24:19 -0400
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc6-mm2
Date: Tue, 23 Aug 2005 18:28:18 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508231828.19755.daniel.ritz@gmx.ch>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yup, seems to be generally good...
> 
> Noticed this in the log earlier tonight:
> 
> Aug 23 19:44:51 tornado kernel: hub 5-0:1.0: port 1 disabled by hub (EMI?), 
> re-enabling...
> Aug 23 19:44:51 tornado kernel: usb 5-1: USB disconnect, address 2
> Aug 23 19:44:51 tornado kernel: drivers/usb/class/usblp.c: usblp0: removed
> Aug 23 19:44:51 tornado kernel: Unable to handle kernel NULL pointer 
> dereference at virtual address 00000004
> Aug 23 19:44:51 tornado kernel:  printing eip:
> Aug 23 19:44:51 tornado kernel: c01ccef2
> Aug 23 19:44:51 tornado kernel: *pde = 00000000
> Aug 23 19:44:51 tornado kernel: Oops: 0000 [#1]
> Aug 23 19:44:51 tornado kernel: SMP
> Aug 23 19:44:51 tornado kernel: last sysfs file: 
> /devices/pci0000:00/0000:00:1f.3/i2c-0/name
> Aug 23 19:44:51 tornado kernel: Modules linked in: nfsd exportfs lockd eeprom 
> sunrpc ipv6 iptable_filter binfmt_misc reiser4 zlib_de
> flate zlib_inflate dm_mod video thermal processor fan button ac tpm_nsc 
> i2c_i801 sky2 e100 sr_mod
> Aug 23 19:44:51 tornado kernel: CPU:    1
> Aug 23 19:44:51 tornado kernel: EIP:    0060:[<c01ccef2>]    Not tainted VLI
> Aug 23 19:44:51 tornado kernel: EFLAGS: 00010286   (2.6.13-rc6-mm2)
> Aug 23 19:44:51 tornado kernel: EIP is at _raw_spin_lock+0x7/0x73
> Aug 23 19:44:51 tornado kernel: eax: 00000000   ebx: 00000000   ecx: c1a60658 
>    edx: c1a63e24
> Aug 23 19:44:51 tornado kernel: esi: 00000000   edi: c0382400   ebp: f7c55e98 
>    esp: f7c55e90
> Aug 23 19:44:51 tornado kernel: ds: 007b   es: 007b   ss: 0068
> Aug 23 19:44:51 tornado kernel: Process khubd (pid: 109, threadinfo=f7c54000 
> task=c192b030)
> Aug 23 19:44:51 tornado kernel: Stack: f7c58a8c 00000000 f7c55ea0 c0312219 
> f7c55eb0 c030feb7 f7c58ae8 f7c58a48
> Aug 23 19:44:51 tornado kernel:        f7c55ec4 c0217e73 f7c58a48 f7d134ec 
> 00000040 f7c55ed0 c0217ec0 f7c58a48
> Aug 23 19:44:51 tornado kernel:        f7c55edc c0217814 f7c58a48 f7c55eec 
> c0216ad2 f7c58a48 f7c58a14 f7c55ef8
> Aug 23 19:44:51 tornado kernel: Call Trace:
> Aug 23 19:44:51 tornado kernel:  [<c01039c3>] show_stack+0x94/0xca
> Aug 23 19:44:51 tornado kernel:  [<c0103b6c>] show_registers+0x15a/0x1ea
> Aug 23 19:44:51 tornado kernel:  [<c0103d8a>] die+0x108/0x183
> Aug 23 19:44:51 tornado kernel:  [<c031295a>] do_page_fault+0x1ea/0x63d
> Aug 23 19:44:51 tornado kernel:  [<c0103693>] error_code+0x4f/0x54
> Aug 23 19:44:51 tornado kernel:  [<c0312219>] _spin_lock+0x8/0xa
> Aug 23 19:44:51 tornado kernel:  [<c030feb7>] klist_remove+0x10/0x2c
> Aug 23 19:44:51 tornado kernel:  [<c0217e73>] __device_release_driver+0x41/0x65
> Aug 23 19:44:51 tornado kernel:  [<c0217ec0>] device_release_driver+0x29/0x39
> Aug 23 19:44:51 tornado kernel:  [<c0217814>] bus_remove_device+0x52/0x60
> Aug 23 19:44:51 tornado kernel:  [<c0216ad2>] device_del+0x2e/0x5d
> Aug 23 19:44:51 tornado kernel:  [<c0216b0c>] device_unregister+0xb/0x15
> Aug 23 19:44:51 tornado kernel:  [<c0275d67>] usb_disconnect+0x115/0x15c
> Aug 23 19:44:51 tornado kernel:  [<c0276b85>] hub_port_connect_change+0x54/0x399
> Aug 23 19:44:51 tornado kernel:  [<c027713e>] hub_events+0x274/0x3b2
> Aug 23 19:44:51 tornado kernel:  [<c0277296>] hub_thread+0x1a/0xdf
> Aug 23 19:44:51 tornado kernel:  [<c012fba7>] kthread+0x99/0x9d
> Aug 23 19:44:51 tornado kernel:  [<c01010b5>] kernel_thread_helper+0x5/0xb
> Aug 23 19:44:51 tornado kernel: Code: 00 00 00 8b 0d a8 62 36 c0 e9 61 ff ff 
> ff f3 90 31 c0 86 07 84 c0 0f 8e 79 ff ff ff 83 c4 18 5
> b 5e 5f 5d c3 55 89 e5 56 53 89 c3 <81> 78 04 ad 4e ad de 75 2d be 00 e0 ff ff 
> 21 e6 8b 06 39 43 0c
> 
this one is my fault, caused by driver-core-fix-bus_rescan_devices-race.patch
problem is that USB is direclty messing with dev->driver and then calling
device_bind_driver() if the device is not already bound...
i think the correct solution would be a sane API here and disallow direct
messing with dev->driver...meanwhile the attached patch will do.

messing directly with dev->driver is especially bad if it's already set
to another driver. this leads to problems later in device_release_driver().

akpm: please replace driver-core-fix-bus_rescan_devices-race.patch with
the attached one.

rgds
-daniel

---
[PATCH] driver core: fix bus_rescan_devices() race.

bus_rescan_devices_helper() does not hold the dev->sem when it checks for
!dev->driver. device_attach() holds the sem, but calls again device_bind_driver()
even when dev->driver is set. what happens is that a first device_attach() call
(module insertion time) is on the way binding the device to a driver. another
thread calls bus_rescan_devices().  now when bus_rescan_devices_helper() checks
for dev->driver it is still NULL 'cos the the prior device_attach() is not yet
finished. but as soon as the first one releases the dev->sem the second
device_attach() tries to rebind the already bound device again.
device_bind_driver() does this blindly which leads to a corrupt
driver->klist_devices list (the device links itself, the head points to the
device). later a call to device_release_driver() sets dev->driver to NULL and
breaks the link it has to itself on knode_driver. rmmoding the driver later
calls driver_detach() which leads to an endless loop 'cos the list head in
klist_devices still points to the device. and since dev->driver is NULL it's
stuck with the same device forever. boom. and rmmod hangs.

very easy to reproduce with new-style pcmcia and a 16bit card. just loop
modprobe <pcmcia-modules> ;cardctl eject; rmmod <card driver, pcmcia modules>.

easiest fix is to check if the device is already bound to a driver in
device_bind_driver(). this avoids the double binding. nicer would be not to
call device_bind_driver() in device_attach() if dev->driver is set. but since
some drivers are messing with dev->driver directly this is not a good idea.

and while at it replace spin_(un|)lock_irq in driver_detach with the non-irq
variants. just doesn't make sense to me. the whole klist locking never uses the
irq variants.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -485,8 +485,7 @@ void bus_remove_driver(struct device_dri
 /* Helper for bus_rescan_devices's iter */
 static int bus_rescan_devices_helper(struct device *dev, void *data)
 {
-	if (!dev->driver)
-		device_attach(dev);
+	device_attach(dev);
 	return 0;
 }
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -40,6 +40,9 @@
  */
 void device_bind_driver(struct device * dev)
 {
+	if (klist_node_attached(&dev->knode_driver))
+		return;
+
 	pr_debug("bound device '%s' to driver '%s'\n",
 		 dev->bus_id, dev->driver->name);
 	klist_add_tail(&dev->driver->klist_devices, &dev->knode_driver);
@@ -222,15 +225,15 @@ void driver_detach(struct device_driver 
 	struct device * dev;
 
 	for (;;) {
-		spin_lock_irq(&drv->klist_devices.k_lock);
+		spin_lock(&drv->klist_devices.k_lock);
 		if (list_empty(&drv->klist_devices.k_list)) {
-			spin_unlock_irq(&drv->klist_devices.k_lock);
+			spin_unlock(&drv->klist_devices.k_lock);
 			break;
 		}
 		dev = list_entry(drv->klist_devices.k_list.prev,
 				struct device, knode_driver.n_node);
 		get_device(dev);
-		spin_unlock_irq(&drv->klist_devices.k_lock);
+		spin_unlock(&drv->klist_devices.k_lock);
 
 		down(&dev->sem);
 		if (dev->driver == drv)
