Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268464AbUIMQcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268464AbUIMQcU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 12:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267930AbUIMQa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 12:30:58 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:41761 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267856AbUIMQ2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 12:28:43 -0400
Message-ID: <9e47339104091309281c4e6fb7@mail.gmail.com>
Date: Mon, 13 Sep 2004 12:28:27 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: radeon-pre-2
Cc: Dave Airlie <airlied@linux.ie>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1095087860.14582.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094912726.21157.52.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409122319550.20080@skynet>
	 <1095074778.14374.41.camel@localhost.localdomain>
	 <9e47339104091308063c394704@mail.gmail.com>
	 <1095087860.14582.37.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doesn't the base platform need to be designed to also treat individual
heads as resources?

fbdev only sets the mode on a single head. My cards have more that one
head. When I tried adding mode setting to DRM so that I could handle
my other heads there was a big uproar that fbdev owns mode setting and
that code shouldn't be duplicated. Making fbdev support more than one
head means that it's API has to be redesigned. DRM doesn't have a mode
API so one can be designed from scratch.

In a two head system with simultaneous users, one using fbdev console
and the other playing a 3D game, how is this locking thing going to
work on a process swap basis? Even though we don't have the code for
this today the architecture needs to be designed for it. The reason
you can't do this today is because the kernel level drivers won't
allow it, you can do this currently from the X server.

Heads need to stay in an "unassigned state" until someone logs in on
them. This allows a head to issue a request for "merged fb" mode and
take over the other head. This may require some creativity for drawing
the log in prompts.

Don't forget about SAK and drawing prompts that can't be spoofed.

-- 
Jon Smirl
jonsmirl@gmail.com
