Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbTIOOrd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 10:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbTIOOrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 10:47:33 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:13705 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261438AbTIOOra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 10:47:30 -0400
Date: Mon, 15 Sep 2003 07:46:55 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1227] New: Oops with SynCE and Compaq iPAQ 3600
Message-ID: <1504610000.1063637215@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1227

           Summary: Oops with SynCE and Compaq iPAQ 3600
    Kernel Version: 2.6.0-test5-bk3
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: felipe_alfaro@linuxmail.org


Distribution: 
SuSE Linux 8.2 
 
Hardware Environment: 
Pentium V 2.0Ghz 
Intel 845 motherboard (uhci-hcd) 
Compaq iPAQ 3660 with USB craddle 
 
Software Environment: 
SynCE 0.8.3 
 
Problem Description: 
Performing the following steps causes the kernel to oops and freeze. The 
kernel oops is attached to this bug report. I have also attached the .config 
file used to compile the kernel. 
 
Steps to reproduce: 
1. boot 2.6.0-test5-bk3 
2. modprobe ipaq 
3. synce-serial-config ttyUSB0 
4. dccm 
5. synce-serial-start

Unable to handle kernel NULL pointer dereference at virtual address 0000010c
 printing eip:
e08794d4
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<e08794d4>]     Not tainted VLI
EFLAGS: 00010297
EIP is at ipaq_read_bulk_callback+0xca/0x282 [ipaq]
eax: 00000006   ebx: 00000000   ecx: de7cd600   edx: 00000006
esi: de9fc200   edi: df4f9600   ebp: 00000000   esp: c038dee0
ds: 007b   es: 007b   ss:0068
Process swapper (pid: 0, threadinfo=c038c000 task=c03169c0)
Stack: 00000046 00000086 de9fc200 de9fc200 00000006 dd273000 de7cd600 de9fc200
       c038dfa4 de9fc200 df765c00 e08421ea de9fc200 c038dfa4 c038c000 00000286
       e082ed9a df765c00 de9fc200 c038dfa4 df765df8 c038dfa4 df765c00 00000001
Call Trace:
 [<e08421ea>] usb_hcd_giveback_urb+0x25/0x39 [usbcore]
 [<e082ed9a>] uhci_finish_completion+0x6a/0xac [uhci_hcd]
 [<e0842234>] usb_hcd_irq+0x36/0x5f [usbcore]
 [<c010c633>] handle_IRQ_event+0x3a/0x64
 [<c010c999>] do_IRQ+0x94/0x135
 [<c0107000>] _stext+0x0/0x5d
 [<c02d404c>] common_interrupt+0x18/0x20
 [<c0107000>] _stext+0x0/0x5d
 [<c012007b>] __wake_up_common+0x31/0x50
 [<c0109041>] default_idle+0x23/0x26
 [<c010909f>] cpu_idle+0x2c/0x35
 [<c038e6cc>] start_kernel+0x17d/0x1ab
 [<c038e426>] unknown_bootoption+0x0/0xfd

Code: e8 8c a7 8a df eb 9f 8b 56 30 85 c0 89 54 24 10 89 d5 0f 85 ed 00 00 00 8b
 44 24 10 8b 5f 08 85 c0 74 6a 31 ed 3b 6c 24 10 7d 51 <8b> 83 0c 01 00 00 3d ff
 01 00 00 0f 8f b6 00 00 00 8b 4c 24 14
 <0>Kernel panic: Fata; exception in interruppt
In interrupt handler - not syncing


