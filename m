Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265695AbUA0U0S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbUA0U0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:26:17 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:30628 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S265695AbUA0UZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:25:48 -0500
Date: Tue, 27 Jan 2004 15:22:25 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto/sha256.c crypto/sha512.c
Message-ID: <20040127202225.GA15808@certainkey.com>
References: <20040127193945.GA15559@certainkey.com> <Xine.LNX.4.44.0401271514150.4185-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0401271514150.4185-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you take a peek in your/Plumb's crypto/md5.c you've reduced the F1() macro
to the identical operation as the new Ch() inline function.

It reduces gcc's tenancy to re-load values in functions such like:
  (x & y) ^ (~x & z)
  (x & y) ^ (x & z) ^ (y & z)

This works out much nicer:
   z ^ (x & (y ^ z))
   (x & y) | (z & (x | y))

I've seen this in a few .c files (gcc -S blah.c; vim blah.s)

The Ch() and Maj() operations are used a lot in sha256/512.

JLC

On Tue, Jan 27, 2004 at 03:14:53PM -0500, James Morris wrote:
> On Tue, 27 Jan 2004, Jean-Luc Cooke wrote:
> 
> > Optimized the choice and majority fuctions a bit.
> > 
> > Patch:
> >   http://jlcooke.ca/lkml/faster_sha2.patch
> > 
> > Test suite:
> >   http://jlcooke.ca/lkml/faster_sha2.c
> >   build with:
> >     gcc -O3 -s faster_sha2.c -o faster_sha2
> > 
> 
> What kind of performance improvement does this provide?

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
