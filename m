Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263768AbTIBUOD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 16:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263744AbTIBUOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 16:14:03 -0400
Received: from [213.39.233.138] ([213.39.233.138]:62377 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263768AbTIBUOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 16:14:00 -0400
Date: Tue, 2 Sep 2003 22:08:34 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Dave Olien <dmo@osdl.org>, Petri Koistinen <petri.koistinen@iki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: Sparse warning: bitmap.h: bad constant expression
Message-ID: <20030902200834.GB24744@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.56.0309012249230.14789@dsl-hkigw4a35.dial.inet.fi> <20030902015702.GA10265@osdl.org> <20030902095628.GB7616@wohnheim.fh-wedel.de> <16212.28592.322946.64754@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16212.28592.322946.64754@gargle.gargle.HOWL>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 September 2003 12:23:44 +0200, Mikael Pettersson wrote:
> 
> If data is a local variable then this is perfectly valid example of a
> C99 variable-length array (VLA). This works at least with gcc-2.95.3
> and newer, and gcc handles it by itself w/o calling alloca().

A lot of buggy code consists of perfectly valid C99. :)

> Of course, VLAs should be bounded in size to avoid overflowing the
> kernel stack, but that doesn't make them illegal per se.

There is a deeper problem to this.  At the moment, there is no way to
prove that the kernel doesn't contain a stack overflow somewhere.  In
order to do this, we can make some assumptions and do a formal proof
*as long as the assumptions are valid*.

This perfectly valid C99 code means either that we need very
complicated checker software - a problem in itself - or that the
assumptions are wrong and we are none the wiser.

And even if you ignore this pet project of mine, do you know of a sane
way to have an upper bound for a VLA?  And if there is, why not use a
static array with the upper bound as size in the first place?
Explicit is always simpler than implicit and simpler code has less
bugs. :)

Jörn

-- 
To recognize individual spam features you have to try to get into the
mind of the spammer, and frankly I want to spend as little time inside
the minds of spammers as possible.
-- Paul Graham
