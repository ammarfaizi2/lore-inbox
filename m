Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbTFZDDh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 23:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbTFZDDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 23:03:37 -0400
Received: from pcp03710388pcs.westk01.tn.comcast.net ([68.34.200.110]:58752
	"EHLO ori.thedillows.org") by vger.kernel.org with ESMTP
	id S265359AbTFZDD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 23:03:28 -0400
Subject: Re: 2.4.21: kernel BUG at ide-iops.c:1262!
From: David Dillow <dave@thedillows.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1056557323.1444.4.camel@dhcp22.swansea.linux.org.uk>
References: <1056493150.2840.17.camel@ori.thedillows.org>
	 <20030624204828.I30001@newbox.localdomain>
	 <1056513292.3885.2.camel@ori.thedillows.org>
	 <1056557323.1444.4.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056597452.2732.4.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Jun 2003 23:17:33 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-25 at 12:08, Alan Cox wrote:
> On Mer, 2003-06-25 at 04:54, David Dillow wrote:
> 
> > I thought I had, but upon checking, it was still kicking. Killing it
> > allows the burn to complete uninterrupted.
> > 
> > I'll test patches to kill the kernel BUG, but I'm happy to be able to
> > burn without a reboot again.
> 
> I've put a test fix into -ac3

Well, it no longer BUGS. Progress. :)

Unfortunately, it still oopses, then panics. Everything but the kernel
is the same as before. Forgot to get ksym/module info for ksymoops
before testing, can get that info if need be.

ksymoops 2.4.5 on i686 2.4.21.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.21-ac3/ (specified)
     -m /boot/System.map-2.4.21-ac3 (specified)

No modules in ksyms, skipping objects
cpu: 0, clocks: 1339302, slice: 446434
cpu: 1, clocks: 1339302, slice: 446434
Unable to handle kernel NULL pointer dereference at virtual address
00000000
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010096
eax: c029c480   ebx: c034b7fc   ecx: 00000033   edx: 00000002
esi: c15de400   edi: 00000000   ebp: c15e3440   esp: c02cded4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02cd000)
Stack: c01de899 c034b7fc c026be65 00000000 c01d891d c15de400 00000002
00000000 
       c15de400 00000292 00000000 00000001 c01d7d15 c15de400 00000002
000003ac 
       00000000 c15de46c c01d7c90 c0126f1e c15de400 c15de46c c15de46c
00000001 
Call Trace:    [<c01de899>] [<c01d891d>] [<c01d7d15>] [<c01d7c90>]
[<c0126f1e>]
  [<c0122e24>] [<c0122cc2>] [<c0122a89>] [<c0109289>] [<c01053e0>]
[<c0105000>]
  [<c010bde8>] [<c01053e0>] [<c0105000>] [<c010540c>] [<c0105474>]
Code:  Bad EIP value.


>>EIP; 00000000 Before first symbol

>>eax; c029c480 <idescsi_driver+0/6c>
>>ebx; c034b7fc <ide_hwifs+67c/2cd8>
>>esi; c15de400 <END_OF_CODE+127f9c8/????>
>>ebp; c15e3440 <END_OF_CODE+1284a08/????>
>>esp; c02cded4 <init_task_union+1ed4/2000>

Trace; c01de899 <idescsi_reset+29/80>
Trace; c01d891d <scsi_reset+11d/370>
Trace; c01d7d15 <scsi_old_times_out+85/160>
Trace; c01d7c90 <scsi_old_times_out+0/160>
Trace; c0126f1e <run_timer_list+12e/1b7>
Trace; c0122e24 <bh_action+54/80>
Trace; c0122cc2 <tasklet_hi_action+62/a0>
Trace; c0122a89 <do_softirq+d9/e0>
Trace; c0109289 <do_IRQ+e9/f0>
Trace; c01053e0 <default_idle+0/50>
Trace; c0105000 <_stext+0/0>
Trace; c010bde8 <call_do_IRQ+5/d>
Trace; c01053e0 <default_idle+0/50>
Trace; c0105000 <_stext+0/0>
Trace; c010540c <default_idle+2c/50>
Trace; c0105474 <cpu_idle+24/30>

 <0>Kernel panic: Aiee, killing interrupt handler!


