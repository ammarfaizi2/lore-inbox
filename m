Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbTIORG2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 13:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbTIORG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 13:06:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:61597 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261554AbTIORG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 13:06:26 -0400
Date: Mon, 15 Sep 2003 10:03:14 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Joshua Kwan <joshk@triplehelix.org>
cc: <linux-kernel@vger.kernel.org>, <pavel@ucw.cz>
Subject: Re: Swsusp weirdness with ACPI
In-Reply-To: <20030913210722.GA264@anemic>
Message-ID: <Pine.LNX.4.33.0309150955360.950-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Here is my /proc/acpi/sleep:
> S0 S3 S4 S4bios S5
> 
> - 0 doesn't seem to do anything.

0 is 'On'. It will not do anything. 

> - 3 will ONLY 'suspend' my laptop if all my USB devices are disconnected
>   and I have removed my PCMCIA cards.

Do you physically have to remove the devices or can you simply remove the 
modules? 

>   Furthermore, it won't resume. The fan will spin up, etc., but the LCD
>   will not turn on.

Noted. This is a common problem that we're trying to get to the bottom of. 


> - 4 nearly works. When it's suspending there will be an oops that flies
>   by too quickly to read. It will turn off though, but when I reboot it,
>   my swap partition will have been hosed:
> 
>   "Unable to find swap-space signature" when trying to swapon
>   
>   "PM: Reading swsusp image.
>   swsusp: Resume From partition: hda7, Device: unknown-block(0,0)
>   Resume Machine: Error -6 resuming
>   PM: Resume from disk failed." when I try to resume.
> 
>   I have to mkswap it again for stuff to work.

Interesting. That backtrace and the cause (whether it's an actual Oops, a 
BUG() or a WARN_ON()) is important. Is there anyway you could hook up a 
serial console to capture the output? 

Also, if you're willing, I would recommend trying 2.6.0-test5-mm2, which
will allow you to try the original swsusp code (via /proc/acpi/sleep)
independently of the more recent suspend-to-disk code (via 
/sys/power/state).

Thanks,


	Pat

