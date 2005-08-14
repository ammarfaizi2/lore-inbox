Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbVHNBOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbVHNBOx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 21:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVHNBOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 21:14:53 -0400
Received: from imap.gmx.net ([213.165.64.20]:26053 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751365AbVHNBOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 21:14:53 -0400
X-Authenticated: #1189245
Message-ID: <42FE9B41.4000909@gmx.net>
Date: Sun, 14 Aug 2005 03:15:45 +0200
From: Carsten Menke <bootsy52@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.3 and 2.6.13-rc6 Kernel Oops using ISDN capi (c2faxsend)
References: <42FCD58B.5010702@gmx.net> <42FCE37F.7070606@gmx.net>
In-Reply-To: <42FCE37F.7070606@gmx.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Menke wrote:

The same applies using 2.6.13-rc6 but the trace looks a little bit different 
(the last line). The fax transfer starts but then breaks with this trace in the 
middle.

//Carsten

capilib_new_ncci: kcapi: appl 3 ncci 0x10101 up
kcapi: appl 3 ncci 0x10101 forced down
kcapi: appl 3 ncci 0x10101 down
Unable to handle kernel NULL pointer dereference at virtual address 00000004
  printing eip:
e0968df2
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in: ipv6 piix ide_generic b1pci b1dma b1 n_hdlc tun capi capifs 
kernelcapi evdev pcspkr parport_pc parport psmouse genrtc e1000 ide_cd cdrom 
ide_disk ide_core floppy usb_storage fbcon font bitblit vga16fb usbhid usbkbd 
ehci_hcd uhci_hcd thermal processor fan unix
CPU:    0
EIP:    0060:[<e0968df2>]    Not tainted VLI
EFLAGS: 00010282   (2.6.13-rc6)
EIP is at capilib_release_appl+0x52/0x70 [kernelcapi]
eax: 00000000   ebx: d75e6d80   ecx: c03b9c14   edx: 00000000
esi: dfb7fe4c   edi: dfb7fe4c   ebp: 00000003   esp: d7679dac
ds: 007b   es: 007b   ss: 0068
Process c2faxsend (pid: 4112, threadinfo=d7678000 task=c1718540)
Stack: e096b940 00000003 00010101 dfb7fcc8 00000003 dfe8b000 dff85300 e0937b29
        dfb7fe4c 00000003 000000e2 dfb7fcc8 dd6e0a88 dea2b0d0 e09660ba dfb7fcc8
        00000003 00000000 e0966ce0 dfb7fcc8 00000003 dd6e0a80 d55b8480 e089a653
Call Trace:
  [<e0937b29>] b1dma_release_appl+0x29/0xe0 [b1dma]
  [<e09660ba>] release_appl+0x1a/0x70 [kernelcapi]
  [<e0966ce0>] capi20_release+0xc0/0xd0 [kernelcapi]
  [<e089a653>] capidev_free+0x93/0xa0 [capi]
  [<e089b739>] capi_release+0x19/0x30 [capi]
  [<c0160a3a>] __fput+0x18a/0x1a0
  [<c015ed9d>] filp_close+0x4d/0x80
  [<c011fe34>] put_files_struct+0x64/0xd0
  [<c0120b69>] do_exit+0x109/0x410
  [<c0120ef0>] do_group_exit+0x40/0xb0
  [<c012a900>] get_signal_to_deliver+0x230/0x340
  [<c0102f1f>] do_signal+0x8f/0x120
  [<c0118198>] wake_up_state+0x18/0x20
  [<c0128cae>] signal_wake_up+0x2e/0x50
  [<c0129311>] force_sig_info+0x71/0xb0
  [<c0129c50>] force_sig+0x20/0x30
  [<c0104d75>] do_general_protection+0xa5/0x1d0
  [<c023db22>] copy_to_user+0x42/0x60
  [<c0122b0c>] sys_gettimeofday+0x3c/0x90
  [<c0104cd0>] do_general_protection+0x0/0x1d0
  [<c0102fe7>] do_notify_resume+0x37/0x3c
  [<c01031a6>] work_notifysig+0x13/0x15
Code: f3 39 fb 8b 36 75 f2 83 c4 0c 5b 5e 5f 5d c3 8b 43 0c 89 6c 24 04 c7 04 24 
40 b9 96 e0 89 44 24 08 e8 e3 56 7b df 8b 53 04 8b 03 <89> 50 04 89 02 c7 43 04 
00 02 20 00 c7 03 00 01 10 00 89 1c 24
  <1>Fixing recursive fault but reboot is needed!


-- 
"There are two major products that came out of Berkeley: LSD and UNIX.
   We don't believe this to be a coincidence." --Jeremy S. Anderson
