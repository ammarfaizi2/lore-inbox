Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbTAWFxF>; Thu, 23 Jan 2003 00:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbTAWFxE>; Thu, 23 Jan 2003 00:53:04 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:34566 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S261354AbTAWFxE>; Thu, 23 Jan 2003 00:53:04 -0500
Message-ID: <3E2F84CF.4010609@snapgear.com>
Date: Thu, 23 Jan 2003 15:59:43 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: common RODATA in vmlinux.lds.h (2.5.59)
References: <Pine.LNX.4.44.0301221014250.9969-100000@chaos.physics.uiowa.edu>
In-Reply-To: <Pine.LNX.4.44.0301221014250.9969-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai,

Kai Germaschewski wrote:
[snip]
> You want to use sections as an abstraction for different parts of the 
> image, like text/rodata vs data. However, let me claim the sections are 
> not the right tool for the job, instead that's why ELF segments exist.
> Just declaring two MEMORY regions, e.g. rom/ram and putting text/rodata
> sections into rom, the rest into ram will give you a vmlinux with two 
> segments, exactly what you need. (There's two ways to do that, using 
> MEMORY or PHDRS - whatever works better for you)

I can see your point here. So as long as we can get the sections
within RODATA placed into the right segment then we can still do
what we need. That will be good enough for me in the m68knommu case.


[snip]
>>It's not that it _needs_ to group things inside a single output section
>>(though often doing so is just simpler), but it _does_ need more control
>>over the output sections than is provided by the current RODATA macro:
>>at least, it needs to be able to specify which memory regions the
>>various sections go, sometimes at separate link- and run-time addresses
>>(i.e., a "> MEM AT> OTHER_MEM" directive following each output section).
> 
> 
> All of this can, AFAICS, be nicely handled by additional 
> "{TEXT,RODATA,DATA}_MEM" macros which allow the arch to specify regions as 
> necessary.

Oddly enough (or perhaps not :-) this is virtually the method I
currently use in the m68knommu vmlinux.lds.S to allow it to link
for both flash+ram or ram-only operation - depending on a CONFIG_
option.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

