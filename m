Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbTIBKzY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 06:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263684AbTIBKzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 06:55:24 -0400
Received: from [213.39.233.138] ([213.39.233.138]:52167 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261978AbTIBKzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 06:55:19 -0400
Date: Tue, 2 Sep 2003 12:54:56 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Dave Olien <dmo@osdl.org>, Petri Koistinen <petri.koistinen@iki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: Sparse warning: bitmap.h: bad constant expression
Message-ID: <20030902105456.GC7616@wohnheim.fh-wedel.de>
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
> =?iso-8859-1?Q?J=F6rn?= Engel writes:
>  > On Mon, 1 September 2003 18:57:02 -0700, Dave Olien wrote:
>  > > 
>  > > The problem seems to be that sparse currently will only accept array
>  > > declarations with a size that can be evaluated at compile time to
>  > > a fixed value.  So an array declaration of the form:
>  > > 
>  > > int asize;
>  > > int data[asize];
>  > > 
>  > > will fail.  sparse needs to be modified to recognize this type of 
>  > > declaration with a variable array size.  That'll take a few hours of
>  > > someone's time to fix.
>  > 
>  > Not quite true.  The above is an implicit call to alloca and should
>  > not exist in the kernel.  No need to hack support into sparse.
> 
> If data is a local variable then this is perfectly valid example of a
> C99 variable-length array (VLA). This works at least with gcc-2.95.3
> and newer, and gcc handles it by itself w/o calling alloca().
> 
> Of course, VLAs should be bounded in size to avoid overflowing the
> kernel stack, but that doesn't make them illegal per se.

Ok, if you prefer this wording:
"It does exactly what alloca() would do, but is harder to grep for."

It uses an unknown amount of stack space, the stack is finite and
small and random bad things happen when it spills over.

Jörn

-- 
"Security vulnerabilities are here to stay."
-- Scott Culp, Manager of the Microsoft Security Response Center, 2001
