Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTLDK7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 05:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTLDK7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 05:59:24 -0500
Received: from ferreol-1-82-66-171-16.fbx.proxad.net ([82.66.171.16]:21267
	"EHLO diablo.hd.free.fr") by vger.kernel.org with ESMTP
	id S261464AbTLDK7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 05:59:22 -0500
Message-ID: <3FCF1381.7090507@free.fr>
Date: Thu, 04 Dec 2003 11:59:13 +0100
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Mike Fedyk <mfedyk@matchmail.com>, zwane@holomorphy.com,
       linux-kernel@vger.kernel.org, baldrick@free.fr
Subject: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <3FC4E8C8.4070902@free.fr>	<Pine.LNX.4.58.0311261305020.1683@montezuma.fsmlabs.com>	<20031126233738.GD1566@mis-mike-wstn.matchmail.com>	<3FC53A3B.50601@free.fr>	<20031202160303.2af39da0.rddunlap@osdl.org>	<20031203003106.GF4154@mis-mike-wstn.matchmail.com>	<20031202162745.40c99509.rddunlap@osdl.org>	<3FCDE506.7020302@free.fr>	<Pine.LNX.4.58.0312031409410.27578@montezuma.fsmlabs.com>	<3FCE877B.3010703@free.fr>	<20031204013408.GE29119@mis-mike-wstn.matchmail.com> <20031203201149.42f58e2a.rddunlap@osdl.org>
In-Reply-To: <20031203201149.42f58e2a.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> It seems possible that these commands (above) are flushing the kernel
> log buffer to disk (/var/log/messages e.g.), so that they don't need
> to be saved by kmsgdump.  Have you looked in the kernel message file
> for them?

You are right, the oops indeed makes it to the disk in that case, thanks!
Here follows a nice oops. Probably very easy to reproduce to any 
speedtouch owner by launching /etc/init.d/hotplug stop while modem_run 
is still running...


ehci_hcd 0000:00:10.3: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:10.3: USB bus 1 deregistered
diablo modem_run[1033]: Device disconnected, shutting down
uhci_hcd 0000:00:10.0: remove, state 1
usb usb2: USB disconnect, address 1
usb 2-1: USB disconnect, address 2
drivers/char/lirc/lirc_atiusb.c: USB Remote on #200 now disconnected
usb 2-2: USB disconnect, address 3
printing eip:
c8ae9822
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c8ae9822>]    Not tainted VLI
EFLAGS: 00010246
EIP is at releaseintf+0x62/0x80 [usbcore]
eax: 00000000   ebx: c6dcb024   ecx: c663c0c0   edx: 00000000
esi: c6dcb000   edi: 00000000   ebp: c595df0c   esp: c595def8
ds: 007b   es: 007b   ss: 0068
Process modem_run (pid: 1033, threadinfo=c595c000 task=c6ddc080)
Stack: c016ffe3 c6205ca4 c663c0c0 00000000 c7ff4dc0 c595df24 c8ae9c27 
c663c0c0
00000000 c6719f00 00000000 c595df48 c0157a5c c66ba4c0 c6719f00 c66ba4c0
c66d1a40 c6719f00 00000000 c6e10740 c595df64 c0156047 c6719f00 c6e10740
Call Trace:
[<c016ffe3>] iput+0x63/0x80
[<c8ae9c27>] usbdev_release+0xb7/0xc0 [usbcore]
[<c0157a5c>] __fput+0x10c/0x120
[<c0156047>] filp_close+0x57/0x80
[<c0123d17>] put_files_struct+0x67/0xd0
[<c012491e>] do_exit+0x15e/0x3e0
[<c0124c4a>] do_group_exit+0x3a/0xb0
[<c02a302e>] sysenter_past_esp+0x43/0x65

Code: 08 0f b3 51 40 19 c0 85 c0 75 18 89 d9 ff 46 24 0f 8e 34 23 00 00 
89 f8 8b 5d f4 8b 75 f8 8b 7d fc c9 c3 8b 86 90 01 00 00 31 ff <8b> 44 
90 0c c7 04 24 40 70 af c8 89 44 24 04 e8 da 6b ff ff eb
<0>Fatal exception: panic in 5 seconds

