Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbTHaBJv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 21:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTHaBJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 21:09:50 -0400
Received: from k-kdom.nishanet.com ([65.125.12.2]:25867 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S262317AbTHaBJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 21:09:48 -0400
Message-ID: <3F5147F9.6060102@boxho.com>
Date: Sat, 30 Aug 2003 20:57:29 -0400
From: Resident Boxholder <resid@boxho.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: undisclosed-recipients:;
Subject: Re: 2.6.0-test4-mm2: promise again fdisk causes Oops
References: <5.1.0.14.2.20030830152430.01be2350@caffeine.cc.com.au>
In-Reply-To: <5.1.0.14.2.20030830152430.01be2350@caffeine.cc.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

If you'd like to get a null modem cable and contribute logs about the 
promise that should help. If you'd like to get back to work, promise ide 
cards, uh, aren't great for linux right now. I switched to a siig card.

"disabling the promise controller in bios", generally if you disable 
anything in bios and have linux code in the kernel for it, the thing 
will be found and enabled by linux until you take the relevent code out 
of your kernel or rip the card out of your box. You don't want to take 
the promise code out and have generic code make do, either, so try 
taking the card out!

"promise controller", I started with two, took one and its cd's out, 
played with hdparm, disabled nforce2 ethernet and usb and serial and 
parallel and winmodem and audio(shame, it's the surround sound mcpt), 
disable apic so linux can enable it(!), finally took the promise card 
out and put in a Silicon Image 680 chip siig controller card. With the 
promise in the promise drives would crash the system in any config but I 
could run 32io unmask irq udma6 on mbo drives only with no errors. With 
the SiImage.c driver and SiI680 chip unmask off is needed(according to 
siimage.c doc, and IN FACT) also hdparm -d1 -c1 -p9 -u0 -X70 on the siig 
and still needed unmask off on the mbo controller to keep raid from 
crashing hdparm -d1 -c1 -p4 -u0 -X70 on the mbo controller. -u0 turns 
unmask off.

Siig SiI680 chip works without errors on a four-drive linux software 
raid as long as I do the hdparms, bios turn off apic, usb, ethernet, 
audio, serial, parallel, winmodem, use a card for ethernet. Nvidia says 
set "non-pnp os" but I didn't find that helpful, had to turn onboard 
audio and ethernet off and pnp-os is on(kern 2.6.0-t4 MSI nforce2 
k7ndelta mbo amd xp 3000+ cpu pc3200csl2 ddr, 4 Maxtor 8mbcache 60G's, 
amd74xx driver on mbo controller and siimage.c on SiI680 card).

I could crash both promise and SiI680 with fdisk, mke2fs, mkreiserfs, 
e2fsck, reiserfsck, mdadm -C, mdadm -A, but the relevent conflicts were 
hdparm -u0 the sii680 and conflicts between promise and sii680(cmd680) 
and usb and onboard ethernet and...there was no fix for promise but siig 
CAN work in a no-frills server setup.

The usb code is being worked on as far as conflicts.

cp -aR /usr /tmp should break the promise setup if it's going to break.

-Bob D

Peter Lieverdink wrote:

> FYI: I can't reproduce this under 2.6.0-test4-mm3-1
>
> - Peter.
> -- 
> At 15:12 29/08/2003 +1000, you wrote:
>
>> Hi,
>>
>> When running fdisk -l under 2.6.0-test4-mm2, the kernel oopses. dmesg,
>> the oops (fdisk.txt) and output from lspci are attached.
>>
>> I've tried after disabling the Promise controller in the BIOS, but the
>> oops still occurs. Same when I specify a device instead of -l.
>>
>> fdisk is from debian/unstable, version 2.11z
>>
>> - Peter. 
>
>

