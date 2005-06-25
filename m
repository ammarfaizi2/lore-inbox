Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVFYWLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVFYWLh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 18:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVFYWLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 18:11:37 -0400
Received: from mail-1.netbauds.net ([62.232.161.102]:58316 "EHLO
	mail-1.netbauds.net") by vger.kernel.org with ESMTP id S261379AbVFYWKR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 18:10:17 -0400
Message-ID: <42BDD628.6020807@netbauds.net>
Date: Sat, 25 Jun 2005 23:09:44 +0100
From: "Darryl L. Miles" <darryl@netbauds.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.12 initrd module loading seems parallel on bootup
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm witnessing a problem with mounting root on a system that loads 
modules from initrd in order to be able to mount root, this problem does 
not exist in 2.6.11.12 but does in 2.6.12 and 2.6.12.1.  Its as-if the 
modprobe/insmod from the initrd mini-root is loading the modules in 
parallel rather than in series.  The machine is SMP too.

The printk output over the console indicates the module loading is 
happening in parallel, as I can clearly see different driver bootup 
messages out of their expected order.

During bootup synchronous behavior is needed so that the drivers can be 
loaded in the order to allow auto-detection to occur at each stage in 
order to resolve root, in my case:

Loading scsi_mod.ko module
Loading sd_mod.ko module
Loading scsi_transport_spi.ko module
Loading sym53c8xx.ko module
Loading cpqarray.ko module
Loading raid1.ko module
Loading jbd.ko module
Loading ext3.ko module

For an EXT3 fs over /dev/md0 over sym53x8xx SCSI bus.


Maybe this problem is a userspace problem, like an extra option needed 
to insmod to make is wait ?  Please advise.

-- 
Darryl L. Miles


