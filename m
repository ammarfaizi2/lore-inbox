Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272563AbTHSR7r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272453AbTHSR7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:59:44 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:3076 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S272563AbTHSRsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 13:48:17 -0400
Date: Tue, 19 Aug 2003 19:48:14 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Andries Brouwer <aebr@win.tue.nl>, Vojtech Pavlik <vojtech@suse.cz>,
       Jamie Lokier <jamie@shareable.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030819194814.A2179@pclin040.win.tue.nl>
References: <20030818122933.A970@pclin040.win.tue.nl> <Pine.GSO.3.96.1030819143241.29184C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030819143241.29184C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Aug 19, 2003 at 03:04:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 03:04:58PM +0200, Maciej W. Rozycki wrote:

> > >  Well, mode #3 with no translation in the i8042 looks quite sanely. 
> > 
> > In theory perhaps. In practice it isnt sane at all.
> 
>  Yep, the design is clean.  And we can handle it for good devices, for its
> additional functionality (e.g. autorepeat of <Pause> ;-) ) and to have a
> clean reference design of code.  I see no reason to "punish" good devices
> for the faults of bad ones.

Your reasoning is backwards.
For the user the only thing that matters is that the keyboard works.
Which codes certain chips send to each other is completely irrelevant.

Everybody uses translated Set 2. It works.
Anything else gives obscure problems.

If we exchange ugly code that fails for one in a million users
for nice code that fails for one in tenthousand users,
that is no progress.

> > (That is, the majority of the keyboards sold today do not do as one
> > would wish. Since Microsoft does not require anything for Set 3,
> > behaviour in Set 3 is essentially random, especially for these
> > additional keys and buttons. A single keypress may give several
> > scancodes, or none at all. Many laptops do not have any support
> 
>  Well, we need not take care of non-standard keys -- as such they need to
> be handled on a case-by-case basis (with customized key maps).

If the keyboard is in Set 3, then these keys may not give any scancode at all.
In order for the non-standard keys to work we need Set 2.

My laptop has function buttons that bring me to a setup menu where
I can set various timeouts related to power saving. These built-in
menus react to translated scancode Set 2 only. There is no way to get
out if one first chooses Set 3.

Etc. Set 3 is a pain. Nobody wants it, except the people who have read
the spec only and say - look, neat, a single code for a single keystroke.
Reality is very different.

>  If standard keys are broken, then we can still revert to mode #2 with all
> its limits as we do now.  At least we can disable the translation in the
> i8042 to get full and unambiguous scan codes.

Also disabling translation causes all kinds of obscure troubles.
It is extremely unwise to go for obscure modes that were supported by
most keyboards ten years ago, and may or may not have any support today.

Andries

