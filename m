Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTIWJs3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 05:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263307AbTIWJs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 05:48:29 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:36841 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S262098AbTIWJsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 05:48:17 -0400
Date: Tue, 23 Sep 2003 11:47:46 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
To: Greg KH <greg@kroah.com>
Cc: Yaroslav Halchenko <yoh@onerussian.com>, linux-kernel@vger.kernel.org
Subject: Re: USB problem. 'irq 9: nobody cared!'
Message-ID: <20030923094746.GA22232@ppp0.net>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Yaroslav Halchenko <yoh@onerussian.com>,
	linux-kernel@vger.kernel.org
References: <20030921184149.GA12274@washoe.rutgers.edu> <20030922063324.GF3398@ppp0.net> <20030923050848.GA5917@washoe.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923050848.GA5917@washoe.rutgers.edu>
I-love-doing-this: really
X-Modeline: vim:set ts=8 sw=4 smarttab tw=72 si noic notitle:
X-Operating-System: Linux/2.4.22aa1 (i686)
X-Uptime: 11:39:13 up 21 days,  1:37, 11 users,  load average: 0.10, 0.32, 0.16
Accept-Languages: de, en, fr
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yaroslav Halchenko <yoh@onerussian.com> wrote on 2003-09-23 01:08:48
> Thanx - reversing all "improvements"  done in -bk5 seems to help
> - usb works :-))
> 
> --Yarik
> 
> On Mon, Sep 22, 2003 at 08:33:24AM +0200, Jan Dittmer wrote:
> > Yaroslav Halchenko <kernel@onerussian.com> wrote on 2003-09-21 14:41:49
> > > Dear Gurus,
> > > 
> > > Since one of the bk versions in -test4- USB problem persist. On boot I'm
> > > getting next dump. More information about my system and configuration is at
> > > 
> > > http://www.onerussian.com/Linux/bug.USB/
> > > 
> > > Please help to get rid of the problem cause USB doesn't work now for me :-(
> > 
> > Try reverting the following patch, taken from the bk4-bk5 incremental
> > diff (Apply with patch -p1 -R). This fixed it for me.
> > 
> >    Jan
> > 

Greg, what is going on here? In a nutshell: Irq 9 gets disabled on boot
and all other devices on this irq consequently doesn't work any more.
Here is the oops from dmesg again:

uhci-hcd 0000:00:1f.2: UHCI Host Controller
irq 9: nobody cared!
Call Trace:
 [<c010b65a>] __report_bad_irq+0x2a/0x90
 [<c010b750>] note_interrupt+0x70/0xb0
 [<c010ba21>] do_IRQ+0x121/0x130
 [<c0109d38>] common_interrupt+0x18/0x20
 [<c01e007b>] crypto_init_compress_ops+0x3b/0x40
 [<c01226de>] do_softirq+0x3e/0xa0
 [<c010b9fd>] do_IRQ+0xfd/0x130
 [<c0109d38>] common_interrupt+0x18/0x20
 [<c01e44bf>] pci_bus_write_config_word+0x5f/0x90
 [<c029f450>] uhci_reset+0x0/0x60
 [<c029f48f>] uhci_reset+0x3f/0x60
 [<c0295ad6>] usb_hcd_pci_probe+0x196/0x4a0
 [<c01e8092>] pci_device_probe_static+0x52/0x70
 [<c01e821c>] __pci_device_probe+0x3c/0x50
 [<c01e825c>] pci_device_probe+0x2c/0x50
 [<c023c6ff>] bus_match+0x3f/0x70
 [<c023c84f>] driver_attach+0x6f/0xb0
 [<c023cb13>] bus_add_driver+0x93/0xb0
 [<c023cf4f>] driver_register+0x2f/0x40
 [<c01e84ec>] pci_register_driver+0x5c/0x90
 [<c044bbb4>] uhci_hcd_init+0xc4/0x160
 [<c04347cb>] do_initcalls+0x2b/0xa0
 [<c012e10f>] init_workqueues+0xf/0x30
 [<c01050a4>] init+0x34/0x1d0
 [<c0105070>] init+0x0/0x1d0
 [<c0107255>] kernel_thread_helper+0x5/0x10

