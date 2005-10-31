Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVJaL5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVJaL5Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 06:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVJaL5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 06:57:25 -0500
Received: from plasma-gate.weizmann.ac.il ([132.77.150.54]:34968 "EHLO
	plasma-gate.weizmann.ac.il") by vger.kernel.org with ESMTP
	id S932066AbVJaL5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 06:57:24 -0500
Message-ID: <43660693.6040601@weizmann.ac.il>
Date: Mon, 31 Oct 2005 13:57:07 +0200
From: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
Organization: Weizmann Institute of Science
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jonathan@jonmasters.org
CC: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix floppy.c to store correct ro/rw status in underlying
 gendisk
References: <4363B081.7050300@jonmasters.org> <35fb2e590510291035n297aa22cv303ae77baeb5c213@mail.gmail.com>
In-Reply-To: <35fb2e590510291035n297aa22cv303ae77baeb5c213@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Masters wrote:

> Let me know if this fixes it for you - should bomb out now if you try.
> The error isn't the cleanest (blame mount), but it does fail.

This works fine, thanks! For what it worth, though, mount -o remount,rw 
says remounting read-only yet still returns success. (Opposite to 
busybox, which now says "Permission denied" - rather misleading, but at 
least it fails).

My question is, shouldn't it be implemented at a more generic level? 
Floppy is just one example. Others are all kind of USB storage, ZIP/Jazz 
drives, and even normal SCSI disks (which have a RO jumper - at least 
some of them do).

I got an ancient USB disk on key with a write-protection switch. When I 
plug it in in the RO mode, everything goes exactly as it was (before 
your patch) with floppy. Now something interesting:
1. The thingy is plugged in RW and mounted
2. While connected, I switch it to RO
   dmesg says:
   -> SCSI device sda: 129024 512-byte hdwr sectors (66 MB)
   -> sda: Write Protect is on
   -> sda: Mode Sense: 03 00 80 00
   -> sda: assuming drive cache: write through
3.
# mount -o remount,rw  /mnt
mount: block device /dev/sda1 is write-protected, mounting read-only
# echo $?
0

So it seems there is some layer in bd which does know about RO status 
(and furthermore it's set by hot events)?

Regards,

Evgeny
