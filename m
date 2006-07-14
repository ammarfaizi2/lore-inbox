Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWGNL2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWGNL2s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 07:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWGNL2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 07:28:48 -0400
Received: from server.mrvanes.com ([81.17.40.76]:28859 "EHLO mail.mrvanes.com")
	by vger.kernel.org with ESMTP id S932402AbWGNL2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 07:28:47 -0400
From: Martin van Es <martin@mrvanes.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: Kernel 2.6.17.1 bug/oops in snd_usb_audio subsystem
Date: Fri, 14 Jul 2006 13:28:40 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200607141154.36939.martin@mrvanes.com> <20060714105421.GA6831@martell.zuzino.mipt.ru>
In-Reply-To: <20060714105421.GA6831@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607141328.40680.martin@mrvanes.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 July 2006 12:54, Alexey Dobriyan wrote:
> On Fri, Jul 14, 2006 at 11:54:36AM +0200, Martin van Es wrote:
> > I already sent this mail to perex@suse.cz a couple of days ago since I
> > thought that was the closest match in the MAINTAINERS list for this oops.
> > Since I didn't receive any reply
>
> Your kernel is tainted. Please complain to kqemu developers. Don't waste
> Jaroslav's time.

Thank you Alexey for pointing out I reported this oops while running a tainted 
kernel (kqemu was indeed tainting it). I interpreted the reply as a request 
for reproducing the oops on a untainted version of the Kernel of which I'll 
post the dmesg output below.

Hope this helps.
Is there anything else I can do to contribute?

BUG: unable to handle kernel NULL pointer dereference at virtual address 
000001b8
 printing eip:
dea9a514
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: snd_usb_audio snd_usb_lib pwc snd_rawmidi snd_hwdep 
videodev v4l2_common capability commoncap ipw2200
CPU:    0
EIP:    0060:[<dea9a514>]    Not tainted VLI
EFLAGS: 00210202   (2.6.17.1 #5)
EIP is at snd_usb_pcm_open+0x34/0x4d0 [snd_usb_audio]
eax: d681e9c0   ebx: 00000000   ecx: 0000000e   edx: 000001a8
esi: deaa8d20   edi: ca6a7e50   ebp: c8f5afc0   esp: ca6a7d9c
ds: 007b   es: 007b   ss: 0068
Process ffmpeg (pid: 4793, threadinfo=ca6a6000 task=caf275b0)
Stack: 00000020 ca6a7dd8 00000000 cedf1c00 00000010 c8f5afc0 c030f7f4 cedf1c00
       00000000 00000010 cedf1c00 000001a8 00000011 0000000b ffffffff d3eaba00
       00000000 0000000d ca6a7e50 c8f5afc0 c030fb17 d681e9c0 00000001 c8edeb00
Call Trace:
 <c030f7f4> snd_pcm_hw_constraints_init+0x704/0x790  <c030fb17> 
snd_pcm_open_substream+0x57/0xb0
 <c031df41> snd_pcm_oss_open+0x221/0x4a0  <c0163800> 
generic_permission+0x110/0x120
 <c02126c7> kobject_get+0x17/0x20  <c01185c0> default_wake_function+0x0/0x20
 <c030482d> soundcore_open+0x8d/0x1c0  <c015e826> chrdev_open+0x76/0x160
 <c015e7b0> chrdev_open+0x0/0x160  <c0153aeb> __dentry_open+0xbb/0x200
 <c0153d4c> do_filp_open+0x5c/0x70  <c01539cb> get_unused_fd+0x5b/0xc0
 <c0153db3> do_sys_open+0x53/0x100  <c0153eb7> sys_open+0x27/0x30
 <c0102f47> syscall_call+0x7/0xb
Code: 8b 48 5c 8d 14 52 fc 89 4c 24 28 89 d1 c1 e1 04 01 ca b9 0e 00 00 00 8d 
14 d5 10 00 00 00 89 54 24 2c 8b 58 08 01 da 89 54 24 2c <c7> 42 10 ff ff ff 
ff c7 42 24 00 00 00 00 8b 7c 24 28 81 c7 d0
EIP: [<dea9a514>] snd_usb_pcm_open+0x34/0x4d0 [snd_usb_audio] SS:ESP 
0068:ca6a7d9c