handlers:
[<c01eb9af>] (acpi_irq+0x0/0x16)
Disabling IRQ #9
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci-hcd 0000:00:1f.2: irq 9, io base 00001820
uhci-hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
PM: Adding info for usb:usb1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PM: Adding info for usb:1-0:0
uhci-hcd 0000:00:1f.4: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci-hcd 0000:00:1f.4: irq 9, io base 00002400
uhci-hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
PM: Adding info for usb:usb2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
PM: Adding info for usb:2-0:0

Thanks,

Jan


diff -urN linux-2.6.0-test4-bk4/drivers/usb/core/hcd-pci.c linux-2.6.0-test4-bk5/drivers/usb/core/hcd-pci.c
--- linux-2.6.0-test4-bk4/drivers/usb/core/hcd-pci.c	2003-08-22 16:55:40.000000000 -0700
+++ linux-2.6.0-test4-bk5/drivers/usb/core/hcd-pci.c	2003-09-03 04:46:52.000000000 -0700
@@ -139,6 +139,7 @@
 			return retval;
 		}
 	}
+	// hcd zeroed everything
 	hcd->regs = base;
 	hcd->region = region;
 
@@ -165,6 +166,7 @@
 		dev_err (hcd->controller, "can't reset\n");
 		goto clean_3;
 	}
+	hcd->state = USB_STATE_HALT;
 
 	pci_set_master (dev);
 #ifndef __sparc__
@@ -230,7 +232,8 @@
 		BUG ();
 
 	hub = hcd->self.root_hub;
-	hcd->state = USB_STATE_QUIESCING;
+	if (HCD_IS_RUNNING (hcd->state))
+		hcd->state = USB_STATE_QUIESCING;
 
 	dev_dbg (hcd->controller, "roothub graceful disconnect\n");
 	usb_disconnect (&hub);
@@ -287,8 +290,8 @@
 		pci_save_state (dev, hcd->pci_state);
 
 		/* driver may want to disable DMA etc */
+		hcd->state = USB_STATE_QUIESCING;
 		retval = hcd->driver->suspend (hcd, state);
-		hcd->state = USB_STATE_SUSPENDED;
 	}
 
  	pci_set_power_state (dev, state);
diff -urN linux-2.6.0-test4-bk4/drivers/usb/core/hcd.c linux-2.6.0-test4-bk5/drivers/usb/core/hcd.c
--- linux-2.6.0-test4-bk4/drivers/usb/core/hcd.c	2003-08-22 16:57:00.000000000 -0700
+++ linux-2.6.0-test4-bk5/drivers/usb/core/hcd.c	2003-09-03 04:46:52.000000000 -0700
@@ -483,7 +483,7 @@
 {
 	struct urb	*urb;
 	struct usb_hcd	*hcd;
-	int		length;
+	int		length = 0;
 	unsigned long	flags;
 
 	urb = (struct urb *) ptr;
@@ -499,7 +499,9 @@
 		return;
 	}
 
-	length = hcd->driver->hub_status_data (hcd, urb->transfer_buffer);
+	if (!HCD_IS_SUSPENDED (hcd->state))
+		length = hcd->driver->hub_status_data (
+					hcd, urb->transfer_buffer);
 
 	/* complete the status urb, or retrigger the timer */
 	spin_lock (&hcd_data_lock);
@@ -1097,6 +1099,8 @@
 static int hcd_get_frame_number (struct usb_device *udev)
 {
 	struct usb_hcd	*hcd = (struct usb_hcd *)udev->bus->hcpriv;
+	if (!HCD_IS_RUNNING (hcd->state))
+		return -ESHUTDOWN;
 	return hcd->driver->get_frame_number (hcd);
 }
 
@@ -1193,6 +1197,12 @@
 		goto done;
 	}
 
+	/* running ~= hc unlink handshake works (irq, timer, etc)
+	 * halted ~= no unlink handshake is needed
+	 * suspended, resuming == should never happen
+	 */
+	WARN_ON (!HCD_IS_RUNNING (hcd->state) && hcd->state != USB_STATE_HALT);
+
 	if (!urb->hcpriv) {
 		retval = -EINVAL;
 		goto done;
@@ -1208,6 +1218,17 @@
 		goto done;
 	}
 
