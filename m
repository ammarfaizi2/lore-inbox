Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUF0JES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUF0JES (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 05:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUF0JES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 05:04:18 -0400
Received: from main.gmane.org ([80.91.224.249]:25537 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261422AbUF0JEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 05:04:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: 2.6.7-mm3
Date: Sun, 27 Jun 2004 02:04:10 -0700
Message-ID: <pan.2004.06.27.09.04.08.841686@triplehelix.org>
References: <20040626233105.0c1375b2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-234-108.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

thought I'd give this one a spin before I turned in.

On Sat, 26 Jun 2004 23:31:05 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm3/
> 
> 
> - Added Adam's PNP bk tree to the "external bk trees"
> 
> - random fixes and updates all over the place

A few issues.

1. NFS goes boom

mount -a -t nfs happens in my bootscripts, and results in

nfs warning: mount version older than kernel
net/sunrpc/rpc_pipe.c: rpc_lookup_parent failed to find path /nfs/clnt0
RPC: Couldn't create pipefs entry /nfs/clnt0, error -2
NFS: cannot create RPC client.
general protection fault: 0000 [#1]
PREEMPT
Modules linked in: snd_intel8x0 analog evdev usblp joydev ehci_hcd ohci_hcd orinoco_usb orinoco hermes forcedeth snd_au8830 snd_ac97_codec gameport snd_mpu401_uart snd_rawmidi snd_seq_device
CPU:    0
EIP:    0060:[<c0180e45>]    Not tainted VLI
EFLAGS: 00010246   (2.6.7-mm3)
EIP is at nfs_fill_super+0x2e5/0x350
eax: fffffffe   ebx: df045000   ecx: c1594200   edx: dffdd480
esi: 00000001   edi: df980627   ebp: df603ec0   esp: df603ea4
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 2322, threadinfo=df602000 task=df653270)
Stack: c1594400 fffffffb dffdd480 c1594400 c1594400 00000060 dffdd562 df603ee8
       c0182a8c dffdd480 c0376f71 dffdd480 00000001 c03c4900 dffbd9e0 fffffff4
       c03c4900 df603f08 c014f7b9 df045000 df046000 00000001 dfb32000 df602000
Call Trace:
 [<c01053ca>] show_stack+0x7a/0x90
 [<c010554d>] show_registers+0x14d/0x1b0
 [<c01056dd>] die+0x8d/0x100
 [<c0105039>] error_code+0x2d/0x38
 [<c0182a8c>] nfs_get_sb+0x19c/0x230
 [<c014f7b9>] do_kern_mount+0x49/0xc0
 [<c01638b2>] do_add_mount+0x72/0x180
 [<c0163b98>] do_mount+0x128/0x160
 [<c0163f4e>] sys_mount+0x8e/0x100
 [<c0104e8f>] syscall_call+0x7/0xb
Code: c0 75 05 8b 45 e8 eb ae e8 49 54 fb ff eb f4 e8 22 de 1c 00 eb e3 e8 1b de 1c 00 eb d2 c7 04 24 20 ab 37 c0 e8 cd 62 f9 ff eb bb <ff> 00 8b 55 ec 8b 02 89 42 04 e9 2c ff ff ff c7 04 24 40 ab 37

config and full dmesg at
http://triplehelix.org/~joshk/2.6.7-mm3/

2. Cannot 'halt' or 'reboot' the system

Dunno why. Could be because the oops kind of screwed things up.

3. Noted this in the dmesg:

serial: guess board returned false
serial: guess board returned false

I suppose this is just some old debugging code.

4. New joystick?

input: Analog 4-axis 4-button joystick at <NULL> [ADC port]

I only have one gamepad on my system, and that's

input: USB HID v1.10 Joystick [Logitech Logitech Dual Action] on usb-0000:00:02.1-2

On a more positive note radeonfb hardware acceleration seems to work fine,
so that's really cool.

Good stuff!

-- 
Joshua Kwan


