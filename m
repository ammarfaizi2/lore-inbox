Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266281AbUGOUkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266281AbUGOUkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 16:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266250AbUGOUkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 16:40:45 -0400
Received: from larry.aptalaska.net ([64.186.96.3]:26543 "EHLO
	larry.aptalaska.net") by vger.kernel.org with ESMTP id S266281AbUGOUkn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 16:40:43 -0400
Message-ID: <40F6EBC6.7060205@aptalaska.net>
Date: Thu, 15 Jul 2004 12:40:38 -0800
From: Matthew Schumacher <matt.s@aptalaska.net>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       syslinux@zytor.com
Subject: Re: Possible bug with kernel decompressor.
References: <40F490B6.6000106@schu.net> <40F5AE63.5010505@am.sony.com> <40F6C504.9010403@aptalaska.net> <40F6DD54.5040308@zytor.com>
In-Reply-To: <40F6DD54.5040308@zytor.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Matthew Schumacher wrote:
> 
>>
>> I should note that this hardware requires the linux mem/memmap= params 
>> because of the buggy memory detection in the bios so I was required to 
>> use the uppermem command in grub to make it detect the memory and put 
>> the initrd image in the right place.
>>
> 
> Specify, please.
> 
>     -hpa

This is what I am using in grub and it works:

title Linux (2.6.8)
         root (hd0,0)
         uppermem 62464k
         kernel /linux26 memmap=exactmap memmap=640K@0 memmap=63M@1M 
console=ttyS0,9600n8 load_ramdisk=1 root=/dev/root ramdisk_size=32768 
ether=9,0x320,0,0x3c509,eth0 ether=10,0x330,0,0x3c509,eth1 ide0=ali14xx
	initrd /rootfs.gz

This is what I was using in syslinux that broke with "invalid compressed 
format (err=2)" after a improper shutdown (only ramdisk mounted).

  LABEL linux
   KERNEL linux26
   APPEND memmap=exactmap memmap=640K@0 memmap=63M@1M 
console=ttyS0,9600n8 load_ramdisk=1 initrd=rootfs.gz root=/dev/root 
ramdisk_size=32768 ether=9,0x320,0,0x3c509,eth0 
ether=10,0x330,0,0x3c509,eth1 ide0=ali14xx

hope that helps,

schu

