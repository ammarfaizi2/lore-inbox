Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263440AbTC2RM5>; Sat, 29 Mar 2003 12:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263441AbTC2RM5>; Sat, 29 Mar 2003 12:12:57 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:60065 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S263440AbTC2RM4>; Sat, 29 Mar 2003 12:12:56 -0500
Date: Sat, 29 Mar 2003 18:24:02 +0100 (MET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeremy Jackson <jerj@coplanar.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: linux kernel IDE development process question
In-Reply-To: <1048955308.1467.20.camel@contact.skynet.coplanar.net>
Message-ID: <Pine.SOL.4.30.0303291815560.27420-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

On 29 Mar 2003, Jeremy Jackson wrote:

> Hello IDE people,
>
> I'd like to get input from everyone involved in drivers/ide/ on the
> current development process.
>
> I would like to know what code is kept in sync between 2.4/2.5
> (2.2/2.0?).  This way I can start by understanding what is already being
> done. This is related to the recent "hdparm and removable IDE?" thread
> on LKML.
>
> I would like to start by declaring ide_hwifs[] static, and removing the
> extern ide_hwifs from ide.h.  all references to ide_hwifs[] will be
> converted to macros and/or access method functions, that return a
> pointer to a particular ide_hwifs_t.  for_each_hwif() and replacements
> for whatever else is in use will be provided as well, initially just
> doing the same thing that is done now, ie iterating through ide_hwifs[].

Yes, I've been thinking about this recently and I think this is the way to
go.

> There's more to my plan, that's just to get the discussion going.  I
> will only address what can be easily merged into all currently supported
> kernel trees, I just need to know what they are.

If it will be merged any time soon you may call yourself lucky :-).

> by creating a new file ide-kernel.[ch], and moving the ide_hwifs[] and
> accessor functions to it, each kernel tree can implement it differently
> without complicating backports for the common stuff.  Initially the
> changes will *not* alter any behaviour, just jockeying stuff into place

You should just commit changes to 2.5 and later port it to 2.4.

> to make that painless when the time comes.  (think about it: if the
> access methods return pointers, who's going to notice when ide_hwifs[]
> is replaced with a linked list?)

Yep, but probably there will be some problems in transition.

> My motivation: I'd *really* like to be able to sell entry level PC
> servers with hotswap raid1.  I'm not in a hurry, baby steps are ok, I
> just want to get the ball rolling.  It's all negotiable.  I'm no expert
> here.
>
> Regards,
>
> Jeremy
> --
> Jeremy Jackson <jerj@coplanar.net>

Regards
--
Bartlomiej Zolnierkiewicz