+	/* PCI IRQ setup can easily be broken so that USB controllers
+	 * never get completion IRQs ... maybe even the ones we need to
+	 * finish unlinking the initial failed usb_set_address().
+	 */
+	if (!hcd->saw_irq) {
+		dev_warn (hcd->controller, "Unlink after no-IRQ?  "
+			"Different ACPI or APIC settings may help."
+			"\n");
+		hcd->saw_irq = 1;
+	}
+
 	/* maybe set up to block until the urb's completion fires.  the
 	 * lower level hcd code is always async, locking on urb->status
 	 * updates; an intercepted completion unblocks us.
@@ -1287,6 +1308,8 @@
 	dev = udev->hcpriv;
 	hcd = udev->bus->hcpriv;
 
+	WARN_ON (!HCD_IS_RUNNING (hcd->state) && hcd->state != USB_STATE_HALT);
+
 	local_irq_disable ();
 
 rescan:
@@ -1483,6 +1506,7 @@
 	if (unlikely (hcd->state == USB_STATE_HALT))	/* irq sharing? */
 		return IRQ_NONE;
 
+	hcd->saw_irq = 1;
 	hcd->driver->irq (hcd, r);
 	if (hcd->state != start && hcd->state == USB_STATE_HALT)
 		usb_hc_died (hcd);
diff -urN linux-2.6.0-test4-bk4/drivers/usb/core/hcd.h linux-2.6.0-test4-bk5/drivers/usb/core/hcd.h
--- linux-2.6.0-test4-bk4/drivers/usb/core/hcd.h	2003-08-22 16:53:55.000000000 -0700
+++ linux-2.6.0-test4-bk5/drivers/usb/core/hcd.h	2003-09-03 04:46:52.000000000 -0700
@@ -73,6 +73,7 @@
 	 * hardware info/state
 	 */
 	struct hc_driver	*driver;	/* hw-specific hooks */
+	unsigned		saw_irq : 1;
 	int			irq;		/* irq allocated */
 	void			*regs;		/* device memory/io */
 	struct device		*controller;	/* handle to hardware */
@@ -89,13 +90,11 @@
 
 	int			state;
 #	define	__ACTIVE		0x01
-#	define	__SLEEPY		0x02
 #	define	__SUSPEND		0x04
 #	define	__TRANSIENT		0x80
 
 #	define	USB_STATE_HALT		0
 #	define	USB_STATE_RUNNING	(__ACTIVE)
-#	define	USB_STATE_READY		(__ACTIVE|__SLEEPY)
 #	define	USB_STATE_QUIESCING	(__SUSPEND|__TRANSIENT|__ACTIVE)
 #	define	USB_STATE_RESUMING	(__SUSPEND|__TRANSIENT)
 #	define	USB_STATE_SUSPENDED	(__SUSPEND)
diff -urN linux-2.6.0-test4-bk4/drivers/usb/core/message.c linux-2.6.0-test4-bk5/drivers/usb/core/message.c
--- linux-2.6.0-test4-bk4/drivers/usb/core/message.c	2003-08-22 16:53:13.000000000 -0700
+++ linux-2.6.0-test4-bk5/drivers/usb/core/message.c	2003-09-03 04:46:52.000000000 -0700
@@ -246,21 +246,22 @@
 		io->status = urb->status;
 
 		/* the previous urbs, and this one, completed already.
-		 * unlink the later ones so they won't rx/tx bad data,
-		 *
-		 * FIXME don't bother unlinking urbs that haven't yet been
-		 * submitted; those non-error cases shouldn't be syslogged
+		 * unlink pending urbs so they won't rx/tx bad data.
 		 */
 		for (i = 0, found = 0; i < io->entries; i++) {
+			if (!io->urbs [i])
+				continue;
 			if (found) {
 				status = usb_unlink_urb (io->urbs [i]);
-				if (status && status != -EINPROGRESS)
-					err ("sg_complete, unlink --> %d",
-							status);
+				if (status != -EINPROGRESS && status != -EBUSY)
+					dev_err (&io->dev->dev,
+						"%s, unlink --> %d\n",
+						__FUNCTION__, status);
 			} else if (urb == io->urbs [i])
 				found = 1;
 		}
 	}
+	urb->dev = 0;
 
 	/* on the last completion, signal usb_sg_wait() */
 	io->bytes += urb->actual_length;
@@ -356,7 +357,7 @@
 			goto nomem;
 		}
 
