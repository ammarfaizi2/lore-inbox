Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269231AbRHGSBT>; Tue, 7 Aug 2001 14:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269242AbRHGSBK>; Tue, 7 Aug 2001 14:01:10 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:19728 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269231AbRHGSBF>; Tue, 7 Aug 2001 14:01:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC][PATCH] parser for mount options
Date: Tue, 7 Aug 2001 20:06:54 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0108071227080.18565-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0108071227080.18565-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <0108072006540A.02365@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 August 2001 19:02, Alexander Viro wrote:
> OK, folks - here's an implementation of parser for mount options.
> Patch contains parser itself (lib/parser.c, include/linux/parser.h)
> and switches parse_options() in several filesystems to using it
> instead of the current ad-hackery.
> [...]
> 	It works surprisingly well - syntax is immediately visible in
> the table, code is not crapped with tons of global variables and
> parser itself is not large.

It's a big improvement.

> 	Patch applies clean at least to -pre4 and -pre5.  Comments,
> suggestions and flames are welcome.

Can't think of anything to flame about, so how about a comment: strtok 
is evil.  Even strtok_r sucks somewhat for destroying the input string 
but strtok is far worse for keeping internal static state.  This would 
be a good opportunity to add strtok_r to the library and use it.

--
Daniel
