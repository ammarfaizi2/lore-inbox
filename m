Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbTIBJ45 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 05:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbTIBJ45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 05:56:57 -0400
Received: from [213.39.233.138] ([213.39.233.138]:35778 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263623AbTIBJ44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 05:56:56 -0400
Date: Tue, 2 Sep 2003 11:56:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dave Olien <dmo@osdl.org>
Cc: Petri Koistinen <petri.koistinen@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: Sparse warning: bitmap.h: bad constant expression
Message-ID: <20030902095628.GB7616@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.56.0309012249230.14789@dsl-hkigw4a35.dial.inet.fi> <20030902015702.GA10265@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030902015702.GA10265@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 September 2003 18:57:02 -0700, Dave Olien wrote:
> 
> The problem seems to be that sparse currently will only accept array
> declarations with a size that can be evaluated at compile time to
> a fixed value.  So an array declaration of the form:
> 
> int asize;
> int data[asize];
> 
> will fail.  sparse needs to be modified to recognize this type of 
> declaration with a variable array size.  That'll take a few hours of
> someone's time to fix.

Not quite true.  The above is an implicit call to alloca and should
not exist in the kernel.  No need to hack support into sparse.

Petri's code below has constant array bounds, once the preprocessing
is done, that should be fixed in sparse.

> On Mon, Sep 01, 2003 at 10:59:21PM +0300, Petri Koistinen wrote:
> > Hi!
> > 
> > If I try to compile latest kernel with "make C=1" I'll get many warning
> > messages from sparse saying:
> > 
> > warning: include/linux/bitmap.h:85:2: bad constant expression
> > warning: include/linux/bitmap.h:98:2: bad constant expression
> > 
> > Sparse doesn't seem to like DECLARE_BITMAP macros.
> > 
> > #define DECLARE_BITMAP(name,bits) \
> >         unsigned long name[BITS_TO_LONGS(bits)]
> > 
> > So what is wrong with this and how it could be fixed so that sparse
> > wouldn't complain?

Sorry, I've just had a casual glance at sparse so far.  Looks like a
preprocessing problem, that's all I can say.

Jörn

-- 
Fancy algorithms are slow when n is small, and n is usually small.
Fancy algorithms have big constants. Until you know that n is
frequently going to be big, don't get fancy.
-- Rob Pike