-		io->urbs [i]->dev = dev;
+		io->urbs [i]->dev = 0;
 		io->urbs [i]->pipe = pipe;
 		io->urbs [i]->interval = period;
 		io->urbs [i]->transfer_flags = urb_flags;
@@ -448,6 +449,7 @@
 	for (i = 0; i < io->entries && !io->status; i++) {
 		int	retval;
 
+		io->urbs [i]->dev = io->dev;
 		retval = usb_submit_urb (io->urbs [i], SLAB_ATOMIC);
 
 		/* after we submit, let completions or cancelations fire;
@@ -459,9 +461,9 @@
 		case -ENXIO:	// hc didn't queue this one
 		case -EAGAIN:
 		case -ENOMEM:
+			io->urbs [i]->dev = 0;
 			retval = 0;
 			i--;
-			// FIXME:  should it usb_sg_cancel() on INTERRUPT?
 			yield ();
 			break;
 
@@ -477,8 +479,10 @@
 
 			/* fail any uncompleted urbs */
 		default:
+			io->urbs [i]->dev = 0;
 			io->urbs [i]->status = retval;
-			dbg ("usb_sg_msg, submit --> %d", retval);
+			dev_dbg (&io->dev->dev, "%s, submit --> %d\n",
+				__FUNCTION__, retval);
 			usb_sg_cancel (io);
 		}
 		spin_lock_irqsave (&io->lock, flags);
@@ -521,9 +525,9 @@
 			if (!io->urbs [i]->dev)
 				continue;
 			retval = usb_unlink_urb (io->urbs [i]);
-			if (retval && retval != -EINPROGRESS)
-				warn ("usb_sg_cancel, unlink --> %d", retval);
-			// FIXME don't warn on "not yet submitted" error
+			if (retval != -EINPROGRESS && retval != -EBUSY)
+				dev_warn (&io->dev->dev, "%s, unlink --> %d\n",
+					__FUNCTION__, retval);
 		}
 	}
 	spin_unlock_irqrestore (&io->lock, flags);
diff -urN linux-2.6.0-test4-bk4/drivers/usb/core/usb.c linux-2.6.0-test4-bk5/drivers/usb/core/usb.c
--- linux-2.6.0-test4-bk4/drivers/usb/core/usb.c	2003-08-22 16:56:17.000000000 -0700
+++ linux-2.6.0-test4-bk5/drivers/usb/core/usb.c	2003-09-03 04:46:52.000000000 -0700
@@ -991,8 +991,8 @@
  *
  * This call is synchronous, and may not be used in an interrupt context.
  *
- * Only hub drivers (including virtual root hub drivers for host
- * controllers) should ever call this.
+ * Only the hub driver should ever call this; root hub registration
+ * uses it only indirectly.
  */
 #define NEW_DEVICE_RETRYS	2
 #define SET_ADDRESS_RETRYS	2
@@ -1417,11 +1417,46 @@
 			usb_pipein (pipe) ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
+static int usb_device_suspend(struct device *dev, u32 state)
+{
+	struct usb_interface *intf;
+	struct usb_driver *driver;
+
+	if ((dev->driver == &usb_generic_driver) || 
+	    (dev->driver_data == &usb_generic_driver_data))
+		return 0;
+
+	intf = to_usb_interface(dev);
+	driver = to_usb_driver(dev->driver);
+
+	if (driver && driver->suspend)
+		return driver->suspend(intf, state);
+	return 0;
+}
+
+static int usb_device_resume(struct device *dev)
+{
+	struct usb_interface *intf;
+	struct usb_driver *driver;
+
+	if ((dev->driver == &usb_generic_driver) || 
+	    (dev->driver_data == &usb_generic_driver_data))
+		return 0;
+
+	intf = to_usb_interface(dev);
+	driver = to_usb_driver(dev->driver);
+
+	if (driver && driver->resume)
+		return driver->resume(intf);
+	return 0;
+}
 
 struct bus_type usb_bus_type = {
 	.name =		"usb",
 	.match =	usb_device_match,
 	.hotplug =	usb_hotplug,
+	.suspend =	usb_device_suspend,
+	.resume =	usb_device_resume,
 };
 
 #ifndef MODULE
@@ -1509,7 +1544,6 @@
 EXPORT_SYMBOL(usb_find_interface);
 EXPORT_SYMBOL(usb_ifnum_to_if);
 
