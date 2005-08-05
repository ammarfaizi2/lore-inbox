Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263070AbVHEToI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263070AbVHEToI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVHETmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:42:08 -0400
Received: from spirit.analogic.com ([208.224.221.4]:2568 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S263085AbVHETlI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 15:41:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050805192628.GA24706@minerva.local.lan>
References: <20050805192628.GA24706@minerva.local.lan>
X-OriginalArrivalTime: 05 Aug 2005 19:41:05.0813 (UTC) FILETIME=[9EAD6C50:01C599F5]
Content-class: urn:content-classes:message
Subject: Re: local DDOS? Kernel panic when accessing /proc/ioports
Date: Fri, 5 Aug 2005 15:40:26 -0400
Message-ID: <Pine.LNX.4.61.0508051538390.6245@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: local DDOS? Kernel panic when accessing /proc/ioports
thread-index: AcWZ9aAA+ZCHBAo7RiGBkpxUYaJpvw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Martin Loschwitz" <madkiss@madkiss.org>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Aug 2005, Martin Loschwitz wrote:

> Hi folks,
>
> I just ran into the following problem: Having updated my box to 2.6.12.3,
> I tried to start YaST2 and noticed a kernel panic (see below). Some quick
> debugging brought the result that the kernel crashes while some user (not
> even root ...) tries to access /proc/ioports. Is this a known problem and
> if so, is a fix available?
>
> Ooops and ksymoops-output is attached.
>

This can happen if a module is unloaded that doesn't free its
resources! Been there, done that.

> =============
> Oops
> =============
>
> Unable to handle kernel paging request at virtual address e081e6a8
> printing eip:
> c01d16b2
> *pde = 1ff5b067
> *pte = 00000000
> Oops: 0000 [#1]
> Modules linked in: snd_mixer_oss snd radeon drm dm_mod autofs4 af_packet ext3 jbd i810_audio ac97_codec soundcore b44 mii intel_agp agpgart i2c_i801 i2c_core ipw2200 firmware_class ieee80211 ieee80211_crypt parport_pc parport 8250 serial_core usbhid ohci_hcd uhci_hcd pcmcia yenta_socket rsrc_nonstatic pcmcia_core video thermal processor fan container button battery ac genrtc unionfs loop sbp2 ohci1394 ieee1394 usb_storage ub ehci_hcd usbcore
> CPU:    0
> EIP:    0060:[<c01d16b2>]    Not tainted VLI
> EFLAGS: 00210297   (2.6.12.3)
> EIP is at vsnprintf+0x332/0x4d0
> eax: e081e6a8   ebx: 0000000a   ecx: e081e6a8   edx: fffffffe
> esi: c71760e9   edi: 00000000   ebp: c7176fff   esp: c457deb4
> ds: 007b   es: 007b   ss: 0068
> Process cat (pid: 3275, threadinfo=c457c000 task=c5052020)
> Stack: c71760e2 c7176fff 00000323 00000000 00000010 00000004 00000002 00000001
>       ffffffff ffffffff c4f7d640 c031f3ad c4f7d640 000000dd c01789c7 c71760dd
>       00000f23 c03265ef c457df2c c03265dd c011e934 c4f7d640 c03265dd 00000000
> Call Trace:
> [<c01789c7>] seq_printf+0x37/0x60
> [<c011e934>] r_show+0x84/0x90
> [<c01784c6>] seq_read+0x1d6/0x2d0
> [<c0158b85>] vfs_read+0xe5/0x160
> [<c0158ea1>] sys_read+0x51/0x80
> [<c0102f79>] syscall_call+0x7/0xb
> Code: 00 83 cf 01 89 44 24 24 eb bb 8b 44 24 48 8b 54 24 20 83 44 24 48 04 8b 08 b8 ec 2b 33 c0 81 f9 ff 0f 00 00 0f 46 c8 89 c8 eb 06 <80> 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75 20
>
> =============
> Ksymoops
> =============
>
>>> EIP; c01d16b2 <vsnprintf+332/4d0>   <=====
>
>>> eax; e081e6a8 <pg0+203236a8/3fb03400>
>>> ecx; e081e6a8 <pg0+203236a8/3fb03400>
>>> edx; fffffffe <__kernel_rt_sigreturn+1bbe/????>
>>> esi; c71760e9 <pg0+6c7b0e9/3fb03400>
>>> ebp; c7176fff <pg0+6c7bfff/3fb03400>
>>> esp; c457deb4 <pg0+4082eb4/3fb03400>
>
> Trace; c01789c7 <seq_printf+37/60>
> Trace; c011e934 <r_show+84/90>
> Trace; c01784c6 <seq_read+1d6/2d0>
> Trace; c0158b85 <vfs_read+e5/160>
> Trace; c0158ea1 <sys_read+51/80>
> Trace; c0102f79 <syscall_call+7/b>
>
> This architecture has variable length instructions, decoding before eip
> is unreliable, take these instructions with a pinch of salt.
>
> Code;  c01d1687 <vsnprintf+307/4d0>
> 00000000 <_EIP>:
> Code;  c01d1687 <vsnprintf+307/4d0>
>   0:   00 83 cf 01 89 44         add    %al,0x448901cf(%ebx)
> Code;  c01d168d <vsnprintf+30d/4d0>
>   6:   24 24                     and    $0x24,%al
> Code;  c01d168f <vsnprintf+30f/4d0>
>   8:   eb bb                     jmp    ffffffc5 <_EIP+0xffffffc5>
> Code;  c01d1691 <vsnprintf+311/4d0>
>   a:   8b 44 24 48               mov    0x48(%esp),%eax
> Code;  c01d1695 <vsnprintf+315/4d0>
>   e:   8b 54 24 20               mov    0x20(%esp),%edx
> Code;  c01d1699 <vsnprintf+319/4d0>
>  12:   83 44 24 48 04            addl   $0x4,0x48(%esp)
> Code;  c01d169e <vsnprintf+31e/4d0>
>  17:   8b 08                     mov    (%eax),%ecx
> Code;  c01d16a0 <vsnprintf+320/4d0>
>  19:   b8 ec 2b 33 c0            mov    $0xc0332bec,%eax
> Code;  c01d16a5 <vsnprintf+325/4d0>
>  1e:   81 f9 ff 0f 00 00         cmp    $0xfff,%ecx
> Code;  c01d16ab <vsnprintf+32b/4d0>
>  24:   0f 46 c8                  cmovbe %eax,%ecx
> Code;  c01d16ae <vsnprintf+32e/4d0>
>  27:   89 c8                     mov    %ecx,%eax
> Code;  c01d16b0 <vsnprintf+330/4d0>
>  29:   eb 06                     jmp    31 <_EIP+0x31>
>
> This decode from eip onwards should be reliable
>
> Code;  c01d16b2 <vsnprintf+332/4d0>
> 00000000 <_EIP>:
> Code;  c01d16b2 <vsnprintf+332/4d0>   <=====
>   0:   80 38 00                  cmpb   $0x0,(%eax)   <=====
> Code;  c01d16b5 <vsnprintf+335/4d0>
>   3:   74 07                     je     c <_EIP+0xc>
> Code;  c01d16b7 <vsnprintf+337/4d0>
>   5:   40                        inc    %eax
> Code;  c01d16b8 <vsnprintf+338/4d0>
>   6:   4a                        dec    %edx
> Code;  c01d16b9 <vsnprintf+339/4d0>
>   7:   83 fa ff                  cmp    $0xffffffff,%edx
> Code;  c01d16bc <vsnprintf+33c/4d0>
>   a:   75 f4                     jne    0 <_EIP>
> Code;  c01d16be <vsnprintf+33e/4d0>
>   c:   29 c8                     sub    %ecx,%eax
> Code;  c01d16c0 <vsnprintf+340/4d0>
>   e:   83 e7 10                  and    $0x10,%edi
> Code;  c01d16c3 <vsnprintf+343/4d0>
>  11:   89 c3                     mov    %eax,%ebx
> Code;  c01d16c5 <vsnprintf+345/4d0>
>  13:   75 20                     jne    35 <_EIP+0x35>
>
> --
>  .''`.   Martin Loschwitz           Debian GNU/Linux developer
> : :'  :  madkiss@madkiss.org        madkiss@debian.org
> `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
>   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
