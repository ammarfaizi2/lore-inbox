Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267868AbUHET3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267868AbUHET3L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267904AbUHET2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 15:28:02 -0400
Received: from mail1.kontent.de ([81.88.34.36]:16515 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S267926AbUHETZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 15:25:56 -0400
Date: Thu, 5 Aug 2004 21:25:56 +0200
From: Sascha Wilde <wilde@sha-bang.de>
To: "David N. Welton" <davidw@eidetix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
Message-ID: <20040805192556.GA825@kenny.sha-bang.local>
References: <4107E788.8030903@eidetix.com> <41122C82.3020304@eidetix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41122C82.3020304@eidetix.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 02:48:02PM +0200, David N. Welton wrote:
> [ Please CC replies to me. ]
> 
> David N. Welton wrote:

> drivers/input/serio.c:753

drivers/input/serio/i8042.c
right?

> 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
> 		printk(KERN_ERR "i8042.c: Can't write CTR while initializing 
> 		i8042.\n");
> 		return -1;
> 	}
> 
> If I do the reboot instructions before this, it reboots fine. 
> Afterwards, and it just sits there, no reboot.

This is quite interesting, as there is only one function/macro, which
seems to be messing up things -- I don't know much (hardly anything)
aboout that hardwarestuff, but I'll have a look at i8042_command as
soon as I find the time.  At least it's a start...

> Sascha, to see if your problem is the same as mine, you might try 
> putting this bit of code before the above call:

[reboot code]
> 
> It will cause your machine to reboot before it's even finished booting, 

It works, so this seems to be the exactly same issue.  I only tested
with the code before the point above, I'll do further testings at the
weekend, but I'm quite optimistic, that you found the point of
failure.  Thanks!

> so don't do it with your only available kernel!

don't worry, lots o'kernel here...  ;-)

cheers
sascha
-- 
Sascha Wilde : "There are 10 types of people in the world. 
             : Those who understand binary and those who don't."
