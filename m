Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267328AbTAGHYr>; Tue, 7 Jan 2003 02:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267329AbTAGHYr>; Tue, 7 Jan 2003 02:24:47 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:14860
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S267328AbTAGHYq>; Tue, 7 Jan 2003 02:24:46 -0500
Subject: Re: [PATCH] Define hash_mem in lib/hash.c to apply hash_long to an
	arbitraty piece of memory.
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <15898.24480.346258.361959@notabene.cse.unsw.edu.au>
References: <15898.24480.346258.361959@notabene.cse.unsw.edu.au>
Content-Type: text/plain
Organization: 
Message-Id: <1041924803.27637.3.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 06 Jan 2003 23:33:23 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-06 at 21:03, Neil Brown wrote:
> Seeing as we have a simple, elegant, and effective hash_long in
> hash.h, and seeing that I need to hash things that aren't a long
> (i.e. strings), I would like to propose defining "hash_mem" based on
> hash_long as done in the following patch (hash_mem already exists
> local to net/sunrpc/svcauth.c, this patch tidies it up and moves it to
> lib/hash.c). 
> 
> It could be argued that there are better hashing functions for
> strings, and indeed Andrew Morton pointed me to ext3/hash.c
> 
> I did a little testing and found that on a list of 2 million 
> basenames from a recent backup index (800,000 unique):
> 
>  hash_mem (as included here) is noticably faster than HASH_HALF_MD4 or
>  HASH_TEA: 
> 
>   hash_mem:		10 seconds
>   DX_HASH_HALF_MD4:	14 seconds
>   DX_HASH_TEA:		15.2 seconds

I think they have a different set of design requirements.  They're both
designed to not only generate hashes, but make the hashes
cryptographically strong (ie, impossible to generate collisions with
less effort than brute force).  They're naturally slower than a simple
hash, so you'd only use them if you need the stronger requirements.

	J

