Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264282AbUEDUzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264282AbUEDUzL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 16:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbUEDUzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 16:55:11 -0400
Received: from av3-1-sn1.fre.skanova.net ([81.228.11.109]:13793 "EHLO
	av3-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S264282AbUEDUzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 16:55:04 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>,
       Hamie <hamish@travellingkiwi.com>, linux-kernel@vger.kernel.org
Subject: Re: uspend to Disk - Kernel 2.6.4 vs. r50p
References: <20040429064115.9A8E814D@damned.travellingkiwi.com>
	<20040503123150.GA1188@openzaurus.ucw.cz>
	<40965DAA.4040504@pointblue.com.pl> <20040503192940.GA3531@elf.ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 04 May 2004 22:55:00 +0200
In-Reply-To: <20040503192940.GA3531@elf.ucw.cz>
Message-ID: <m2pt9j29qz.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
> 
> > >Use echo 4 > /proc/acpi/sleep, and vanilla kernels.
> > >
> > >			
> > >
> > What If it happends that I have T22 Thinkpad, and it doesn't work with 
> > ACPI in 2.6 (causes problems with network cards for some reason, long 
> > and not yet fixed bug in ACPI), and I don't have /proc/acpi. How can I 
> > use swsusp than ?
> 
> I added entry to FAQ:
> 
> Q: My machine doesn't work with ACPI. How can I use swsusp than ?
> 
> A: Do reboot() syscall with right parameters. Warning: glibc gets in
> its way, so check with strace:
> 
> reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 0xd000fce2)
> 
> Ouch, and when you code that trivial program, send me source, I lost
> mine.

#include <unistd.h>
#include <syscall.h>

#define	LINUX_REBOOT_MAGIC1	0xfee1dead
#define	LINUX_REBOOT_MAGIC2	672274793
#define	LINUX_REBOOT_CMD_SW_SUSPEND	0xD000FCE2

int main()
{
    syscall(SYS_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
	    LINUX_REBOOT_CMD_SW_SUSPEND, 0);
    return 0;
}

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
