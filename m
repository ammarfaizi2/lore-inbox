Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVBQPp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVBQPp7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 10:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVBQPp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 10:45:59 -0500
Received: from fire.osdl.org ([65.172.181.4]:38113 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261152AbVBQPp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 10:45:57 -0500
Date: Thu, 17 Feb 2005 07:45:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Roman Zippel <zippel@linux-m68k.org>, Andreas Schwab <schwab@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Pty is losing bytes
In-Reply-To: <20050217044444.GA6115@thunk.org>
Message-ID: <Pine.LNX.4.58.0502170744160.2383@ppc970.osdl.org>
References: <jebramy75q.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org>
 <je1xbhy3ap.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151239160.2330@ppc970.osdl.org>
 <Pine.LNX.4.61.0502160405410.15339@scrub.home> <Pine.LNX.4.58.0502151942530.2383@ppc970.osdl.org>
 <20050216144203.GB7767@thunk.org> <Pine.LNX.4.58.0502160802510.2383@ppc970.osdl.org>
 <20050217044444.GA6115@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Feb 2005, Theodore Ts'o wrote:
> 
> Yes, but then when the buffer is full, and we return the "we'll take
> anything" return value, the code that was getting confused with the
> "incorrect" receive_room value will still be getting confused....

But that's fine - at that point we're literally _supposed_ to drop 
characters: we have to, in order to see the EOLN.

But we're only supposed to drop characters IFF:
 - the buffer is full
 - we are in canon mode
 - we _still_ haven't seen a single EOLN in the whole buffer

If any of these three isn't true, we're not supposed to drop anything.

That's my argument.

		Linus
