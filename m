Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266628AbUBLW3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 17:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266633AbUBLW3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 17:29:15 -0500
Received: from [212.28.208.94] ([212.28.208.94]:6406 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266628AbUBLW3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 17:29:13 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: John Bradford <john@grabjohn.com>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Thu, 12 Feb 2004 23:29:11 +0100
User-Agent: KMail/1.6.1
Cc: Linux kernel <linux-kernel@vger.kernel.org>
References: <20040209115852.GB877@schottelius.org> <200402122039.19143.robin.rosenberg.lists@dewire.com> <200402122113.i1CLDqoB000179@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200402122113.i1CLDqoB000179@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402122329.11182.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 February 2004 22.13, you wrote:
> I know what you're saying, there is only one way to encode the data
> correctly.  I totally agree with that.
> 
> However, we both know that UTF-8 provides escapes from the 7-bit
> encoding, and although it goes against the standard to encode 7-bit
> characters using such sequences, in the real world don't you think
> that there will be a lot of decoders which decode the multi-byte
> sequence back, rather than report an error?  This is not something
> that will be happening in the kernel - it will be up to userspace to
> do it, so there may well be many different implementations.

Oh, I wasn't thinking of fixing *every* application out there, but making
the kernel api's convert between the user locale and the file system locale,
thus restricting the problems to places that can be fixed.

An alternative would be glibc since it's used by most apps, but then there
could be funny and inefficient interactions with filesystems that already
do the job. The "future" common case would be utf-utf conversion for all
native file systems, i.e. no work.

[... ]

> I don't think that the issue with combining characters is likely to be
> an issue, I only mentioned it as an example.  As you pointed out a
> single accented character, and a two character combination are
> distinct, and converting the combination to the corresponding single
> character in a filename would definitely be wrong, in my opinion.
> However, that doesn't mean that software won't do it.

Some applications break if I put any non-ascii characters, but they few
enough that I can afford the loss. Most shell scripts break if I even have
a space in a filename.  This shouldn't be any worse than that. The space
issue is really serious (but I don't think that can be fixed other than teaching
people to program properly, and possibly improving bash's knowledge of the 
difference between a space and argument separator).

-- robin
