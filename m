Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbTJNKSR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 06:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTJNKSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 06:18:17 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:13953 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262310AbTJNKSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 06:18:15 -0400
Date: Tue, 14 Oct 2003 11:19:20 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310141019.h9EAJKT2001118@81-2-122-30.bradfords.org.uk>
To: Hans Reiser <reiser@namesys.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Wes Janzen <superchkn@sbcglobal.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3F8BB7AE.2040507@namesys.com>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60>
 <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk>
 <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
 <20031014064925.GA12342@bitwizard.nl>
 <3F8BA037.9000705@sbcglobal.net>
 <200310140721.h9E7LmNE000682@81-2-122-30.bradfords.org.uk>
 <20031014074020.GC13117@bitwizard.nl>
 <200310140811.h9E8Bxq1000831@81-2-122-30.bradfords.org.uk>
 <3F8BB7AE.2040507@namesys.com>
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I know I said my previous post was the last one on this subject, but
we seem to have moved on to a slightly different area).

Quote from Hans Reiser <reiser@namesys.com>:
> Perhaps we should tell people to first write to the bad block, and only 
> if the block remains bad after triggering the remapping by writing to it 
> should you make any effort to get the filesystem to remap it for you.  
> What do you think?

I'm not convinced that this belongs in the filesystem.  I can see how
it makes sense in some ways for magnetic disk devices, but that's not
the filesystem's concern.  How would we know that the write isn't
being cached by hardware further along the line, for example?  What
are the negative effects of repeated writes if the filesystem is on
flash, or a tape.  A damaged tape could be damaged more by winding
back and forth, for example, (OK, tape is a bad example, but some
future storage technology that we don't know about could have an
analogous problem.  My point is that just because 99% of installations
will use ReiserFS on disk device, is it right to put disk device
specifics in the FS?).

Also, one corner case that occurs to me is that the first remapping
worked, and then the newly allocated area went bad in the time before
we verified it.  Then it could look like a persistant fault, when it
is infact it's two separate faults.  Realistically, though, I suspect
that is only likely to happen on a rapidly dieing disk, in which case
there isn't much we can do anyway.

In general, though, the question is really, should ReiserFS be usable
on a device which doesn't do it's own bad block handling?  I suggest
no.

The ultimate point is that only the drive firmware really knows what's
going on, and it can make informed decisions based on things that
nothing external to the drive knows about.  How much error correction
it needed to read a block, the number of errors per physical head, and
per physical cylinder, etc.  The filesystem can only generally make a
decision based on whether there is an error or not.

> Rogier has not indicated that he has tried writing to the bad sector, 
> has he?

I don't think so.

John.
