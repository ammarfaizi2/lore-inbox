Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268204AbUIKRLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268204AbUIKRLt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUIKRKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:10:52 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.73]:18314 "EHLO
	pimout5-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268204AbUIKRKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:10:40 -0400
Date: Sat, 11 Sep 2004 13:10:18 -0400 (EDT)
From: Vladimir Dergachev <volodya@mindspring.com>
X-X-Sender: volodya@node2.an-vo.com
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
In-Reply-To: <1094915671.21290.77.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0409111304300.15792@node2.an-vo.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de> 
 <Pine.LNX.4.58.0409100209100.32064@skynet>  <9e47339104090919015b5b5a4d@mail.gmail.com>
  <20040910153135.4310c13a.felix@trabant>  <9e47339104091008115b821912@mail.gmail.com>
  <1094829278.17801.18.camel@localhost.localdomain>  <9e4733910409100937126dc0e7@mail.gmail.com>
  <1094832031.17883.1.camel@localhost.localdomain>  <9e47339104091010221f03ec06@mail.gmail.com>
  <1094835846.17932.11.camel@localhost.localdomain>  <9e47339104091011402e8341d0@mail.gmail.com>
  <Pine.LNX.4.58.0409102254250.13921@skynet>  <1094853588.18235.12.camel@localhost.localdomain>
  <Pine.LNX.4.58.0409110137590.26651@skynet>  <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>
  <Pine.LNX.4.58.0409110600120.26651@skynet>  <1094883136.6095.75.camel@admin.tel.thor.asgaard.local>
  <Pine.LNX.4.61.0409110305070.13840@node2.an-vo.com> 
 <1094913414.21157.65.camel@localhost.localdomain> 
 <Pine.LNX.4.61.0409111144590.15458@node2.an-vo.com>
 <1094915671.21290.77.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Sep 2004, Alan Cox wrote:

> On Sad, 2004-09-11 at 16:53, Vladimir Dergachev wrote:
>>      Lastly, I am not saying you have to put all the code in the same file.
>> All I am saying we can mandate that all Radeon HW specific code is linked
>> in one module - and this would make things easier for developers.
>
> And if I want dri but not frame buffer, or vice versa, as the majority
> of current users do

You are missing my point - I do not say we need to *activate* the 
framebuffer, just link the mode setting (and other hardware dependent 
code) into DRM driver.

This is kinda like vesafb driver is doing now - if I don't pass vga=XX 
parameter on the command line it does not touch the graphics card.

Thus, even if framebuffer support is not compiled into the kernel the DRM 
driver is able to reinitialize the card into a sane state.

>
>>      I would agree that this can be coded as well - but why bother ? Or is
>> it done and working already ?
>
> Splitting the modules up is the easy bit. The API is the hard bit so you
> might as well formalize it. It also gives the users the ability to not
> load huge radeon modules.
>

This is a good point - if we don't need DMA or 3d acceleration we can 
reduce memory footprint. This would seem that current DRM driver would 
need to be dependent on whatever driver contains the mode setting code.

What do you think ?

                       best

                         Vladimir Dergachev
