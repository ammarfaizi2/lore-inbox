Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266604AbUBLVIA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 16:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266600AbUBLVGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 16:06:40 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1920 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266596AbUBLVEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 16:04:00 -0500
Date: Thu, 12 Feb 2004 21:13:52 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402122113.i1CLDqoB000179@81-2-122-30.bradfords.org.uk>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200402122039.19143.robin.rosenberg.lists@dewire.com> 
References: <20040209115852.GB877@schottelius.org>
 <200402121906.54699.robin.rosenberg.lists@dewire.com>
 <200402121908.i1CJ86NC000167@81-2-122-30.bradfords.org.uk>
 <200402122039.19143.robin.rosenberg.lists@dewire.com>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Robin Rosenberg <robin.rosenberg.lists@dewire.com>:
> On Thursday 12 February 2004 20.08, you wrote:
> > > There are many ways of getting things wrong. The algorithm for encoding 
> > > UTF-8 doesn't give you the option of encoding 65 as two bytes; any UCS-4 
> > > character with code 0-0x7F must result in a onand the same principle goes 
> > > for every other character and the unicdeo standard forbids the use of anything
> > > but the shortest possible sequence.
> > 
> > The recommended encoding algorithm forbids anything but the shortest
> That algorithm is the /definition/ of UTF-8, not just an example. Sure you can actually 
> do it another way, but the result is uniquely defined (or else it's not UTF-8).

I know what you're saying, there is only one way to encode the data
correctly.  I totally agree with that.

However, we both know that UTF-8 provides escapes from the 7-bit
encoding, and although it goes against the standard to encode 7-bit
characters using such sequences, in the real world don't you think
that there will be a lot of decoders which decode the multi-byte
sequence back, rather than report an error?  This is not something
that will be happening in the kernel - it will be up to userspace to
do it, so there may well be many different implementations.

Imagine you have two files, with the following filename bytes:

11000001 10000001 00000000

01000001 00000000

..and a _real world_ application, which is not necessarily completely
UTF-8 conformant, tries to open the file with filename 'A'.  Which one
is it going to open?

> > Well, as long as every userspace implementation gets it correct, we'll
> > be OK.  Personally, I doubt they all will, especially those that
> > convert from legacy encodings to Unicode, although quite possibly the
> > above scenario with combining characters is not likely to happen for
> > filenames.  Or is it?  What about copying a file from a filesystem
> > with a UTF-8 encoding to a filesystem with a legacy encoding, and then
> > back again?
> 
> Sounds like you think we want to invent a new problem.

I am aware that similar problems already exist.  However, most legacy
encodings don't suffer from the first issue we discussed above, where
multiple byte sequences could be decoded to the same character codes.
I don't think that the issue with combining characters is likely to be
an issue, I only mentioned it as an example.  As you pointed out a
single accented character, and a two character combination are
distinct, and converting the combination to the corresponding single
character in a filename would definitely be wrong, in my opinion.
However, that doesn't mean that software won't do it.

John.
