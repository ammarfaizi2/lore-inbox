Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267653AbUBTBDR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267626AbUBTA6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:58:40 -0500
Received: from dp.samba.org ([66.70.73.150]:39811 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267624AbUBTA5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:57:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16437.23418.259802.240906@samba.org>
Date: Fri, 20 Feb 2004 11:57:30 +1100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>, viro@parcelfarce.linux.theplanet.co.uk,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
In-Reply-To: <Pine.LNX.4.58.0402191621250.2244@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
	<20040219163838.GC2308@mail.shareable.org>
	<Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
	<20040219182948.GA3414@mail.shareable.org>
	<Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
	<20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org>
	<Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org>
	<20040219204853.GA4619@mail.shareable.org>
	<Pine.LNX.4.58.0402191326490.1439@ppc970.osdl.org>
	<20040220000054.GA5590@mail.shareable.org>
	<Pine.LNX.4.58.0402191607490.2244@ppc970.osdl.org>
	<Pine.LNX.4.58.0402191621250.2244@ppc970.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

 > That said, who actually _uses_ dnotify? The only time dnotify seems to 
 > come up in discussions is when people complain how badly designed it is, 
 > and I don't think I've ever heard anybody say that they use it and 
 > that they liked it ;)

This may not be the example you want, but Samba uses it and it is
absolutely vital to good performance.

The common situation is this:

  - 1000 windows drones sitting in an office with their windows
    explorer windows open on their home directory on the server, but
    not doing any real work.

  - all those windows boxes ask the Samba server "let me know when the
    directory changes so I can refresh this window that nobody is
    looking at anyway"

  - before we had dnotify samba had to continuously poll all those
    directories, looking for a change in a checksum of the directory
    contents. We had tunable parameters for how often to poll, whether
    to poll etc, but basically it sucked, because windows users with
    nothing better to do ask "why doesn't it behave just like NT"

  - now samba just watches for dnotify events

The other situation where it really sucked was for windows developers
using visual C. The builtin make-like system in that braindead tool
actually got compilations wrong if the file server didn't tell it that
a file in its directory had changed. It would say "nothing to do" when
you do a build and we hadn't polled recently enough. Cue the angry
windows developers and people screaming to put a real NT box in
instead of Samba.

So dnotify has been a huge bonus for Samba, I just wish a few more
non-Samba tools would use it so it doesn't run the risk of being
removed because only Samba cares. It sucks being the ugly duckling,
and knowing that nobody is ever going to tell you you're really a
swan :)

Cheers, Tridge
