Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbTA1Mpn>; Tue, 28 Jan 2003 07:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbTA1Mpn>; Tue, 28 Jan 2003 07:45:43 -0500
Received: from arnold.dormnet.his.se ([193.10.185.236]:29189 "HELO
	smtp.dormnet.his.se") by vger.kernel.org with SMTP
	id <S265246AbTA1Mpl>; Tue, 28 Jan 2003 07:45:41 -0500
Date: Tue, 28 Jan 2003 13:51:20 +0100
From: Andreas Henriksson <andreas@fjortis.info>
To: linux-kernel@vger.kernel.org
Subject: Re: OOPS in read_cd... what to do?
Message-ID: <20030128125119.GA31590@foo>
References: <Pine.GSO.4.33.0301270937370.18209-100000@Amps.coe.neu.edu> <3E355D1F.1080007@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3E355D1F.1080007@didntduck.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

While talking about old (probably unmaintaned) hardware and oops..

Any kernel I've tried oops when I try to use the e2100 driver to get my
Cabletron E2100 isa network-card running.

Btw. I don't expect anyone to care, but I'd be very happy if anyone could
give me any comment/hint... I haven't done much debugging before and I'm
not very familiar with kernel/driver development. (So if anyone wondered
why I'm even looking at this, it's not because I can't live without my
Cabletron. It's more like this might be my chance to get more familiar. ;-])

How to reproduce:
1. load module.
	#modprobe e2100
	e2100.c: Presently autoprobing (not recommended) for a single card.
	e2100.c:v1.01 7/21/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)
	 00 00 1D 0A 72 AB, IRQ 15, secandary media, memory @ 0xd0000
(I can supply io=0x380 to get rid of the warning message, but there will
be no real difference. I'm not really sure this is the correct value,
but last time I tried this I did look at the jumpers and used the right
value, thats when I noticed the oops. A weird thing btw. It didn't
happen when there also was a ne2000-compatible isa-card used at the same
time, then it just refused to send any traffic.)

2. configure and up the interface, then send traffic using the
interface.
(ping some.remote.ip ... pinging myself works fine, but I guess it's
because the driver isn't involved there)


ksymoops output:


ksymoops 2.4.5 on i586 2.4.20.  Options used
     -v vmlinux (specified)
     -k ksyms (specified)
     -l modules (specified)
     -o /lib/modules/2.4.20/ (default)
     -m System.map (specified)

c38e44e7
*pde = 00000000
Oops: 0000
CPU:    0
EFLAGS: 00010246
eax: 00000030   ebx: 0000002a     ecx: 00000000       edx: c38e4a20
esi: c097f6c2   edi: 000d0000     ebp: 00000380       esp: c07d1c7c
ds: 0018        es: 0018       ss: 0018
Process ping (pid: 320, stackpage=c07d10000)
Stack:  c10e6a60 00000030 c38e4a20 0000003c c38e12ff c38e4a20 0000002a c097f6c2
               00000030 c10e6c60 c38e4a20 c2e20120 c38e4a98 0000002a 00000380 c01d4ce1
               c2e20120 c38e4a20 c02ab7c8 c38e4a20 00000000 c01ceac1 c38e4a20 c2e20120
Call Trace:    [<c38e4a20>] [<c38e12ff>] [<c38e4a20>] [<c38e4a20>] [<c38e4a98>]
  [<c01d4ce1>] [<c38e4a20>] [<c38e4a20>] [<c01ceac1>] [<c38e4a20>] [<c38e4a9e>]
  [<c01fa629>] [<c38e4a20>] [<c01fa133>] [<c38e4a20>] [<c38e4a90>] [<c38e4a98>]
  [<c01d19fa>] [<c01d20bd>] [<c01e0690>] [<c01e13b2>] [<c01f8217>] [<c01f7eb0>]
  [<c010df44>] [<c01c8309>] [<c018e407>] [<c01c9a9c>] [<c0106d34>] [<c0106c23>]
Code: 8a 14 38 25 ff 00 00 00 8d 55 10 8a 04 38 ec b0 05 8d 55 15
Using defaults from ksymoops -t elf32-i386 -a i386


>>edx; c38e4a20 <[e2100]dev_e21+0/570>
>>esi; c097f6c2 <_end+6ae7e6/35fa124>
>>edi; 000d0000 Before first symbol
>>esp; c07d1c7c <_end+500da0/35fa124>

Trace; c38e4a20 <[e2100]dev_e21+0/570>
Trace; c38e12ff <[8390]ei_start_xmit+133/1f8>
Trace; c38e4a20 <[e2100]dev_e21+0/570>
Trace; c38e4a20 <[e2100]dev_e21+0/570>
Trace; c38e4a98 <[e2100]dev_e21+78/570>
Trace; c01d4ce1 <qdisc_restart+51/d8>
Trace; c38e4a20 <[e2100]dev_e21+0/570>
Trace; c38e4a20 <[e2100]dev_e21+0/570>
Trace; c01ceac1 <dev_queue_xmit+101/244>
Trace; c38e4a20 <[e2100]dev_e21+0/570>
Trace; c38e4a9e <[e2100]dev_e21+7e/570>
Trace; c01fa629 <arp_send+1f5/240>
Trace; c38e4a20 <[e2100]dev_e21+0/570>
Trace; c01fa133 <arp_solicit+ab/d4>
Trace; c38e4a20 <[e2100]dev_e21+0/570>
Trace; c38e4a90 <[e2100]dev_e21+70/570>
Trace; c38e4a98 <[e2100]dev_e21+78/570>
Trace; c01d19fa <__neigh_event_send+7e/1b4>
Trace; c01d20bd <neigh_resolve_output+61/19c>
Trace; c01e0690 <ip_output+c4/12c>
Trace; c01e13b2 <ip_build_xmit+2c2/35c>
Trace; c01f8217 <raw_sendmsg+28b/2f4>
Trace; c01f7eb0 <raw_getfrag+0/24>
Trace; c010df44 <do_page_fault+0/486>
Trace; c01c8309 <sockfd_lookup+11/7c>
Trace; c018e407 <tty_ioctl+1b3/39c>
Trace; c01c9a9c <sys_socketcall+1e4/200>
Trace; c0106d34 <error_code+34/40>
Trace; c0106c23 <system_call+33/40>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8a 14 38                  mov    (%eax,%edi,1),%dl
Code;  00000003 Before first symbol
   3:   25 ff 00 00 00            and    $0xff,%eax
Code;  00000008 Before first symbol
   8:   8d 55 10                  lea    0x10(%ebp),%edx
Code;  0000000b Before first symbol
   b:   8a 04 38                  mov    (%eax,%edi,1),%al
Code;  0000000e Before first symbol
   e:   ec                        in     (%dx),%al
Code;  0000000f Before first symbol
   f:   b0 05                     mov    $0x5,%al
Code;  00000011 Before first symbol
  11:   8d 55 15                  lea    0x15(%ebp),%edx

 <0>Kernel panic: Aiee, killing interrupt handler!




Did I forget to append something? (Hope not)


Thanks for all your great work by the way!

Regards,
Andreas Henriksson
