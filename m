Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbUBTUsE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 15:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbUBTUsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 15:48:04 -0500
Received: from babyruth.hotpop.com ([38.113.3.61]:44470 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP id S261326AbUBTUqi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 15:46:38 -0500
Date: Sat, 21 Feb 2004 07:53:08 +0530
From: John Levin <levin@gamebox.net>
To: linux-kernel@vger.kernel.org
Cc: pavel@ucw.cz
Subject: 2.6.2-rc3 messages  BUG
Message-Id: <20040221075308.161992c7.levin@gamebox.net>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	My guess atleast in this case is that  suspend/resume cyle looses track
of the fact that a module is use.I have file corruption. All those
files which have been created after resume is corrupted. I copied dmesg
into a backup file and saved it. When i boot 2.4 and look into it , it
is corrputed.
	After booting I connect to the internet through wvdial. So i have to
load up usbcore,cdc_acm,uhci. i am connected to the net and searching on
google.	Now i do echo 4 > /proc/acpi/sleep . It suspends. Then i resume
it from command line.
 So now wvdial looks as if connected but really isn't. So i close it and
try running it again. It doesn't detect /dev/usb/acm/0. So i remove the
modules and try inserting it (uhci) which gives me the error.

Here is something which i could copy after resume.

--> WvDial: Internet dialer version 1.53
--> Initializing modem.
--> Sending: ATZ
--> Sending: ATQ0
--> Re-Sending: ATZ
--> Modem not responding.
lsmod
[root@mdk9 root]# lsmod
Module                  Size  Used by
uhci_hcd               31752  0
cdc_acm                10784  3
usbcore               111828  4 uhci_hcd,cdc_acm
[root@mdk9 root]# rmmod uhci_hcd
[root@mdk9 root]# insmod
/lib/modules/2.6.3-rc2/kernel/drivers/usb/host/uhci-hcd.ko

------------[cut here ]------------ 
kernel BUG at mm/slab.c:1269!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0143a29>]    Not tainted
EFLAGS: 00010202
EIP is at kmem_cache_create+0x509/0x670
eax: 00000031   ebx: c130277c   ecx: c04a50e8   edx: c03cc3f8
esi: cf935fa7   edi: cf935fa7   ebp: cbdedf74   esp: cbdedf44
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 2234, threadinfo=cbdec000 task=cc1fa6a0)
Stack: c036e980 cf935f99 00010c00 cbdedf64 c13026a4 c0000000 c1302668
fffffffc       00000020 00000000 fffffff4 cf938980 cbdedf9c cf91d0d4
cf935f99 00000044       00000080 00010c00 00000000 00000000 c03ceb70
c03ceb58 cbdedfbc c0137aeb Call Trace:
 [<cf91d0d4>] uhci_hcd_init+0xd4/0x12e [uhci_hcd]
 [<c0137aeb>] sys_init_module+0xeb/0x1c0
 [<c010b1df>] syscall_call+0x7/0xb

Code: 0f 0b f5 04 5a df 36 c0 8b 0b e9 71 ff ff ff 8b 47 34 c7 04
Segmentation fault

--

