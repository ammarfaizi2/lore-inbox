Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266396AbUBLSHC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 13:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266495AbUBLSHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 13:07:02 -0500
Received: from [212.28.208.94] ([212.28.208.94]:45316 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266396AbUBLSG7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 13:06:59 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: John Bradford <john@grabjohn.com>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Thu, 12 Feb 2004 19:06:54 +0100
User-Agent: KMail/1.6.1
Cc: Linux kernel <linux-kernel@vger.kernel.org>
References: <20040209115852.GB877@schottelius.org> <200402121740.03974.robin.rosenberg.lists@dewire.com> <200402121716.i1CHGXLv000188@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200402121716.i1CHGXLv000188@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402121906.54699.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 February 2004 18.16, John Bradford wrote:
> I'm not sure whether it's valid UTF-8 or not, but it's certainly
> possible to code, for example, an 'A', (decimal 65), via an escape to
> a 31-bit character representation.  Presumably the majority of UTF-8
> parsers would decode the sequence as 65, rather than emit an error.

There are many ways of getting things wrong. The algorithm for encoding 
UTF-8 doesn't give you the option of encoding 65 as two bytes; any UCS-4 
character with code 0-0x7F must result in a onand the same principle goes 
for every other character and the unicdeo standard forbids the use of anything
but the shortest possible sequence.

> Also, even ignoring that, how do you handle things like accented
> characters which can be represented as single characters, or as
> sequences containing combining characters?  Some applications might
> convert the sequence containing combining characters in to the single
> character, and others might not.

In UTF-8 you cannot represent à as `a. I can have both in a file name and they
are different. An application that assumes `a is the same a à (in UTF-8) is broken
and should be fixed. 

-- robin
