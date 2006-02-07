Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWBGHx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWBGHx3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 02:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWBGHx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 02:53:29 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:44241 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S965004AbWBGHx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 02:53:28 -0500
Message-ID: <43E85337.1090001@aitel.hist.no>
Date: Tue, 07 Feb 2006 08:58:47 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: alex-lists-linux-kernel@yuriev.com
CC: linux-kernel@vger.kernel.org
Subject: Re: non-fakeraid controllers
References: <20060207015126.GA12236@s2.yuriev.com>
In-Reply-To: <20060207015126.GA12236@s2.yuriev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alex-lists-linux-kernel@yuriev.com wrote:

>Hi,
>
>	This is not an attempt to start a religious flamewar about what is
>RAID vs. what is softraid vs. what is fakeraid. 
>
>	Does anyone has a list/refence/etc on reasonably modern SCSI
>controllers (at least u160) in a non-fakeraid way i.e. the way that would
>allow linux to boot from a RAID protected disk array when one of the drives
>in the array failed even if the root filesystem is located on the same
>array?
>  
>
Ability to boot requires bios/bootloader support. Depending on the bios in
question, this may work for real RAID, fakeraid or even linux sw raid.

You can boot directly from the software raid-1 in linux.  And you can set
it up so it will boot with one drive failed too - although you may have
to disconnect the bad drive so the biosdoesn't mistakenly try to load the
kernel bootloader from the damaged disk.

Having the root filesytem on a damaged array is not a problem - as soon
as the kernel is running it can activate the raid in degraded mode and
use the filesystem just fine.  This is no more secure than a single-disk 
setup
though, so don't wait too long before you replace the failed drive.

Fakeraid controllers may have bios support for booting, but often
you'll find that linux have no support for the fake raid.  So you have
to turn that off and use software raid instead.  An expensive "real raid"
controller that have linux support, will usually have a bios that support
booting from the raid too.  Writing to manufacturers should get you the
details on booting in degraded conditions.

Helge Hafting
