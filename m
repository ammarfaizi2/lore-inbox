Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbUCJKPr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 05:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbUCJKPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 05:15:47 -0500
Received: from lon-mail-5.gradwell.net ([193.111.201.131]:15624 "HELO
	lon-mail-5.gradwell.net") by vger.kernel.org with SMTP
	id S262564AbUCJKPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 05:15:46 -0500
Date: Wed, 10 Mar 2004 10:15:44 +0000 (UTC)
From: "Joseph S. Myers" <jsm@polyomino.org.uk>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: Neil Booth <neil@daikokuya.co.uk>
cc: Linus Torvalds <torvalds@osdl.org>,
       Thomas Schlichter <thomas.schlichter@web.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gcc@gcc.gnu.org
Subject: Re: [PATCH] fix warning about duplicate 'const'
In-Reply-To: <20040310064001.GA7584@daikokuya.co.uk>
Message-ID: <Pine.LNX.4.58.0403101010360.22587@digraph.polyomino.org.uk>
References: <200403090043.21043.thomas.schlichter@web.de>
 <20040308161410.49127bdf.akpm@osdl.org> <Pine.LNX.4.58.0403081627450.9575@ppc970.osdl.org>
 <200403090217.40867.thomas.schlichter@web.de> <Pine.LNX.4.58.0403081728250.9575@ppc970.osdl.org>
 <20040310054918.GB4068@twiddle.net> <20040310064001.GA7584@daikokuya.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Neil Booth wrote:

> > seems dicey at best.  I'm not sure what to do about this, actually.
> > We might could do something with a new __nonqual_typeof(a) that
> > strips outermost type qualifications, but I havn't given that much
> > thought.
> 
> Or you could compile in C99 mode?

The gnu89-only kludge allowing compound literals in static initializers in 
certain cases, for compatibility with their old ill-defined semantics, is 
there because it was needed by Linux; I don't know if it's still needed, 
but that would prevent compiling in C99 mode where compound literals have 
only their C99 semantics as unnamed variables.

Simpler to restrict the pedwarns for duplicate qualifiers to (pedantic &&
!flag_isoc99) (in all the various cases warned for) and document this as
an extension from C99 that is accepted in C89/C90 mode.

-- 
Joseph S. Myers
jsm@polyomino.org.uk
