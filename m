Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbUCCTT5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 14:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbUCCTT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 14:19:57 -0500
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:8314 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262551AbUCCTTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 14:19:54 -0500
Subject: [RFC] syncppp broken - how to fix?
From: Paul Fulghum <paulkf@microgate.com>
To: linux-kernel@vger.kernel.org
Cc: shemninger@osdl.org
Content-Type: text/plain
Organization: 
Message-Id: <1078341592.2118.19.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Mar 2004 13:19:53 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.0-test8 a patch from shemninger@osdl.org was
applied to drivers/net/wan/syncppp.c which breaks
syncppp when used with some wan drivers:

drivers/net/wan/cosa.c
drivers/net/wan/hostess_sv11.c
drivers/net/wan/wanpipe_multppp.c
drivers/char/synclink.c
drivers/char/synclinkmp.c
drivers/char/pcmcia/synclink_cs.c

The problem is the addition of a BUG_ON()
line in sppp_attach() which imposes the new
requirement that the net device priv member
be initialized *before* calling sppp_attach().

The priv member is not actually used in
sppp_attach(). The BUG_ON line does a sanity
check which touches priv member, which is not
set prior to calling sppp_attach() by the drivers
listed above.

So should all of the WAN drivers be changed to
accomodate this new requirement (which does not
seem to serve a purpose) ?

Or should the BUG_ON line be removed from
syncppp.c to return it to the original convention?

It seems odd to add a sanity check for a member
that is not used and is not set. It also seems
counter productive to modify multiple drivers
to set this value to accomodate the new sanity check
since that value is still not used in sppp_attach.


-- 
Paul Fulghum
paulkf@microgate.com


