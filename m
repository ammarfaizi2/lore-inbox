Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268544AbUIQHlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268544AbUIQHlq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 03:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268537AbUIQHkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 03:40:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26769 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268539AbUIQHiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 03:38:23 -0400
Date: Fri, 17 Sep 2004 00:38:00 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, devices@lanana.org
Subject: Re: ub vs. ubd
Message-Id: <20040917003800.199cc524@lembas.zaitcev.lan>
In-Reply-To: <200409170523.i8H5NZ2J005424@ccure.user-mode-linux.org>
References: <1340.1095332981@www10.gmx.net>
	<20040916084118.2441c38a@lembas.zaitcev.lan>
	<200409161753.i8GHrM2J003175@ccure.user-mode-linux.org>
	<20040916103454.46936a28@lembas.zaitcev.lan>
	<200409170523.i8H5NZ2J005424@ccure.user-mode-linux.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004 01:23:35 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> zaitcev@redhat.com said:
> > Can you send me your /proc/partitions from a guest with a few UBDs
> > configured? 
> 
> usermode:~# more /proc/partitions 
> major minor  #blocks  name
> 
>   98     0    1049600 ubda
>   98    16    1049600 ubdb
>   98    32     204801 ubdc

I see. So, the appended patch should be appropriate.

-- Pete

--- linux-2.6.9-rc1/Documentation/devices.txt	2004-08-19 17:15:31.000000000 -0700
+++ linux-2.6.9-rc1-ub/Documentation/devices.txt	2004-09-17 00:35:36.996215488 -0700
@@ -1741,10 +1741,14 @@
 		See http://stm.lbl.gov/comedi or http://www.llp.fu-berlin.de/.
 
  98 block	User-mode virtual block device
-		  0 = /dev/ubd0		First user-mode block device
-		  1 = /dev/ubd1		Second user-mode block device
+		  0 = /dev/ubda		First user-mode block device
+		 16 = /dev/ubdb		Second user-mode block device
 		    ...
 
+		Partitions are handled in the same way as for IDE
+		disks (see major number 3) except that the limit on
+		partitions is 15.
+
 		This device is used by the user-mode virtual kernel port.
 
  99 char	Raw parallel ports
