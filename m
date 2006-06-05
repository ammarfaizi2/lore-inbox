Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751090AbWFEWBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWFEWBU (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 18:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWFEWBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 18:01:19 -0400
Received: from quickstop.soohrt.org ([85.131.246.152]:386 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S1751090AbWFEWBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 18:01:19 -0400
Date: Tue, 6 Jun 2006 00:01:17 +0200
From: Horst Schirmeier <horst@schirmeier.com>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, bdirks@pacbell.net
Subject: Re: [Patch] Zoran strncpy() cleanup
Message-ID: <20060605220117.GP7236@quickstop.soohrt.org>
Mail-Followup-To: Eric Sesterhenn <snakebyte@gmx.de>,
	LKML <linux-kernel@vger.kernel.org>, bdirks@pacbell.net
References: <1149538357.16994.7.camel@alice> <20060605210230.GN7236@quickstop.soohrt.org> <1149542155.17537.3.camel@alice> <20060605213645.GO7236@quickstop.soohrt.org> <1149543974.17681.2.camel@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149543974.17681.2.camel@alice>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2006, Eric Sesterhenn wrote:
> > Problem is, the strings are (possibly) still not zero-terminated:
> > strncpy() only appends zeroes if src contents are short enough; if they
> > are not, dest is only zero-terminated if dest[sizeof(dest)-1] was zero
> > before.
> > strlcpy() semantics promise more sanity; dest is always zero-terminated
> > (if its size is >= 1), and the size parameter holds total dest size.
> > (See lib/string.c for more details.)
> 
> In all cases there is a memset() which sets the entire structure to
> zero. Since we never write to the last byte with the strncpy() it will
> be null terminated. But if you think strlcpy() is safer for the future,
> i can make you a third patch.

I did not dig in the surrounding code that deeply, no doubt you're right
about the zero termination issue.

I just _personally_ think strlcpy(dest, src, sizeof(*dest)); looks
more sane than strncpy(dest, src, sizeof(*dest)-1);, and it additionally
does not rely on dest being zero-terminated beforehand.

Kind regards,
 Horst

-- 
PGP-Key 0xD40E0E7A
