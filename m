Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267284AbSKVB1h>; Thu, 21 Nov 2002 20:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbSKVB1g>; Thu, 21 Nov 2002 20:27:36 -0500
Received: from hera.cwi.nl ([192.16.191.8]:24812 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267284AbSKVB1b>;
	Thu, 21 Nov 2002 20:27:31 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 22 Nov 2002 02:34:35 +0100 (MET)
Message-Id: <UTC200211220134.gAM1YZn19628.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@transmeta.com
Subject: Re: [PATCH] kill i_dev
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From torvalds@transmeta.com  Fri Nov 22 00:57:03 2002

    > There is a single side effect: a stat on a socket now sees
    > a nonzero st_dev. There is nothing against that - FreeBSD
    > has a nonzero value as well - but there is at least one
    > utility (fuser) that will need an update.

    Looking at the patch (not testing it), as far as I can tell we'll return a 
    basically random number that is just whatever the anonymous super-block 
    was allocated, right?

Right.

    I'm not convinced that returning random numbers to user space is
    necessarily a great idea.. That said, I think we already do it for unnamed
    pipes anyway, so I'm more wondering if we should have some way to map
    these numbers (in user space) to a valid thing, so that they wouldn't just
    be random numbers.

I don't know. We can try in-kernel to give these well-known services
well-known numbers. Or we can give them essentially random
numbers like today but publish these somewhere, e.g. under /sys.
Both are easy, but seem too heavy for a value used by nobody.
We have process IDs and anonymous fs IDs, and both are just what
they happen to be.


Andries


[If userspace wants to know the present value, then create a socket,
stat, 3! Create a pipe, stat, 7!]
