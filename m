Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbULCRA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbULCRA6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbULCRA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:00:58 -0500
Received: from mail.tmr.com ([216.238.38.203]:39347 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S262369AbULCRAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:00:48 -0500
Message-ID: <41B09D4B.3090906@tmr.com>
Date: Fri, 03 Dec 2004 12:07:23 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Waychison <Michael.Waychison@Sun.COM>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: wakeup_pmode_return jmp failing?
References: <41B084B4.1050402@sun.com>
In-Reply-To: <41B084B4.1050402@sun.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> Not sure who to direct this to.  I've been trying to get acpi s3 to work
> on my pentium M laptop (tecra m2).  Without the nvidia driver loaded, I
> can echo 3 > /proc/acpi/sleep and the machine does indeed suspend (power
> light throbs and all).  However, when I try to wake up the thing, it
> would flash the bios screen and throw me back to grub.
> 
> I've been investigating the code at arch/i386/kernel/acpi/wakeup.S, and
> have discovered that if I place a busy wait directory before the ljmpl
> to wakeup_pmode_return, that I indeed do see 'Lin' on the screen instead
> of the bios screen.
> 
> The joke is, if I place a busy wait first thing after the
> wakeup_pmode_return label, it never gets executed and I get a regular boot.
> 
> It would appear as though the jump from 16bit code into the 32bit code
> is failing and the bios is kicking in with a regular startup.
> 
> Anybody have any suggestions?

Install a 2.4 kernel with apm enabled and use that.

That's serious, I have an IBM, Tecra, Dell, and Acer, and 5-6 friends 
running Linux on laptops. Every one (other than the Acer) works with 
"apm -s" and recovers. Some work with "apm -S". The Acer never had a 2.4 
kernel, and I haven't rebuilt with apm on 2.6 (or even looked to see if 
it was supported). All of these suspend fine with ACPI, none ever wakes up.

Is suspend even supposed to be generally functional? I thought it was a 
WIP not expected to work except on certain models which have been hand 
tuned by the developers. In fact I have a message somewhere saying you 
have to get out of X to a text console, manually shutdown the network, 
and then it might work. Then start everything up again.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
