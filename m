Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263565AbUESKyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbUESKyT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 06:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUESKyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 06:54:19 -0400
Received: from nacho.zianet.com ([216.234.192.105]:7443 "HELO nacho.zianet.com")
	by vger.kernel.org with SMTP id S263565AbUESKyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 06:54:18 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Wed, 19 May 2004 04:53:31 -0600
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
       mason@suse.com, wli@holomorphy.com, hugh@veritas.com, adi@bitmover.com,
       support@bitmover.com, linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <200405172319.38853.elenstev@mesatop.com> <Pine.LNX.4.58.0405180728510.25502@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405180728510.25502@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405190453.31844.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 May 2004 08:38 am, Linus Torvalds wrote:
> 
> On Mon, 17 May 2004, Steven Cole wrote:
> >
> > No problems, and with PREEMPT of course.
> 
> Ok. Good. It's a small data-set, but the bug made sense, and so did the 
> fix.

Perhaps a final note on this: I did more testing on reiserfs overnight with
Chris' patch, and it survived eleven pulls and unpulls with no failures.

> 
> > > If you see a failure on ext3, please try to analyze the corruption pattern 
> > > again. It might be something different.
> > 
> > So, I take it that I should revert that one-liner if I want to get any failure data?
> > With it, ext3 was pretty solid for this testing.
> 
> Yes. That one-liner is bogus. It was a good way to test a hypothesis for
> the common case of a filesystem that uses the block_write_full_page thing
> (and reiser is one of the few that doesn't), but it wasn't the real fix.
> The reiser patch was the real fix for the problem on reiser, but ext3
> should have been ok already. It uses (through a lot of other functions)
> generic_file_aio_write_nolock() as the real write engine, and that one
> calls "commit_write()" with the page lock held.
> 
> 		Linus

I also tested ext3 more extensively (10 pulls/unpulls) and could not repeat
the alleged failure on ext3.  That was with akpm's one-liner backed out.

Steven
