Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbVL3BV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbVL3BV6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 20:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbVL3BV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 20:21:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6543 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751192AbVL3BV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 20:21:57 -0500
Date: Thu, 29 Dec 2005 20:21:45 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ryan Anderson <ryan@michonline.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: userspace breakage
Message-ID: <20051230012145.GD12822@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Ryan Anderson <ryan@michonline.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com> <43B48176.3080509@michonline.com> <20051230004608.GA12822@redhat.com> <Pine.LNX.4.64.0512291702140.3298@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512291702140.3298@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 05:05:08PM -0800, Linus Torvalds wrote:
 > 
 > 
 > On Thu, 29 Dec 2005, Dave Jones wrote:
 > > 
 > > There's a 2.6.15rc7 kernel that some Fedora Core 4 users could download
 > > and play with right now. I thought it'd be great to get some extra testing
 > > over the xmas holidays. Unfortunatly, due to the necessary udev upgrade, 
 > > many users are turned off from testing by the inability to run X after
 > > installing it.
 > 
 > Can you actually detail this thing a bit more? I'm a FC4 user myself, and 
 > I'm sure as hell running X too. And that's not even a special X install 
 > like I used to have, it's bog-standard FC4 afaik.
 > 
 > And I'm definitely running -rc7 (well, not exactly, it's my current git 
 > tree, so it's -rc7+patches).
 > 
 > So whatever breakage is there, I'd love to know more. It's not entirely 
 > obvious.

It's X config dependant. If you have

Option      "Device" "/dev/input/mice"

in your inputdevice section, all should work (I think[*]).
However, some folks seem to have somehow ended up with references
to either 'mouse0' or 'event*' in there.

With 2.6.14 on my testbox, I get this..

$ ls /dev/input/
event0  event1  mice  mouse0

With 2.6.15rc

$ ls /dev/input/
mice

If I can dig out the bugzilla that reported this, I'll followup.
Something in my head is telling me it had something to do with
laptop touchpads, but that could be the post-xmas `nog talking.

		Dave

[*] How much I look forward to a world where X has no config file
    and just figures all this out itself.

