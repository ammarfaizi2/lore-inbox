Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130018AbRAJU1p>; Wed, 10 Jan 2001 15:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132594AbRAJU1f>; Wed, 10 Jan 2001 15:27:35 -0500
Received: from think.faceprint.com ([166.90.149.11]:15880 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S130018AbRAJU12>; Wed, 10 Jan 2001 15:27:28 -0500
Message-ID: <3A5CC4B2.74B911BD@faceprint.com>
Date: Wed, 10 Jan 2001 15:23:14 -0500
From: Nathan Walp <faceprint@faceprint.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Grobler <grobh@sun.ac.za>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.4.0-ac5
In-Reply-To: <Pine.LNX.4.30.0101102212290.30013-100000@prime.sun.ac.za>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Grobler wrote:
> 
> On Wed, 10 Jan 2001, Nathan Walp wrote:
> > First post to the list, hope I get this right...
> 
> Could you please run this through ksymoops on your machine.
> Depending on which distribution you're using, this can be as
> simple as:
> 
>   ksymoops <  oops.txt
> 
> Remember to set the System.map to the correct one, if you did
> not compile in /usr/src/linux.
> 
> Thanks,
> -- Hans
Here it is... I opted to cut out the 1200-odd warnings, which from the
look of them were all because i'm running it under 2.4.0-ac4 (which
boots fine).

faceprint@patience:~$ ksymoops -o /lib/modules/2.4.0-ac5/ -m
/boot/System.map-2.4.0-ac5 < oops.txt | less
ksymoops 2.3.4 on i686 2.4.0-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-ac5/ (specified)
     -m /boot/System.map-2.4.0-ac5 (specified)

No modules in ksyms, skipping objects
<snip warnings>
CPU:    0
EIP:    0010:[<c01129ba>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000     ecx: 00000186       edx: 00000000
esi: 00000004   edi: c0105000     ebp: 0008e000       esp: c0335fc0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0335000)
Stack: 00000000 c033bdbb 0000ffec 0009ee00 c033c093 c03367f5 c03368fb
c0299040
       0000ffec 0000ffec 0000ffec 0000ffec 0000ffec 00000000 c0370ce0
c0100191
Call Trace: [<c0100191>]
Code: 0f 30 41 0f 30 b9 c1 00 00 00 0f 30 b9 c2 00 00 00 0f 30 b8

>>EIP; c01129ba <setup_apic_nmi_watchdog+a/90>   <=====
Trace; c0100191 <L6+0/2>
Code;  c01129ba <setup_apic_nmi_watchdog+a/90>
00000000 <_EIP>:
Code;  c01129ba <setup_apic_nmi_watchdog+a/90>   <=====
   0:   0f 30                     wrmsr     <=====
Code;  c01129bc <setup_apic_nmi_watchdog+c/90>
   2:   41                        inc    %ecx
Code;  c01129bd <setup_apic_nmi_watchdog+d/90>
   3:   0f 30                     wrmsr  
Code;  c01129bf <setup_apic_nmi_watchdog+f/90>
   5:   b9 c1 00 00 00            mov    $0xc1,%ecx
Code;  c01129c4 <setup_apic_nmi_watchdog+14/90>
   a:   0f 30                     wrmsr  
Code;  c01129c6 <setup_apic_nmi_watchdog+16/90>
   c:   b9 c2 00 00 00            mov    $0xc2,%ecx
Code;  c01129cb <setup_apic_nmi_watchdog+1b/90>
  11:   0f 30                     wrmsr  
Code;  c01129cd <setup_apic_nmi_watchdog+1d/90>
  13:   b8 00 00 00 00            mov    $0x0,%eax

Kernel panic: Attempted to kill the idle task!

1205 warnings issued.  Results may not be reliable.



Hope this is of a little more help ;-)

Nathan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
