Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269454AbRHLWAL>; Sun, 12 Aug 2001 18:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269455AbRHLWAB>; Sun, 12 Aug 2001 18:00:01 -0400
Received: from leng.mclure.org ([64.81.48.142]:51726 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S269454AbRHLV7m>; Sun, 12 Aug 2001 17:59:42 -0400
Date: Sun, 12 Aug 2001 14:59:53 -0700
From: Manuel McLure <manuel@mclure.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
Message-ID: <20010812145953.A955@ulthar.internal.mclure.org>
In-Reply-To: <20010812113142.G948@ulthar.internal.mclure.org> <E15W1eR-000691-00@the-village.bc.nu> <20010812133539.A17802@ulthar.internal.mclure.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010812133539.A17802@ulthar.internal.mclure.org>; from manuel@mclure.org on Sun, Aug 12, 2001 at 13:35:39 -0700
X-Mailer: Balsa 1.2.pre1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.08.12 13:35 Manuel McLure wrote:
> 
> On 2001.08.12 13:15 Alan Cox wrote:
> > Yep. So far the new driver that Linus took from a non maintaier breaks
> > 
> > 	SMP
> > 	Some mixers
> > 	Uniprocessor with some cards
> > 	Surround sound (spews noise on cards)
> > 
> > so I think Linus should do the only sane thing - back it out. I'm
> backing
> > it out of -ac. Of my three boxes, one spews noise, one locks up smp and
> > one works.
> 
> Does the CVS driver work? If it does I can try that one instead of the
> in-kernel one.

I've answered that one on my own - I installed today's CVS emu10k1 and got
another Oops:

ksymoops 2.4.0 on i686 2.4.6.  Options used
     -v /usr/src/linux-2.4.8/vmlinux (specified)
     -k ksyms.2.4.8 (specified)
     -l lsmod.2.4.8 (specified)
     -o /lib/modules/2.4.8 (specified)
     -m /usr/src/linux-2.4.8/System.map (specified)

Warning (compare_maps): mismatch on symbol tulip_max_interrupt_work  ,
tulip says d190236c, /lib/modules/2.4.8/kernel/drivers/net/tulip/tulip.o
says d190192c.  Ignoring /lib/modules/2.4.8/kernel/drivers/net/tulip/tulip.o
entry
Warning (compare_maps): mismatch on symbol tulip_rx_copybreak  , tulip says
d1902370, /lib/modules/2.4.8/kernel/drivers/net/tulip/tulip.o says
d1901930.  Ignoring /lib/modules/2.4.8/kernel/drivers/net/tulip/tulip.o
entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says
d18d12e0, /lib/modules/2.4.8/kernel/drivers/usb/usbcore.o says d18d0e00. 
Ignoring /lib/modules/2.4.8/kernel/drivers/usb/usbcore.o entry
Unable to handle kernel NULL pointer dereference at virtual address
00000000
d796940f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d796940f>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210082
eax: c60f4640   ebx: 00000000   ecx: 00000000   edx: 00000004
esi: 00200282   edi: 00000000   ebp: c02d0240   esp: caa2df70
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid: 3337, stackpage=caa2d000)
Stack: 00000000 cf392ac4 00000000 c0116a34 c60f4640 00000001 c02d0280
fffffffe
       00200046 c01167fb c02d0280 caa2dfc4 00000000 c02cc900 c02744c8
c01082ac
       401a92c0 4015ba30 082f2378 bfffee98 c0106f54 401a92c0 00000004
082f2378
Call Trace: [<c0116a34>] [<c01167fb>] [<c01082ac>] [<c0106f54>]
Code: f6 03 02 75 04 56 9d eb 54 53 e8 e2 23 00 00 8d 44 24 04 50

>>EIP; d796940f <[emu10k1]emu10k1_waveout_bh+f/70>   <=====
Trace; c0116a34 <tasklet_hi_action+64/90>
Trace; c01167fb <do_softirq+4b/90>
Trace; c01082ac <do_IRQ+9c/b0>
Trace; c0106f54 <ret_from_intr+0/7>
Code;  d796940f <[emu10k1]emu10k1_waveout_bh+f/70>
00000000 <_EIP>:
Code;  d796940f <[emu10k1]emu10k1_waveout_bh+f/70>   <=====
   0:   f6 03 02                  testb  $0x2,(%ebx)   <=====
Code;  d7969412 <[emu10k1]emu10k1_waveout_bh+12/70>
   3:   75 04                     jne    9 <_EIP+0x9> d7969418
<[emu10k1]emu10k1_waveout_bh+18/70>
Code;  d7969414 <[emu10k1]emu10k1_waveout_bh+14/70>
   5:   56                        push   %esi
Code;  d7969415 <[emu10k1]emu10k1_waveout_bh+15/70>
   6:   9d                        popf
Code;  d7969416 <[emu10k1]emu10k1_waveout_bh+16/70>
   7:   eb 54                     jmp    5d <_EIP+0x5d> d796946c
<[emu10k1]emu10k1_waveout_bh+6c/70>
Code;  d7969418 <[emu10k1]emu10k1_waveout_bh+18/70>
   9:   53                        push   %ebx
Code;  d7969419 <[emu10k1]emu10k1_waveout_bh+19/70>
   a:   e8 e2 23 00 00            call   23f1 <_EIP+0x23f1> d796b800
<[emu10k1]emu10k1_waveout_update+0/a0>
Code;  d796941e <[emu10k1]emu10k1_waveout_bh+1e/70>
   f:   8d 44 24 04               lea    0x4(%esp,1),%eax
Code;  d7969422 <[emu10k1]emu10k1_waveout_bh+22/70>
  13:   50                        push   %eax

Kernel panic: Aiee, killing interrupt handler!

3 warnings issued.  Results may not be reliable.


So back to 2.4.6 for me.

-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft
