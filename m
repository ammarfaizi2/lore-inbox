Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267936AbUIKHMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267936AbUIKHMm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 03:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267989AbUIKHMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 03:12:42 -0400
Received: from pimout6-ext.prodigy.net ([207.115.63.78]:9120 "EHLO
	pimout6-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267936AbUIKHMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 03:12:38 -0400
Date: Sat, 11 Sep 2004 03:11:50 -0400 (EDT)
From: Vladimir Dergachev <volodya@mindspring.com>
X-X-Sender: volodya@node2.an-vo.com
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
cc: Dave Airlie <airlied@linux.ie>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
In-Reply-To: <1094883136.6095.75.camel@admin.tel.thor.asgaard.local>
Message-ID: <Pine.LNX.4.61.0409110305070.13840@node2.an-vo.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de> 
 <Pine.LNX.4.58.0409100209100.32064@skynet>  <9e47339104090919015b5b5a4d@mail.gmail.com>
  <20040910153135.4310c13a.felix@trabant>  <9e47339104091008115b821912@mail.gmail.com>
  <1094829278.17801.18.camel@localhost.localdomain>  <9e4733910409100937126dc0e7@mail.gmail.com>
  <1094832031.17883.1.camel@localhost.localdomain>  <9e47339104091010221f03ec06@mail.gmail.com>
  <1094835846.17932.11.camel@localhost.localdomain>  <9e47339104091011402e8341d0@mail.gmail.com>
  <Pine.LNX.4.58.0409102254250.13921@skynet>  <1094853588.18235.12.camel@localhost.localdomain>
  <Pine.LNX.4.58.0409110137590.26651@skynet>  <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>
  <Pine.LNX.4.58.0409110600120.26651@skynet> <1094883136.6095.75.camel@admin.tel.thor.asgaard.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I still haven't seen a complete logical chain leading to that
> conclusion.
>
> The lowlevel driver could provide all the necessary arbitration and
> safety measures to prevent the two from stepping on each other's toes.
>

The thing is I know of no way to provide arbitration in such a way as to 
permit other code to access PLL registers directly.

One way or the other you will have to add "please set mode X" function to 
DRM and then the point of having a separate file for fb-con related 2d 
only is moot.

Additional argument for this is that DRM *NEEDS* to know about mode 
setting so that when it detects an engine lockup it is able to restore the 
card to a sane state without FB driver.

Right now there are two places where engine reset is handled: DRM driver
(where we reset the chip and leave it as is, with mode all screwed up) and
in Xserver (where we set the mode, but I have never seen this code path 
triggered).

Thus at the very least you would want to mandate the availability of mode 
setting part of FB when DRM is loaded - and they you can just as well link 
the relevant code together.

                          best

                              Vladimir Dergachev
