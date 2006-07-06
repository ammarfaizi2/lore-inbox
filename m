Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbWGFDLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbWGFDLN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 23:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWGFDLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 23:11:13 -0400
Received: from terminus.zytor.com ([192.83.249.54]:21383 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965150AbWGFDLM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 23:11:12 -0400
Message-ID: <44AC7F46.3050204@zytor.com>
Date: Wed, 05 Jul 2006 20:11:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@linuxmail.org>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: Re: [klibc 30/31] Remove in-kernel resume-from-disk invocation code
References: <klibc.200606272217.00@tazenda.hos.anvin.org> <44AC5F5C.7070907@zytor.com> <200607061145.08590.ncunningham@linuxmail.org> <200607061218.39202.ncunningham@linuxmail.org>
In-Reply-To: <200607061218.39202.ncunningham@linuxmail.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi again.
> 
> (Excuse me replying to myself, but this might help someone else).
> 
> On Thursday 06 July 2006 11:45, Nigel Cunningham wrote:
>> Is there a klibc howto somewhere? I tried googling for 'klibc howto',
>> reading the files in Documentation/ and browsing your klibc mailing list
>> archive before asking!
> 
>> What I'm wondering specifically is: Say a user needs to run some commands
>> to set up access to encrypted storage before they can resume. At the
>> moment, we'd tell them to put these commands and the echo > do_resume in
>> their linuxrc (or init) script prior to mounting their root filesystem.
>> Forgive me if I'm asking a stupid question but it's not immediately obvious
>> to me how they would now do that. I'd much rather follow a simple howto
>> than spend a good amount of time tracing function calls etc. I still see
>> init/initramfs.c, and it mentions both CONFIG_BLK_DEV_INITRD and
>> CONFIG_BLK_DEV_RAM. Would I be right in surmising that you can still have
>> an initrd or ramfs to do such things as the above, after klibc has done its
>> work? If not, is there some other way I'm ignorant of?
> 
> For the record, I've since discovered that what you really want is an 
> initramfs howto. I think I stuck with those old-fangled initrds for too long. 
> Better update my desktop from Mandrake 10 too :)... is there a pattern here?
> 

Okay, let's try to start from the beginning...

initramfs is, indeed, a replacement for initrd, but it's not a 1:1 map. 
  Instead, initramfs contents -- which can come from multiple sources! 
-- is simply extracted right into rootfs.

kinit is a replacement for the in-kernel root-handling code, as well as 
other related in-kernel code like resume from disk.  It is compiled as a 
monolithic binary for size reasons.

klibc is a very small C library which *can* be used to produce initramfs 
binaries; in particular, it's used to produce kinit, and is small enough 
that it can be realistically included with the kernel distribution.

If you provide your own /init in an initramfs, it will override the 
default, which is /init -> /kinit.  You can then choose to invoke kinit 
if you want to; for example, you could try to resume from suspend2, and 
invoke kinit if that fails.

	-hpa
