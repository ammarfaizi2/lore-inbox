Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132027AbRDPTmp>; Mon, 16 Apr 2001 15:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131985AbRDPTmZ>; Mon, 16 Apr 2001 15:42:25 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:6419 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S131983AbRDPTmO>;
	Mon, 16 Apr 2001 15:42:14 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104161942.f3GJg4r401708@saturn.cs.uml.edu>
Subject: Re: Bug in EZ-Drive remapping code (ide.c)
To: Andries.Brouwer@cwi.nl
Date: Mon, 16 Apr 2001 15:42:04 -0400 (EDT)
Cc: acahalan@cs.uml.edu, Jochen.Hoenicke@informatik.uni-oldenburg.de,
        andre@linux-ide.org, linux-kernel@vger.kernel.org
In-Reply-To: <UTC200104160831.KAA196012.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at Apr 16, 2001 10:31:48 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer writes:
>From acahalan@saturn.cs.uml.edu Mon Apr 16 08:35:09 2001
>>Andries.Brouwer writes:

>>> What one wants is to remap access to sector 0 to sector 1,
>>> and leave all other sectors alone. Thus, if someone asks
>>> for sectors 0 1 2 3 4, she should get sectors 1 1 2 3 4.
>>
>> No, because then you can't write to the real first sector.
>> Assuming translation is good, 1 0 2 3 4 is a better order.
>> Then "dd if=/dev/zero of=/dev/hda bs=1k count=999" will get
>> rid of all this crap. Otherwise, killing it is difficult.
>
> If you use EZdrive and damage its code, then probably you
> cannot boot anymore, or lose access to your data.
> Killing it must be difficult.

The above dd command wipes out out the partition table anyway,
with or without EZdrive. I think it also kills the EZdrive code.

EZdrive tends to come installed by default, to support DOS and
similar crufty Microsoft bits. For a pure Linux system it should
be removed.

What you are arguing for is protecting root from himself.
You want to limit the rope, but this is silly as the partitions
themselves are still completely unprotected.

The "1 0 2 3 4" order is nicely 1-to-1, unlike the other orders.

> EZdrive provides uninstall code itself, but if you really want,
> boot with "hda=noremap", and then your dd command will erase
> both EZdrive and your precious data.

This is a pain. The fdisk program ought to have a "wipe EZdisk"
option. More generally, it ought to let the user wipe everything
of a similar nature, by both brute force and by copying the second
sector over the first.

