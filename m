Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266831AbUHORsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266831AbUHORsc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 13:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUHORsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 13:48:31 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:61348 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S266831AbUHORry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 13:47:54 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sun, 15 Aug 2004 13:47:49 -0400
User-Agent: KMail/1.6.82
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408150704.49312.gene.heskett@verizon.net> <20040815112617.GH12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040815112617.GH12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408151347.49987.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.53.77] at Sun, 15 Aug 2004 12:47:51 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 August 2004 07:26, viro@parcelfarce.linux.theplanet.co.uk wrote:
>On Sun, Aug 15, 2004 at 07:04:49AM -0400, Gene Heskett wrote:
>> On Sunday 15 August 2004 06:37,
>> viro@parcelfarce.linux.theplanet.co.uk
>>
>> wrote:
>> >On Sun, Aug 15, 2004 at 06:10:28AM -0400, Gene Heskett wrote:
>> >> all in one line of text, its a bit hard to locate real
>> >> duplicates. But I think I see some right now!  Can this line be
>> >> modified to spit them out, one entry per line with all dups
>> >> sorted to be adjacent?
>> >
>> >Sure, just add \n in format here.  Sorry, hadn't noticed that...
>> >
>> >> >+	seq_printf(m, "%d:%d:%lu:%o\n",
>>
>> And here it is right after starting x on the reboot. (I take it
>> the first number is the number of dups?)
>
>Yes - uniq -c merges duplicates and puts the number of copies in
> front of line, so sort | uniq -c | sort -nr will sort by frequency
> and print each line with number of times it had occured.
>
>You don't have any duplicates so far and the output looks OK...

And I still don't have any dups, but I AAARRRRGGGGGggg! do have this:

--------------
Aug 15 09:33:02 coyote kernel: Unable to handle kernel paging request at virtual address 5f746573
Aug 15 09:33:02 coyote kernel:  printing eip:
Aug 15 09:33:02 coyote kernel: 5f746573
Aug 15 09:33:02 coyote kernel: *pde = 00000000
Aug 15 09:33:02 coyote kernel: Oops: 0000 [#1]
Aug 15 09:33:02 coyote kernel: PREEMPT
Aug 15 09:33:02 coyote kernel: Modules linked in: eeprom snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_bt87x snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd forcedeth sg
Aug 15 09:33:02 coyote kernel: CPU:    0
Aug 15 09:33:02 coyote kernel: EIP:    0060:[<5f746573>]    Not tainted
Aug 15 09:33:02 coyote kernel: EFLAGS: 00210006   (2.6.8-rc4)
Aug 15 09:33:02 coyote kernel: EIP is at 0x5f746573
Aug 15 09:33:02 coyote kernel: eax: f0679a18   ebx: 20262620   ecx: 00000000   edx: 00000001
Aug 15 09:33:02 coyote kernel: esi: 63617266   edi: 00000001   ebp: ee62dcf8   esp: ee62dcd8
Aug 15 09:33:02 coyote kernel: ds: 007b   es: 007b   ss: 0068
Aug 15 09:33:02 coyote kernel: Process top (pid: 2439, threadinfo=ee62d000 task=ed68c3b0)
Aug 15 09:33:02 coyote kernel: Stack: c0113378 f0679a18 00000001 00000000 00000000 ee62d000 00000000 00200286
Aug 15 09:33:02 coyote kernel:        ee62dd20 c01133db f0678924 00000001 00000001 00000000 00000000 f0678000
Aug 15 09:33:02 coyote kernel:        ee62dea8 ee52df3e ee62de0c c01ef5fe 00000000 0000001d 00020001 ffffffff
Aug 15 09:33:02 coyote kernel: Call Trace:
Aug 15 09:33:02 coyote kernel:  [<c010476f>] show_stack+0x7f/0xa0
Aug 15 09:33:02 coyote kernel:  [<c0104908>] show_registers+0x158/0x1b0
Aug 15 09:33:02 coyote kernel:  [<c0104a89>] die+0x89/0x100
Aug 15 09:33:02 coyote kernel:  [<c0111725>] do_page_fault+0x1f5/0x553
Aug 15 09:33:02 coyote kernel:  [<c01043d9>] error_code+0x2d/0x38
Aug 15 09:33:02 coyote kernel:  [<c01133db>] __wake_up+0x3b/0x70
Aug 15 09:33:02 coyote kernel:  [<c01ef5fe>] n_tty_receive_buf+0x20e/0xf20
Aug 15 09:33:02 coyote kernel:  [<c01f1e3a>] pty_write+0x12a/0x130
Aug 15 09:33:02 coyote kernel:  [<c01eec7b>] opost_block+0xeb/0x1a0
Aug 15 09:33:02 coyote kernel:  [<c01f0efc>] write_chan+0x18c/0x220
Aug 15 09:33:02 coyote kernel:  [<c01eb9e7>] tty_write+0x1b7/0x250
Aug 15 09:33:02 coyote kernel:  [<c014b7ca>] vfs_write+0xca/0x140
Aug 15 09:33:02 coyote kernel:  [<c014b90b>] sys_write+0x4b/0x80
Aug 15 09:33:02 coyote kernel:  [<c01041dd>] sysenter_past_esp+0x52/0x71
Aug 15 09:33:02 coyote kernel: Code:  Bad EIP value.
Aug 15 09:33:02 coyote kernel:  <6>note: top[2439] exited with preempt_count 2
Aug 15 09:33:02 coyote kernel: bad: scheduling while atomic!
Aug 15 09:33:02 coyote kernel:  [<c01047ae>] dump_stack+0x1e/0x20
Aug 15 09:33:02 coyote kernel:  [<c0305578>] schedule+0x478/0x480
Aug 15 09:33:02 coyote kernel:  [<c013d209>] unmap_vmas+0x199/0x1b0
Aug 15 09:33:02 coyote kernel:  [<c0141471>] exit_mmap+0x81/0x160
Aug 15 09:33:02 coyote kernel:  [<c0114895>] mmput+0x65/0x90
Aug 15 09:33:02 coyote kernel:  [<c0118ad3>] do_exit+0x153/0x430
Aug 15 09:33:02 coyote kernel:  [<c0104af9>] die+0xf9/0x100
Aug 15 09:33:02 coyote kernel:  [<c0111725>] do_page_fault+0x1f5/0x553
Aug 15 09:33:02 coyote kernel:  [<c01043d9>] error_code+0x2d/0x38
Aug 15 09:33:02 coyote kernel:  [<c01133db>] __wake_up+0x3b/0x70
Aug 15 09:33:02 coyote kernel:  [<c01ef5fe>] n_tty_receive_buf+0x20e/0xf20
Aug 15 09:33:02 coyote kernel:  [<c01f1e3a>] pty_write+0x12a/0x130
Aug 15 09:33:02 coyote kernel:  [<c01eec7b>] opost_block+0xeb/0x1a0
Aug 15 09:33:02 coyote kernel:  [<c01f0efc>] write_chan+0x18c/0x220
Aug 15 09:33:02 coyote kernel:  [<c01eb9e7>] tty_write+0x1b7/0x250
Aug 15 09:33:02 coyote kernel:  [<c014b7ca>] vfs_write+0xca/0x140
Aug 15 09:33:02 coyote kernel:  [<c014b90b>] sys_write+0x4b/0x80
Aug 15 09:33:02 coyote kernel:  [<c01041dd>] sysenter_past_esp+0x52/0x71
-------------------

And the shell I had a "top" running in on xwindow #2 had crashed with a SIGABRT.
This was about 10 minutes after I had gone out to make some more cement blocks,
which takes around 3 hours.

I was able to restart the shell, and the top.  The system "feels" normal.

I'm going to call tcwo tomorrow and see what I can get in new hardware.
This is fscking ridiculous.  I get a cpu/cooler/fan that runs 40C
cooler than the old one and its doing nothing but crashing.  The
absolute longest uptime so far was the recent nearly 37 hours.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
