Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbUL0Psl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbUL0Psl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbUL0Psk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:48:40 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:16914 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S261915AbUL0PsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:48:18 -0500
Message-ID: <41D02EBD.80600@benton987.fsnet.co.uk>
Date: Mon, 27 Dec 2004 15:48:13 +0000
From: Andrew Benton <andy@benton987.fsnet.co.uk>
User-Agent: Mozilla Thunderbird 0.6+ (X11/20041223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 and speedtouch usb
References: <200412271108.47578.zztchesmeli@echo.fr> <41D00D67.1010307@benton987.fsnet.co.uk> <200412271433.28454.zztchesmeli@echo.fr>
In-Reply-To: <200412271433.28454.zztchesmeli@echo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Tchesmeli wrote:
> Le Lundi 27 Décembre 2004 14:25, Andrew Benton a écrit :
> 
>>Serge Tchesmeli wrote:
>>
>>>Hi,
>>>
>>>i have try the new kernel 2.6.10, compil with exactly the same option
>>>from my 2.6.9 (i have copied the .config) but i notice a high load on my
>>>machine, and i see that was syslogd.
>>>So, i look at my log and see:
>>>
>>>Dec 26 19:40:44 gateway last message repeated 137 times
>>>Dec 26 19:40:46 gateway kernel: usb 2-1: events/0 timed out on ep0in
>>>Dec 26 19:40:46 gateway kernel: SpeedTouch: Error -110 fetching device
>>>status Dec 26 19:40:46 gateway kernel: usb 2-1: modem_run timed out on
>>>ep0in Dec 26 19:40:46 gateway kernel: usb 2-1: usbfs: USBDEVFS_CONTROL
>>>failed cmd modem_run rqt 192 rq 18 len 8 ret -110
>>
>>Are you using the kernel or userspace driver?
> 
> 
> I'm using the kernel speedtouch driver.
> 
Well it looks like modem_run is giving you problems. If you want you could do 
without it and  let the kernel load the firmware itself. To try this you will 
need to  prepare the firmware by splitting it into two parts To do that you'll 
need a copy of the speedtouch-1.3.1 driver
http://prdownloads.sourceforge.net/speedtouch/speedtouch-1.3.1.tar.gz?download
untar it and cd into the speedtouch-1.3.1/src folder and then enter

gcc -o firmware firmware.c -DSTANDALONE_EXTRACTER

That will compile a binary called firmware. You can use that to split  the 
modems firmware into two parts. If (for example) the firmware is  called mgmt.o, 
copy it into the speedtouch-1.3.1/src folder and then enter

./firmware mgmt.o
mv boot.bin speedtch-1
mv firmware.bin speedtch-2

That will create two files, boot.bin and firmware.bin. Rename boot.bin  -> 
speedtch-1 and firmware.bin -> speedtch-2. Then you need to copy  these two 
speedtch files into hotplugs firmware folder. You can find  this by reading 
/etc/hotplug/firmware.agent

cat /etc/hotplug/firmware.agent | grep FIRMWARE_DIR=

Make sure you enabled hotplug firmware loading in your kernel config
CONFIG_FW_LOADER=y
and check that hotplug has this line in /etc/hotplug/usb.usermap

speedtouch 0x0003 0x06b9 0x4061 0x0000 0x0000 0x00 0x00 0x00 0x00 0x00  0x00 
0x00000000
