Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264555AbTFIR0B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 13:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264559AbTFIR0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 13:26:01 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:60360 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264555AbTFIR0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 13:26:00 -0400
Date: Mon, 9 Jun 2003 19:39:33 +0200 (MEST)
Message-Id: <200306091739.h59HdXam011608@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: mochel@osdl.org
Subject: Re: [RFC] New system device API
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jun 2003 09:18:03 -0700 (PDT), Patrick Mochel wrote:
>> >-EXPORT_SYMBOL(device_lapic);
>> 
>> Why did you ignore the 'not static' comment, and why remove
>> the EXPORT? They're there for a reason...
>
>Because it only appeared to be there to be able to set the parent device
>for hierarchically dependent devices. Assuming that is not needed, then 
>the EXPORT_SYMBOL() shouldn't be needed, and that device can be declared 
>statically. Right? 

Yes, they were only there so a child device could set its
parent pointer.

>> Unless I'm missing something, you've just broken the hierarchical
>> relationship that exists between the local APIC device and its
>> client devices (NMI watchdog, oprofile [which you didn't convert],
>> and perfctr [not merged into Linus' tree]).
>
>I'm aware of the necessary ancstral relationship, and I should have 
>mentioned this in the first email. Proper ancestral order is maintained by 
>virtue of the fact that child devices are registered after parent devices. 
>Because of this, they are inserted into the list of system devices after 
>their parents, so by walking the list in reverse order, you are guaranteed 
>to suspend/shutdown the devices in the right order. 

Ok. I'm used to having this spelled out explicitly, but walking the
list in insertion order / reverse insertion order should work too.

/Mikael
