Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWAVMJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWAVMJO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 07:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWAVMJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 07:09:14 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:20171 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964774AbWAVMJN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 07:09:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nSYQJjomGFd0Hvcz8b7OBNQqlB2XVG3SGnsMAzUZG+CU7YYqWwVe9d0/xL5T3UMJnvECI5CPkCYE5QpzjkjehpPnTC4tZzGlOClbKA9r8w0QZ6PcxzhwEf5eBgJflMyGLI7DHVgCJ5b3KiM6KnXbmXG3obpVI3TTHzvjG7JxRIM=
Message-ID: <6f0f8ee70601220409t63a80180p2a1bdae057f5a7d4@mail.gmail.com>
Date: Sun, 22 Jan 2006 17:39:11 +0530
From: Deepak Madhusudan <deepak.katagade@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Problem in kernel stack size (please help me).
Cc: Suleiman Souhlal <ssouhlal@freebsd.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Al Viro <viro@ftp.linux.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Herbert Poetzl <herbert@13thfloor.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
   I am writing a serialdriver in FED 3 (2.6.9 kernel) which acts as a
serial interface between the codec and the application. We have
written an Interrupt Service Routine to handle the interrupts of the
hardware.The problem what I am facing is: by default FED3(2.6.9) comes
with the following option enabled in its kernel configuration.

Processor  type and features ------------>
[* ] 4GB kernel-space and 4GB user-space virtual memory support.

If this option is enabled my driver will  get hanged and again I have
to reboot my system.when I checked the flow of my diver it isgoing up
to ISR and when the interrupt occurs it is hanging. When I disabled
the above option and  I recompiled the kernel my driver was able to
work without any problem.


The above same driver In FED4 (2.6.11 kernel) will hang with the
following dump messages.

Unable to handle kernel paging request at virtual address 5452415d

 printing eip:

c011d0ad

*pde = 00000000

Oops: 0002 [#1]

Modules linked in: md5 ipv6 parport_pc lp parport rfcomm l2cap
bluetooth sunrpc pcmcia ipt_REJECT ipt_state ip_conntrack
iptable_filter ip_tables dm_mod i82365 rsrc_nonstatic pcmcia_core
uhci_hcd snd_cs46xx snd_rawmidi snd_ac97_codec snd_seq_oss
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss
snd_pcm snd_timer snd soundcore snd_page_alloc gameport floppy

CPU:    0

EIP:    0060:[<c011d0ad>]    Tainted: P      VLI

EFLAGS: 00210007   (2.6.11)

EIP is at scheduler_tick+0x3d/0x3e0

eax: 54524155   ebx: ccda6121   ecx: b62f5f4a   edx: 000005f3

esi: 00000000   edi: c5cd19b4   ebp: c04a1f7c   esp: c04a1f48

ds: 007b   es: 007b   ss: 0068

Process mrVia CancelPMState=%d

 (pid: 1381123423, threadinfo=c04a1000 task=ccda6121)

Stack: 00000082 c0432d80 00000031 c8e25850 00490490 00000000 00000009 00000008

       00000000 00000000 c5cd19b4 00000000 c5cd19b4 00000000 c0108e85 c046af98

       00000000 c046af98 c046af98 00000001 00200096 cb7bdfa0 c040f760 00000000

Call Trace:

 [<c0108e85>] timer_interrupt+0xa5/0x270

 [<c014d9c3>] handle_IRQ_event+0x33/0x70

 [<c014daee>] __do_IRQ+0xee/0x380

 [<c0105883>] do_IRQ+0x53/0xa0

 =======================

 [<c0103c9e>] common_interrupt+0x1a/0x20

 [<c012301c>] release_console_sem+0xac/0x280

 [<c0122d79>] vprintk+0x1b9/0x320

 [<c0122bbb>] printk+0x1b/0x20

 [<ccd6f0f7>] CodecModemOpen+0x13f/0x13c4.

If the following option is enabled in kernel configuration.

Kernel hacking:
Use 4k kernel stack instead of 8k. (CONFIG_4KSTACKS).

Since by default in FED3 and FED4 the specified options will come
enabled I cannot ask the user of my driver to disable the above option
and to recompile the kernel to use my driver.Please can you help me in
this regard. I think the problem may be with the kernel stack size.
please give me the suggestions. waiting for the reply.
Thanks in advance
deepak
