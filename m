Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbTIKRyK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbTIKRyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:54:09 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:32518 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261487AbTIKRwe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:52:34 -0400
Date: Thu, 11 Sep 2003 13:43:27 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5-mm1 aha152x **still** doesn't work (fwd)
In-Reply-To: <20030910092001.4c7908e7.rddunlap@osdl.org>
Message-ID: <Pine.LNX.3.96.1030911133221.29153E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, Randy.Dunlap wrote:

> On Wed, 10 Sep 2003 10:14:37 -0400 (EDT) Bill Davidsen <davidsen@tmr.com> wrote:
> 
> | 
> | oddball:root> modprobe aha152x aha152x=0x340,9,7,1,1,1
> | SCSI subsystem initialized
> | aha152x: invalid module params io=0x340, irq=8,scsiid=7,reconnect=1,parity=1,sync=1,delay=1000,exttrans=0
> | FATAL: Error inserting aha152x 
> | (/lib/modules/2.6.0-test5-mm1/kernel/drivers/scsi/aha152x.ko): No such 
> | device
> | 
> | 
> | It happily looks at the "9" in the init string and says "irq=8" doesn't 
> | work. Works with the 2.4.18 kernel from RH7.3, so ??? The IRQ jumpers are 
> | soldered on the board.
> | 
> | Clearly if I had the option of using another board I would, that's not
> | going to happen for various reasons (administrative and technical).
> 
> Wow, looks odd alright.  What is CONFIG_PCMCIA?  (yes/no/module)
> What is CONFIG_ISAPNP?  Just send me your .config file, please.

Half an answer on the "8" and no clue on why it doesn't insert... The
modules.conf file and modprobe.conf file don't agree. Virtually certain
that I must have edited it after it was automatically created. Needless to
say modprobe.conf is wrong, this brings up the question of why it takes
the options from the file instead of believing the ones on the bloody
command line!

modules.conf:	options aha152x aha152x=0x340,9,7,1,1,1
modprobe.conf:	options aha152x aha152x=0x340,8,7,1,1,1

However, there is no change in the functionality, other than the change
from "=8" to "=9" and the device is still not found. Has there been a
change in the ability to share interrupts? I have tried ACPI on and off
(needed =force to get it on) in hopes of a better assignment of the NIC
and/or USB, they seem locked to 9 in 2.6. I will have to get a 2.4 kernel
booted again and see where everything falls with that.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

