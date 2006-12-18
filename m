Return-Path: <linux-kernel-owner+w=401wt.eu-S1754183AbWLRPzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183AbWLRPzL (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754185AbWLRPzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:55:11 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:43002 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbWLRPzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:55:09 -0500
Date: Mon, 18 Dec 2006 10:54:16 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ieee1394 in 2.6.20-rc1 (was Re: Linux 2.6.20-rc1)
In-reply-to: <4586B77E.1080803@s5r6.in-berlin.de>
To: linux-kernel@vger.kernel.org
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Linus Torvalds <torvalds@osdl.org>,
       linux1394-devel@lists.sourceforge.net
Message-id: <200612181054.18226.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
 <200612172329.14723.gene.heskett@verizon.net>
 <4586B77E.1080803@s5r6.in-berlin.de>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 December 2006 10:45, Stefan Richter wrote:
>Gene Heskett wrote:
>> On Sunday 17 December 2006 20:05, Stefan Richter wrote:
>>>What's missing in our implementation is that the use count of ohci1394
>>>goes up too once a "high-level driver" uses resources of a host driven
>>>by ohci1394.
>>
>> This needs some tlc then I assume?
>
>Yes. It's now logged at http://bugzilla.kernel.org/show_bug.cgi?id=7701
>and will probably stay there until I do something about it myself.

Thanks, that pretty well describes what happened here.

>>>The FireWire stack has three layers: Low level (ohci1394 and pcilynx;
>>>control the host bus adapter),
>>
>> The hardware
>
>Yes, or more precisely the built-in hardware, not hardware at the other
>end of the wire.

That was assumed when I wrote it :)

>>>mid level (the ieee1394 core)
>>
>> which I assume (fuggly word) steers the high level stuff to the right
>> entry points in the hardware handler?
>
>Yes. It implements common management functionality and makes actions
>like "write into a register of a remote node" or "receive a stream into
>a buffer" independent of the actual host adapter --- or at least that
>was the intent when Linux' FireWire stack was designed. Years ago there
>was actually another driver for a non-OHCI host adapter chip from
>Adaptec; and there is a mostly functional but unmaintained out-of-tree
>driver for a non-OHCI/ non-PCI adapter from Texas Instruments (TI
> GP2Lynx).
>
>IOW the ieee1394 core provides a platform to stick application-level
>drivers (protocol drivers) like for DV, IPv4 networking, SBP-2 storage
>on top of it without having to care of how particular host adapter chips
>are programmed. raw1394 basically extends ieee1394 to stick userspace
>drivers on it.
>
>But as mentioned, this layering is partly violated in the actual
>implementation. Also, the ieee1394 core is itself needlessly dependent
>on a PCI kernel API, making it harder for embedded developers to add
>their own low-level drivers than it ought to be. (So I was told; I
>actually rarely hear from embedded development projects.)

Typical :-)  Don't let me distract you from more important work :)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
