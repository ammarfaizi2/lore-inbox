Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272862AbRIGWBO>; Fri, 7 Sep 2001 18:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272865AbRIGWBD>; Fri, 7 Sep 2001 18:01:03 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:35079 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272862AbRIGWAs>; Fri, 7 Sep 2001 18:00:48 -0400
Message-ID: <3B994392.23A745EA@folkwang-hochschule.de>
Date: Sat, 08 Sep 2001 00:00:50 +0200
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier 
	<nettings@folkwang-hochschule.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, nettings@folkwang-hochschule.de
Subject: 2.4.9-ac9 ide-scsi oops [was Re: 2.4.8-ac11 lockup when burning cds]
In-Reply-To: <3B922604.A8E3EB5F@folkwang-hochschule.de> <3B9232D8.143FC76D@folkwang-hochschule.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Nettingsmeier wrote:
> 
> Jörn Nettingsmeier wrote:
> >
> > hello *
> >
> > i see hard lockups in 2.4.8-ac11 when i try to burn a cd.
> 
> the problem is the same in 2.4.9-ac5.
> 
> regards,
> 
> jörn

with kernel 2.4.9-ac9, the problem remains the same, but i have
finally been able to capture an oops message. "capture" here means
copying the whole shit from the log console and typing it back in
again at ten past midnight, so excuse minor inaccuracies...


the syslog messages just before the oops were:

hda timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda status timeout: status=0xd0 {busy}
hda: drive not ready for command
hda: ATAPI reset complete
hda: irq timeout: status=0xd0 {busy}

and now, the oops:


<oops>
ksymoops 2.4.0 on i686 2.4.9-ac9  
 
Warning (compare_maps): mismatch on symbol usb_devfs_handle  ,
usbcore says e2a53320,
/lib/modules/2.4.9-ac9/kernel/drivers/usb/usbcore.o says e2a52e40. 
Ignoring /lib/modules/2.4.9-ac9/kernel/drivers/usb/usbcore.o entry
Oops: 0002
CPU: 0
EIP: 0010: [<c01f3ea3>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000000   ebx: d6bac740   ecx: 00000000   edx: d6bac740
esi: 00000000   edi: 00000000   ebp: cf590000   esp: c02e7eb4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02c7000)
Stack: d6bac740 c0371560 000000d0 c0371520 00000000 d6bac749
dfffa7c0 c0371560
       c01c3c12 00000000 c189ad60 c0371560 c189ad60 c01f4088
000000d0 c01c481a
       c0371560 c0297862 000000d0 c189ad60 c01c466c 00000000
c0351b60 00000282
Call trace: [<c01c3c12>] [<c01f4088>] [<c01c481a>] [<c01c466c>]
[<c011f895>]
            [<c011f90c>] [<c011c030>] [<c011bf0d>] [<c011bcaf>]
[<c01088cb>]
[<c01051b0>]
            [<c0105180>] [<c0105180>] [<c01051b0>] [<c01051dd>]
[<c0105242>]
[<c0105000>]
            [<c0105043>]
Code: c7 80 78 01 00 00 00 00 07 00 83 7c 24 10 00 0f 84 66 01 00
 
>>EIP; c01f3ea3 <idescsi_end_request+6b/250>   <=====
Trace; c01c3c12 <ide_error+11e/164>
Trace; c01f4088 <idescsi_pc_intr+0/230>
Trace; c01c481a <ide_timer_expiry+1ae/20c>
Trace; c01c466c <ide_timer_expiry+0/20c>
Trace; c011f895 <timer_bh+259/2b0>
Trace; c011f90c <do_timer+20/50>
Trace; c011c030 <bh_action+4c/88>
Trace; c011bf0d <tasklet_hi_action+61/90>
Trace; c011bcaf <do_softirq+6f/cc>
Trace; c01088cb <do_IRQ+db/ec>
Trace; c01051b0 <default_idle+0/34>
Trace; c0105180 <init+134/154>
Trace; c0105180 <init+134/154>
Trace; c01051b0 <default_idle+0/34>
Trace; c01051dd <default_idle+2d/34>
Trace; c0105242 <cpu_idle+3e/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105043 <rest_init+43/44>
Code;  c01f3ea3 <idescsi_end_request+6b/250>
00000000 <_EIP>:
Code;  c01f3ea3 <idescsi_end_request+6b/250>   <=====
   0:   c7 80 78 01 00 00 00      movl   $0x70000,0x178(%eax)  
<=====
Code;  c01f3eaa <idescsi_end_request+72/250>
   7:   00 07 00
Code;  c01f3ead <idescsi_end_request+75/250>
   a:   83 7c 24 10 00            cmpl   $0x0,0x10(%esp,1)
Code;  c01f3eb2 <idescsi_end_request+7a/250>
   f:   0f 84 66 01 00 00         je     17b <_EIP+0x17b> c01f401e
<idescsi_end_request+1e6/250>
 
 <0>Kernel panic: Aiee, killing Interrupt handler !
 
2 warnings issued.  Results may not be reliable.

</oops>

here's my system config again:
dual p3/600, 512mb ram, 
asus p2b-ds mobo w/ onboard aic7xxx scsi, pci scsi controller
symbios (disabled, module *not* loaded when the oops occured), one
scsi cdrom and one 4gig scsi hd connected to the adaptec onboard,
one disk hdc connected to onboard IDE #1 (master), and the offending
cd burner hda, connected to onboard IDE #0 (master), and running in
scsi-emulation mode.

hope the oops will be useful to someone...

please keep me cc:ed on replies.

all the best,

jörn


-- 
Jörn Nettingsmeier     
home://Kurfürstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/
