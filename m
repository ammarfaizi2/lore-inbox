Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265722AbTIJUNV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 16:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265723AbTIJUNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 16:13:21 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:8337 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S265722AbTIJUNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 16:13:19 -0400
Date: Wed, 10 Sep 2003 21:12:40 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops_in_progress is unlikely()
Message-ID: <20030910201240.GB24424@mail.jlokier.co.uk>
References: <20030907064204.GA31968@sfgoth.com> <20030907221323.GC28927@redhat.com> <20030910142031.GB2589@elf.ucw.cz> <20030910142308.GL932@redhat.com> <20030910152902.GA2764@elf.ucw.cz> <Pine.LNX.4.53.0309101147040.14762@chaos> <20030910183138.GA23783@mail.jlokier.co.uk> <Pine.LNX.4.53.0309101439390.18459@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309101439390.18459@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> 		cmpl	$1, %eax
> 		jz	1f
> 		jc	2f
> 		call	do_default
> 		jmp	more_code
> 	1:	call	do_something_if_equal
> 		jmp	more_code
> 	2:	call	do_something_if_less
> 	more_code:
> 
> In every case, one has to jump around code for other execution paths
> except the last, where you have to jump on condition anyway. There
> is no free liunch, and the straight-through route, do_default
> uas just as many jumps as the last.

Here is your code optimised for no jumps in the "do_default" case:

		cmpl	$1,%eax
		jbe	1f
		call	do_default
	more_code:
		.subsection 1
	1:	jnz	2f
		call	do_something_if_equal
		jmp	more_code
	2:	call	do_something_if_less
		jmp	more_code
		.previous

> > How would you optimise it, if you were writing assembly language yourself?

> I did. And I do this for a living. And, after 30 years of this shit
> they still haven't fired me. Learn something. I'm pissed.

It's ok to be pissed.  I'd be pissed too :)

*ducks*

Enjoy :)
-- Jame
