Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbTAEXAJ>; Sun, 5 Jan 2003 18:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbTAEXAJ>; Sun, 5 Jan 2003 18:00:09 -0500
Received: from [193.126.32.23] ([193.126.32.23]:14556 "EHLO
	mail.paradigma.co.pt") by vger.kernel.org with ESMTP
	id <S265368AbTAEXAI>; Sun, 5 Jan 2003 18:00:08 -0500
Date: Sun, 5 Jan 2003 23:07:52 +0000
From: Nuno Monteiro <nuno@itsari.org>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: updated CDROMREADAUDIO DMA patch
Message-ID: <20030105230752.GA936@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[First of all, excuse me for breaking the thread, I had already deleted 
your original mail when I ran into this. Sorry for the inconvenience :)]

On January 4th 2003 Andrew Morton wrote:
> A refresh and retest of this patch, against 2.4.21-pre2.  It would
> be helpful if a few (or a lot of) people could test this, and report
> on the result.   Otherwise it'll never get anywhere...

Ok, I tested it earlier on today and I ran into an oops & kernel panic. I 
can read audio cd's just fine (using xmms, gtcd, whatever) for hours, but 
whenever I try to rip anything using cdparanoia, it goes down south.

This is 2.4.21-pre2aa2 with some reiserfs fixes Hans posted on lkml a 
while ago, mind you, and not vanilla 2.4.21-pre2. The patch applied 
cleanly, though -- not even with offset. Its a run-of-the-mill 48x cdrom 
(dont even know the brand), connected as slave on the primary IDE 
channel, which is a PIIX4. Let me know if you need any other info!

So, here it is, your moment of zen ;)


Unable to handle kernel NULL pointer dereference at virtual address 
00000014
c0190b2d
*pde = 00000000
Oops: 0000 2.4.21-pre2aa2 #1 Sun Jan 5 20:53:19 WET 2003
CPU:    0
EIP:    0010:[<c0190b2d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000004   ebx: 00000000   ecx: 0000f000   edx: c0293500
esi: c29457a4   edi: c2945800   ebp: 00000004   esp: c0229ec4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0229000)
Stack: c2945800 c02936f8 00000002 00000001 c2a4850c c2945800 00000001 
c02936f8        c2945800 00000001 c02936f8 c02936f8 c2a488a4 c02936f8 
00000001 c29458b8        00000930 00000001 c2a4981e c02936f8 00000001 
c02936f8 c11f7160 00000286 Call Trace:    [<c2a4850c>] [<c2a488a4>] 
[<c2a4981e>] [<c0119ef8>] [<c019cbbf>]
   [<c2a496f0>] [<c010843e>] [<c01085ae>] [<c0105220>] [<c010a7a8>] 
[<c0105220>]
   [<c0105243>] [<c0105287>] [<c0105000>] [<c0105019>]
Code: 8b 43 14 85 c0 7d 0c 0f 0b 54 01 20 b7 1f c0 8d 74 26 00 8b 

>> EIP; c0190b2d <end_that_request_first+91/11c>   <=====

>> edx; c0293500 <ide_hwifs+0/2be8>
>> esi; c29457a4 <[sb].data.end+53c1b1/63ea6d>
>> edi; c2945800 <[sb].data.end+53c20d/63ea6d>
>> esp; c0229ec4 <init_task_union+1ec4/2000>

Trace; c2a4850c <[ide-cd]ide_cdrom_end_request+58/a8>
Trace; c2a488a4 <[ide-cd]cdrom_end_request+58/60>
Trace; c2a4981e <[ide-cd]cdrom_pc_intr+12e/24c>
Trace; c0119ef8 <timer_bh+24/394>
Trace; c019cbbf <ide_intr+c3/110>
Trace; c2a496f0 <[ide-cd]cdrom_pc_intr+0/24c>
Trace; c010843e <handle_IRQ_event+32/5c>
Trace; c01085ae <do_IRQ+72/b4>
Trace; c0105220 <default_idle+0/28>
Trace; c010a7a8 <call_do_IRQ+5/d>
Trace; c0105220 <default_idle+0/28>
Trace; c0105243 <default_idle+23/28>
Trace; c0105287 <cpu_idle+1f/34>
Trace; c0105000 <_stext+0/0>
Trace; c0105019 <rest_init+19/1c>

Code;  c0190b2d <end_that_request_first+91/11c>
00000000 <_EIP>:
Code;  c0190b2d <end_that_request_first+91/11c>   <=====
    0:   8b 43 14                  mov    0x14(%ebx),%eax   <=====
Code;  c0190b30 <end_that_request_first+94/11c>
    3:   85 c0                     test   %eax,%eax
Code;  c0190b32 <end_that_request_first+96/11c>
    5:   7d 0c                     jge    13 <_EIP+0x13>
Code;  c0190b34 <end_that_request_first+98/11c>
    7:   0f 0b                     ud2a   Code;  c0190b36 
<end_that_request_first+9a/11c>
    9:   54                        push   %esp
Code;  c0190b37 <end_that_request_first+9b/11c>
    a:   01 20                     add    %esp,(%eax)
Code;  c0190b39 <end_that_request_first+9d/11c>
    c:   b7 1f                     mov    $0x1f,%bh
Code;  c0190b3b <end_that_request_first+9f/11c>
    e:   c0 8d 74 26 00 8b 00      rorb   $0x0,0x8b002674(%ebp)

  Kernel panic: Aiee, killing interrupt handler!




--
		Nuno

