Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266254AbUHII3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266254AbUHII3G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUHII3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:29:06 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:32130 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S266254AbUHII2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:28:50 -0400
Message-ID: <411735BD.3000303@eidetix.com>
Date: Mon, 09 Aug 2004 10:28:45 +0200
From: "David N. Welton" <davidw@eidetix.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jamesl@appliedminds.com
CC: Sascha Wilde <wilde@sha-bang.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
References: <auto-000000462036@appliedminds.com>
In-Reply-To: <auto-000000462036@appliedminds.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Lamanna wrote:

> Without having a USB keyboard plugged in, and having DEBUG #defined, can you post
> the command printks?
> I suspect that David posted the printks as his machine was starting up. What we
> really need to look at is what happens on shutdown and if one of those commands
> hangs for some reason.


Without keyboard:

drivers/input/serio/i8042.c: 60 -> i8042 (command) [357624] 

drivers/input/serio/i8042.c: 9a -> i8042 (parameter) [357624]

With keyboard:

drivers/input/serio/i8042.c: ff -> i8042 (kbd-data) [33392] 

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [33464] 

drivers/input/serio/i8042.c: aa <- i8042 (interrupt, kbd, 1) [33841] 

drivers/input/serio/i8042.c: 60 -> i8042 (command) [33976] 

drivers/input/serio/i8042.c: 65 -> i8042 (parameter) [33976]

The shutdown sequence is not hanging, though, as far as I can tell.  You 
can triple fault the machine immediately after the first WCTR command 
during initialization (triple fault reboots it just fine just before the 
same command) and it doesn't cause a reboot, and yet it's no longer 
executing instructions from the kernel (or at least not printk's or 
anything meaningful).  I don't think it's the parameters that it's 
passing to the WCTR command either, because if you look in the previous 
batch of printk's, it's putting back in exactly what it got out.

-- 
David N. Welton
davidw@eidetix.com

