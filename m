Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266423AbTGJTfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 15:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266429AbTGJTfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 15:35:51 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:54003 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S266423AbTGJTfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 15:35:50 -0400
Message-ID: <3F0DC337.50903@mvista.com>
Date: Thu, 10 Jul 2003 12:49:11 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, andre@linux-ide.org, frankt@promise.com
Subject: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21, patch attached
 to fix
Content-Type: multipart/mixed;
 boundary="------------090406070103090506020202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090406070103090506020202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Folks,

After I upgraded to 2.4.21, I noticed my Gigabyte motherboard with 
onboard IDE Promise 20276 FastTrack RAID no longer works.  The following 
patch fixes the problem, which appears to be an incomplete list of 
devices in the ide setup code.  There are probably other fasttrack RAID 
adaptors that should be added to the setup code, but I don't know what 
they are.

Thanks
-steve

--------------090406070103090506020202
Content-Type: text/plain;
 name="pdc20276fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pdc20276fix.patch"

--- linux-2.4.21/drivers/ide/setup-pci.c	Fri Jun 13 07:51:34 2003
+++ linux-2.4.21-work/drivers/ide/setup-pci.c	Thu Jul 10 12:02:45 2003
@@ -640,7 +640,8 @@
 		 */
 		if (((d->vendor == PCI_VENDOR_ID_PROMISE) &&
 		     ((d->device == PCI_DEVICE_ID_PROMISE_20262) ||
-		      (d->device == PCI_DEVICE_ID_PROMISE_20265))) &&
+		      (d->device == PCI_DEVICE_ID_PROMISE_20265) ||
+		      (d->device == PCI_DEVICE_ID_PROMISE_20276))) &&
 		    (secondpdc++==1) && (port==1))
 			goto controller_ok;
 			

--------------090406070103090506020202--