-EXPORT_SYMBOL(usb_new_device);
 EXPORT_SYMBOL(usb_reset_device);
 EXPORT_SYMBOL(usb_disconnect);
 
diff -urN linux-2.6.0-test4-bk4/drivers/usb/host/uhci-hcd.c linux-2.6.0-test4-bk5/drivers/usb/host/uhci-hcd.c
--- linux-2.6.0-test4-bk4/drivers/usb/host/uhci-hcd.c	2003-08-22 16:59:32.000000000 -0700
+++ linux-2.6.0-test4-bk5/drivers/usb/host/uhci-hcd.c	2003-09-03 04:46:52.000000000 -0700
@@ -2099,7 +2099,7 @@
 	uhci->state_end = jiffies + HZ;
 	outw(USBCMD_RS | USBCMD_CF | USBCMD_MAXP, io_addr + USBCMD);
 
-        uhci->hcd.state = USB_STATE_READY;
+        uhci->hcd.state = USB_STATE_RUNNING;
 }
 
 /*
@@ -2143,6 +2143,20 @@
 #endif
 }
 
+static int uhci_reset(struct usb_hcd *hcd)
+{
+	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
+
+	uhci->io_addr = (unsigned long) hcd->regs;
+
+	/* Maybe kick BIOS off this hardware.  Then reset, so we won't get
+	 * interrupts from any previous setup.
+	 */
+	pci_write_config_word(hcd->pdev, USBLEGSUP, USBLEGSUP_DEFAULT);
+	reset_hc(uhci);
+	return 0;
+}
+
 /*
  * Allocate a frame list, and then setup the skeleton
  *
@@ -2159,7 +2173,7 @@
  *  - The fourth queue is the bandwidth reclamation queue, which loops back
  *    to the high speed control queue.
  */
-static int __devinit uhci_start(struct usb_hcd *hcd)
+static int uhci_start(struct usb_hcd *hcd)
 {
 	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
 	int retval = -EBUSY;
@@ -2171,7 +2185,6 @@
 	struct proc_dir_entry *ent;
 #endif
 
-	uhci->io_addr = (unsigned long) hcd->regs;
 	io_size = pci_resource_len(hcd->pdev, hcd->region);
 
 #ifdef CONFIG_PROC_FS
@@ -2188,10 +2201,6 @@
 	uhci->proc_entry = ent;
 #endif
 
-	/* Reset here so we don't get any interrupts from an old setup */
-	/*  or broken setup */
-	reset_hc(uhci);
-
 	uhci->fsbr = 0;
 	uhci->fsbrtimeout = 0;
 
@@ -2343,9 +2352,6 @@
 
 	init_stall_timer(hcd);
 
-	/* disable legacy emulation */
-	pci_write_config_word(hcd->pdev, USBLEGSUP, USBLEGSUP_DEFAULT);
-
 	udev->speed = USB_SPEED_FULL;
 
 	if (usb_register_root_hub(udev, &hcd->pdev->dev) != 0) {
@@ -2446,7 +2452,7 @@
 		reset_hc(uhci);
 		start_hc(uhci);
 	}
-	uhci->hcd.state = USB_STATE_READY;
+	uhci->hcd.state = USB_STATE_RUNNING;
 	return 0;
 }
 #endif
@@ -2484,6 +2490,7 @@
 	.flags =		HCD_USB11,
 
 	/* Basic lifecycle operations */
+	.reset =		uhci_reset,
 	.start =		uhci_start,
 #ifdef CONFIG_PM
 	.suspend =		uhci_suspend,
@@ -2504,18 +2511,9 @@
 };
 
 static const struct pci_device_id uhci_pci_ids[] = { {
-
 	/* handle any USB UHCI controller */
-	.class = 		((PCI_CLASS_SERIAL_USB << 8) | 0x00),
-	.class_mask = 	~0,
+	PCI_DEVICE_CLASS(((PCI_CLASS_SERIAL_USB << 8) | 0x00), ~0),
 	.driver_data =	(unsigned long) &uhci_driver,
-
-	/* no matter who makes it */
-	.vendor =	PCI_ANY_ID,
-	.device =	PCI_ANY_ID,
-	.subvendor =	PCI_ANY_ID,
-	.subdevice =	PCI_ANY_ID,
-
 	}, { /* end: all zeroes */ }
 };
 
