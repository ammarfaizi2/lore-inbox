Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVIJLpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVIJLpL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 07:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVIJLpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 07:45:11 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:47370 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S1750755AbVIJLpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 07:45:10 -0400
Message-ID: <4322C741.9060808@roarinelk.homelinux.net>
Date: Sat, 10 Sep 2005 13:45:05 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, adaplas@pol.net
Subject: Re: 2.6.13-mm2
References: <20050908053042.6e05882f.akpm@osdl.org>
In-Reply-To: <20050908053042.6e05882f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Andrew Morton wrote:

> +i810fb-add-i2c-ddc-support.patch
> +i810fb-add-i2c-ddc-support-fix.patch
> +i810fb-add-i2c-ddc-support-fix-fix.patch
> +i810fb-add-i2c-ddc-support-Makefile-fix.patch

compiled with CONFIG_FB_I810_I2C = n and CONFIG_FB_I810 = y
it oopses at boot in file drivers/video/i810/i810_main.c:1884

...
Kernel command line: root=/dev/hda7 video=i810fb:xres:1024,yres:768,bpp:8,hsync1:40,hsync2:80,vsync1:60,vsync2:60,extvga,vram:4,accel,mtrr
...
Unable to handle kernel NULL pointer dereference at virtual address 00000054
  printing eip:
c02543c0
*pde = 00000000
Oops: 0000 [#1]
last sysfs file:
Modules linked in:
CPU:    0
EIP:    0060:[<c02543c0>]    Not tainted VLI
EFLAGS: 00010286   (2.6.13-mm2)
EIP is at i810fb_find_init_mode+0x53/0x93
eax: c113ddd4   ebx: c1194000   ecx: c04be2dd   edx: c1194000
esi: c1194008   edi: c113ddd4   ebp: c1194240   esp: c113ddcc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c113c000 task=c7cd6a30)
Stack: 00000000 00000008 00000400 00000300 00000000 00001000 00000000 00000000
        00000008 00000000 00000000 00000000 00000000 00000000 00000000 00000000
        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace:
  [<c01ecb01>] fb_alloc_cmap+0x8d/0xa0
  [<c025491b>] i810fb_init_pci+0x10a/0x23c
  [<c026dd9e>] __driver_attach+0x0/0x33
  [<c01e1198>] pci_call_probe+0xa/0xc
  [<c01e11c8>] __pci_device_probe+0x2e/0x3f
  [<c01e11f7>] pci_device_probe+0x1e/0x30
  [<c026dcfb>] driver_probe_device+0x31/0x82
  [<c026ddc1>] __driver_attach+0x23/0x33
  [<c026d60f>] bus_for_each_dev+0x35/0x59
  [<c026dde2>] driver_attach+0x11/0x13
  [<c026dd9e>] __driver_attach+0x0/0x33
  [<c026d993>] bus_add_driver+0x52/0x92
  [<c026e0a2>] driver_register+0x2f/0x34
  [<c01e1394>] pci_register_driver+0x64/0x74
  [<c0254b51>] i810fb_init+0x2f/0x36
  [<c049a676>] do_initcalls+0x49/0x8e
  [<c0100269>] init+0x0/0x107
  [<c010028b>] init+0x22/0x107
  [<c0101281>] kernel_thread_helper+0x5/0xb
Code: 02 00 00 f3 ab 8d 73 08 b9 a0 00 00 00 89 f2 89 e0 89 e7 e8 5f 8a f8 ff 8b 0d 78 8e 4f c0 85 c9 74 1d ff 73 20 89 da 89 f8 6a 00 <ff> 35 54 00 00 00 ff 35 20 00 00 00 e8 37
  <0>Kernel panic - not syncing: Attempted to kill init!


A few debug printks suggest the pointer "specs" is NULL.

with CONFIG_FB_I810_I2C = y it survives boot, but does not work, i.e. on
this laptop there is no EDID and bios table seems borked/missing;
the driver also does no longer honour the commandline parameters
(xres/yres v/hsync1/2) and simply defaults to 640x480.

Built with CONFIG_I810_FB = m, it does _nothing_ when insmod'ded, not even
print the i810fb banner in dmesg; lsmod shows the module is there.

Unapplying the above mentioned patches makes it work again

Thanks,

-- 
  Manuel Lauss
