Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbTLOPEp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 10:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbTLOPEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 10:04:45 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:17362 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263895AbTLOPEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 10:04:35 -0500
Date: Mon, 15 Dec 2003 16:04:20 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
Message-ID: <20031215150420.GD1286@wohnheim.fh-wedel.de>
References: <20031214052516.GA313@vana.vc.cvut.cz> <Pine.LNX.4.58.0312142032310.9900@earth> <Pine.LNX.4.58.0312141228170.1478@home.osdl.org> <Pine.LNX.4.58.0312141238460.1478@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0312141238460.1478@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 December 2003 12:45:34 -0800, Linus Torvalds wrote:
> 
> Btw, on another note: to avoid the appearance of recursion, I'd prefer a
> 
> 	p = leader;
> 	goto top;
> 
> instead of a "release_task(leader);".
> 
> I realize that the recursion should be just one deep (the leader of the
> leader is itself, and that will stop the thing from going further), but it
> looks trivial to avoid it, and any automated source checking tool would be
> confused by the apparent recursion.

Since you mentioned it - how would you prefer the asct (we need a
better acronym) to detect recursion depth.  Currently, I have those in
a seperate file that should come with the kernel, maybe in
Documentation/recursions or so.  But how about this:

/**
 * RECURSION:	2
 * NAME:	do_recurse
 */
void do_recurse(int recurse)
{
	if (recurse)
		do_recurse(0);
}

Ok, the format is ugly, feel free to pick anything nicer.  But
explicitly stating the recursion depth right where it happens makes
sense to me, as many human readers would like a similar comment
anyway.

Any opinion?

Jörn

-- 
Fools ignore complexity.  Pragmatists suffer it.
Some can avoid it.  Geniuses remove it.
-- Perlis's Programming Proverb #58, SIGPLAN Notices, Sept.  1982
