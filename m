Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265554AbTIJTEU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265533AbTIJTDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:03:09 -0400
Received: from gprs145-173.eurotel.cz ([160.218.145.173]:59010 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265526AbTIJTCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:02:16 -0400
Date: Wed, 10 Sep 2003 21:02:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Jamie Lokier <jamie@shareable.org>, Dave Jones <davej@redhat.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops_in_progress is unlikely()
Message-ID: <20030910190202.GG2834@elf.ucw.cz>
References: <20030907064204.GA31968@sfgoth.com> <20030907221323.GC28927@redhat.com> <20030910142031.GB2589@elf.ucw.cz> <20030910142308.GL932@redhat.com> <20030910152902.GA2764@elf.ucw.cz> <Pine.LNX.4.53.0309101147040.14762@chaos> <20030910183138.GA23783@mail.jlokier.co.uk> <Pine.LNX.4.53.0309101439390.18459@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309101439390.18459@chaos>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Your guess is incorrect.
> >
> > > You are always going to take an extra jump in one execution
> > > path after the function, and you will take a conditional jump
> > > before the function call in the other execution path. So, you
> > > always have the "extra" jumps, no matter.
> >
> > That is not true.  The "likely" path has no taken jumps.
> >
> 
> Absolutely, positively, irrefutably wrong! Any logical operation
> with any real processor can only result in a jump upon condition. The
> path not taken will always require a jump around the code that
> handled the jump upon condition unless the code exists at
> the end of a procedure where a 'return' will suffice. Period.

No.

	jz	not_likely
	likely_code
go_back:
	more_likely_core
	retn	

not_likely:
	do_whatever_you_need
	jmp go_back
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
