Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263892AbTIEOqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 10:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264055AbTIEOqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 10:46:16 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:34033 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S263892AbTIEOqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 10:46:10 -0400
From: dave <dav1d@bigfoot.com>
Subject: Re: 2.6.0-test4-mm6
To: linux-kernel@vger.kernel.org, Maciej Soltysiak <solt@dns.toxicfilms.tv>
Date: Fri, 05 Sep 2003 15:44:58 +0100
References: <smuc.6c2.27@gated-at.bofh.it> <snqc.7FM.21@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20030905144600.CNEC2218.mta07-svc.ntlworld.com@stimpy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak wrote:

>> 2. X11R6 won't start anymore, it fails with a strange
>> Fatal server error:
>> xf86OpenConsole: VT_GETMODE failed
>> I can't find a reason for that in the changelog.
> Well, I can't start X because I am using nvidia drivers + www.minion.de
> patches, and some specs seem to have changed again.
> kernel: nvidia: Unknown symbol kdev_val
> 
> If the kdev_t.h changes are going to stay, I will have to wait for
> Christian Zander's updates to the nvidia 2.6-patch.

The following patch fixes it for me.

Cheers,

dave

--- nv-linux.h  2003-09-05 15:20:55.000000000 +0100
+++ nv-linux.h.fixed    2003-09-05 15:21:03.000000000 +0100
@@ -129,8 +129,13 @@
 #define NV_VMA_PRIVATE(vma)           ((vma)->vm_private_data)

 #ifdef KERNEL_2_5
-#  define NV_DEVICE_NUMBER(_minor)      ((kdev_val(_minor)) & 0x0f)
-#  define NV_IS_CONTROL_DEVICE(_minor)  (((kdev_val(_minor)) & 0xff) == 0xff)
+
+//#  define NV_DEVICE_NUMBER(_minor)      ((kdev_val(_minor)) & 0x0f)
+//#  define NV_IS_CONTROL_DEVICE(_minor)  (((kdev_val(_minor)) & 0xff) == 0xff)
+
+#  define NV_DEVICE_NUMBER(_minor)      (MINOR(_minor) & 0x0f)
+#  define NV_IS_CONTROL_DEVICE(_minor)  ((MINOR(_minor) & 0x0ff) == 0xff)
+
 #  define NV_IS_SUSER()                 capable(CAP_SYS_ADMIN)
 #  define NV_PCI_DEVICE_NAME(x)         ((x)->pretty_name)
 #  define NV_CLI()                      local_irq_disable()

