Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbTHULiM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 07:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbTHULiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 07:38:12 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:16579 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S262616AbTHULiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 07:38:06 -0400
Date: Thu, 21 Aug 2003 13:37:34 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Vojtech Pavlik <vojtech@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
In-Reply-To: <20030819194814.A2179@pclin040.win.tue.nl>
Message-ID: <Pine.GSO.3.96.1030821125736.2489B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003, Andries Brouwer wrote:

> >  Yep, the design is clean.  And we can handle it for good devices, for its
> > additional functionality (e.g. autorepeat of <Pause> ;-) ) and to have a
> > clean reference design of code.  I see no reason to "punish" good devices
> > for the faults of bad ones.
> 
> Your reasoning is backwards.
> For the user the only thing that matters is that the keyboard works.
> Which codes certain chips send to each other is completely irrelevant.

 The codes might not matter much to a user.  But mode #3 gives additional
control over the keyboard which can be made user-visible.

> Everybody uses translated Set 2. It works.
> Anything else gives obscure problems.

 It mostly works, indeed.  With all its limitations. 

> If we exchange ugly code that fails for one in a million users
> for nice code that fails for one in tenthousand users,
> that is no progress.

 I see no reason to force that 99 people per million to use anything
beyond they had so far.  But why have the remaining 999900 people got to
suffer?

 Fortunately we already have an option to force one set or another.

> >  Well, we need not take care of non-standard keys -- as such they need to
> > be handled on a case-by-case basis (with customized key maps).
> 
> If the keyboard is in Set 3, then these keys may not give any scancode at all.
> In order for the non-standard keys to work we need Set 2.

 Interesting...

> My laptop has function buttons that bring me to a setup menu where
> I can set various timeouts related to power saving. These built-in
> menus react to translated scancode Set 2 only. There is no way to get
> out if one first chooses Set 3.

 Well, that's a design error.  Can you do that when running Linux?  I
suppose so.  That means the SMM is involved with its all obscurities.  The
design error is it should be under the control of the OS. 

> Etc. Set 3 is a pain. Nobody wants it, except the people who have read
> the spec only and say - look, neat, a single code for a single keystroke.

 Plus the symmetry of keys -- no more strange behaviour of "special" keys. 
That's more important -- all keys behave the same way and they do not
magically depend on modifiers.

> Reality is very different.

 Actually the spec is a standard and standard hardware performs as
expected (e.g. hardware released by IBM).  The rest is non-standard and if
a manufacturer claims PS/2-compliance for any of these items, then he
lies. 

> >  If standard keys are broken, then we can still revert to mode #2 with all
> > its limits as we do now.  At least we can disable the translation in the
> > i8042 to get full and unambiguous scan codes.
> 
> Also disabling translation causes all kinds of obscure troubles.
> It is extremely unwise to go for obscure modes that were supported by
> most keyboards ten years ago, and may or may not have any support today.

 Note the translation is done outside the keyboard -- the onboard 8042
controller is responsible for it.  And it's an obstacle for normal
operation, most notably you cannot handle hot-plug events as they are
undistinguishable from a <Shift> release. 

 To summarize -- I do not want anyone to suffer unnecessarily because of
having bad hardware (i.e. beyond what's directly caused by the limitations
of such hardware).  But those who have good hardware should be able to
make good use of it.  And I prefer the defaults to assume good hardware --
for bad hardware a command line option may override the defaults.  This
way bad hardware becomes visible -- right now a user cannot easily
distinguish between a good keyboard and a broken one, so he has no obvious
choice and also there is no incentive for manufacturers to fix broken
devices for those who care (I wouldn't mind a statement on a keyboard box
e.g.: "Windows-compliant" or "PS/2-compliant" or both, so that I know what
to choose). 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

