Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266041AbUAVPyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 10:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266043AbUAVPyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 10:54:45 -0500
Received: from central.switch.ch ([130.59.11.11]:61163 "EHLO central.switch.ch")
	by vger.kernel.org with ESMTP id S266041AbUAVPyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 10:54:40 -0500
Message-ID: <400FF239.7000200@switch.ch>
Date: Thu, 22 Jan 2004 16:54:33 +0100
From: Harald Staub <staub@switch.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.6b) Gecko/20031222 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Harald Welte <laforge@gnumonks.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: filemap.c bad pmd
References: <4007B9F4.9000203@switch.ch> <20040120005338.GA8642@obroa-skai.de.gnumonks.org>
In-Reply-To: <20040120005338.GA8642@obroa-skai.de.gnumonks.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>One of our news servers just had a kernel panic that has similarities to a 
>>problem you had in August:
>>
>><http://www.ussg.iu.edu/hypermail/linux/kernel/0308.1/0778.html>
>>"2.4.18/2.4.20 filemap.c pmd bug (was Re: Problem with mm in 2.4.19 and 
>>2.4.20)"
> 
> 
> mh.  So we can acknowledge that there is a problem.  
>  
> 
>>Since I could not find a solution, I would like to ask you if you have a 
>>hint for me.  Below are some details.
> 
> 
> No, I didn't receive any hint from one of the filesystem/mm developers :(
> 
> 
>>Harald Staub
>>staub@switch.ch
> 
> 
> Hey, you are one of the admins of the switch.ch newsservers?  They're
> one of the biggest in europe (besides belnet.be and garr.it), aren't
> they?


Well, our inn admin is Uli Schmid.  I am the Debian admin.  When I tell him 
I heard our servers are quite big, he just smiles, so I do not really know 
how big they are :-)


> that oops is not very helpful as long as it isn't processed by ksymoops
> (which only you can do with your original kernel binary and system.map)


Ok, I tried that:

ksymoops 2.4.5 on i686 2.6.1-hs.1.  Options used
      -V (default)
      -k ksyms (specified)
      -l modules (specified)
      -o /lib/modules/2.4.23-hs.1 (specified)
      -m /boot/System.map-2.4.23-hs.1 (specified)

Unable to handle kernel paging request at virtual address e15dc264
f88ac2e4
*pde = 214001e3
Oops: 0000
CPU:    1
EIP:    0060:[<f88ac2e4>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00005e00   ebx: 6a5605ea   ecx: 0000000a   edx: 17a82000
esi: 00010000   edi: 00000020   ebp: e15dc200   esp: c1c15ee0
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, stackpage=c1c15000)
Stack: f7910000 00010000 00000020 0000000b 00000001 c02303d9 00002ae0 00000000
        c037998c c0379960 000005ea f7906d80 01000040 f88ab30c f7910000 f7917bec
        00000001 f7c33dc0 04000001 c0395a88 c0108cd1 0000000b f79a3c00 c1c15f7c
Call Trace:    [<c02303d9>] [<f88ab30c>] [<c0108cd1>] [<c0108ef7>] [<c01052b0>]
   [<c01052b0>] [<c01052b0>] [<c01052b0>] [<c01052dc>] [<c0105342>] [<c0117b7f>]
   [<c0117a8e>]
Code: 83 7d 64 00 74 0a 68 1d 03 00 00 e8 78 b0 86 c7 8b 44 24 28


 >>EIP; f88ac2e4 <[sk98lin]ReceiveIrq+1fc/778>   <=====

 >>eax; 00005e00 Before first symbol
 >>ebx; 6a5605ea Before first symbol
 >>edx; 17a82000 Before first symbol
 >>esi; 00010000 Before first symbol
 >>ebp; e15dc200 <_end+21219384/384bf184>
 >>esp; c1c15ee0 <_end+1853064/384bf184>

Trace; c02303d9 <process_backlog+81/124>
Trace; f88ab30c <[sk98lin]SkGeIsrOnePort+44/138>
Trace; c0108cd1 <handle_IRQ_event+5d/88>
Trace; c0108ef7 <do_IRQ+d7/11c>
Trace; c01052b0 <default_idle+0/34>
Trace; c01052b0 <default_idle+0/34>
Trace; c01052b0 <default_idle+0/34>
Trace; c01052b0 <default_idle+0/34>
Trace; c01052dc <default_idle+2c/34>
Trace; c0105342 <cpu_idle+3e/54>
Trace; c0117b7f <release_console_sem+93/98>
Trace; c0117a8e <printk+126/140>

Code;  f88ac2e4 <[sk98lin]ReceiveIrq+1fc/778>
00000000 <_EIP>:
Code;  f88ac2e4 <[sk98lin]ReceiveIrq+1fc/778>   <=====
    0:   83 7d 64 00               cmpl   $0x0,0x64(%ebp)   <=====
Code;  f88ac2e8 <[sk98lin]ReceiveIrq+200/778>
    4:   74 0a                     je     10 <_EIP+0x10>
Code;  f88ac2ea <[sk98lin]ReceiveIrq+202/778>
    6:   68 1d 03 00 00            push   $0x31d
Code;  f88ac2ef <[sk98lin]ReceiveIrq+207/778>
    b:   e8 78 b0 86 c7            call   c786b088 <_EIP+0xc786b088>
Code;  f88ac2f4 <[sk98lin]ReceiveIrq+20c/778>
   10:   8b 44 24 28               mov    0x28(%esp,1),%eax

  <0>Kernel panic: Aiee, killing interrupt handler!

I have no idea if this could be helpful.  That there is a lot about sk98lin 
may be no surprise since there is something going on that interface (about 
80Mbps).  Nevertheless, I had a look at the syskonnect web site and found a 
recommended patch for sk98lin.  Sooner or later we will try that.


>>ProLiant DL380, dual PIII 1GHz, 1GB RAM, kernel 2.4.24 with some patches 
>>(usagi, exec_shield; not used on this machine, but patched in: xfs, 
>>cryptoloop), highmem (4GB) support, inn 2.4.1
>>Disks connected to "Compaq Smart Array 5300 Controller" (SCSI) and aic7xxx 
>>(IDE RAID)
> 
> 
> mh, as indicated in my original posting, I was running a pretty standard
> configuration (no patches, no highmem, not even SMP) and had the same
> problem with an inn (2.3.x) server.


We have reduced the load now, using some inn config.  The uptime is now 4 days.

The hardware is now 3 years old and definitely got performance problems, so 
we will migrate to newer hardware.

Thank you for your response!

Harald Staub
staub@switch.ch
