Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUJ3VlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUJ3VlD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 17:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUJ3VlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 17:41:03 -0400
Received: from pils.us-lot.org ([212.67.207.13]:22283 "EHLO pils.us-lot.org")
	by vger.kernel.org with ESMTP id S261345AbUJ3VjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 17:39:17 -0400
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Paulo da Silva <psdasilva@esoterica.pt>, linux-kernel@vger.kernel.org
Subject: Re: k 2.6.9: ub module causes /dev/sda and /dev/sda1 not being
 created
References: <mailman.1099103401.11097.linux-kernel2news@redhat.com>
	<20041030091522.6f2da605@lembas.zaitcev.lan>
From: Adam Sampson <azz@us-lot.org>
Organization: Things I did not know at first I learned by doing twice.
Date: Sat, 30 Oct 2004 22:39:07 +0100
In-Reply-To: <20041030091522.6f2da605@lembas.zaitcev.lan> (Pete Zaitcev's
 message of "Sat, 30 Oct 2004 09:15:22 -0700")
Message-ID: <y2a654ryjgk.fsf@cartman.at.fivegeeks.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> writes:

> This is intentional. The ub takes over certain functions of usb-storage
> when it is configured in. Is it a problem? If yes, why?

This happened to me too.

If you build both ub and usb_storage as modules and only load
usb_storage, then you can't use USB Storage devices any more:
usb_storage doesn't get attached to them (you end up with Driver=none
in /proc/bus/usb/devices). Since ub doesn't appear work with my
unbranded el-cheapo card reader, I wasn't able to use it until I
removed ub from my kernel config and rebuilt.

A friend's got a USB hard disk, and has the same problem with
usb_storage not getting used any more; I don't think he's tried ub
yet, but it's clearly the wrong thing to use for the job anyway.

This is how my card reader appears in /proc/bus/usb/devices with only
usb_storage built as a module:

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#= 35 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0d7d ProdID=0240 Rev= 1.00
S:  Manufacturer=
S:  Product=USB Reader
S:  SerialNumber=FF0390500928
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   2 Ivl=1ms

And these are the errors that I got from ub when trying to mount a
card:

Wed Oct 27 19:54:27 2004 warning: ub: sizeof ub_scsi_cmd 60 ub_dev 924
Wed Oct 27 19:54:27 2004 info: uba: device 3 capacity nsec 50 bsize 512
Wed Oct 27 19:54:27 2004 warning: uba: made changed
Wed Oct 27 19:54:27 2004 info: uba: device 3 capacity nsec 50 bsize 512
Wed Oct 27 19:54:27 2004 info: uba: device 3 capacity nsec 50 bsize 512
Wed Oct 27 19:54:27 2004 info:  uba:end_request: I/O error, dev uba, sector 0
Wed Oct 27 19:54:27 2004 err: Buffer I/O error on device uba, logical block 0
Wed Oct 27 19:54:27 2004 warning: end_request: I/O error, dev uba, sector 2
Wed Oct 27 19:54:27 2004 err: Buffer I/O error on device uba, logical block 1
Wed Oct 27 19:54:27 2004 warning: end_request: I/O error, dev uba, sector 4
Wed Oct 27 19:54:27 2004 err: Buffer I/O error on device uba, logical block 2
Wed Oct 27 19:54:27 2004 warning: end_request: I/O error, dev uba, sector 6
Wed Oct 27 19:54:27 2004 err: Buffer I/O error on device uba, logical block 3
Wed Oct 27 19:54:27 2004 warning: end_request: I/O error, dev uba, sector 6
Wed Oct 27 19:54:27 2004 err: Buffer I/O error on device uba, logical block 3
Wed Oct 27 19:54:27 2004 warning: end_request: I/O error, dev uba, sector 4
Wed Oct 27 19:54:27 2004 err: Buffer I/O error on device uba, logical block 2
Wed Oct 27 19:54:27 2004 warning: end_request: I/O error, dev uba, sector 2
Wed Oct 27 19:54:27 2004 err: Buffer I/O error on device uba, logical block 1
Wed Oct 27 19:54:27 2004 warning: end_request: I/O error, dev uba, sector 0
Wed Oct 27 19:54:27 2004 err: Buffer I/O error on device uba, logical block 0
Wed Oct 27 19:54:27 2004 warning:  unable to read partition table
Wed Oct 27 19:54:27 2004 info:  uba:end_request: I/O error, dev uba, sector 2
Wed Oct 27 19:54:27 2004 err: Buffer I/O error on device uba, logical block 1
Wed Oct 27 19:54:27 2004 warning: end_request: I/O error, dev uba, sector 4
Wed Oct 27 19:54:27 2004 err: Buffer I/O error on device uba, logical block 2
Wed Oct 27 19:54:27 2004 warning: end_request: I/O error, dev uba, sector 6
Wed Oct 27 19:54:27 2004 err: Buffer I/O error on device uba, logical block 3
Wed Oct 27 19:54:27 2004 warning: end_request: I/O error, dev uba, sector 0
Wed Oct 27 19:54:27 2004 err: Buffer I/O error on device uba, logical block 0
Wed Oct 27 19:54:27 2004 warning:  unable to read partition table
Wed Oct 27 19:54:27 2004 info: usbcore: registered new driver ub
Wed Oct 27 19:55:27 2004 warning: uba: made changed
Wed Oct 27 19:55:27 2004 info: uba: device 3 capacity nsec 50 bsize 512
Wed Oct 27 19:55:27 2004 info: uba: device 3 capacity nsec 50 bsize 512
Wed Oct 27 19:55:27 2004 info:  uba:end_request: I/O error, dev uba, sector 2
Wed Oct 27 19:55:27 2004 err: Buffer I/O error on device uba, logical block 1
Wed Oct 27 19:55:27 2004 warning: end_request: I/O error, dev uba, sector 4
Wed Oct 27 19:55:27 2004 err: Buffer I/O error on device uba, logical block 2
Wed Oct 27 19:55:27 2004 warning: end_request: I/O error, dev uba, sector 6
Wed Oct 27 19:55:27 2004 err: Buffer I/O error on device uba, logical block 3
Wed Oct 27 19:55:27 2004 warning: end_request: I/O error, dev uba, sector 0
Wed Oct 27 19:55:27 2004 err: Buffer I/O error on device uba, logical block 0
Wed Oct 27 19:55:27 2004 warning: end_request: I/O error, dev uba, sector 2
Wed Oct 27 19:55:27 2004 err: Buffer I/O error on device uba, logical block 1
Wed Oct 27 19:55:27 2004 warning: end_request: I/O error, dev uba, sector 4
Wed Oct 27 19:55:27 2004 err: Buffer I/O error on device uba, logical block 2
(etc.; lots more "Buffer I/O error" lines)

-- 
Adam Sampson <azz@us-lot.org>                        <http://offog.org/>
