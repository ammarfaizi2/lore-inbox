Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVBPQGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVBPQGZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 11:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVBPQGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 11:06:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:56249 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262058AbVBPQGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 11:06:10 -0500
Date: Wed, 16 Feb 2005 08:06:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Roman Zippel <zippel@linux-m68k.org>, Andreas Schwab <schwab@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Pty is losing bytes
In-Reply-To: <20050216144203.GB7767@thunk.org>
Message-ID: <Pine.LNX.4.58.0502160802510.2383@ppc970.osdl.org>
References: <jebramy75q.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org>
 <je1xbhy3ap.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151239160.2330@ppc970.osdl.org>
 <Pine.LNX.4.61.0502160405410.15339@scrub.home> <Pine.LNX.4.58.0502151942530.2383@ppc970.osdl.org>
 <20050216144203.GB7767@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Feb 2005, Theodore Ts'o wrote:
> 
> The comment above the test explains why that test is there in
> n_tty_receive_room.  If that test isn't there, and we are doing input
> canonicalization, when the buffer gets full

Yes, yes, but did you see my suggested version that I had just below that
explained what I thought the real fix was?

Th eproblem with checking for the "canon but no canon data" is that it's a
special case that IS ONLY VALID WHEN THE BUFFER IS FULL! Until that
happens, it means that the code returns the wrong value, and then can
(obviously, as seen by the bug) drop bytes even when it shouldn't.

That's why my suggested work-around moved things around, to only return 
the "we'll take anything" thing if the buffer really was full.

		Linus
