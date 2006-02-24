Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWBXXqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWBXXqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 18:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWBXXqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 18:46:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12523 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964802AbWBXXqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 18:46:16 -0500
Date: Sat, 25 Feb 2006 00:45:26 +0100
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: My machine is cursed: no sound. Help! [was Re: es1371 sound problems]
Message-ID: <20060224234526.GA1766@elf.ucw.cz>
References: <20060223205309.GA2045@elf.ucw.cz> <s5h1wxtdmri.wl%tiwai@suse.de> <20060224161631.GB1925@elf.ucw.cz> <20060224234050.GA1644@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224234050.GA1644@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 25-02-06 00:40:50, Pavel Machek wrote:
> Hi!
> 
> > > I've seen similar messages in some reports but haven't figured out the
> > > cause yet.
> > > 
> > > To be sure, could you check the patch below, making the wait time in
> > > codec acceessor longer?
> > > Also, try to build ens1371 driver as a module.
> > 
> > Tried that... only msleep() hunks did apply, but that should be only
> > more conservative, AFAICT. It took looong time to boot (my fault,
> > should have used 50, not 0xa000 or how much is that), but same result
> > as before. I tried loading it as a module, but same problem :-(.
> 
> I guess my machine is cursed. emu10k does not work -- produces no
> sound. ens1371 does not work -- is not initialized. usb sound card --
> produces no sound.
> 
> Now, I tried to break the curse by connecting usb sound card to
> another machine... but guess what, still no sound. Connected to second
> machine:
> 
> root@amd:~# cat /proc/asound/cards
>  0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
>                       Intel 82801DB-ICH4 with AD1981B at 0xc0000c00, irq 5
>  1 [U0x4fa0x4201   ]: USB-Audio - USB Device 0x4fa:0x4201
>                       USB Device 0x4fa:0x4201 at usb-0000:00:1d.1-2, full speed
> root@amd:~#
> 
> (usb soundcard clicks when I launch mpg123, but that's it.)

Heh, and I guess I have an added bonus. When I unplugged usb soundcard
while mpg123 was running....

[2:49] Decoding of hymna_tmou.mp3 finished.
Unable to handle kernel paging request at virtual address 6b6b6c6b
 printing eip:
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c016c335>]    Not tainted VLI
EFLAGS: 00010246   (2.6.16-rc4-g32e117c5-dirty #222)
EIP is at __fput+0xc5/0x190
eax: 6b6b6c6b   ebx: 6b6b6b6b   ecx: 00000001   edx: f726a000
esi: f722c440   edi: f704ee10   ebp: f727036c   esp: f726bf8c
ds: 007b   es: 007b   ss: 0068
Process mpg123 (pid: 1685, threadinfo=f726a000 task=f707a540)
Stack: <0>00000000 c1cf2be0 f722c440 00000000 f7c036cc f726a000 c01693a7 00000003
       00000003 08056c28 ffffffff c0103139 00000003 00000000 b7f60ff4 08056c28
       ffffffff bfbd1f70 00000006 0000007b c010007b 00000006 b7eef707 00000073
Call Trace:
 [<c01693a7>] filp_close+0x47/0x90
 [<c0103139>] syscall_call+0x7/0xb
Code: 85 a9 00 00 00 8b 46 10 85 c0 74 42 8b 18 85 db 74 3c b8 01 00 00 00 e8 1a 3a fb ff e8 a5 e0 0f
00 c1 e0 07 8d 84 18 00 01 00 00 <ff> 08 83 3b 02 0f 84 a5 00 00 00 b8 01 00 00 00 e8 36 3a fb ff
 <6>note: mpg123[1685] exited with preempt_count 1
Segmentation fault
pavel@amd:~/incoming$

Should I get covox-soundcard-on-paralel-port to break the curse or what?

								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
