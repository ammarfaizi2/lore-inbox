Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265342AbUFSB6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265342AbUFSB6v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 21:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbUFSB6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 21:58:51 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:11973 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S265342AbUFSB6q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 21:58:46 -0400
Message-ID: <40D39DF4.3010102@blue-labs.org>
Date: Fri, 18 Jun 2004 21:59:16 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ov511 [2.6.7-rc3] does something odd
References: <468F3FDA28AA87429AD807992E22D07E017B977D@orsmsx408>
In-Reply-To: <468F3FDA28AA87429AD807992E22D07E017B977D@orsmsx408>
Content-Type: multipart/mixed;
 boundary="------------050102010802010509020606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050102010802010509020606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ov511 driver is a webcam driver, not a NIC.

What I'm getting, is this blurb below, and the camera wigs out.  I get 
unsynched video over a partial frame and a memory image from the last 
good frame.  I.e. if the camera breaks at noon, the bottom half of the 
image sent from the camera -might- remain as an imprint from that image 
for however long until it blurbs again.  The top half of the image sent 
from the webcam is an unsynchronised gray green image.  I.e. diagonal 
stripes of an image.

This isn't 100% the same every time.  Sometimes it's reversed.  
Sometimes the top 1/2 is the live half that is "working" except the top 
half is actually a full HxW frame that's squished vertically into 
approximately the top 1/2.

Now I'm only going to blame half of this on the ov511 driver.  Here's 
why; every N minutes which seems random, this machine burps.  It seems 
that all interrupts are..interrupted.  The HD LED goes solid, sound bits 
loop like a broken record, keyboard and mice halt, and the video output 
is lost.  This burp lasts for about 5-7 seconds.

When the machine recovers, everything is normal -except- the ov511 
device.  All other devices resume operation as expected -- and the 
kernel is none the wiser it seems.  Nothing appears in dmesg.

David

Venkatesan, Ganesh wrote:

>David/Jens:
>
>What Intel NICS are you seeing this failure in? Could you send me a
>lspci -vvv for the device? Also an ethtool -I eth?.
>
>Thanks,
>ganesh 
> 
>-------------------------------------------------
>Ganesh Venkatesan
>Network/Storage Division, Hillsboro, OR
>
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of David Ford
>Sent: Tuesday, June 15, 2004 4:38 PM
>To: linux-kernel mailing list
>Subject: ov511 [2.6.7-rc3] does something odd
>
>usb 2-1.3: new full speed USB device using address 7
>DEV: registering device: ID = '2-1.3'
>PM: Adding info for usb:2-1.3
>bus usb: add device 2-1.3
>bound device '2-1.3' to driver 'usb'
>DEV: registering device: ID = '2-1.3:1.0'
>PM: Adding info for usb:2-1.3:1.0
>bus usb: add device 2-1.3:1.0
>drivers/usb/media/ov511.c: USB OV511 video device found
>drivers/usb/media/ov511.c: model: AverMedia InterCam Elite
>drivers/usb/media/ov511.c: Sensor is an OV7610
>CLASS: registering class device: ID = 'video0'
>class_hotplug - name = video0
>drivers/usb/media/ov511.c: Device at usb-0000:00:10.0-1.3 registered to 
>minor 0
>bound device '2-1.3:1.0' to driver 'ov511'
>stack segment: 0000 [1] PREEMPT
>CPU 0
>Modules linked in:
>Pid: 6806, comm: camsource Not tainted 2.6.7-rc3
>RIP: 0010:[<ffffffff803a9906>] <ffffffff803a9906>{ov51x_v4l1_ioctl+38}
>RSP: 0018:000001003c4edf18  EFLAGS: 00010216
>RAX: 000001003fefe920 RBX: 6b6b6b6b6b6b6c13 RCX: 00000000407ff760
>RDX: 0000000040107613 RSI: 000001003a1d5a88 RDI: 6b6b6b6b6b6b6c13
>RBP: 6b6b6b6b6b6b6b6b R08: 0000000000524f80 R09: 000001003d714c08
>R10: 00000000407ff738 R11: 0000000000000246 R12: 00000000407ff760
>R13: 0000000000000000 R14: 0000000000000007 R15: 00000000ffffffe7
>FS:  00000000407ff960(005b) GS:ffffffff80737b00(0000)
>knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>CR2: 0000002a9e5c8000 CR3: 0000000000101000 CR4: 00000000000006e0
>Process camsource (pid: 6806, threadinfo 000001003c4ec000, task 
>000001003e1b2430)
>Stack: 0000000040107613 0000000040107613 000001003a1d5a88
>ffffffff801ad8bd
>       0000000000000000 000000003b8658f4 0000000000000000
>00000000005250c0
>       00000000407ff760 0000000000525040
>Call Trace:<ffffffff801ad8bd>{sys_ioctl+685} 
><ffffffff8011221a>{system_call+126}
>
>
>Code: ff 8d a8 00 00 00 0f 88 8a 2c 00 00 31 c0 85 c0 41 b8 fc ff
>RIP <ffffffff803a9906>{ov51x_v4l1_ioctl+38} RSP <000001003c4edf18>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

--------------050102010802010509020606
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------050102010802010509020606--
