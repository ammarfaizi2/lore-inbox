Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269659AbTHOQTo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270219AbTHOQNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:13:47 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S269523AbTHOQJz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:09:55 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Alan Stern <stern@rowland.harvard.edu>,
       Peter Denison <lkml@marshadder.uklinux.net>
Subject: Re: [linux-usb-devel] 2.4.21 USB printer failure w/ HP PSC750
Date: Fri, 15 Aug 2003 10:37:32 -0400
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0308061619120.1249-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0308061619120.1249-100000@ida.rowland.org>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308151037.32368.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.12.207] at Fri, 15 Aug 2003 09:37:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 August 2003 16:30, Alan Stern wrote:
>On Wed, 6 Aug 2003, Peter Denison wrote:
>> Having just upgraded to 2.4.21, the first time I tried to print,
>> the following happened. The printer started to print, but gave up
>> after a while and spat out just about 1" of image. Needless to
>> say, it all worked fine under 2.4.20.
>>

I can confirm that this does not appear to be printer related, this 
nearly exact scenario just happened to me while running test3-mm2.  So 
I powered down the printer, in this case an Epson C82 being driven by 
cups, and then rebooted to 2.4.22-rc2.  Where it also refused to 
print, until I went to the local cups page and "started" both 
printers, which had been apparently disabled by the above failure and 
it carried over the reboot from 2.6.0-test3-mm2 to 2.4.22-rc2.  Once 
the printer was 'started' then the 3 jobs I'd sent were spit right out 
normally.

It appears that usblp still has problems as of 2.6.0-test3-mm2.

>From /var/log/messages:

Aug 15 09:59:23 coyote kernel: drivers/usb/class/usblp.c: usblp1: nonzero read/write bulk status received: -104
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -84 reading printer status
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -110 reading printer status
Aug 15 10:00:16 coyote last message repeated 79 times
Aug 15 10:00:16 coyote kernel: usb 1-2: USB disconnect, address 3
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -104 reading printer status
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote last message repeated 10 times
Aug 15 10:00:16 coyote kernel: ass/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote last message repeated 55 times
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer sass/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote last message repeated 55 times
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer sass/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote last message repeated 55 times
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer sass/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote last message repeated 55 times
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer s3>drivers/usb/class/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote last message repeated 55 times
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 rass/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote last message repeated 55 times
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer sass/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote last message repeated 55 times
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer sass/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote last message repeated 55 times
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer sass/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote last message repeated 55 times
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer sass/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote last message repeated 55 times
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer sass/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote kernel: drivers/usb/class/usblp.c: usblp1: error -19 reading printer status
Aug 15 10:00:16 coyote last message repeated 229 times
Aug 15 10:00:26 coyote kernel: drivers/usb/class/usblp.c: usblp1: removed
Aug 15 10:00:26 coyote kernel: Unable to handle kernel paging request at virtual address 00010021
Aug 15 10:00:26 coyote kernel:  printing eip:
Aug 15 10:00:26 coyote kernel: c027ffc7
Aug 15 10:00:26 coyote kernel: *pde = 00000000
Aug 15 10:00:26 coyote kernel: Oops: 0000 [#1]
Aug 15 10:00:26 coyote kernel: PREEMPT
Aug 15 10:00:26 coyote kernel: CPU:    0
Aug 15 10:00:26 coyote kernel: EIP:    0060:[<c027ffc7>]    Not tainted VLI
Aug 15 10:00:26 coyote kernel: EFLAGS: 00010202
Aug 15 10:00:26 coyote kernel: EIP is at usb_buffer_free+0x17/0x50
Aug 15 10:00:26 coyote kernel: eax: 00010001   ebx: c166a780   ecx: def42cc0   edx: c03c0b18
Aug 15 10:00:26 coyote kernel: esi: c166a784   edi: dfff46c0   ebp: d90f9f30   esp: d90f9f20
Aug 15 10:00:26 coyote kernel: ds: 007b   es: 007b   ss: 0068
Aug 15 10:00:26 coyote kernel: Process usb (pid: 12673, threadinfo=d90f8000 task=def42cc0)
Aug 15 10:00:26 coyote kernel: Stack: c51aa700 c166a780 c166a784 dfff46c0 d90f9f4c c0291b50 df838400 00002000
Aug 15 10:00:26 coyote kernel:        df5fe000 1f5fe000 c166a780 d90f9f64 c0291c53 c166a780 00000077 d3eabc00
Aug 15 10:00:26 coyote kernel:        00000000 d90f9f88 c0154b26 dc12ab90 d3eabc00 dc12ab90 dc101c80 d3eabc00
Aug 15 10:00:26 coyote kernel: Call Trace:
Aug 15 10:00:26 coyote kernel:  [<c0291b50>] usblp_cleanup+0x40/0xa0
Aug 15 10:00:26 coyote kernel:  [<c0291c53>] usblp_release+0x63/0x70
Aug 15 10:00:26 coyote kernel:  [<c0154b26>] __fput+0x116/0x130
Aug 15 10:00:26 coyote kernel:  [<c01530cb>] filp_close+0x8b/0xb0
Aug 15 10:00:26 coyote kernel:  [<c0153152>] sys_close+0x62/0xa0
Aug 15 10:00:26 coyote kernel:  [<c03560fb>] syscall_call+0x7/0xb
Aug 15 10:00:26 coyote kernel:
Aug 15 10:00:26 coyote kernel: Code: 14 89 44 24 0c ff 52 14 eb e1 8d 76 00 8d bc 27 00 00 00 00 55 89 e5 83 ec 10 8b 45 08 85 c0 74 18 8b 80 c8 00 00 00 85 c0 74 0e <8b> 50 20 85 d2 74 07 8b 4a 18 85 c9 75 02 c9 c3 89 04 24 8b 45
Aug 15 10:01:12 coyote shutdown: shutting down for system reboot
Aug 15 10:01:12 coyote init: Switching to runlevel: 6
[...]
Aug 15 10:01:19 coyote kernel: hub 1-0:0: new USB device on port 2, assigned address 4
Aug 15 10:01:19 coyote kernel: drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 4 if 0 alt 0 proto 2 vid 0x04B8 pid 0x0005
---------------------
the last 2 lines were output when I turned the printer back on while 
the shutdown was in progress.

All this because I wanted to print my flight itinerary for a
trip to Colorado expected to leave Sunday and be there, and out of
touch (probably, unless I can find a machine to take back to the
guest house), for 2 months.  I hope I don't forget howto type by 
the time I get back. :-)
 
And I hope 2.6 is a little closer to prime time by then.  So far
its been hit or miss, but looking better with each test release. :)

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

