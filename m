Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277374AbRJENPu>; Fri, 5 Oct 2001 09:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277373AbRJENPl>; Fri, 5 Oct 2001 09:15:41 -0400
Received: from mplsdslgw14poolA71.mpls.uswest.net ([63.229.192.71]:45390 "EHLO
	bear.iucha.org") by vger.kernel.org with ESMTP id <S277374AbRJENPY>;
	Fri, 5 Oct 2001 09:15:24 -0400
Date: Fri, 5 Oct 2001 08:15:52 -0500
From: iuchaflorin@qwest.net
To: linux-kernel@vger.kernel.org
Cc: linux@connectcom.net, bfrey@turbolinux.com.cn
Subject: linux-2.4.11-pre3-xfs oops in advansys driver
Message-ID: <20011005081552.A518@bear.iucha.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux@connectcom.net,
	bfrey@turbolinux.com.cn
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using linux-2.4.11-pre3-xfs from SGI XFS CVS on a debian woody. The
machine is a K6-III/500 with 512 MB RAM. The system is installed on two disks
attached to an advansys controller:
   scsi0 : AdvanSys SCSI 3.3G: PCI Ultra-Wide: PCIMEM 0xE080A000-0xE080A03F, IRQ 0x5
    Vendor: IBM       Model: DCHS04W           Rev: 6464
    Type:   Direct-Access                      ANSI SCSI revision: 02
    Vendor: IBM       Model: DCHS04U           Rev: 6464
    Type:   Direct-Access                      ANSI SCSI revision: 02

lspci -v shows
   00:09.0 SCSI storage controller: Advanced System Products, Inc ABP940-UW
      Flags: bus master, medium devsel, latency 64, IRQ 5
      I/O ports at d800 [size=64]
      Memory at e9000000 (32-bit, non-prefetchable) [size=256]
      Expansion ROM at <unassigned> [disabled] [size=64K]

Last night, while my wife was browsing using Netscape, the machine looked up
hard. This is what the serial console captured before oops:

invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
advansys: adv_isr_callback: board 0: scp 0xdfef9600 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef9400 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef9200 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef8c00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef8400 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef8200 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef8000 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef9e00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef9c00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef9a00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef9800 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfefe000 not on active queue
advansys: adv_isr_callback: board 0: scp 0xc1840e00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xc1840c00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xc1840a00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xc1840800 not on active queue
advansys: adv_isr_callback: board 0: scp 0xc1840600 not on active queue
advansys: adv_isr_callback: board 0: scp 0xc1840400 not on active queue
advansys: adv_isr_callback: board 0: scp 0xc1840200 not on active queue
advansys: adv_isr_callback: board 0: scp 0xc1840e00 not on active queue

And then this oops, decoded:

ksymoops 2.4.3 on i586 2.4.11-pre3-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.11-pre3-xfs/ (default)
     -m /boot/System.map-2.4.11-pre3-xfs (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

c022c5ae
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c022c5ae>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013002
eax: c186adf0   ebx: c80004fe   ecx: df126000   edx: f000ef57
esi: 880004fe   edi: c0335084   ebp: 00003046   esp: de09df48
ds: 0018   es: 0018   ss: 0018
Process XFree86 (pid: 381, stackpage=de09d000)
Stack: c0335000 c033507c 00000000 c02248dc c0335084 c180ef40 24000001 00000005
       de09dfc4 00000000 00000000 db769ea0 00000000 c0107d6c 00000005 c033507c
       de09dfc4 000000a0 c03049a0 00000005 de09dfbc c0107ece 00000005 de09dfc4
Call Trace: [<c02248dc>] [<c0107d6c>] [<c0107ece>] [<c0109c68>]
Code: c6 83 18 00 00 c0 01 c6 83 19 00 00 c0 00 c6 83 1a 00 00 c0

>>EIP; c022c5ae <AdvISR+72/12c>   <=====
Trace; c02248dc <advansys_interrupt+84/180>
Trace; c0107d6c <handle_IRQ_event+30/5c>
Trace; c0107ece <do_IRQ+6e/b0>
Trace; c0109c68 <call_do_IRQ+6/e>
Code;  c022c5ae <AdvISR+72/12c>
00000000 <_EIP>:
Code;  c022c5ae <AdvISR+72/12c>   <=====
   0:   c6 83 18 00 00 c0 01      movb   $0x1,0xc0000018(%ebx)   <=====
Code;  c022c5b4 <AdvISR+78/12c>
   7:   c6 83 19 00 00 c0 00      movb   $0x0,0xc0000019(%ebx)
Code;  c022c5bc <AdvISR+80/12c>
   e:   c6 83 1a 00 00 c0 00      movb   $0x0,0xc000001a(%ebx)

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

Thank you,
florin

-- 

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
