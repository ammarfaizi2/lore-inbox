Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUBNPY1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 10:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUBNPY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 10:24:27 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:55187 "EHLO uni-kl.de")
	by vger.kernel.org with ESMTP id S262048AbUBNPYZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 10:24:25 -0500
Date: Sat, 14 Feb 2004 16:24:14 +0100
From: Eduard Bloch <edi@gmx.de>
To: John Bradford <john@grabjohn.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040214152414.GB5023@zombie.inka.de>
References: <20040209115852.GB877@schottelius.org> <200402121740.03974.robin.rosenberg.lists@dewire.com> <200402121716.i1CHGXLv000188@81-2-122-30.bradfords.org.uk> <200402121906.54699.robin.rosenberg.lists@dewire.com> <200402121908.i1CJ86NC000167@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200402121908.i1CJ86NC000167@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by mailgate1.uni-kl.de id i1EFONRL007825
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* John Bradford [Thu, Feb 12 2004, 07:08:06PM]:

> Well, as long as every userspace implementation gets it correct, we'll
> be OK.  Personally, I doubt they all will, especially those that
> convert from legacy encodings to Unicode, although quite possibly the
> above scenario with combining characters is not likely to happen for
> filenames.  Or is it?  What about copying a file from a filesystem
> with a UTF-8 encoding to a filesystem with a legacy encoding, and then
> back again?

I always wondered why there is no "iocharset" option for unixoid
filesystems. IMO there could be an easy migration path for existing
installations to UTF-8:

 - convert all filenames to UTF-8 (or any other Unicode encoding)
 - mount the FS with "iocharset=UTF-8,charset=latin1" (for current
   Latin1 users). Users can continue to use their latin1 names while
   they are stored in Unicode on the disk (this is what currently
   happens with VFAT, a very nice solution IMHO)
 - when enough applications are ready for multibyte encodings, remove
   the charset/iocharset workaround and make people use .UTF-8 locales

Though, the ultimate solution for the steps 2. and 3. would be the
Microsoft-like way:

 - convert the filenames in libc (from $locale to UTF-8), depending on
   which locale the user has set

This sounds like cheating but would allow to be most flexible and most
compatible to encoding-ignoring applications.

Eduard.
-- 
Wir sind nichts; was wir suchen ist alles.
		-- Johann Christian Friedrich Hölderlin
