Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265534AbTLHRNZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265535AbTLHRNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:13:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:52186 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265534AbTLHRNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:13:12 -0500
Date: Mon, 8 Dec 2003 09:12:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rafal Skoczylas <nils@secprog.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.test11 bug
In-Reply-To: <Pine.LNX.4.58.0312080848560.13236@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312080911470.13236@home.osdl.org>
References: <20031208034631.GA14081@secprog.org> <Pine.LNX.4.58.0312072100250.13236@home.osdl.org>
 <20031208161742.GB9087@secprog.org> <Pine.LNX.4.58.0312080848560.13236@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rafael - you had the wrong address for the kernel mailing list, and I
didn't notice when I replied.

Here is my comment again for the mailing list in case somebody else can
think of something. The more heads, the merrier.

		Linus

On Mon, 8 Dec 2003, Linus Torvalds wrote:
>
> On Mon, 8 Dec 2003, Rafal Skoczylas wrote:
> >
> > > Rafal - how consistent is the second form of the oops?
> > > Have you seen that trace more than once?
> >
> > Not exactly the same, but there are some similarities (If I understand
> > this log correctly). I ripped those oopses out of the logs so maybe you
> > could look yourself and see something I don't see:
> > http://secprog.org/who/rs/linux/2.6-test11-log.txt
>
> Oh wow.
>
> They all look to be (except for the odd last "bad page state" one, which
> is likely just a result of some _other_ earlier corruption) due to the
> high bit being cleared. And it's consistent across reboots too, so it's
> not just some corruption that stayed around in memory.
>
> In all cases it looks like a pointer that should have been of the form
> "0xDxxxxxxx", and was corrupted into the form "0x5xxxxxxx".
>
> And every time it's "mlnetd" - which may just be a coincidence (possibly
> brought on by that being the most commonly run thing on your box), but it
> certainly looks like it could also be an indication of the source of the
> corruption.
>
> I find it interesting that it seems to be bit 31 that is corrupt:
> admittedly that is also the only bit that is almost guaranteed to cause
> oopses when it corrupts (because it changes the pointer "the most"), but
> it's also to some degree one of the least used bits for bit operations. A
> lot of things use bit #0 for locking etc.
>
> I'll have to think about this, but quite frankly I'm also hoping to see
> more of a pattern about what this is all about. Can you keep your oopses
> up somewhere? Maybe opening a bug on bugme.osdl.org? Even though I don't
> use bugme personally, it's good to keep the record around when we don't
> immediately see the reason for something..
>
> 			Linus
>
