Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268170AbUIKPk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268170AbUIKPk1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 11:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268175AbUIKPk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 11:40:27 -0400
Received: from pimout6-ext.prodigy.net ([207.115.63.78]:52195 "EHLO
	pimout6-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268170AbUIKPkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 11:40:14 -0400
Date: Sat, 11 Sep 2004 11:39:52 -0400 (EDT)
From: Vladimir Dergachev <volodya@mindspring.com>
X-X-Sender: volodya@node2.an-vo.com
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
To: Keith Whitwell <keith@tungstengraphics.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@gmail.com>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
In-Reply-To: <4142BACC.4080708@tungstengraphics.com>
Message-ID: <Pine.LNX.4.61.0409111136120.15458@node2.an-vo.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de> 
 <Pine.LNX.4.58.0409100209100.32064@skynet>  <9e47339104090919015b5b5a4d@mail.gmail.com>
  <20040910153135.4310c13a.felix@trabant>  <9e47339104091008115b821912@mail.gmail.com>
  <1094829278.17801.18.camel@localhost.localdomain>  <9e4733910409100937126dc0e7@mail.gmail.com>
  <1094832031.17883.1.camel@localhost.localdomain>  <9e47339104091010221f03ec06@mail.gmail.com>
  <1094835846.17932.11.camel@localhost.localdomain>  <9e47339104091011402e8341d0@mail.gmail.com>
  <Pine.LNX.4.58.0409102254250.13921@skynet> <1094853588.18235.12.camel@localhost.localdomain>
 <Pine.LNX.4.61.0409102039380.12529@node2.an-vo.com> <4142BACC.4080708@tungstengraphics.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> anything else.. (remembering graphics cards are not-multifunction cards -
>>>> like Christoph used as an example before - 2d/3d are not separate
>>>> functions...)...
>>> 
>>> 
>>> We've addressed this before. Zillions of drivers provide multiple
>>> functions to multiple higher level subsystems. They don't all have to
>>> be compiled together to make it work.
>>> 
>>> 2D and 3D _are_ to most intents and purposes different functions. They
>>> are as different as IDE CD and IDE disk if not more so.
>> 
>> 
>> Functions - yes, but they become such only at a higher level. 3d for 
>> example does not really exist in kernel in any form.
>> 
>> I would like to see unified fb (or the hardware-specific part of fb) and 
>> drm for one simple reason that I think you mentioned:
>> 
>>     One driver per device. I.e. one driver per *physical* device.
>> 
>> Lastly, one point that you appear to have missed: DRM does DMA transfers
>> (among everything else). FB sets video modes - i.e. messes with PLL.
>> The problem is that there are configurations where messing with PLL while a 
>> DMA trasfer is active will lock up PCI (or AGP) bus hard.
>> 
>> For example, a video decoder can be clocked off pixel clock for video pass 
>> through mode. If we trasfer video data to main RAM at the same time and
>> FB gets a command instructing it to change resolution there would be a hard 
>> lockup.
>
> I can see this being the case, but why can't fb just using existing drm 
> interfaces to achieve device quiescence before touching the PLL's?

Video decoder is not part of 3d engine. In fact if we are not transferring 
data via DMA into system RAM the video decoder will be running 
continuously and none of currently examined for quiescence flags would 
show it.

To do all this properly there should be a piece of code that knows all 
about currrent state of the card - which clocks are connected to what, 
which transfers are running and which parts of the engine are busy.

Btw, it would also be nice if that code received interrupts that can occur 
when user hotplugs monitors.

                              best

                                 Vladimir Dergachev

