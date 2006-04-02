Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWDBOjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWDBOjq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 10:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWDBOjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 10:39:46 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:25250 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S932350AbWDBOjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 10:39:45 -0400
Message-ID: <442FE22E.9090000@bootc.net>
Date: Sun, 02 Apr 2006 15:39:42 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5 (X11/20060309)
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Occasional APC Smart-UPS CS 500 USB UPS troubles
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have an APC Smart-UPS CS 500, and most of the time it works really 
nicely. I was stupefied to find it worked out of the box in Ubuntu 
Dapper and pops up a nice little icon when the power goes out, etc... 
The trouble is, that's only most of the time.

I'm guessing the USB controller in the device is buggy or something, 
because occasionally, when I reboot my machine with the UPS plugged in, 
the boot hangs or produces strange errors when detecting USB devices. 
All it takes to get the machine to boot properly is yank the USB plug on 
the UPS, plug it in again, and reboot.

Has anyone seen this before?

Not exactly kernel related I must admit, but this never seems to happen 
on *shudder* Windows, and I wouldn't expect such severe behaviour in 
case of trouble...

I've seen this on all sorts of kernels starting with the early 2.6 
series up to 2.6.16.1 and 2.6.16-ck3. My latest hang was with the latter 
kernel, and modprobe got stuck with the following trace:

modprobe      D ED465280     0   819    815                     (NOTLB)
f7cfade4 f7d0366c f7d03540 ed465280 000f41fd 005b8d80 00000000 f7794d1c
        00000292 f7cfa000 f7d03540 c02d0e0e 00000001 f7d03540 c0113f02 
f7794d24
        f7794d24 f6e31c58 f9734f40 f97e2f44 c0257dc6 c02cf89f f97e2f44 
f7794c58
Call Trace:
  [__down+202/240] __down+0xca/0xf0
  [default_wake_function+0/12] default_wake_function+0x0/0xc
  [__driver_attach+0/89] __driver_attach+0x0/0x59
  [__sched_text_start+7/12] __down_failed+0x7/0xc
  [.text.lock.dd+39/188] .text.lock.dd+0x27/0xbc
  [bus_for_each_dev+55/89] bus_for_each_dev+0x37/0x59
  [driver_attach+17/19] driver_attach+0x11/0x13
  [__driver_attach+0/89] __driver_attach+0x0/0x59
  [bus_add_driver+90/211] bus_add_driver+0x5a/0xd3
  [pg0+959850838/1069790208] usb_register_driver+0x50/0xae [usbcore]
  [pg0+949030918/1069790208] hid_init+0x6/0x3d [usbhid]
  [sys_init_module+4905/5197] sys_init_module+0x1329/0x144d
  [cp_new_stat64+237/255] cp_new_stat64+0xed/0xff
  [vma_prio_tree_insert+23/42] vma_prio_tree_insert+0x17/0x2a
  [vma_link+162/223] vma_link+0xa2/0xdf
  [do_mmap_pgoff+1202/1535] do_mmap_pgoff+0x4b2/0x5ff
  [sys_mmap2+97/144] sys_mmap2+0x61/0x90
  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75

Let me know if you need more info!

Thanks,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
