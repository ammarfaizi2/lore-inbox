Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268168AbUIKPjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268168AbUIKPjY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 11:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268170AbUIKPjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 11:39:24 -0400
Received: from the-village.bc.nu ([81.2.110.252]:26035 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268168AbUIKPjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 11:39:16 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vladimir Dergachev <volodya@mindspring.com>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0409110305070.13840@node2.an-vo.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <Pine.LNX.4.58.0409100209100.32064@skynet>
	 <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <20040910153135.4310c13a.felix@trabant>
	 <9e47339104091008115b821912@mail.gmail.com>
	 <1094829278.17801.18.camel@localhost.localdomain>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.58.0409110600120.26651@skynet>
	 <1094883136.6095.75.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.61.0409110305070.13840@node2.an-vo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094913414.21157.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Sep 2004 15:36:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-11 at 08:11, Vladimir Dergachev wrote:
> The thing is I know of no way to provide arbitration in such a way as to 
> permit other code to access PLL registers directly.

This arises solely because the DRM and framebuffer drivers cannot find
each other and have no shared structures. The moment you have that it
becomes

	down(&dev->foo->pll_lock);

> Thus at the very least you would want to mandate the availability of mode 
> setting part of FB when DRM is loaded - and they you can just as well link 
> the relevant code together.

You are making a generic assumption for a single card specific problem
in a specific situation. That leads to bad decisions for embedded. It
does argue for mode setting and fb to be separate too.

(Remember for most embedded devices mode setting code is trivial)

