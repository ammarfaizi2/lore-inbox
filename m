Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290617AbSAYJkF>; Fri, 25 Jan 2002 04:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290624AbSAYJjl>; Fri, 25 Jan 2002 04:39:41 -0500
Received: from duck.a2000.nl ([62.108.1.88]:21955 "EHLO smtp1.a2000.nl")
	by vger.kernel.org with ESMTP id <S290617AbSAYJjb>;
	Fri, 25 Jan 2002 04:39:31 -0500
Message-ID: <3C511D4B.5060205@users.sf.net>
Date: Fri, 25 Jan 2002 09:54:35 +0100
From: Thomas Tonino <ttonino@users.sourceforge.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020111
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel wrote:

 > hmmm ... maybe it is realy hardware depending ... with my
 > relativly new motherboard and fast cpu/system componends
 > it is no problem at all ...
 > looking video, hearing music , ... no problems ...

I've played with lvcool on my box: Abit KT7A (KT133A), Athlon 1.1 GHz.

When I use my BT848 tv card to watch tv, there usually are some signs 
that the PCI transfer rate is not high enough - some bits of image do 
not get refreshed, but nothing major when lvcool is off.

But when running lvcool, the whole thing would look like a special 
effects show: not even half the image would be refreshed every frame.

The BT848 writes directly over the PCI to AGP bridge to the video card 
RAM so the CPU is completely idle. Thus it seems likely that the bus 
performance is affected. ISTR that the actual 'disconnect' effect is 
caused by a read from a south bridge register. I assume that read takes 
a while, and this keeps the bus busy. This may not be a prblem in 
itself, unless the PCU has the highest priority in the system, or has 
the possibility to 'just do another cycle'.

However, with lvcool the CPU temperature dropped remarkably - from 20 
degrees above case to 2 degrees above case.

But after updating the BIOS to version 3R, lvcool only results in a hard 
crash. So now I found out how PCI latencies work, I have no change to 
test. I can imagine that playing with the host bridge latencies will 
solve this, just as it can improve on the video playing without lvcool.

That said, the 3R bios version does not support ACPI based disconnect at 
all. But why lvcool wedges the system so well? Maybe some ACPI activity? 
But then, my kernel was the same before and after the BIOS update.


Thomas

