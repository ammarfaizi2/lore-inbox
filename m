Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267567AbUBSUtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267572AbUBSUtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:49:07 -0500
Received: from mail.shareable.org ([81.29.64.88]:20096 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S267567AbUBSUs6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:48:58 -0500
Date: Thu, 19 Feb 2004 20:48:53 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Tridge <tridge@samba.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
Message-ID: <20040219204853.GA4619@mail.shareable.org>
References: <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org> <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Comments?

Yes: The slow part of my brain thinks dnotify with a new flag
DN_IGNORE_SELF, meaning don't notify for things done by the process
which is watching, would provide equivalent functionality.

That is:

Samba looks up a name:

    1. Look up cache entry in Samba's cache; fails.
    2. Try exact name; fails.
    3. Open directory.
    4. Register dnotify (DN_IGNORE_SELF | DN_CREATE | DN_RENAME | DN_DELETE).
    5. readdir(); no case-insensitive match.
    6. Stores negative cache entry in Samba.

Future lookups just succeed in Samba's cache.

Negative cache entries are simply invalidated whenever a dnotify is
received for that directory.

Samba already maintains a cache for positive entries, so this would be
very little logic to add.

In what way is your two bit proposal better?

- Jamie
