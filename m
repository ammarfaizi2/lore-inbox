Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268979AbUIMWSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268979AbUIMWSp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268980AbUIMWSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:18:44 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:8345 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S268907AbUIMWSY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:18:24 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Jon Smirl <jonsmirl@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: radeon-pre-2
Date: Tue, 14 Sep 2004 06:17:34 +0800
User-Agent: KMail/1.5.4
Cc: Dave Airlie <airlied@linux.ie>,
       Felix =?iso-8859-1?q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de> <1095087860.14582.37.camel@localhost.localdomain> <9e47339104091309281c4e6fb7@mail.gmail.com>
In-Reply-To: <9e47339104091309281c4e6fb7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409140617.35207.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 September 2004 00:28, Jon Smirl wrote:
> Doesn't the base platform need to be designed to also treat individual
> heads as resources?
>
> fbdev only sets the mode on a single head. My cards have more that one
> head. When I tried adding mode setting to DRM so that I could handle
> my other heads there was a big uproar that fbdev owns mode setting and
> that code shouldn't be duplicated. Making fbdev support more than one
> head means that it's API has to be redesigned.

What do you mean?

Your driver has 2 heads, both of which have independent outputs and
separate framebuffers, then register your driver twice:

display0->fb0->framebuffer0-|
                            common par
display1->fb1->framebuffer1-|

Or outputs are interdependent with a common framebuffer, then register the
driver once:

                           par0
display0->fb0->framebuffer-|
	                   par1

Or outputs are independent, but shares a common framebuffer, then register
driver twice, each info with the same pointer to framebuffer:

              par0
display0->fb0-|
              framebuffer
display1->fb1-|
	      par1

Tony


