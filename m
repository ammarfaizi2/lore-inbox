Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131499AbRAVKgy>; Mon, 22 Jan 2001 05:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131693AbRAVKgf>; Mon, 22 Jan 2001 05:36:35 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:32964 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131499AbRAVKg0>; Mon, 22 Jan 2001 05:36:26 -0500
Message-ID: <3A6C0EEE.3E5BB5A1@uow.edu.au>
Date: Mon, 22 Jan 2001 21:43:58 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: jeffml@pobox.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1pre9 Oops (was Re: 2.4.1pre8 Oops)
In-Reply-To: <01012111414100.15973@earth>,
		<01012111414100.15973@earth> <01012115521800.18005@earth>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another NMI oops?

You've deadlocked over my old friend console_lock.  I can't
see _why_ though.   Was this with the same setup, using the
serial console?  If so then probably the other CPU was 
stuck in the serial console driver, holding console_lock.


Jeff Lightfoot wrote:
> 
> On Sunday 21 January 2001 11:41, I wrote:
> > Nothing special with this box.  SMP no modules, Squid proxy and
> > running VNC/Pan at the time.  Using kernel version of reiserfs on
> > filesystems other than root.
> 
> I also failed to mention that I use devfs.
> 
> [Oops snipped]
> 
> Upgraded to 2.4.1pre9 and got the following Oops:
> 
> EIP:    0010:[<c022b533>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00000086
> eax: 00000001   ebx: 00000001   ecx: 00000001   edx: c0238440
> esi: c02d7068   edi: 00000020   ebp: 0000000d   esp: c7a63ed0
> ds: 0018   es: 0018   ss: 0018
> Process pan (pid: 2318, stackpage=c7a63000)
> Stack: 00000001 c02d7068 00000020 0000000d 00000082 00000001 c02da381
> 0000001e
>        c01125bf c0238440 00000001 00000001 00000001 00000001 c0233d6d
> 00000001
>        00000020 c02f502c c02d7068 00000020 0000000d ffffe000 c1460018
> c0100018
> Call Trace: [<c01125bf>] [<c0100018>] [<c01ed565>] [<c011916c>]
> [<c010a8c5>] [<c0109014>] [<ffff0018>]
>        [<c0130018>] [<c0130e19>] [<c0108f53>] [<c010002b>]
> Code: 80 3d c0 6d 28 c0 00 f3 90 7e f5 e9 d6 b7 ee ff 80 3d c0 6d
> 
> >>EIP; c022b533 <stext_lock+787/662d>   <=====
> Trace; c01125bf <smp_error_interrupt+43/48>
> Trace; c0100018 <startup_32+18/cb>
> Trace; c01ed565 <net_tx_action+5/118>
> Trace; c011916c <do_softirq+5c/8c>
> Trace; c010a8c5 <do_IRQ+e5/f4>
> Trace; c0109014 <ret_from_intr+0/20>
> Trace; ffff0018 <END_OF_CODE+3fcd7e44/????>
> Trace; c0130018 <sys_fchdir+c/11c>
> Trace; c0130e19 <sys_read+a1/c4>
> Trace; c0108f53 <system_call+33/38>
> Trace; c010002b <startup_32+2b/cb>
> Code;  c022b533 <stext_lock+787/662d>
> 00000000 <_EIP>:
> Code;  c022b533 <stext_lock+787/662d>   <=====
>    0:   80 3d c0 6d 28 c0 00      cmpb   $0x0,0xc0286dc0   <=====
> Code;  c022b53a <stext_lock+78e/662d>
>    7:   f3 90                     repz nop
> Code;  c022b53c <stext_lock+790/662d>
>    9:   7e f5                     jle    0 <_EIP>
> Code;  c022b53e <stext_lock+792/662d>
>    b:   e9 d6 b7 ee ff            jmp    ffeeb7e6 <_EIP+0xffeeb7e6>
> c0116d19 <printk+11/17c>
> Code;  c022b543 <stext_lock+797/662d>
>   10:   80 3d c0 6d 00 00 00      cmpb   $0x0,0x6dc0
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
