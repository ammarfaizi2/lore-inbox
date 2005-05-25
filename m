Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVEYLb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVEYLb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 07:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVEYLb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 07:31:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8627 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262186AbVEYL2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 07:28:47 -0400
Date: Wed, 25 May 2005 13:28:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc4, -mm: bad ide-cs problems
Message-ID: <20050525112824.GA2892@elf.ucw.cz>
References: <20050525112745.GA1936@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050525112745.GA1936@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 25-05-05 13:27:45, Pavel Machek wrote:
> Hi!
> 
> I see some problems in pcmcia subsystem in 2.6.12-rc4:
> 
> On compaq nx5000, inserting CF ide card is recognized as anonymous
> memory. On compaq evo, it is recognized okay and
> mounts/works. Unfortunately when I unplug the card, I get an oops:
> 
> Message from syslogd@Elf at Wed May 25 13:25:25 2005 ...
> Elf kernel: Unable to handle kernel NULL pointer dereference at
> virtual address 00000010
> 
> Message from syslogd@Elf at Wed May 25 13:25:25 2005 ...
> Elf kernel:  printing eip:
> 
> Message from syslogd@Elf at Wed May 25 13:25:25 2005 ...
> Elf kernel: *pde = 00000000
> 
> Message from syslogd@Elf at Wed May 25 13:25:25 2005 ...
> Elf kernel: Oops: 0000 [#1]
> 
> . -mm kernel actually works better on nx5000; it behaves similary to
> -rc4 on evo; unfortunately it produces similar oops on card unplug.

This is full oops from -rc4 on compaq evo:

hde: cache flushes not supported
 hde: hde1
ide-cs: hde: Vcc = 3.3, Vpp = 0.0
 hde: hde1
 hde: hde1
Unable to handle kernel NULL pointer dereference at virtual address
00000010
 printing eip:
c033d618
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c033d618>]    Not tainted VLI
EFLAGS: 00010292   (2.6.12-rc4)
EIP is at ide_drive_remove+0x8/0x10
eax: c07825f8   ebx: c0782704   ecx: c07826f0   edx: 00000000
esi: c07826e0   edi: c065fed8   ebp: 00000001   esp: dfce5e84
ds: 007b   es: 007b   ss: 0068
Process pccardd (pid: 932, threadinfo=dfce4000 task=dfc84a40)
Stack: c02dc4b4 c07826e0 c065fa00 c0782568 c02dc724 c07826e0 c0782a80
c02db5e2
       c07826e0 df373a80 c02db628 c07825f8 c033bcfb c0782568 00000002
df373b80
       df373b80 c0670680 c0670728 c034f63b df758200 00000000 c034f67a
c0386108
Call Trace:
 [<c02dc4b4>] device_release_driver+0x74/0x80
 [<c02dc724>] bus_remove_device+0x64/0xa0
 [<c02db5e2>] device_del+0x52/0x90
 [<c02db628>] device_unregister+0x8/0x10
 [<c033bcfb>] ide_unregister+0x3ab/0x4a0
 [<c034f63b>] ide_release+0x5b/0x60
 [<c034f67a>] ide_event+0x3a/0xc0
 [<c0386108>] send_event_callback+0x28/0x30
 [<c02dc0e0>] __bus_for_each_dev+0x50/0x80
 [<c02dc1b8>] bus_for_each_dev+0x28/0x50
 [<c03860e0>] send_event_callback+0x0/0x30
 [<c038615f>] send_event+0x4f/0x70
 [<c03860e0>] send_event_callback+0x0/0x30
 [<c038621e>] ds_event+0x9e/0xb0
 [<c0380375>] send_event+0x95/0x120
 [<c0380418>] socket_shutdown+0x8/0x30
 [<c0380958>] socket_remove+0x8/0x70
 [<c0380a18>] socket_detect_change+0x58/0x70
 [<c0380bdb>] pccardd+0x1ab/0x200
 [<c0119810>] default_wake_function+0x0/0x10
 [<c0102fd2>] ret_from_fork+0x6/0x14
 [<c0119810>] default_wake_function+0x0/0x10
 [<c0380a30>] pccardd+0x0/0x200
 [<c010133d>] kernel_thread_helper+0x5/0x18
Code: c1 dd ff 8b 43 08 a8 08 75 07 31 c0 e9 6d ff ff ff e8 dd e7 1c
00 eb f2 e8 d6 e7 1c 00 eb a7 8d 74 26 00 2d e8 00 00 00 8b 50 1c <ff>
52 10 31 c0 c3 89 f6 55 57 89 c7 b8 01 00 00 00 56 53 83 ec

