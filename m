Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUHQXJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUHQXJt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 19:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268509AbUHQXJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 19:09:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:37321 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265395AbUHQXJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 19:09:15 -0400
Date: Tue, 17 Aug 2004 16:12:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org,
       benh@kernel.crashing.org, david-b@pacbell.net
Subject: Re: [patch] enums to clear suspend-state confusion
Message-Id: <20040817161245.50dd6b96.akpm@osdl.org>
In-Reply-To: <20040817223700.GA15046@elf.ucw.cz>
References: <20040812120220.GA30816@elf.ucw.cz>
	<20040817212510.GA744@elf.ucw.cz>
	<20040817152742.17d3449d.akpm@osdl.org>
	<20040817223700.GA15046@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> > If, at some time in the future you change the suspend state to a struct
> > then you will want to pass that thing around by reference, not by
> > value. 
> 
> Actually I expect it to become struct of two members, system-state and
> bus-specific state. That seems small enough to pass by value.

hm.  Yes, it's hard to see how this structure can grow much larger.

But we'll be stuck for all time with a weird interface, just because once back
in August of '04 we didn't want to patch 129 files.

> > Hence your new suspend_state_t will need to be typecast to a pointer to
> > struct, and not a struct.  And that's not a thing which we do in-kernel
> > much at all.  (There's nothing wrong with the practice per-se, but in the
> > kernel it does violate the principle of least surprise).
> > 
> > So if you really do intend to add more things to the suspend state I'd
> > suggest that you set the final framework in place immediately.  Do:
> > 
> > struct suspend_state {
> > 	enum system_state state;
> > }
> 
> I can do that... but it will break compilation of every driver in the
> tree. I can fix drivers I use and try to fix some more will sed, but
> it will be painfull (and pretty big diff, and I'll probably miss some).

That's OK - it's just an hour's work.  I'd be more concerned about
irritating people who are maintaining and using out-of-tree drivers.

Can you remind me why we need _any_ of this?  "enums to clear suspend-state
confusion" sounds like something which is very optional.  I'd be opting to
go do something else instead ;)

