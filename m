Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUG2NGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUG2NGi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 09:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUG2NGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 09:06:38 -0400
Received: from guardian.hermes.si ([193.77.5.150]:50957 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S264560AbUG2NGc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 09:06:32 -0400
Message-ID: <B1ECE240295BB146BAF3A94E00F2DBFF090202@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: David Balazic <david.balazic@hermes.si>,
       "'Matt Domsch'" <Matt_Domsch@dell.com>
Cc: Dave Jones <davej@redhat.com>, Andries Brouwer <aebr@win.tue.nl>,
       Jeff Garzik <jgarzik@pobox.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: RE: Weird:  30 sec delay during early boot
Date: Thu, 29 Jul 2004 15:05:10 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: 	Matt Domsch[SMTP:Matt_Domsch@dell.com]
> 
> On Wed, Jul 28, 2004 at 02:16:19PM +0200, David Balazic wrote:
> > The same delay as before.
> > 
> > I built 2.6.8-rc1 first, then patched and issued a "make bzImage";
> > maybe it did not compile all the new stuff ?
> 
> No, it didn't work for Jeff either, and I've been gone on vacation/OLS
> the past couple weeks, just now getting back into normal work mode.  I
> haven't forgotten about you.
> 
> The crazy thing is, the early real mode code has issued a "Get Disk
> Type" (int13 fn15) command for ages, so I suspect it's not being slow for
> disk 80 or 81, but for one of the higher values.  From setup.S:
> 
> # Check that there IS a hd1 :-)
>         movw    $0x01500, %ax
>         movb    $0x81, %dl
>         int     $0x13
>         jc      no_disk1
>         cmpb    $3, %ah
>         je      is_disk1
> 
> This is all I was trying to accomplish with that test patch.
> 
> David, you had said before that by downgrading your BIOS you no longer
> saw the delay.  Is this not still true?
> 
Still true, downgrading removes the delay.

> You also mentioned that Grub made different calls.  I'll check that
> out too.
> 
Can you make a patch, that only accesses hd0 and hd1 ?
Or one which prints what is it doing, on each step ?
( I tried this one myself, but it did not work :blush: , IA32 assembler
is not my strong side )

> Thanks,
> Matt
> 
> -- 
> Matt Domsch
> Sr. Software Engineer, Lead Engineer
> Dell Linux Solutions linux.dell.com & www.dell.com/linux
> Linux on Dell mailing lists @ http://lists.us.dell.com
> 
