Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUBLS6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 13:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUBLS6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 13:58:17 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1920 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266534AbUBLS6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 13:58:15 -0500
Date: Thu, 12 Feb 2004 19:08:06 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402121908.i1CJ86NC000167@81-2-122-30.bradfords.org.uk>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200402121906.54699.robin.rosenberg.lists@dewire.com>
References: <20040209115852.GB877@schottelius.org>
 <200402121740.03974.robin.rosenberg.lists@dewire.com>
 <200402121716.i1CHGXLv000188@81-2-122-30.bradfords.org.uk>
 <200402121906.54699.robin.rosenberg.lists@dewire.com>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm not sure whether it's valid UTF-8 or not, but it's certainly
> > possible to code, for example, an 'A', (decimal 65), via an escape to
> > a 31-bit character representation.  Presumably the majority of UTF-8
> > parsers would decode the sequence as 65, rather than emit an error.
> 
> There are many ways of getting things wrong. The algorithm for encoding 
> UTF-8 doesn't give you the option of encoding 65 as two bytes; any UCS-4 
> character with code 0-0x7F must result in a onand the same principle goes 
> for every other character and the unicdeo standard forbids the use of anything
> but the shortest possible sequence.

The recommended encoding algorithm forbids anything but the shortest
sequence, yes, but what will the majority of decoders do?  I suspect
that at least some will follow the usual networking rule of be liberal
in what you accept, which for filenames may well cause all sorts of
security holes.

> > Also, even ignoring that, how do you handle things like accented
> > characters which can be represented as single characters, or as
> > sequences containing combining characters?  Some applications might
> > convert the sequence containing combining characters in to the single
> > character, and others might not.
> 
> In UTF-8 you cannot represent à as `a. I can have both in a file name and they
> are different. An application that assumes `a is the same a à (in UTF-8) is broken
> and should be fixed. 

Well, as long as every userspace implementation gets it correct, we'll
be OK.  Personally, I doubt they all will, especially those that
convert from legacy encodings to Unicode, although quite possibly the
above scenario with combining characters is not likely to happen for
filenames.  Or is it?  What about copying a file from a filesystem
with a UTF-8 encoding to a filesystem with a legacy encoding, and then
back again?

However, I am less concerned about this second scenario than the first.

John.
