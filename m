Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266621AbUBMARN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 19:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266625AbUBMARN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 19:17:13 -0500
Received: from mail.shareable.org ([81.29.64.88]:7298 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S266621AbUBMARI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 19:17:08 -0500
Date: Fri, 13 Feb 2004 00:17:02 +0000
From: Jamie Lokier <jamie@shareable.org>
To: John Bradford <john@grabjohn.com>
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040213001702.GA24981@mail.shareable.org>
References: <20040209115852.GB877@schottelius.org> <20040212004532.GB29952@hexapodia.org> <20040212085451.GC20898@mail.shareable.org> <200402121655.39709.robin.rosenberg.lists@dewire.com> <200402121617.i1CGHH2c000275@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402121617.i1CGHH2c000275@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> > Definitely a good reason.  It seem many assume file names are a local thing,
> > but this is not so. Now consider the case with an external firewire
> > disk or memory stick created on a machine with iso-8859-1 as the system character
> > set and e.g xfs as the file system. What happens when I hook it up to a new redhat
> > installation that thinks file names are best stored as utf8? Most non-ascii
> > file names aren't even legal in utf8.
> 
> Another thing to consider is that you can encode the same character in
> several ways using utf8,

No, you can't.  Only the shortest encoding of a character is valid
UTF-8, and any program which claims to comply with Unicode is
_required_ to reject all other encodings, citing security as the main
reason.

That means any code which transcodes UTF-8 to another encoding (such
as iso-8859-1) must reject the non-minimal forms as invalid
characters, in whatever way that is done.

If there's any transcoding code in Linux which doesn't do that, it's a
potential security hole and should be fixed.

> so two filenames could have different byte strings, but evaluate to
> the same set of unicode characters.

That's true in some other encodings I think (the iso-2022 ones), but
not UTF-8.

-- Jamie
