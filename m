Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTF3NNA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 09:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTF3NNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 09:13:00 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:49660 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263281AbTF3NM6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 09:12:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: rmoser <mlmoser@comcast.net>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
Date: Mon, 30 Jun 2003 08:26:54 -0500
X-Mailer: KMail [version 1.2]
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk> <200306291545410600.02136814@smtp.comcast.net>
In-Reply-To: <200306291545410600.02136814@smtp.comcast.net>
MIME-Version: 1.0
Message-Id: <03063008265401.14007@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 June 2003 14:45, rmoser wrote:
> *********** REPLY SEPARATOR  ***********
>
> On 6/29/2003 at 8:42 PM viro@parcelfarce.linux.theplanet.co.uk wrote:
> >On Sun, Jun 29, 2003 at 08:28:47PM +0100, Jamie Lokier wrote:
> >> Consider that many people choose ext3 rather than reiser simply
> >> because it is easy to convert ext2 to ext3, and hard to convert ext2
> >> to reiser (and hard to convert back if they don't like it).  I have
> >> seen this written by many people who choose to use ext3.  Thus proving
> >> that there is value in in-place filesystem conversion :)
> >
> >Uh-huh.  You want to get in-kernel conversion between ext* and reiserfs?
> >With recoverable state if aborted?  Get real.
>
> no, in-kernel conversion between everything.  You don't think it can be
> done? It's not that difficult a problem to manage data like that :D

You are ASSUMING that the new filesystem requires lessthan or equal amount
of metadata. This is NOT always true. A conversion of a full EXT2 to Riserfs
would fail simply because there is no free space to expand the needed
additional overhead.

Going in the other direction usually is possible (again, depending on the
filesystem) but there are exceptions... Try converting an EXT2 to DosFS.
In place. And maintain a recoverable state when aborted.

Not gonna happen.

Too much depends on what the target filesystem is, and what it may require.

Consider another - switching to an extent filesystem... If the datablocks 
don't move, then you need MORE extents than the current indirect pointers.
And each extent is LARGER than the indirect pointers.

Then you have to compress/condense the extents (requiring shuffling data
blocks around to reduce the number of extents). Each requires free space
to do it's work, and the amount of free blocks is not the same.

Faster to do a copy. more reliable too. and recoverable.
