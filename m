Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVAQX6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVAQX6Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 18:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVAQX5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 18:57:51 -0500
Received: from [194.109.195.176] ([194.109.195.176]:63443 "EHLO
	scrub.xs4all.nl") by vger.kernel.org with ESMTP id S261531AbVAQX5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 18:57:32 -0500
Date: Tue, 18 Jan 2005 00:57:11 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Karim Yaghmour <karim@opersys.com>
cc: Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <41EC2DCA.50904@opersys.com>
Message-ID: <Pine.LNX.4.61.0501172323310.30794@scrub.home>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
 <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>
 <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home>
 <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home>
 <41E899AC.3070705@opersys.com> <Pine.LNX.4.61.0501160245180.30794@scrub.home>
 <41EA0307.6020807@opersys.com> <Pine.LNX.4.61.0501161648310.30794@scrub.home>
 <41EADA11.70403@opersys.com> <Pine.LNX.4.61.0501171403490.30794@scrub.home>
 <41EC2DCA.50904@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Jan 2005, Karim Yaghmour wrote:

> > Periodically can also mean a buffer start call back from relayfs 
> > (although that would mean the first entry is not guaranteed) or a 
> > (per cpu) eventcnt from the subsystem. The amount of needed search would 
> > be limited. The main point is from the relayfs POV the buffer structure 
> > has always the same (simple) structure.
> 
> But two e-mails ago, you told us to drop the start_reserve and end_reserve
> and move the details of the buffer management into relayfs and out of
> ltt? Either we have a callback, like you suggest, and then we need to
> reserve some space to make sure that the callback is guaranteed to have
> the first entry, or we drop the callback and provide an option to the
> user for relayfs to write this first entry for him. Providing a callback
> without reservation is no different than relying purely on the heartbeat,
> which, like I said before and for the reasons illustrated below, is
> unrealistic.

Why is so important that it's at the start of the buffer? What's wrong 
with a special event _near_ the start of a buffer?

> > Why is it "totally unrealistic"?
> 
> Ok, let's expand a little here on the amount of data. Say you're getting
> 2MB/s of data (which is not unrealistic on a loaded system.) That means
> that if I'm tracing for 2 days, I've got 345GB of data (~7.5GB/hour).
> In practice, users aren't necessarily interested in plowing through the
> entire 345GB, they just want to view a given portion of it. Now, if I
> follow what you are suggesting, I have to go through the entire 345GB to:
> a) create indexes, b) reorder events, and likely c) have to rewrite
> another 345GB of data. And I haven't yet discussed the kind of problems
> you would encounter in trying to reorder such a beast that contains,
> by definition, variable-sized events. For one thing, if event N+1 doesn't
> follow N, then you would be forced to browse forward until you actually
> found it before you could write a properly ordered trace. And it just
> takes a few processes that are interrupted and forced to sleep here and
> there to make this unusable. That's without the RAM or fs space required
> to store those index tables ... At 3 to 12 bytes per events, that's a lot
> of space for indexes ...
> 
> If I keep things as they are with ordered events and delimiters on buffer
> boundaries, I can skip to any place within this 345GB and start processing
> from there.

What gives you the idea, that you can't do this with what I proposed?
You can still seek freely within the data at buffer boundaries and you 
only have to search a little into the buffer to find the delimiter. Events 
are not completely at random, so that the little reordering can be done at 
runtime. Sorry, but I don't get what kind of unsolvable problems you see 
here.

> Rhetorical: Couldn't the ad-hoc mode case be a special case of the
> managed mode?

Wrong question. What compromises can be made on both sides to create a 
common simple framework? Your unwillingness to compromise a little on the 
ltt requirements really amazes me.

bye, Roman
