Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbUCOQMk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 11:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbUCOQMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 11:12:40 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:4567 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262670AbUCOQMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 11:12:06 -0500
Date: Mon, 15 Mar 2004 16:10:47 +0000
From: Dave Jones <davej@redhat.com>
To: perex@suse.cz, Isaku Yamahata <yamahata@private.email.ne.jp>,
       George Hansper <ghansper@apana.org.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ALSA MIDI serial u16550 horribly broken in 2.6.4
Message-ID: <20040315161047.GA19555@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, perex@suse.cz,
	Isaku Yamahata <yamahata@private.email.ne.jp>,
	George Hansper <ghansper@apana.org.au>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

poking io port 0x1 probably isn't going to do much good.
Here's what happens after a 'modprobe snd_serial_u16550'

		Dave

u16550: can't grab port 0x1
no UART detected at 0x1
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c788b38f
*pde = 00000000
Oops: 0000 [#1]
SMP
CPU:    0
EIP:    0060:[<c788b38f>]    Not tainted
EFLAGS: 00010246   (2.6.4-prep)
EIP is at snd_info_unregister+0x5/0x60 [snd]
eax: 00000000   ebx: c1286b1c   ecx: 00000000   edx: 00000000
esi: 00000000   edi: c1286b59   ebp: c1286b40   esp: c21cef4c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 8679, threadinfo=c21ce000 task=c37a0ce0)
Stack: c1286b1c fffffff0 c1286b59 c7889c6d 00000000 c78991f6 c1286b59 c1286b40
       c78073f3 00009600 0001c200 00000000 00000000 c7807490 c1286b1c 00000000
       00000000 00000000 c031bbd8 c21ce000 c78074b4 c031bbf8 c789ac00 c0138fad
Call Trace:
 [<c7889c6d>] snd_card_free+0x163/0x1ed [snd]
 [<c78073f3>] snd_serial_probe+0x12a/0x1de [snd_serial_u16550]
 [<c7807490>] snd_serial_probe+0x1c7/0x1de [snd_serial_u16550]
 [<c78074b4>] alsa_card_serial_init+0xd/0x34 [snd_serial_u16550]
 [<c0138fad>] sys_init_module+0x14f/0x25f
 [<c02c4567>] syscall_call+0x7/0xb
 
Code: 8b 40 20 85 c0 74 05 8b 78 34 eb 06 8b 3d 2c 5f 89 c7 bb 90

