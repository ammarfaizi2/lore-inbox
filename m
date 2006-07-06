Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWGFNDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWGFNDN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 09:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWGFNDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 09:03:13 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:15547 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030249AbWGFNDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 09:03:12 -0400
Date: Thu, 6 Jul 2006 15:02:52 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: CDROMEJECT (or START_STOP(2)) completely disables USB flash
 stick
In-Reply-To: <200607061310.14526.arvidjaar@mail.ru>
Message-ID: <Pine.LNX.4.61.0607061458520.11738@yvahk01.tjqt.qr>
References: <200607061310.14526.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>While working on some HAL issues I hit some not clear - to me at least - 
>behavior. I was testing HAL Eject method that under Linux effectively 
>calls 'eject /dev/block'. Now for USB stick - at least, that I have, this 
>results in "ejecting medium" without apparently any way to get it back (the 
>only way is to replug stick).

I suppose eject does the same as `sdparm -C eject`, and yes, it does not 
seem like you can reload an USB stick with the opposite of eject, `sdparm 
-C load` (at least these are the commands that work for CDROM devices).

>{pts/0}% LC_ALL=C sudo blockdev --rereadpt /dev/sda
>/dev/sda: No medium found
>
>I tried 'sdparm -C start' without much success as well:
>
>{pts/0}% LC_ALL=C sudo sdparm -v -C start /dev/sda
>    /dev/sda:           128MB             2.00
>    Start stop unit command: 1b 00 00 00 01 00
>{pts/0}% LC_ALL=C sudo blockdev --rereadpt /dev/sda
>/dev/sda: No medium found
>
>Well, I just try to understand if this is a expected (and reasonable) 
>behaviour or a bug in hardware or possibly software?

I cannot close the tray of the CDROM drive with -C start (or -C ready), so 
I doubt the same will be true for USB sticks.

Maybe all of this is a limitation of USB sticks - I got to check it with 
real USB harddisks or hotswap SCA disks.


Jan Engelhardt
-- 
