Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUITXGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUITXGr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 19:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266187AbUITXGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 19:06:46 -0400
Received: from mail.tmr.com ([216.238.38.203]:28686 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265943AbUITXGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 19:06:43 -0400
Date: Mon, 20 Sep 2004 18:59:33 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Robert Love <rml@novell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] inotify 0.9
In-Reply-To: <1095714306.3666.39.camel@betsy.boston.ximian.com>
Message-ID: <Pine.LNX.3.96.1040920180744.11755B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2004, Robert Love wrote:

> On Mon, 2004-09-20 at 16:16 -0400, Bill Davidsen wrote:

> You can pin just a directory and retrieve all of the events therein.
> You do not need to pin every single inode on your machine.  This is the
> same as dnotify - except inotify also allows you to watch individual
> files.
> 
> > I'm not clear on what race you would get sending a notify to a user mode 
> > process that an inode had changed, but if you say there could be one I 
> > can't argue.
> 
> If you cannot track the lifecycle of the object being watched, you
> essentially cannot watch it.  To track the lifetime of an inode, you
> need to ensure that it remains in the icache.

What I proposed as a possible implementation was to have anything which
did a trackable operation on the inode send a notify to user space. And
that isn't the same as dnotify although it might address some of the same
uses. As a for instance when an open is done the open code sends a notify,
and until that time it's not obvious that the inode must be pinned. By
having a single user program accept the notify and decide what to do, the
kernel can do less of it. Yes, that could mean passing out a lot of
information which would be dropped by the user program. That's what I had
in mind when I asked if the process needed to be real time.


> Look, Bill: Conjecturing about a potential problem in a space you are
> unfamiliar with does nothing but obstruct Linux development and act as
> Stop Energy.  Constructive, well-informed opinions are money.
> Everything else is just liking the sound of your voice.

If an idea is so tenuous that one person noting that the memory overhead
of a feature is or could be very high and asking "could it be done thus"
provides Stop Enargy then there may be a lack of conviction.

I personally don't mind being questioned on an idea, it points out flaws,
it lets me be confident that I have it right, or at least avoid putting a
lot of effort into something and then having someone say "oh here's a
better way." I don't go with "how dare you question me?"

I have virtually no experience with dnotify, but a lot with putting Linux
on old small systems to give to low income kids who can buy "modern" 
machines, and if I see a feature which won't run on a small machine I want
to suggest that there might be a better way. Sorry, a lower resource cost
way. 

Developers don't typically have small slow machines, and don't think about
the old, embedded, or laptop uses unless someone mentions it. I'm sorry
you think think I'm talking to hear myself talk, the point I'm making is
valid to me.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

