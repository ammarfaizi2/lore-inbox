Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266574AbUJAVeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUJAVeW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266687AbUJAVd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:33:57 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:22962 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266574AbUJAV2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 17:28:42 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
Date: Fri, 1 Oct 2004 23:31:03 +0200
User-Agent: KMail/1.6.2
Cc: Kevin Fenzi <kevin-linux-kernel@scrye.com>
References: <415C2633.3050802@0Bits.COM> <200410012153.31376.rjw@sisk.pl> <20041001195800.066582B131@voldemort.scrye.com>
In-Reply-To: <20041001195800.066582B131@voldemort.scrye.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410012331.03430.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 of October 2004 21:57, Kevin Fenzi wrote:
> >>>>> "Rafael" == Rafael J Wysocki <rjw@sisk.pl> writes:
> 
> >> Do you have HIMEM enabled?
> 
> Rafael> I'm not sure what you mean.  It's an x86-64 system with 512 MB
> Rafael> of RAM.
> 
> HIMEM is needed for various configs when you have 1GB of memory or
> more.
> 
> So, it shouldn't be set in your case it sounds like...
> You should have "NOHIGHMEM" set in your .config...

Well, I don't think so.  According to Documentation/x86_64/mm.txt:

"The paging design used on the x86-64 linux kernel [...] provides:

o       per process virtual address space limit of 512 Gigabytes
o       top of userspace stack located at address 0x0000007fffffffff
o       PAGE_OFFSET = 0xffff800000000000
o       start of the kernel = 0xffffffff800000000
o       global RAM per system 2^64-PAGE_OFFSET-sizeof(kernel) = 128 Terabytes 
- 2 Gigabytes
o       no need of any common code change
o       no need to use highmem to handle the 128 Terabytes of RAM"
                                                                  ^^^^^^^^^^^^^^
I have only 512 meg. ;-)

> >> Does the patch below make it more stable for you?
> 
> Rafael> I have this patch applied, but I get double faults sometimes
> Rafael> anyway.
> 
> Can you post the exact messages? This seems diffrent than the reboot
> issue I was seeing.

Sure.  They are for 2.6.9-rc2-mm4, though:

Relocating pagedir not necessary
Reading image data (9659 pages): 100% 9659 done.
Stopping tasks: ===|
Freeing memory... done (0 pages freed)
PM: Restoring saved image.
<0>double fault: 0000 [1]
CPU 0
Modules linked in: usbserial lp ohci_hcd parport_pc parport af_packet sk98lin 
ehci_hcd evdev usbhid ipv6
Pid: 17009, comm: hibernate.sh Tainted: G   M  2.6.9-rc2-mm4
RIP: 0010:[<ffffffff8012518d>] <ffffffff8012518d>{do_page_fault+1485}
RSP: 0000:000001001fe00008  EFLAGS: 00010002
RAX: 000000001fce8740 RBX: 0000000000000001 RCX: 000ffffffffff000
RDX: 000000001fce8000 RSI: 0000010000000000 RDI: 000001001fe000e8
RBP: 000001001fce8740 R08: 0000000000000000 R09: 000001001fe27e54
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 000001001fe000e8 R15: 000001001b09e200
FS:  0000000000000000(0000) GS:ffffffff805582c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 0000000080050033
CR2: 000001001fdffff8 CR3: 0000000000101000 CR4: 00000000000006e0
Process hibernate.sh (pid: 17009, threadinfo 000001001c6d8000, task 
000001001ad16530)
Stack: 000001001fe01000 0000000000000060 000001001ad16530 0000ffff0000001a
       fffefffefffefffe fffefffe00030001 fffefffefffefffe fffefffefffefffe
       fffefffefffefffe fffefffefffefffe
Call Trace:<ffffffff8011168d>{error_exit+0} 
<ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} 
<ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} <ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} 
<ffffffff80282d47>{acpi_os_allocate+12}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} 
<ffffffff80282d47>{acpi_os_allocate+12}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} 
<ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} 
<ffffffff80282d47>{acpi_os_allocate+12}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} 
<ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} 
<ffffffff80282d47>{acpi_os_allocate+12}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} 
<ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} 
<ffffffff80282d47>{acpi_os_allocate+12}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} 
<ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} <ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} 
<ffffffff80282d47>{acpi_os_allocate+12}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} 
<ffffffff80282d47>{acpi_os_allocate+12}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} 
<ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} 
<ffffffff80282d47>{acpi_os_allocate+12}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} 
<ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} 
<ffffffff80282d47>{acpi_os_allocate+12}


Code: f6 04 06 81 0f 84 52 fc ff ff 48 8b 05 e2 f9 3a 00 48 89 c2
RIP <ffffffff8012518d>{do_page_fault+1485} RSP <000001001fe00008>

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
