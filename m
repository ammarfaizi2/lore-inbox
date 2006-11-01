Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946671AbWKAHnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946671AbWKAHnP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 02:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946674AbWKAHnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 02:43:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:52611 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1946671AbWKAHnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 02:43:14 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <gregkh@suse.de>, "Martin J. Bligh" <mbligh@google.com>,
       Cornelia Huck <cornelia.huck@de.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
In-Reply-To: <1162361529.5899.1.camel@Homer.simpson.net>
References: <45461977.3020201@shadowen.org> <45461E74.1040408@google.com>
	 <20061030084722.ea834a08.akpm@osdl.org> <454631C1.5010003@google.com>
	 <45463481.80601@shadowen.org>
	 <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com>
	 <1162276206.5959.9.camel@Homer.simpson.net> <4546EF3B.1090503@google.com>
	 <20061031065912.GA13465@suse.de>
	 <1162278594.6416.4.camel@Homer.simpson.net> <20061031072241.GB7306@suse.de>
	 <1162312126.5918.12.camel@Homer.simpson.net>
	 <1162318477.6016.3.camel@Homer.simpson.net>
	 <1162356198.6105.18.camel@Homer.simpson.net>
	 <20061031212508.1b116655.akpm@osdl.org>
	 <1162361529.5899.1.camel@Homer.simpson.net>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 08:43:01 +0100
Message-Id: <1162366981.6107.12.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 07:12 +0100, Mike Galbraith wrote:
> On Tue, 2006-10-31 at 21:25 -0800, Andrew Morton wrote:
> > On Wed, 01 Nov 2006 05:43:18 +0100
> > Mike Galbraith <efault@gmx.de> wrote:
> > 
> > > On Tue, 2006-10-31 at 19:14 +0100, Mike Galbraith wrote:
> > > 
> > > > Seems it's driver-core-fixes-sysfs_create_link-retval-checks-in.patch
> > > > 
> > > > Tomorrow, I'll revert that alone from 2.6.19-rc3-mm1 to confirm...
> > > 
> > > Confirmed.  Boots fine with that patch reverted.
> > 
> > Could you test with something like this applied?
> 
> No output.  I had already enabled debugging, but got nada there either.
> Bugger.  <scritch scritch>

FIWI, the explosion is related to the fact that I have two graphics
cards configured in.  One is on-board (Intel 865 Chipset), and the other
is an ATI X850 AGP (which I use, the other is there in case of failure).

If I disable all of the Intel 865 options, the box gets much further.
It then oopses while initializing sound, and eventually hangs.  I poked
SysRq-T while it was hung, and was looking at the serial console output
when it took off again.  It stalled again, and eventually, I gave up on
it.  The complete log up through me poking SysRq-T is available for the
asking if anyone is interested.

The oops is below, but is probably irrelevant for this thread.

BUG: unable to handle kernel NULL pointer dereference at virtual address 0000010b
 printing eip:
f8818377
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP 
last sysfs file: /class/input/input1/name
Modules linked in: snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore
CPU:    0
EIP:    0060:[<f8818377>]    Not tainted VLI
EFLAGS: 00010282   (2.6.19-rc3-mm1-smp #21)
EIP is at snd_register_device_for_dev+0xff/0x116 [snd]
eax: ffffffef   ebx: f79a2fa0   ecx: dffff4c0   edx: f7873e00
esi: 00000028   edi: 00000008   ebp: f7e4bd0c   esp: f7e4bce4
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2712, ti=f7e4a000 task=dfdb0a90 task.ti=f7e4a000)
Stack: f7c1a3c0 00000000 07400028 f881d69d f7e4bd24 00000000 f786e000 fffffff4 
       f7873e00 f7873e04 f7e4bd40 f882d951 f8832180 f7873e00 f7e4bd24 00000000 
       6964696d 30443143 ffffff00 f7c1a3c0 f79a2fe0 f786e140 00000000 f7e4bd50 
Call Trace:
 [<f882d951>] snd_rawmidi_dev_register+0xaa/0x322 [snd_rawmidi]
 [<f881c9a8>] snd_device_register_all+0x30/0x4f [snd]
 [<f8818bbe>] snd_card_register+0x55/0x311 [snd]
 [<f88582d6>] snd_mpu401_pnp_probe+0x13a/0x1d3 [snd_mpu401]
 [<c03316c7>] pnp_device_probe+0x47/0xa0
 [<c036327b>] driver_probe_device+0xb6/0x18f
 [<c036345c>] __driver_attach+0x84/0x86
 [<c0362b83>] bus_for_each_dev+0x44/0x62
 [<c0363097>] driver_attach+0x19/0x1b
 [<c0362689>] bus_add_driver+0x85/0x1a8
 [<c03636a9>] driver_register+0x54/0x84
 [<c03314d1>] pnp_register_driver+0x17/0x19
 [<f885c081>] alsa_card_mpu401_init+0x81/0xcd [snd_mpu401]
 [<c0141f27>] sys_init_module+0x12f/0x1c9c
 [<c010317c>] syscall_call+0x7/0xb
 [<b7f01f5e>] 0xb7f01f5e
 =======================
Code: a0 52 82 f8 c1 e0 14 09 f0 89 44 24 08 8b 45 14 89 44 24 04 a1 80 b4 83 f8 89 04 24 e8 36 96 b4 c7 89 43 14 85 c0 74 09 8b 55 0c <89> 90 1c 01 00 00 b8 2c 53 82 f8 e8 48 30 cd c7 31 f6 e9 62 ff 
EIP: [<f8818377>] snd_register_device_for_dev+0xff/0x116 [snd] SS:ESP 0068:f7e4bce4

(gdb) list *snd_register_device_for_dev+0xff
0x377 is in snd_register_device_for_dev (include/linux/device.h:405).
400     }
401
402     static inline void
403     dev_set_drvdata (struct device *dev, void *data)
404     {
405             dev->driver_data = data;
406     }
407
408     static inline int device_is_registered(struct device *dev)
409     {

