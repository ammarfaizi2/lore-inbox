Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbUCAMtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 07:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUCAMtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 07:49:22 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:49083 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261247AbUCAMtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 07:49:19 -0500
Date: Mon, 01 Mar 2004 20:48:59 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [Swsusp-devel] Re: Dropping CONFIG_PM_DISK?
Cc: "Micha Feigin" <michf@post.tau.ac.il>,
       "Software suspend" <swsusp-devel@lists.sourceforge.net>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
References: <1ulUA-33w-3@gated-at.bofh.it>  <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz>  <yw1x4qt93i6y.fsf@kth.se> <opr348q7yi4evsfm@smtp.pacific.net.th>  <20040229213302.GA23719@luna.mooo.com>  <opr35wvvrw4evsfm@smtp.pacific.net.th> <1078139361.21578.65.camel@gaston>  <opr36ljbsu4evsfm@smtp.pacific.net.th> <1078141191.28288.83.camel@gaston>
Message-ID: <opr36ojxik4evsfm@smtp.pacific.net.th>
In-Reply-To: <1078141191.28288.83.camel@gaston>
User-Agent: Opera M2/7.50 (Linux, build 600)
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2004 22:39:52 +1100, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

>
>> >> - that 2.4 style PM got depreciated and let die before the
>> >>    "new-driver-model" PM is workin
>> >
>> > Except that it never worked
>>
>> It is actively used for ide, network, serial drivers with swsusp2.
>
> Without any proper ordering guarantee, IDE could take requests
> after beeing suspended, which could be fatal (and cause data loss)
> etc...

Appreciated, suspending a driver like sending XOFF to a tty is ideal,
but not neccessary for _most_ drivers (software suspend) purpose.

Wrt IDE, in practice all processes get frozen well before
suspending drivers. Tested and no issues were ever reported with 2.4.

>
> Moving to the new model is easy. I don't see why we should have had
> such a "compatibility" path on a major kernel version, that makes
> no sense, just help fixing the drivers that need more fixing instead.

What for write new drivers for (fast obsoleting) hardware?.

- Developer time is the most precious resource
- Testing of drivers is in practice very difficult due to lack of
     several variations of HW (one can't really test anything in one box)
- It will take _years_ for drivers to become available and reach the
   stability of 2.4 drivers.
- Many drivers will die for lack of overall resources to port them.

So, why burn resources on reinventing wheels, which end up poorly
tested and run like a disk sliced of a tree...

What is needed is a  _compatible_ infrastructure to _any_ 2.4 driver
in existence and also provideing rudimentary centralized suspend and
resume capability.

This infrastructure could even be a config option
	CONFIG_24_DRIVER_SUPPORT
and be independent of the new model.

Then one could just drop in a driver from 2.4 and use it.

People having time to make new "pretty" drivers could
also use this facility for cross checking.

>
>> >
>> >> - that perfectly good drivers were rewritten from scratch,
>> >>    but without functioning PM support
>> >
>> > Please, give names.
>> >
>>
>> A few I tested:
>>
>> AGP (sis, savage)
>> trident (Ali153x)
>> Serial (82x50)
>> Yenta (Toshiba Topic95)
>>
>> Regards
>> Michael

