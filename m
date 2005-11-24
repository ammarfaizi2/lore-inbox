Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbVKXA4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbVKXA4Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 19:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbVKXA4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 19:56:25 -0500
Received: from gate.crashing.org ([63.228.1.57]:29669 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932607AbVKXA4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 19:56:24 -0500
Subject: Re: Console rotation problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: adaplas@gmail.com
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1132793150.26560.357.camel@gaston>
References: <1132793150.26560.357.camel@gaston>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 11:52:36 +1100
Message-Id: <1132793556.26560.361.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-24 at 11:45 +1100, Benjamin Herrenschmidt wrote:
> Hi Antonio !
> 
> I decided to give a quick test to console rotation on my g5 (radeonfb)
> and couldn't get it to work.
> 
> When I tried echo'ing something in con_rotate, something very strange
> happened:
> 
> pogo:/sys/class/graphics/fb0# echo "1" >con_rotate
> benh@pogo:~$

  .../...

And here is the Oops that explains the shell exit and that I didn't see
the first time :)

Trap 0x600 is an alignment exception, which is a bit weird, I'll try to
dig a bit more, it could be a problem with the alignment trap handler on
ppc.

Ben.

REGS: c00000000f7c3150 TRAP: 0600   Not tainted  (2.6.15-rc2)
MSR: 9000000000009032 <EE,ME,IR,DR>  CR: 44242488  XER: 00000000
DAR: C00000007E56B002, DSISR: 0000000002200000
TASK = c00000000f5a4040[2505] 'bash' THREAD: c00000000f7c0000 CPU: 1
GPR00: 0000000000000010 C00000000F7C33D0 C0000000006952D8 0000000000000058
GPR04: 0000000000000004 0000000000000010 0000000000000001 0000000000000000
GPR08: 0000000000000004 C00000007E56B002 C00000007E56B002 000000000000003F
GPR12: 0000000000000001 C00000000057D800 00000000100D0000 00000000100D2B38
GPR16: 00000000100D0000 00000000100A0000 0000000000000000 0000000000000000
GPR20: 0000000000000010 0000000000000010 C00000000074E600 0000000000000000
GPR24: 0000000000000010 00000000000000FF 0000000000000008 000000000000000B
GPR28: 0000000000000008 C00000000046B7F0 C0000000005F7D30 C00000007E56B000
NIP [C00000000025BAB8] .fbcon_rotate_font+0x500/0x54c
LR [C00000000025B7C4] .fbcon_rotate_font+0x20c/0x54c
Call Trace:
[C00000000F7C33D0] [C00000000025B7A8] .fbcon_rotate_font+0x1f0/0x54c (unreliable)[C00000000F7C34B0] [C000000000259654] .fbcon_switch+0x6a0/0x780
[C00000000F7C3630] [C00000000029ACF8] .redraw_screen+0x1c8/0x264
[C00000000F7C36C0] [C00000000029B5E0] .vc_resize+0x46c/0x474
[C00000000F7C37B0] [C000000000255E94] .fbcon_modechanged+0x16c/0x484
[C00000000F7C3890] [C000000000259930] .fbcon_event_notify+0x1fc/0x564
[C00000000F7C39F0] [C0000000000574FC] .notifier_call_chain+0x64/0x98
[C00000000F7C3A80] [C0000000002623F0] .fb_con_duit+0x2c/0x44
[C00000000F7C3B10] [C0000000002659EC] .store_con_rotate+0x5c/0x88
[C00000000F7C3BC0] [C0000000002A8004] .class_device_attr_store+0x60/0x7c
[C00000000F7C3C40] [C0000000000F01B0] .sysfs_write_file+0xf8/0x1a0
[C00000000F7C3CF0] [C00000000009EEFC] .vfs_write+0x1c0/0x1fc
[C00000000F7C3D90] [C00000000009F014] .sys_write+0x4c/0x90
[C00000000F7C3E30] [C000000000008600] syscall_exit+0x0/0x18
Instruction dump:
7d093670 7d290194 7d5f5214 7d6b0436 7d2707b4 55293032 796007e1 7d094050
78e71f24 4182001c 7d804036 7d275214 <7d6048a8> 7d6b0378 7d6049ad 40c2fff4


