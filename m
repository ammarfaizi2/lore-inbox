Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbTFNIoB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 04:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265656AbTFNIoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 04:44:01 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:24083 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S265655AbTFNIn5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 04:43:57 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.21-rc7 hang on boot after spurious 8259A interrupt: IRQ15.
Date: Sat, 14 Jun 2003 16:57:19 +0800
User-Agent: KMail/1.5.2
Cc: Vojtech Pavlik <vojtech@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200306130958.39707.mflt1@micrologica.com.hk> <200306141124.09882.mflt1@micrologica.com.hk> <1055578663.7651.1.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1055578663.7651.1.camel@dhcp22.swansea.linux.org.uk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306141657.19854.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 June 2003 16:17, Alan Cox wrote:
> > The system executes a regular boot from _reset_ at this stage.
> > swsusp takes over once the kernel is up and restores the
> > suspended kernel
> > Could it be that the kernel does not handle a spurious int at
> > this early stage in the boot process ?
>
> It may also be BIOS SMI handling or reset handling problems as a
> similar case a vendor investigated showed to be. The first thing is
> to make life easier for the BIOS - make sure your kernel doesnt have
> APIC support included

APIC is not in the kernel

I put 

  __asm__("int $0x2f");

before calibrate_delay and inside as well for testing.
spurious 8259A int15 was reported  and up to 18000 counted in 
/proc/interrupts, but no hang ;-) 

I suppose have to settle for hardware/BIOS (IRQ misrouted/8259 
init problem or timer not working) as the cause for the hang

Regards
Michael

-- 
Powered by linux-2.5.70-mm3, compiled with gcc-2.95-3

My current linux related activities in rough order of priority:
- Testing of Swsusp for 2.4
- Research of NFS i/o errors during transfer 2.4>2.5
- Learning 2.5 series kernel debugging with kgdb - it's in the -mm tree
- Studying 2.5 series serial and ide drivers, ACPI, S3
* Input and feedback is always welcome *

