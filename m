Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266564AbUBLTj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 14:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266570AbUBLTj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 14:39:28 -0500
Received: from [212.28.208.94] ([212.28.208.94]:34821 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266564AbUBLTjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 14:39:22 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: John Bradford <john@grabjohn.com>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Thu, 12 Feb 2004 20:39:19 +0100
User-Agent: KMail/1.6.1
Cc: Linux kernel <linux-kernel@vger.kernel.org>
References: <20040209115852.GB877@schottelius.org> <200402121906.54699.robin.rosenberg.lists@dewire.com> <200402121908.i1CJ86NC000167@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200402121908.i1CJ86NC000167@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200402122039.19143.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 February 2004 20.08, you wrote:
> > There are many ways of getting things wrong. The algorithm for encoding 
> > UTF-8 doesn't give you the option of encoding 65 as two bytes; any UCS-4 
> > character with code 0-0x7F must result in a onand the same principle goes 
> > for every other character and the unicdeo standard forbids the use of anything
> > but the shortest possible sequence.
> 
> The recommended encoding algorithm forbids anything but the shortest
That algorithm is the /definition/ of UTF-8, not just an example. Sure you can actually 
do it another way, but the result is uniquely defined (or else it's not UTF-8).

> Well, as long as every userspace implementation gets it correct, we'll
> be OK.  Personally, I doubt they all will, especially those that
> convert from legacy encodings to Unicode, although quite possibly the
> above scenario with combining characters is not likely to happen for
> filenames.  Or is it?  What about copying a file from a filesystem
> with a UTF-8 encoding to a filesystem with a legacy encoding, and then
> back again?

Sounds like you think we want to invent a new problem. The problem is
here and it's real (not in the U.S, but the the rest of the world). There are 
Network file systems (samba in particular), partitions belonging to other 
OS's (ntfs, fat or even other Linux installation on the same machine), 
removable devices etc etc.

Microsoft introduced a kludge for managing long file names in a short filename 
context. Since Linux doesn't have the length limit a nicer kludge could be used
to represent unicode as non-unicode in userspace like a Uxxxxx. When there is
a mismatch there has to be kludge, but it's still many times better than a bunch
of character that look like garbage (and cause legacy application so choke).

-- robin
