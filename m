Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273611AbTHPPH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 11:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273906AbTHPPH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 11:07:27 -0400
Received: from out004pub.verizon.net ([206.46.170.142]:42981 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S273611AbTHPPHY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 11:07:24 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Martin Schlemmer <azarah@gentoo.org>
Subject: Re: increased verbosity in dmesg
Date: Sat, 16 Aug 2003 11:07:21 -0400
User-Agent: KMail/1.5.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200308160438.59489.gene.heskett@verizon.net> <1061030883.13257.253.camel@workshop.saharacpt.lan>
In-Reply-To: <1061030883.13257.253.camel@workshop.saharacpt.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308161107.21430.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.12.137] at Sat, 16 Aug 2003 10:07:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 August 2003 06:48, Martin Schlemmer wrote:
>On Sat, 2003-08-16 at 10:38, Gene Heskett wrote:
>> Greetings;
>>
>> The recently increased verbosity in the dmesg file is causeing the
>> "ring buffer" to overflow, and I am not now seeing the first few
>> pages of the reboot in the dmesg file.
>>
>>
>> Is there any quick and dirty way to increase this to at least 32k,
>> or maybe even to 64k?  With half a gig of memory, this shouldn't
>> be a problem should it?
>
> # dmesg -s 30000
>
>Works here.

Doesn't here.  Example:
[root@coyote root]# dmesg -s 30000 >/tmp/dmesg;ls -l /tmp/dmesg
-rw-r--r--    1 root     root        15496 Aug 16 10:57 /tmp/dmesg

And actually starts up in the middle of the usb stuffs because of the 
size limitation.

Here is a head of the file itself after this last boot.
: registered new driver usbdevfs
usb.c: registered new driver hub
host/usb-uhci.c: $Revision: 1.275 $ time 13:51:40 Aug 15 2003
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 9
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1

etc, etc

Besides, used that way its a read option, and I'm asking about the 
size of the ring being used during the boot for message storage 
before any drives are mounted in writable modes.  Its many kilobytes 
insufficient, and because of pointer wrap, being overwritten before 
the syslog is up and running, and the file 'dmesg' itself is actually 
written to non-volatile storage.

Adjusting this is not an 'after boot' operation as above, but a 
src-code setting buried in the kernel code someplace.  I have NDI how 
interlocked it is with everything else, which is why I was hopeing 
someone could point me and pull the trigger.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

