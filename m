Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268346AbUI2Mgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268346AbUI2Mgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 08:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268345AbUI2Mgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 08:36:55 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:41347 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S268342AbUI2Mgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 08:36:44 -0400
Date: Wed, 29 Sep 2004 14:36:37 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Message-ID: <20040929123637.GA17952@wohnheim.fh-wedel.de>
References: <415A302E.5090402@comcast.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <415A302E.5090402@comcast.net>
User-Agent: Mutt/1.3.28i
Subject: Re: Compressed filesystems:  Better compression?
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Rcpt-To: nigelenki@comcast.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: joern@wohnheim.fh-wedel.de
X-SA-Exim-Version: 3.1 (built Son Feb 22 10:54:36 CET 2004)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 September 2004 23:46:54 -0400, John Richard Moser wrote:
> 
> In my own personal tests, I've gotten a 6.25% increase in compression
> ratio over bzip2 using the above lzma code.  These were very weak tests
> involving simply bunzipping a 32MiB tar.bz2 of the Mozilla 1.7 source
> tree and recompressing it with lzma, which produced a 30MiB tar.lzma.  I
> tried, but could not get it to compress much better than that (I think I
> touched 29.5 at some point but not sure, it was a while ago).

Sounds sane.  bzip2 is really hurt by the hart limit of 900k for block
sorting.

Inside the kernel, other things start to matter, though.  If you
really want to impress me, take some large test data (your mozilla.tar
or whatever), cut it up into chunks of 4k and compress each chunk
individually.  Does lzma still beat gzip?

If you can at least get it to compress better for 64k chunks, that's
already quite interesting.  But excellent compression with infinite
chunk-size and infinite memory is quite pointless inside the kernel.
Such things should be left in userspace where they belong.

Jörn

-- 
The wise man seeks everything in himself; the ignorant man tries to get
everything from somebody else.
-- unknown
