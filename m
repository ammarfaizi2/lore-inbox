Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWIDN0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWIDN0P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWIDN0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:26:15 -0400
Received: from main.gmane.org ([80.91.229.2]:56971 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964914AbWIDN0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:26:14 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [patch/RFC 2.6.18-rc] platform_device_probe(), to conserve memory
Date: Mon, 04 Sep 2006 16:25:45 +0200
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <44FC3769.3060502@flower.upol.cz>
References: <200609031823.05560.david-b@pacbell.net> <200609032224.28303.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090302040005000900080403"
X-Complaints-To: usenet@sea.gmane.org
Cc: David Brownell <david-b@pacbell.net>, Russell King <rmk@arm.linux.org.uk>,
       Greg KH <greg@kroah.com>
X-Gmane-NNTP-Posting-Host: 158.194.192.153
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <200609032224.28303.david-b@pacbell.net>
X-Image-Url: http://flower.upol.cz/~olecom/upol-cz.png
X-Face: =sibd$\hCvyTK_%u<|5M05t1lOc1Ld1'SSQ`+=v3P7:)0g%v{U`~4(q4"X(az&asiUNG.C3)XS1E`)4O'hK0{r}P9fxtLGVWvQQJekut9!Q"K8H2l>/Tfd.~R@PoY{TfjXUht[HdA+.Ncy?W;*K$5v(|n-=C6mne&mN}1(n
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090302040005000900080403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hallo,

David Brownell wrote:
[...]

 > + * One typical use for this would be with drivers for controllers integrated
 > + * into system-on-chip processors, where the controller devices have been
 > + * configured as part of board setup.
 > + *


Or every not-on-external-bus (usb/firewire/cardbus) device in laptop.

IMHO it's very good addition to everything-plug device driver model.
It must have its place in Documentation/driver-model/.

-- 
-o--=O`C  /. .\   (+)
  #oo'L O      o    |
<___=E M    ^--    |  (you're barking up the wrong tree)

--------------090302040005000900080403
Content-Type: text/x-patch;
 name="doc-platform_driver_probe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="doc-platform_driver_probe.patch"

--- linux-2.6.18-rc6/Documentation/driver-model/driver.txt~	2006-09-04 04:19:48.000000000 +0200
+++ linux-2.6.18-rc6/Documentation/driver-model/driver.txt	2006-09-04 16:14:18.551630750 +0200
@@ -105,14 +105,21 @@
 
 It is important that drivers register their driver structure as early as
 possible. Registration with the core initializes several fields in the
 struct device_driver object, including the reference count and the
 lock. These fields are assumed to be valid at all times and may be
 used by the device model core or the bus driver.
 
+int platform_driver_probe(struct platform_driver *drv,
+			  int (*probe)(struct platform_device *))
+
+Use this instead of platform_driver_register() when you know the device
+is not hotpluggable and has already been registered, and you want to
+remove its run-once probe() infrastructure from memory after the driver
+has bound to the device.
 
 Transition Bus Drivers
 ~~~~~~~~~~~~~~~~~~~~~~
 
 By defining wrapper functions, the transition to the new model can be
 made easier. Drivers can ignore the generic structure altogether and
 let the bus wrapper fill in the fields. For the callbacks, the bus can

--------------090302040005000900080403--

