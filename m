Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVBQEpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVBQEpO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 23:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVBQEpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 23:45:14 -0500
Received: from thunk.org ([69.25.196.29]:25244 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262210AbVBQEpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 23:45:09 -0500
Date: Wed, 16 Feb 2005 23:44:44 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andreas Schwab <schwab@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Pty is losing bytes
Message-ID: <20050217044444.GA6115@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
References: <jebramy75q.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org> <je1xbhy3ap.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151239160.2330@ppc970.osdl.org> <Pine.LNX.4.61.0502160405410.15339@scrub.home> <Pine.LNX.4.58.0502151942530.2383@ppc970.osdl.org> <20050216144203.GB7767@thunk.org> <Pine.LNX.4.58.0502160802510.2383@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502160802510.2383@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 08:06:00AM -0800, Linus Torvalds wrote:
> Yes, yes, but did you see my suggested version that I had just below that
> explained what I thought the real fix was?
> 
> Th eproblem with checking for the "canon but no canon data" is that it's a
> special case that IS ONLY VALID WHEN THE BUFFER IS FULL! Until that
> happens, it means that the code returns the wrong value, and then can
> (obviously, as seen by the bug) drop bytes even when it shouldn't.
> 
> That's why my suggested work-around moved things around, to only return 
> the "we'll take anything" thing if the buffer really was full.

Yes, but then when the buffer is full, and we return the "we'll take
anything" return value, the code that was getting confused with the
"incorrect" receive_room value will still be getting confused....

						- Ted
