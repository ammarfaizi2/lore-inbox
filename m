Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWJETaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWJETaL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWJETaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:30:11 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:14721 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750981AbWJETaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:30:09 -0400
Message-ID: <45255D34.804@garzik.org>
Date: Thu, 05 Oct 2006 15:29:56 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: discuss@x86-64.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
References: <200610051910.25418.ak@suse.de> <200610051931.23884.ak@suse.de> <4525445C.6060901@garzik.org> <200610051953.23510.ak@suse.de>
In-Reply-To: <200610051953.23510.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thursday 05 October 2006 19:43, Jeff Garzik wrote:
>> Andi Kleen wrote:
>>> On Thursday 05 October 2006 19:17, Jeff Garzik wrote:
>>>
>>>> Does this fix the following issue:
>>>>
>>>> PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
>>>> PCI: Not using MMCONFIG.
>>>>
>>>> 100% of my x86-64 boxes, AMD or Intel, print this message.  And 100% of 
>>>> them work just fine with MMCONFIG.
>>> No. 
>>>
>>> But it isn't really a issue. Basically everything[1] will work fine anyways.
>>>
>>> [1]  Only thing you're missing AFAIK is PCI Extended Error Reporting.
>> Not really true, I have some cards which have >256 bytes of config space.
> 
> Yes for advanced error handling (which we only support in a few drivers
> right now) I'm not aware of any card that uses it for anything else. Do you 
> have evidence of that?

I need it to access chip-specific configuration registers on a PCI 
Express card.  It's under NDA so that's all I can say.

This will become more common as PCI Express becomes more common, as 
well.  It's largely only luck that we haven't run into more cases like 
this.  Most PCI-Ex devices, like most PCI devices, just don't need a 
whole lot of PCI configuration space.


>>>> I think this rule is far too drastic for real life.
>>> If you have a better proposal please share. I tried a few others, but none
>>> of them could handle all the buggy Intel 9x5 boards that hang on any
>>> mmconfig access (so the "try the first few busses" check already hangs)
>>>
>>> Originally I thought
>>> DMI blacklisting would work, but it's on too many systems for that
>>> (and Linus rightfully hated it anyways). ACPI checks also didn't work.
>>> I don't know of any others.
>> It's a bit disappointing, since I keep getting brand new boxes with 
>> brand new BIOSen, but keep hitting this rule.
> 
> A lot of new boxes are actually buggy due to a common Intel reference
> BIOS bug. There are also a couple of other quirks there.
> 
> I suppose it'll only become better once Windows starts using MCFG.
>  
>> My proposal is quite simple:  "something that works" -- the current 
>> solution obviously does not.
> 
> If you have a patch that works with all known BIOS bugs (including Mac Mini,
> a random Intel 975 board and a Asus AMD K8 board with PCI Express) please share it.

Can you then please share the list of known BIOS bugs?

All I have to do on my machines is work around the disable-mmconfig 
code, and things start working.

	Jeff


