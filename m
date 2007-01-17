Return-Path: <linux-kernel-owner+w=401wt.eu-S1751387AbXAQNak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbXAQNak (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 08:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbXAQNak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 08:30:40 -0500
Received: from mail.syneticon.net ([213.239.212.131]:35801 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbXAQNaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 08:30:39 -0500
X-Greylist: delayed 1895 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jan 2007 08:30:39 EST
Message-ID: <45AE1D65.4010804@wpkg.org>
Date: Wed, 17 Jan 2007 13:58:13 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061110 Mandriva/1.5.0.8-1mdv2007.1 (2007.1) Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel cmdline: root=/dev/sdb1,/dev/sda1 "fallback"?
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Linux (ARM) device that normally starts from /dev/sda1.

It is configured to do so via a cmdline in a RedBoot bootloader:

root=/dev/sda1


The device is pretty small and has no keyboard, video card etc., so if 
it ever happens to break (can be a disk failure, but also operator who 
messed with startup scripts), it has to be opened (warranty!).


These all unpleasant tasks could be avoided if it was possible to have a 
"fallback" device. For example, consider this hypothetical command line:

root=/dev/sdb1,/dev/sda1


/dev/sdb1 - USB-stick which can boot the device
/dev/sda1 - HDD which normally starts the device


It would mean, that kernel tries to boot the OS from /dev/sdb1, and if 
there isn't such a device, it tries to boot the OS from /dev/sda1.


In our case, /dev/sdb1 would be an external USB-stick capable to boot 
the device (in that case, we'd have to add rootdelay= option, too).
One would connect it only if he/she wants to service the device.

If /dev/sdb1 is not found by the kernel, the boot would start 
("fallback") from /dev/sda1.


Does this make sense?


As I understand correctly, the needed change would have to be done in 
init/do_mounts.c, around "static int __init do_mount_root" and "void 
__init mount_block_root"? Any clues on that?


-- 
Tomasz Chmielewski
http://wpkg.org


