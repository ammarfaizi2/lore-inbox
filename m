Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTJ2ULc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 15:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTJ2ULc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 15:11:32 -0500
Received: from mcomail03.maxtor.com ([134.6.76.14]:2571 "EHLO
	mcomail03.maxtor.com") by vger.kernel.org with ESMTP
	id S261567AbTJ2ULa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 15:11:30 -0500
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB3F0@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Pavel Machek'" <pavel@ucw.cz>, John Bradford <john@grabjohn.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Hans Reiser <reiser@namesys.com>,
       "'Norman Diamond'" <ndiamond@wta.att.ne.jp>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       linux-kernel@vger.kernel.org, nikita@namesys.com,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: RE: Blockbusting news, results get worse
Date: Wed, 29 Oct 2003 13:11:27 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz]
> 
> > > If you don't FLUSH CACHE, you have no guarantees your 
> data is on the 
> > > platter.
> > 
> > I think that the idea that is floating around is to 
> deliberately ruin
> > the formatting on part of the drive in order to simulate a 
> bad block.
> > 
> > Operation of disk drives immediately after a power failiure has been
> > discussed before, by the way:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=100665153518652&w=2
> 
> Well, that looks like pure speculation.
> 
> BTW I *do* believe that powerfail can make the sector bad. Imagine you
> bump into bad sector during write, and need to reallocate...
> 
> 								Pavel

Both the linked post and Pavel's point are correct.

In a modern drive, tolerances are so tight that your drive is constantly
re-writing blocks it knows it didn't write very well.  In a power-fail
event, there's little to no time to reallocate or reattempt a write, and
even less energy available to "fix" things that aren't within specification
anymore (spin speed, etc) ... if we don't get the actuator to the latch,
your drive probably won't spin again and you'll lose *all* your data, so
that is our number 1 concern when the power fails.

"Performance" IDE drives these days ship with 8MB buffers, which compounds
the problem even further if you're trying to get data on the media after
power has been cut.

