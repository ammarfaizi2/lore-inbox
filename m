Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266059AbTGIQTT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 12:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266057AbTGIQTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 12:19:19 -0400
Received: from pirx.hexapodia.org ([208.42.114.113]:45871 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S266059AbTGIQTS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 12:19:18 -0400
Date: Wed, 9 Jul 2003 11:33:56 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Kurt Wall <kwall@kurtwerks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modutils-2.3.15 'insmod'
Message-ID: <20030709113356.B9732@hexapodia.org>
References: <Pine.LNX.4.53.0307091119450.470@chaos> <20030709160823.GC267@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030709160823.GC267@kurtwerks.com>; from kwall@kurtwerks.com on Wed, Jul 09, 2003 at 12:08:23PM -0400
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 12:08:23PM -0400, Kurt Wall wrote:
> Quoth Richard B. Johnson:
> > modutils-2.3.15, and probably later, has a bug that can prevent
> > modules from being loaded from initrd, this results in not
> > being able to mount a root file-system. The bug assumes that
> > malloc() will return a valid pointer when given an allocation
> > size of zero.
> 
> This isn't a bug. The standard allow returning a non-null pointer
> for malloc(0).

It's not literally a bug in libc -- the C standard says it's
implementation-defined whether malloc(0) returns NULL or a cookie -- but
it is definitely a bug (in a portable program) to depend on either
behavior from libc.  See ISO/IEC 9899:1999 7.20.3 paragraph 1.

> > The most recent `man` pages that RH 9.0 distributes states that
> > malloc() can return either NULL of a pointer that is valid for
> > free(). This, of course, depends upon the 'C' runtime library's
> > malloc() implementation.
> 
> Perhaps, but IIRC, the rationale in the GNU C library was that
> existing programs assume malloc(0) != 0, which allows you to call
> realloc on the pointer. Returning NULL only makes sense if the 
> malloc() call fails.

This paragraph is nonsensical, because realloc(malloc(0), 10) is
allowed, regardless of whether malloc(0) returns NULL or a cookie.
realloc(NULL, n) is allowed, and defined to be identical to malloc(n).
7.20.3.4 paragraph 3.

Geez, why does a trivial post about a bug in some program have to turn
into a pile of misleading statements and citations to ISO documents?

-andy
