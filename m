Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUIZXGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUIZXGt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 19:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUIZXGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 19:06:49 -0400
Received: from smtp2.nbnz.co.nz ([202.49.143.67]:42252 "HELO smtp2.nbnz.co.nz")
	by vger.kernel.org with SMTP id S264915AbUIZXGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 19:06:25 -0400
Message-ID: <40BC5D4C2DD333449FBDE8AE961E0C33017E3C3F@psexc03.nbnz.co.nz>
From: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
To: linux-kernel@vger.kernel.org
Subject: Help Requested with patching "drivers/pci/quirks.c"
Date: Mon, 27 Sep 2004 11:06:15 +1200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to get lm-sensors running on a 2.6.7 kernel (yes, I know that's a
couple of releases behind...) on a Compaq Evo D51C PC.

On an identical machine which is running 2.4.27, I have to use the
lm-sensors supplied "p4b_smbus" module to enable the SMBus/PCI interface
before the i2c-i801 driver will load; it would appear that this machine
hides it much like the Asus motherboards do.

In the kernel 2.6 world, that module doesn't compile; and my research leads
me to understand that similar functionality is built into the quirks.c code.

Looking at the quirks.c code, I can see functions like
"asus_hides_smbus_hostbridge" and "asus_hides_smbus_lpc", which use a lookup
table to determine whether or not to set the appropriate flag and toggle the
PCI bits to enable the SMbus.  Obviously, I need to include the appropriate
checks (and associated entries in the pci_fixups struct) to get this applied
to my machine at kernel load time (I've seen some patches on the lkml
recently that seem to do exactly this - quite happy to try and add this
functionality).  For example, here is an extract from a similar patch:

+        if ((dev->device == PCI_DEVICE_ID_INTEL_82865_HB) &&
+            (dev->subsystem_device == 0x12bc)) /* HP D330L */
+                asus_hides_smbus = 1;

My problem is that I don't understand how the "dev->device" and
"dev->subsystem_device" values are obtained.  Where/How do I read the actual
values from my machine so that I can add them into the code tables?
 
Any help would be appreciated; as would "cc"ing replies directly to me (I
don't subscribe to lkml, and may miss replies when searching via MARC).

Thanks,

James Roberts-Thomson
----------
Adult:  A person that has stopped growing at both ends but not in the
middle.



This communication is confidential and may contain privileged material.
If you are not the intended recipient you must not use, disclose, copy or retain it.
If you have received it in error please immediately notify me by return email
and delete the emails.
Thank you.
